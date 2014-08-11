require 'spec_helper'

describe 'purchase_date' do
  describe '#initialize' do
    it 'creates a purchase_date' do
      test_purchase_date = Purchase_date.new({:name => "11/3/2014"})
      expect(test_purchase_date).to be_an_instance_of Purchase_date
    end
  end

  describe '.all' do
    it 'returns an empty array' do
      expect(Purchase_date.all).to eq []
    end
  end

  describe '#save' do
    it 'saves an purchase_date to the purchase_dates table' do
      test_purchase_date = Purchase_date.new({:name => "11/3/2014"})
      test_purchase_date.save
      expect(Purchase_date.all).to eq [test_purchase_date]
    end
  end

  describe '#edit' do
    it "uppurchase_dates a purchase_date's information" do
      test_purchase_date = Purchase_date.new({:name => "11/3/2014"})
      test_purchase_date.save
      test_purchase_date.edit("11/7/2014")
      expect(Purchase_date.all[0].name).to eq "11/7/2014"
    end
  end

  describe '.delete' do
    it "deletes a purchase_date" do
      test_purchase_date = Purchase_date.new({:name => "11/3/2014"})
      test_purchase_date.save
      test_purchase_date.delete
      expect(Purchase_date.all).to eq []
    end
  end
end
