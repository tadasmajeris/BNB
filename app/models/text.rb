require 'twilio-ruby'
require 'envyable'


class Text
	def self.send(to,body)
		Envyable.load('./config/env.yml','development')
		client = Twilio::REST::Client.new(ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN'])
		client.account.messages.create({
			:from => +441143032672,
			:to => to,
			:body => body,
		})
		"message sent successfully"
	end
end
