require_relative '../lib/activity'
require_relative '../lib/reunion'

RSpec.describe Reunion do
  let(:activity1) { Activity.new('Brunch') }
  let(:activity2) { Activity.new('Drinks') }
  let(:activity3) { Activity.new('Bowling') }
  let(:activity4) { Activity.new('Jet Skiing') }
  let(:reunion) { Reunion.new('1406 BE') }

  describe '#initialize' do
    it 'exists' do
      expect(reunion).to be_a(Reunion)
    end

    it 'has a name' do
      expect(reunion.name).to eq('1406 BE')
    end

    it 'has zero activities initially' do
      expect(reunion.activities).to eq([])
    end
  end

  describe '#add_activity' do
    it 'can add activities to the list' do
      reunion.add_activity(activity1)
      
      expect(reunion.activities).to eq([activity1])
    end
  end
  
  describe '#breakout' do
    it 'can return total cost of all activities for each particpants' do
      activity1.add_participant('Maria', 20)
      activity1.add_participant('Luther', 40)
      reunion.add_activity(activity1)
      activity2.add_participant('Maria', 60)
      activity2.add_participant('Luther', 60)
      activity2.add_participant('Louis', 0)
      reunion.add_activity(activity2)
      
      expected = {'Maria' => -10, 'Luther' => -30, 'Louis' => 40}
      expect(reunion.breakout).to eq(expected)
    end
  end
  
  
  describe '#summary' do
    it 'can return string of breakout results' do
      activity1.add_participant('Maria', 20)
      activity1.add_participant('Luther', 40)
      reunion.add_activity(activity1)
      activity2.add_participant('Maria', 60)
      activity2.add_participant('Luther', 60)
      activity2.add_participant('Louis', 0)
      reunion.add_activity(activity2)

      expected = "Maria: -10\nLuther: -30\nLouis: 40"
      expect(reunion.summary).to eq(expected)
    end
  end

  describe '#payees' do
    it 'can return a hash with activity keys, and payees array' do
      activity1.add_participant('Maria', 20)
      activity1.add_participant('Luther', 40)
      reunion.add_activity(activity1)
      activity2.add_participant('Maria', 60)
      activity2.add_participant('Luther', 60)
      activity2.add_participant('Louis', 0)
      reunion.add_activity(activity2)

      expected = {activity1.name => ['Luther'], activity2.name => ['Louis']}
      expected = {activity1.name => ['Luther'], activity2.name => ['Louis']}
      expect(reunion.payees('Maria')).to eq(expected)
    end
  end

  describe '#detailed_breakout' do
    it 'can return detailed breakout from each participant by activity' do
      activity1.add_participant("Maria", 20)
      activity1.add_participant("Luther", 40)
      
      activity2.add_participant("Maria", 60)
      activity2.add_participant("Luther", 60)
      activity2.add_participant("Louis", 0)
      
      activity3.add_participant("Maria", 0)
      activity3.add_participant("Luther", 0)
      activity3.add_participant("Louis", 30)
      
      activity4.add_participant("Maria", 0)
      activity4.add_participant("Luther", 0)
      activity4.add_participant("Louis", 40)
      activity4.add_participant("Nemo", 40)
      reunion.add_activity(activity1)
      reunion.add_activity(activity2)
      reunion.add_activity(activity3)
      reunion.add_activity(activity4)

      expected = {
                    "Maria" => [
                      {
                        activity: "Brunch",
                        payees: ["Luther"],
                        amount: 10
                      },
                      {
                        activity: "Drinks",
                        payees: ["Louis"],
                        amount: -20
                      },
                      {
                        activity: "Bowling",
                        payees: ["Louis"],
                        amount: 10
                      },
                      {
                        activity: "Jet Skiing",
                        payees: ["Louis", "Nemo"],
                        amount: 10
                      }
                    ],
                    "Luther" => [
                      {
                        activity: "Brunch",
                        payees: ["Maria"],
                        amount: -10
                      },
                      {
                        activity: "Drinks",
                        payees: ["Louis"],
                        amount: -20
                      },
                      {
                        activity: "Bowling",
                        payees: ["Louis"],
                        amount: 10
                      },
                      {
                        activity: "Jet Skiing",
                        payees: ["Louis", "Nemo"],
                        amount: 10
                      }
                    ],
                    "Louis" => [
                      {
                        activity: "Drinks",
                        payees: ["Maria", "Luther"],
                        amount: 20
                      },
                      {
                        activity: "Bowling",
                        payees: ["Maria", "Luther"],
                        amount: -10
                      },
                      {
                        activity: "Jet Skiing",
                        payees: ["Maria", "Luther"],
                        amount: -10
                      }
                    ],
                    "Nemo" => [
                      {
                        activity: "Jet Skiing",
                        payees: ["Maria", "Luther"],
                        amount: -10
                      }
                    ]
                 }  
      expect(reunion.detailed_breakout).to eq(expected)
    end
  end
end