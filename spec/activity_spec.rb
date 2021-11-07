require_relative '../lib/activity'

RSpec.describe Activity do
  let(:activity) { Activity.new('Brunch') }

  describe '#initialize' do
    it 'exists' do
      expect(activity).to be_a(Activity)
    end

    it 'has a name' do
      expect(activity.name).to eq('Brunch')
    end

    it 'has zero participants initially' do
      expect(activity.participants).to eq({})
    end

    it 'has zero total cost initially' do
      expect(activity.total_cost).to eq(0)
    end
  end

  describe '#add_participant' do
    it 'can add additional participants' do
      activity.add_participant('Maria', 20)
      
      expected = {'Maria' => 20}
      expect(activity.participants).to eq(expected)
    end
    
    it 'can increase the total cost of the activity' do
      activity.add_participant('Maria', 20)
      
      expect(activity.total_cost).to eq(20)
      
      activity.add_participant('Luther', 40)
      
      expect(activity.total_cost).to eq(60)
    end
  end
  
  describe '#split' do
    it 'can return the total cost distributed among all participants' do
      activity.add_participant('Maria', 20)
      activity.add_participant('Luther', 40)
      
      expect(activity.split).to eq(30)
    end
  end
  
  describe '#owed' do
    it 'can retrun the amount owed by each participant for activity' do
      activity.add_participant('Maria', 20)
      activity.add_participant('Luther', 40)

      expected = {'Maria' => 10, 'Luther' => -10}
      expect(activity.owed).to eq(expected)
    end
  end
end