require 'rails_helper'

RSpec.describe Task, type: :model do
  describe '#toggle_complete!' do 
    it 'should switch complete to false if it began as true' do 
      task = Task.new(complete: true)
      task.toggle_complete!
      expect(task.complete).to eq(false)
    end

    it 'should switch complete to true if it began as false' do 
      task = Task.new(complete: false)
      task.toggle_complete!
      expect(task.complete).to eq(true)
    end
  end

  describe '#toggle_favorite!' do
    it 'should switch favorite to false if it began as true' do
      task = Task.new(favorite: false)
      task.toggle_favorite!
      expect(task.favorite).to eq(true)
    end

    it 'should switch favorite to true if it began as false' do
      task = Task.new(favorite: true)
      task.toggle_favorite!
      expect(task.favorite).to eq(false)
    end
  end

  describe '#overdue?' do
    it 'should return true if the the current time is past the deadline' do
      task = Task.new(deadline: 1.hour.ago)
      expect(task.overdue?).to eq(true)
    end

    it 'should return false if the the current time is before the deadline' do
      task = Task.new(deadline: 1.hour.from_now)
      expect(task.overdue?).to eq(false)
    end
  end

  describe '#increment_priority!' do
    it 'should increase priority by 1 if priority is less than 10' do
      task = Task.new(priority: 9)
      task.increment_priority!
      expect(task.priority).to eq(10)
    end

    it 'should not increase priority if priority is greater than or equal to 10' do
      task = Task.new(priority: 10)
      task.increment_priority!
      expect(task.priority).to eq(10)
    end
  end

  describe '#decrement_priority!' do
    it 'should decrease priority by 1 if priority is greater than 1' do
      task = Task.new(priority: 10)
      task.decrement_priority!
      expect(task.priority).to eq(9)
    end

    it 'should not decrease priority if priority is less than or equal to 1' do
      task = Task.new(priority: 1)
      task.decrement_priority!
      expect(task.priority).to eq(1)
    end
  end

  describe '#snooze_hour!' do
    it 'should increase the deadline time by one hour' do
      now = Time.now
      task = Task.new(deadline: now)
      task.snooze_hour!
      expect(task.deadline).to eq(now + 1.hour)
    end
  end

end
