class ReservationMailer < ApplicationMailer
  def send_email_to_client(host, venue)
    @recipient = host
    @venue = venue
    mail(to: @recipient.email, subject: "Thank you! Enjoy your venue space!💯")
  end
end