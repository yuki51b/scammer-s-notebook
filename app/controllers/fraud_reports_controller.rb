class FraudReportsController < ApplicationController
    skip_before_action :require_login, only: [ :new, :create, :show ]
    helper_method :prepare_meta_tags


    def new
        @fraud_report = FraudReport.new
    end

    def create
        @fraud_report = FraudReport.new(fraud_report_params)
        prompt = scam_name_general_prompt(params[:fraud_report]) # promptには受け取ったカラムの値を入れたプロンプトが入る
            response = ChatgptService.call(prompt)
        # 保存先をrespondカラムに指定
            @fraud_report.respond = response
            # 詐欺診断処理を行って詐欺情報を確定させる
                judgmented_scam = handle_scam_diagnosis(response)
            # FraudReport関連するscamレコードを取得
                @fraud_report.scam = judgmented_scam

        begin # エラーが出そうな部分を指定。
                if @fraud_report.save
                    redirect_to fraud_report_path(@fraud_report), notice: '診断結果が出ました'
                else
                    logger.error "Failed to save fraud_report: #{@fraud_report.errors.full_messages.join(', ')}"
                    redirect_to root_path, alert: '保存に失敗しました。'
                end
            rescue Net::ReadTimeout, StandardError => e # beginの箇所で失敗した場合のエラーをキャッチして処理
            logger.error "Failed to call OpenAI: #{e.message}"
            redirect_to root_path, alert: 'OpenAIサービスの呼び出しに失敗しました。'
        end
    end

    def show
        @fraud_report = FraudReport.find(params[:id])
        @scam = Scam.find_by(name: @fraud_report.respond)
        prepare_meta_tags(@scam)
    end

  private

    def fraud_report_params
        params.require(:fraud_report).permit(:contact_method, :contact_content, :information, :urgent_action, :payment_method, :company_info, :who_person)
    end

    def scam_name_general_prompt(fraud_report_params)
        #promptに使用するために設定
        contact_method = fraud_report_params[:contact_method]
        contact_content = fraud_report_params[:contact_content]
        information = fraud_report_params[:information]
        urgent_action = fraud_report_params[:urgent_action]
        payment_method = fraud_report_params[:payment_method]
        company_info = fraud_report_params[:company_info]
        who_person = fraud_report_params[:who_person]
        <<~PROMPT
                ## 指示
                あなたは、"入力情報"からどんな詐欺の可能性が高いかを診断してくれるとても優秀な詐欺の専門家です。
                下記の"入力情報"の情報から、可能性の一番高い詐欺名または特殊詐欺名または悪質商法名を教えてください。
                ## 入力情報
                接触手段はなんですか？: #{contact_method}
                接触の内容は何ですか？: #{contact_content}
                相手が求めている情報や行動: #{information}
                行動を急ぐように求められましたか？: #{urgent_action}
                支払い方法: #{payment_method}
                会社などの情報はありますか: #{company_info}
                相手の特徴や相手は誰かを教えてください: #{who_person}
                ## 制約条件
                - 出力の際は"出力の説明"と"例"を十分に理解して、"出力フォーマット"を遵守して出力してください。
                - "入力情報"を十分理解して、詐欺名または特殊詐欺名または悪質商法名の３つから可能性の高い結果を一つ選んで出力してください。
                - 日本語でお願いします
                - 対話型の出力はしないでください。
                - 過去の出力と今回の手口がある程度同じである場合は、同じ診断名を出力しても構いません。
                ## 出力の説明
                - "出力フォーマット"のnameとplusは出力場所を表しているだけです。その場所に値を出力してくださいという意味です。
                - 1."入力情報"から考えられる一番可能性の高い詐欺名または特殊詐欺名または悪質商法名を"出力フォーマット"のnameの場所に出力してください。
                - 2."1"の今回診断されたnameが特殊詐欺名だった場合、今回の特殊詐欺の手口を表す言葉を一語、"出力フォーマット"のplusに出力してください
                - 3."1"でのnameが特殊詐欺名ではなかった場合、"出力フォーマット"の"& (plus)"は排除して、nameだけを出力してください。
                ## 例
                - "1"でのnameがオレオレ詐欺、"2"でのplusが親族であるならば、オレオレ詐欺&(親族)のように
                - "1"でのnameが不動産詐欺で特殊詐欺ではない時、不動産詐欺
                ## 出力フォーマット
                    name & (plus)
        PROMPT
    end

    def handle_scam_diagnosis(response_name)
        Rails.logger.info "ChatGPT API response: #{response_name}"
        search_scam = Scam.find_by(name: response_name)  #find_byメソッドは値がない場合nilを返す。
        return search_scam if search_scam
        #詐欺名がなかった場合(search_scamがnilだった時)の詐欺詳細をAPIに聞く
            scam_content_prompt = scam_content_general_prompt(response_name)
            scam_content = ChatgptService.call(scam_content_prompt)
        #詐欺名がなかった場合(search_scamがnilだった時)の詐欺ポイント３つをAPIに聞く
            scam_point_1_prompt = scam_point_1_general_prompt(response_name)
            scam_point_1 = ChatgptService.call(scam_point_1_prompt)

            scam_point_2_prompt = scam_point_2_general_prompt(response_name)
            scam_point_2 = ChatgptService.call(scam_point_2_prompt)

            scam_point_3_prompt = scam_point_3_general_prompt(response_name)
            scam_point_3 = ChatgptService.call(scam_point_3_prompt)
        #詐欺名がなかった場合(search_scamがnilだった時)の詐欺師視点の詐欺の手口をAPIに聞く
            scam_strategy_prompt = scam_strategy_general_prompt(response_name)
            scam_strategy = ChatgptService.call(scam_strategy_prompt)
            Rails.logger.info "ChatGPT API response: #{scam_strategy}"

        # scamオブジェクトを生成かつcreate_scamに保存
            create_scam = Scam.new(name: response_name, content: scam_content, point_1: scam_point_1, point_2: scam_point_2, point_3: scam_point_3, scam_strategy: scam_strategy)
                if create_scam.save
                    Rails.logger.info "ChatGPT API response: #{scam_content}"
                    return create_scam
                else
                    logger.error "Failed to save scam: #{scam.errors.full_messages.join(', ')}"
                    return nil
                end
    end

    def scam_content_general_prompt(response_name)
        <<~PROMPT
            詐欺名: #{response_name}
            上記の詐欺についての詳細を一言で教えてください。
            対話型の返答は省き、日本語で詐欺の詳細の1行だけを返答してください。
        PROMPT
    end

    def scam_point_1_general_prompt(response_name)
        <<~PROMPT
            ## 指示
            あなたは#{response_name}に詳しい一流の専門家です。
            その詐欺について、以下の "観点"と"状況"から対策ポイントを１つ教えてください
            ## 状況
            ユーザーが今、その#{response_name}詐欺被害に遭っているかもしれないという状況です。
            ## 観点
            その詐欺の被害に遭わないために、絶対にやってはいけない行為を教えてください。
            ## 制約条件
            - 日本語でお願いします
            - "状況"と"観点"を十分考慮して、判断してください
            - 50文字以内でお願いします
            - 対話型の出力はしないでください
            - 対策ポイントは一つでお願いします
        PROMPT
    end

    def scam_point_2_general_prompt(response_name)
        <<~PROMPT
            ## 指示
            あなたは#{response_name}に詳しい一流の専門家です。
            その詐欺について、以下の "観点"と"状況"から対策ポイントを１つ教えてください
            ## 状況
            ユーザーが今、その#{response_name}詐欺被害に遭っているかもしれないという状況です。
            ## 観点
            その詐欺の被害に遭わないために、相談した方が良い相手を教える観点でお願いします
            ## 制約条件
            - 日本語でお願いします
            - "状況"と"観点"を十分考慮して、判断してください
            - 50文字以内でお願いします
            - 対話型の出力はしないでください
        PROMPT
    end

    def scam_point_3_general_prompt(response_name)
        <<~PROMPT
            ## 指示
            あなたは#{response_name}に詳しい一流の専門家です。
            その詐欺について、以下の "観点"と"状況"から対策ポイントを１つ教えてください
            ## 状況
            ユーザーが今、その#{response_name}詐欺被害に遭っているかもしれないという状況です。
            ## 観点
            ユーザーがその詐欺の被害に遭わないために、決定的となる判断の仕方を教えてください。
            金融庁の登録の確認のように、その詐欺で確認することを提示してください。
            ## 制約条件
            - 日本語でお願いします
            - "状況"と"観点"を十分考慮して、判断してください
            - 50文字以内でお願いします
            - 対話型の出力はしないでください
            - 対策ポイントは一つでお願いします
        PROMPT
    end

    def scam_strategy_general_prompt(response_name)
        <<~PROMPT
            ## 指示
            あなたはどんな詐欺にも詳しい一流の詐欺師です
            下記の"詐欺名"から、一流詐欺師の視点で詐欺の手口について教えてください。
            ## 詐欺名
            #{response_name}
            ## 制約条件
            - 教育者の観点を持って手口を考えるようにお願いします
            - 日本語でお願いします
            - できるだけ詐欺師を演じてください
            - 一人称は"僕"でお願いします
            - しかし、異性の特性を狙った詐欺の場合は性別を考慮しないでください
            - 出力の際は"僕の手口はこうさ！" で初めてください
            - markdown記法を使っての出力はしないでください
            - ターゲットの選び方やその理由も含めてください
            - 実行の手口を教えてください
            - "指示"以上の回答はしないでください。
            - 500文字以内でお願いします
        PROMPT
    end

    def prepare_meta_tags(scam)
        image_url = "#{request.base_url}/images/ogp.png?text=#{CGI.escape(scam.name)}"
        set_meta_tags og: {
            site_name: '詐欺師の手帳',
            title: scam.name,
            description: '詐欺診断が共有されました',
            type: 'website',
            url: request.original_url,
            image: image_url,
            locale: 'ja-JP'
        },
        twitter: {
            card: 'summary_large_image',
            site: '@your_twitter_account',
            image: image_url
        }
    end
end
