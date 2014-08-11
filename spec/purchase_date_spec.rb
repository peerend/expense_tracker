require 'spec_helper'

describe 'purchase_date' do
  describe '#initialize' do
    it 'creates a purchase_date' do
      test_purchase_date = Purchase_date.new({:name => 20141103})
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
      test_purchase_date = Purchase_date.new({:name => 20141103})
      test_purchase_date.save
      expect(Purchase_date.all[0].name).to eq "2014-11-03"
    end
  end

  describe '#edit' do
    it "uppurchase_dates a purchase_date's information" do
      test_purchase_date = Purchase_date.new({:name => 20141103})
      test_purchase_date.save
      test_purchase_date.edit(20141107)
      expect(Purchase_date.all[0].name).to eq "2014-11-07"
    end
  end

  describe '.delete' do
    it "deletes a purchase_date" do
      test_purchase_date = Purchase_date.new({:name => 20141103})
      test_purchase_date.save
      test_purchase_date.delete
      expect(Purchase_date.all).to eq []
    end
  end

  describe '.date_range' do
    it 'returns all purchase date id"s within a specified range' do
      test_date1 = Purchase_date.new({:name => "2014-08-02"})
      test_date1.save
      test_date2 = Purchase_date.new({:name => "2015-04-14"})
      test_date2.save
      test_date3 = Purchase_date.new({:name => "2014-08-30"})
      test_date3.save
      expect(Purchase_date.date_range("2014-08-01", "2014-08-31")).to eq ([test_date1, test_date3])
    end
  end

  describe 'show_expense' do
    it 'returns an expense for a given day' do
      test_date1 = Purchase_date.new({:name => "2014-08-02"})
      test_date1.save
      test_expense = Expense.new({:name => "Burger", :cost => 5.50})
      test_expense.save
      test_expense2 = Expense.new({:name => "frys", :cost => 1.50})
      test_expense2.save
      test_expense.add_purchase_date(test_date1.id)
      test_expense2.add_purchase_date(test_date1.id)
      expect(test_date1.show_expense).to eq ['Burger', 'frys']
    end
  end
end
