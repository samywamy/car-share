class CreateCarsSpaces < ActiveRecord::Migration[5.2]
  def change
    create_table :cars_spaces do |t|
      t.references :car, foreign_key: true
      t.references :space, foreign_key: true

      t.timestamps
    end
  end
end
