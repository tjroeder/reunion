class Activity
  attr_reader :name, :participants, :total_cost

  def initialize(name)
    @name = name
    @participants = {}
    @total_cost = 0
  end

  def add_participant(new_participant, new_cost)
    @participants[new_participant] = new_cost
    @total_cost += new_cost
  end

  def split
    @total_cost / @participants.count
  end

  def owed
    owed_hash = @participants.transform_values do |participant_cost|
      split - participant_cost
    end
  end
end