class CreateFlarks < ActiveRecord::Migration
  def change
    create_table :flarks do |t|

      t.timestamps
    end
  end
end
