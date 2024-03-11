require 'line/bot'

class LinebotController < ApplicationController
    protect_from_forgery :except => [:callback]
  
    def client
      @client ||= Line::Bot::Client.new { |config|
        config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
        config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
      }
    end
  
    def callback
      body = request.body.read
  
      signature = request.env['HTTP_X_LINE_SIGNATURE']
      unless client.validate_signature(body, signature)
        error 400 do 'Bad Request' end
      end
  
      events = client.parse_events_from(body)
  
      events.each { |event|
        case event
        when Line::Bot::Event::Message
            case event.type
            when Line::Bot::Event::MessageType::Text
                if event.message['text'].include?("課金可能額")
                    budget_message(event)
                end
            end
        end
      }
  
      head :ok
    end
  
    private

    def budget_message(event)
        current_year = Time.current.year
        current_month = Time.current.month
        budget = Budget.where(year: current_year, month: current_month).first
    
        if budget.nil?
          message = {
            type: 'text',
            text: "今月の予算は登録されていません。"
          }
        else
          charges_this_month = Charge.where("date >= ? AND date <= ?", Time.current.beginning_of_month, Time.current.end_of_month).order(:date)
          total_spent_this_month = charges_this_month.sum(:amount)
          remaining_budget = budget.amount - total_spent_this_month
    
          message = {
            type: 'text',
            text: "今月の残り課金可能額は#{remaining_budget}円です！"
          }
        end
        client.reply_message(event['replyToken'], message)
      end
    end
end
