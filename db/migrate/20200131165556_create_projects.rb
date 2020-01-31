class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.string :title
      t.references :user, foreign_key: true

      t.timestamps
    end
		add_index :microposts, [:user_id, :created_at]
  end
end
