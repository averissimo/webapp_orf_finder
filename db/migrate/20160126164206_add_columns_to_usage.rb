class AddColumnsToUsage < ActiveRecord::Migration[5.0]
  def change
    change_table :usages do |t|
      t.integer :codon_table
      t.boolean :same_as_codon_table
    end
  end
end
