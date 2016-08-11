class List < ApplicationRecord

  has_many :tasks

  def complete_all_tasks!
    tasks.update_all(complete: true)
  end

  def snooze_all_tasks!
    tasks.map { |task| task.snooze_hour! }
  end

  def total_duration
    total = 0
    tasks.map { |task| total += task.duration}
    return total
  end

  def incomplete_tasks
    tasks.map { |task| task if !task.complete }.delete_if { |task| task == nil }
  end

  def favorite_tasks
    tasks.map { |task| task if task.favorite }.delete_if { |task| task == nil }
  end
  
end
