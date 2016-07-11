class AddColumnRefToTasks < ActiveRecord::Migration
  def change
    add_reference :tasks, :column, index: true, foreign_key: true
  end
end
