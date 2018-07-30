class Translator < ApplicationRecord
  def self.process_translate(room_id, input, language)
    TranslatorWorker.perform_async(room_id, input, language)
  end
end