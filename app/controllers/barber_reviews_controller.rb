class BarberReviewsController < ApplicationController

  def create
    # Step 1: Check if the reservation exist (stylist_id, client_id, clientt_id)

    # Step 2: Check if the current host already reviewed the barber in this reservation.

    @reservation = Reservation.where(
                    id: barber_review_params[:reservation_id],
                    barbershop_id: barber_review_params[:barbershop_id]
                   ).first

    if !@reservation.nil? && @reservation.barbershop.user.id == barber_review_params[:client_id].to_i

      @has_reviewed = BarberReview.where(
                        reservation_id: @reservation.id,
                        client_id: barber_review_params[:client_id]
                      ).first

      if @has_reviewed.nil?
          # Allow to review
          @barber_review = current_user.barber_reviews.create(barber_review_params)
          flash[:success] = "Review created..."
      else
          # Already reviewed
          flash[:success] = "You already reviewed this Reservation"
      end
    else
      flash[:alert] = "Not found this reservation"
    end

    redirect_back(fallback_location: request.referer)
  end

  def destroy
    @barber_review = Review.find(params[:id])
    @barber_review.destroy

    redirect_back(fallback_location: request.referer, notice: "Removed...!")
  end

  private
    def barber_review_params
      params.require(:barber_review).permit(:comment, :star, :barbershop_id, :reservation_id, :client_id)
    end
end