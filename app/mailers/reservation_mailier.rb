class ReservationMailer < ApplicationMailer
  def send_email_to_guest(guest, pool)
    @recipient = guest
    @pool = pool
    mail(to: @recipient.email, subject: "Thank you! Enjoy your pool time!💯")
  end
end