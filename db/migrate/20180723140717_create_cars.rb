class CreateCars < ActiveRecord::Migration[5.2]
  def change
    create_table :cars do |t|
      t.text :name

      t.timestamps
    end
  end
end
