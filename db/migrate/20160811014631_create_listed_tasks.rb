class CreateListedTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :listed_tasks do |t|
      t.integer :task_id
      t.integer :list_id

      t.timestamps
    end
  end
end
