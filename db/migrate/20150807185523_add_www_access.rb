class AddWwwAccess < ActiveRecord::Migration
  def up
    create_table :WwwAccess do |t|
      t.integer :time
      t.integer :user
      t.string :host
      t.string :path
      t.string :code
      t.string :agent
      t.integer :size
      t.string :method
      t.timestamps
    end
  end

  def down
    drop_table :WwwAccess
  end
end
