class CreateUsages < ActiveRecord::Migration[5.0]
  def change
    create_table :usages do |t|
      # session information
      t.string :ip
      t.string :method
      t.string :agent
      t.string :url
      # actual options if method is post
      t.string :sequence
      t.string :start_codons
      t.string :stop_codons
      t.boolean :direct
      t.boolean :reverse
      t.integer :min
      t.timestamps
    end
  end
end
