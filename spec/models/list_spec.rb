require 'rails_helper'

RSpec.describe List, type: :model do

  describe '#complete_all_tasks!' do
    it 'should change all tasks complete status to true' do
      list = List.create(name: "Chores")
      Task.create(complete: false, list_id: list.id, name:"Walk the dog")
      Task.create(complete: false, list_id: list.id, name:"Eat")
      list.complete_all_tasks!
      list.tasks.each do |task|
        expect(task.complete).to eq(true)
      end
    end
  end

  describe '#snooze_all_tasks!' do
    it 'should set the deadlines for all tasks by 1 hour later' do
      list = List.create(name: "List")
      now = Time.now
      Task.create(deadline: now, list_id: list.id, name: "Foo")
      Task.create(deadline: now, list_id: list.id, name: "Foo2")
      list.snooze_all_tasks!
      list.tasks.each do |task|
        expect(task.deadline).to eq(now + 1.hour)
      end
    end
  end

  describe '#total_duration' do
    it 'should return the cumulative duration of all the tasks' do
      list = List.create(name: "List")
      Task.create(list_id: list.id, name: "Foo", duration: 60)
      Task.create(list_id: list.id, name: "Foo2", duration: 70)
      expect(list.total_duration).to eq(130)
    end
  end

  describe '#incomplete_tasks' do
    it 'should return an array of all tasks that are not complete' do
      list = List.create(name: "List")
      task1 = Task.create(list_id: list.id, name: "Foo", complete: false)
      task2 = Task.create(list_id: list.id, name: "Foo2", complete: true)
      task3 = Task.create(list_id: list.id, name: "Foo2", complete: false)
      expect(list.incomplete_tasks).to eq([task1,task3])
    end
  end

  describe '#favorite_tasks' do
    it 'should return an array of all tasks that are marked as favorite' do
      list = List.create(name: "List")
      task1 = Task.create(list_id: list.id, favorite: true)
      task2 = Task.create(list_id: list.id, favorite: false)
      task3 = Task.create(list_id: list.id, favorite: true)
      expect(list.favorite_tasks).to eq([task1, task3])
    end
  end

end
