class ClientReviewsController < ApplicationController

  def create
    # Step 1: Check if the reservation exist (barbershop_id, stylist_id, client_id)

    # Step 2: Check if the current client already reviewed the barber in this reservation.

    @reservation = Reservation.where(
                    id: client_review_params[:reservation_id],
                    barbershop_id: client_review_params[:barbershop_id],
                    user_id: client_review_params[:stylist_id]
                   ).first

    if !@reservation.nil?

      @has_reviewed = ClientReview.where(
                        reservation_id: @reservation.id,
                        barber_id: client_review_params[:barber_id]
                      ).first

      if @has_reviewed.nil?
          # Allow to review
          @client_review = current_user.client_reviews.create(client_review_params)
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
    @client_review = Review.find(params[:id])
    @client_review.destroy

    redirect_back(fallback_location: request.referer, notice: "Removed...!")
  end

  private
    def client_review_params
      params.require(:client_review).permit(:comment, :star, :barbershop_id, :reservation_id, :barber_id)
    end
end