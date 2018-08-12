class TranslatorWorker
  include Sidekiq::Worker

  def perform(room_id, input, language)
    result = translate(input, language)
    ActionCable.server.broadcast "rails_translator_channel_#{room_id}", result: result
  end

  private
    def translate(input, language)
      # Model Translator Root Path
      model_root_path = "/home/nhean/Machine-Learning/Mose-Decoder/"
      moses_path = model_root_path+"/mosesdecoder/bin/moses -f "

      # Input Language Model path
      model_path = ""
      if language == "en"
        model_path = model_root_path+"/working-en/train/model/moses.ini < "
      else
        model_path = model_root_path+"/working-kh/train/model/moses.ini < "
      end
      
      # Write Input to File Ruby to Filter System Symbols
      input_file = Rails.root.join('public', 'input_file.rb')
      open(input_file, 'w') do |file|
        file.write("puts " + "'#{input}'")
      end

      # Get Filtered of Input
      unused_result = IO.popen("ruby #{input_file}") { |f| f.gets() }

      # If input language is Khmer, we have to segement
      if language == "kh"
        # Segmented Model Path
        crf_root_path = "/home/nhean/Machine-Learning/CRF++/"
        segemented_runner = crf_root_path + "main.rb"
        input_crf_file = crf_root_path + "test.txt"

        # Write Filterd Result to Input CRF File
        open(input_crf_file, 'w') do |file|
          file.write(unused_result)
        end
        
        # Get Segmented Result
        unused_result = IO.popen("ruby #{segemented_runner}") { |f| f.gets() }
      end

      # Write Filterd of Input to Middle File
      middle_file = Rails.root.join('public', 'middle_file.txt')
      open(middle_file, 'w') do |file|
        file.write(unused_result)
      end

      # Get Translated Result
      result = IO.popen("#{moses_path}" +"#{model_path}" + "#{middle_file}") { |f| f.gets() }

      # Check Translated Language
      if language == "en"
        result = result.delete(' ')
      else
        result = result.capitalize
      end

      return result
    end
end