class Reunion
  attr_reader :name, :activities

  def initialize(name)
    @name = name
    @activities = []
  end

  def add_activity(new_activity)
    @activities.push(new_activity)
  end

  def breakout
    breakout_hash = Hash.new(0)
    @activities.each do |activity|
      activity.owed.each_pair do |name, cost|
        breakout_hash[name] += cost
      end
    end
    breakout_hash
  end

  def summary
    print_string = ''
    count = 1
    breakout.each_pair do |name, owed_value|
      print_string.concat("#{name}: #{owed_value}\n") if count < breakout.count
      print_string.concat("#{name}: #{owed_value}") if count == breakout.count
      count += 1
    end
    print_string
  end

  def payees(sel_name)
    payees_hash = {}
    @activities.each do |activity|
      activity.owed.each_pair do |name, owed_value|
        if activity.owed.include?(sel_name)          
          unless name == sel_name || owed_value == 0 || activity.owed[name].positive? == activity.owed[sel_name].positive?
            payees_hash[activity.name] ||= []
            payees_hash[activity.name].push(name)
          end
        end
      end
    end
    payees_hash
  end

  def detailed_breakout
    breakout_hash = {}
    @activities.each do |activity|
      activity.owed.each do |name, cost|
        cost /= payees(name)[activity.name].length
        breakout_hash[name] ||= []
        breakout_hash[name].push({activity: activity.name, payees: payees(name)[activity.name], amount: cost})
      end
    end
    breakout_hash
  end
end