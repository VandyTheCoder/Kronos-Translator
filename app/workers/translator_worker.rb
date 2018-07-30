class TranslatorWorker
  include Sidekiq::Worker

  def perform(room_id, input, language)
    result = translate(input, language)
    ActionCable.server.broadcast "rails_translator_channel_#{room_id}", result: result
  end

  private
    def translate(input, language)
      model_root_path = "/home/nhean/Machine-Learning/Mose-Decoder/"
      moses_path = model_root_path+"/mosesdecoder/bin/moses -f "
      model_path = ""
      if(language == "en")
        model_path = model_root_path+"/working-en/train/model/moses.ini < "
      else
        model_path = model_root_path+"/working/train/model/moses.ini < "
      end
      
      input_file = Rails.root.join('public', 'input_file.rb')
      open(input_file, 'w') do |file|
        file.write("puts " + "'#{input}'")
      end

      unused_result = IO.popen("ruby #{input_file}") { |f| f.gets() }

      middle_file = Rails.root.join('public', 'middle_file.txt')
      open(middle_file, 'w') do |file|
        file.write(unused_result)
      end

      result = IO.popen("#{moses_path}" +"#{model_path}" + "#{middle_file}") { |f| f.gets() }
      return result
    end
end