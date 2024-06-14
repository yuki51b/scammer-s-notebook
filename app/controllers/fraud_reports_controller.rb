class FraudReportsController < ApplicationController

    def new
        @fraud_report = FraudReport.new
    end

    def create
        @fraud_report = FraudReport.new(fraud_report_params)

        #prompt =
                contact_method = params[:fraud_report][:contact_method]
                contact_content = params[:fraud_report][:contact_content]
                information = params[:fraud_report][:information]
                urgent_action = params[:fraud_report][:urgent_action]
                payment_method = params[:fraud_report][:payment_method]
                company_info = params[:fraud_report][:company_info]
                additional_details = params[:fraud_report][:additional_details]

        prompt =
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

        begin # エラーが出そうな部分を指定。
            responce = ChatgptService.call(prompt) # ここで設定したAPIのメソッドを使っている
            logger.info "OpenAI API response: #{response}" # レスポンスをログに出力
                @fraud_report.respond = responce # respondカラムという保存先を指定
                if @fraud_report.save
                    redirect_to fraud_report_path(@fraud_report), notice: '診断名を受け取りました'
                else
                    redirect_to root_path, alert: '保存に失敗しました。'
                end
            rescue Net::ReadTimeout, StandardError => e # beginの箇所で失敗した場合のエラーをキャッチして処理
            logger.error "Failed to call OpenAI: #{e.message}"
            redirect_to root_path, alert: 'OpenAIサービスの呼び出しに失敗しました。'
        end
    end

    def show 
        @fraud_report = FraudReport.find(params[:id])
    end

  private

    def fraud_report_params
        params.require(:fraud_report).permit(:contact_method, :contact_content, :information, :urgent_action, :payment_method, :company_info, :additional_details)
    end
end
