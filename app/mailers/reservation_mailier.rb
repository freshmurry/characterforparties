class ReservationMailer < ApplicationMailer
  def send_email_to_client(client, barbershop)
    @recipient = client
    @barbershop = barbershop
    mail(to: @recipient.email, subject: "Enjoy Your New Barbershop Experience! 💈")
  end
end