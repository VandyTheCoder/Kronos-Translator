class RailsTranslatorChannel < ApplicationCable::Channel
  def subscribed
    stream_from "rails_translator_channel_#{params[:room_id]}"
  end

  def unsubscribed
  end

  def translate(data)
    input = data["input"].to_s.downcase
    language = data["language"].to_s
    room_id = params[:room_id]

    Translator.process_translate(room_id, input, language)
  end
end