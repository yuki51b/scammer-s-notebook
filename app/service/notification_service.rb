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
                おはようございます!
                今日の詐欺情報をお届けします。📔

                [詐欺名]
                #{scam_name}


                #{scam_content}

                [３つのポイントに注意しましょう]

                ・#{scam_point_1}

                ・#{scam_point_2}

                ・#{scam_point_3}


                詐欺には十分注意して、被害に遭わないようにするんだぜ👍
            PROMPT
    }

    response = LINE_NOTIFY_CLIENT.broadcast(message)
    Rails.logger.info "Push message response: #{response.inspect}"
  end
end
