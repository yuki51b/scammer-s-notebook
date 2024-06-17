class FraudReportsController < ApplicationController

    def new
        @fraud_report = FraudReport.new
    end

    def create
        @fraud_report = FraudReport.new(fraud_report_params)
        prompt = scam_name_general_prompt(params[:fraud_report])
            response = ChatgptService.call(prompt)
            @fraud_report.respond = response # 保存先をrespondカラムに指定
            # まず、詐欺診断処理を行って詐欺情報を確定させる
                judgmented_scam = handle_scam_diagnosis(response)
            # ここで `FraudReport`関連するscamレコードを取得
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
    end

  private

    def fraud_report_params
        params.require(:fraud_report).permit(:contact_method, :contact_content, :information, :urgent_action, :payment_method, :company_info, :additional_details)
    end

    def scam_name_general_prompt(fraud_report_params)
        #promptに使用するために設定
        contact_method = fraud_report_params[:contact_method]
        contact_content = fraud_report_params[:contact_content]
        information = fraud_report_params[:information]
        urgent_action = fraud_report_params[:urgent_action]
        payment_method = fraud_report_params[:payment_method]
        company_info = fraud_report_params[:company_info]
        additional_details = fraud_report_params[:additional_details]
        <<~PROMPT
            下記はユーザーが入力してくれた情報です
                連絡手段: #{contact_method}
                コンタクトの内容: #{contact_content}
                要求される情報: #{information}
                急いで行動するように求められましたか: #{urgent_action}
                支払い方法: #{payment_method}
                会社などの情報はありますか: #{company_info}
                その他の詳細: #{additional_details}
            上記の情報に基づいて、最も可能性の高い詐欺名(悪質商法も含む)を一つだけ日本語で教えてください
            対話型の返答は省き、詐欺名(悪質商法も含む)のみを返答してください。
        PROMPT
    end

    def handle_scam_diagnosis(response_name)
        search_scam = Scam.find_by(name: response_name)  #find_byメソッドは値がない場合nilを返す。
        return search_scam if search_scam
        #詐欺名がなかった場合(search_scamがnilだった時)の詐欺詳細をAPIに聞く
            scam_content_prompt = scam_content_general_prompt(response_name)
            scam_content = ChatgptService.call(scam_content_prompt)
        #詐欺名がなかった場合(search_scamがnilだった時)の詐欺ポイントをAPIに聞く

            # scamオブジェクトを生成かつcreate_scamに保存
                create_scam = Scam.new(name: response_name, content: scam_content)
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
end