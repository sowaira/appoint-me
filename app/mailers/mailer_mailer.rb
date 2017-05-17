class MailerMailer < ApplicationMailer


	default from: "jv.appointme@gmail.com"

	def confirmation_email(client)
		@client = client
		mail(to: @client.unconfirmed_email, subject: 'Confirmation of email')
	end

	def confirmation_email_designer(designer)
		@designer = designer
		mail(to: @designer.unconfirmed_email, subject: 'Confirmation of email')
	end

end
