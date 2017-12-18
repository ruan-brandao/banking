require 'rails_helper'

RSpec.describe AccountsHelper, type: :helper do
  describe '#formatted_currency' do
    it 'formats integer values to Brazilian Real' do
      expect(helper.formatted_currency(0)).to          eq('R$ 0,00')
      expect(helper.formatted_currency(15)).to         eq('R$ 0,15')
      expect(helper.formatted_currency(7200)).to       eq('R$ 72,00')
      expect(helper.formatted_currency(5678)).to       eq('R$ 56,78')
      expect(helper.formatted_currency(1234567890)).to eq('R$ 12.345.678,90')
    end
  end
end
