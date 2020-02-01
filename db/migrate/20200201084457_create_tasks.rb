class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :content
      t.references :project, foreign_key: true

      t.timestamps
    end
		add_index :tasks, [:project_id, :created_at]
  end
end
