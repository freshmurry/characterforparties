class MessagesChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
      stream_from "conversations_#{params[:id]}"
  end
end  