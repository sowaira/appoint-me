class MailerMailer < ApplicationMailer


	default from: "jv.appointme@gmail.com"

	def confirmation_email(client)
		@client = client
		mail(to: @client.unconfirmed_email, subject: 'Confirmation Email')
	end

end
