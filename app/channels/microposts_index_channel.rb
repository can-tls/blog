class MicropostsIndexChannel < ApplicationCable::Channel
  def subscribed
    stream_from "microposts_index_channel"
  end

  def unsubscribed
  end
end
