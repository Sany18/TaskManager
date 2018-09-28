require 'rails_helper'

RSpec.describe TasksHelper, type: :helper do
  describe "Task helper" do
    it "time now should return curent time (in String)" do
      expect(self.date_now.is_a?(String)).to eq true
    end

    it "color_of_priority should return w3-color (in String)" do
      for i in 0..5
        expect(self.color_of_priority(i).is_a?(String)).to eq true
      end
    end
  end
end
