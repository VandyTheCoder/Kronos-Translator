class CreateTranslators < ActiveRecord::Migration[5.1]
  def change
    create_table :translators do |t|

      t.timestamps
    end
  end
end
