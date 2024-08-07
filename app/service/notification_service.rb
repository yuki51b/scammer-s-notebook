class NotificationService
  def self.call
    new.call
  end

  def call
    send_push_message
  end

  private

  def send_push_message
    scam = Scam.order('RANDOM()').first
    scam_name = scam.name
    scam_content = scam.content
    scam_point_1 = scam.point_1
    scam_point_2 = scam.point_2
    scam_point_3 = scam.point_3
    message = {
      type: 'text',
      text: <<~PROMPT
                おはようございます!!
                今日の詐欺情報はお届けするぞ!!
                -------------------
                < 詐欺名 >
                #{scam_name}

                --------------------

                一言で言うと、#{scam_content}というような詐欺だな！

                < 以下の３つのポイントに注意をするといいぞ!! >
                -------------------
                ・#{scam_point_1}

                ・#{scam_point_2}

                ・#{scam_point_3}

                -------------------

                これで1つ、君の知識になったはずだ!
                詐欺には十分注意して、被害に遭わないでほしいぞ！
                無理をせず、今日という1日過ごすんだぞ!
            PROMPT
    }

    response = LINE_NOTIFY_CLIENT.broadcast(message)
    Rails.logger.info "Push message response: #{response.inspect}"
  end
end
