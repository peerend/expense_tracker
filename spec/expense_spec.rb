require 'spec_helper'

describe 'expense' do
  describe '#initialize' do
    it 'creates an expense' do
      test_expense = Expense.new({:name => "Burger", :cost => 5.50})
      expect(test_expense).to be_an_instance_of Expense
    end
  end

  describe '.all' do
    it 'returns an empty array' do
      expect(Expense.all).to eq []
    end
  end

  describe '#save' do
    it 'saves an expense to the expenses table' do
      test_expense = Expense.new({:name => "Burger", :cost => 5.50})
      test_expense.save
      expect(Expense.all[0].cost).to eq 5.50
    end
  end

  describe '#edit_name' do
    it 'edits an expense name on the expenses table' do
      test_expense = Expense.new({:name => "Burger", :cost => 5.50})
      test_expense.save
      test_expense.edit_name('Cheese Burger')
      expect(Expense.all[0].name).to eq 'Cheese Burger'
    end
  end

  describe '#edit_cost' do
    it 'edits an expense cost on the expenses table' do
      test_expense = Expense.new({:name => "Burger", :cost => 5.50})
      test_expense.save
      test_expense.edit_cost(6.5)
      expect(Expense.all[0].cost).to eq 6.5
    end
  end

  describe '#add_company' do
    it 'adds a company to an expense' do
      test_expense = Expense.new({:name => "Burger", :cost => 5.50})
      test_expense.save
      test_company = Company.new({:name => "BK"})
      test_company.save
      test_expense.add_company(test_company.id)
      expect(test_expense.show_company).to eq ["BK"]
    end
  end

  describe '#add_category' do
    it 'adds a category to an expense' do
      test_expense = Expense.new({:name => "Burger", :cost => 5.50})
      test_expense.save
      test_category = Category.new({:name => "Dining"})
      test_category.save
      test_expense.add_category(test_category.id)
      expect(test_expense.show_category).to eq ["Dining"]
    end
  end
  describe '#add_purchase_date' do
    it 'adds a purchase_date to an expense' do
      test_expense = Expense.new({:name => "Burger", :cost => 5.50})
      test_expense.save
      test_purchase_date = Purchase_date.new({:name => "11/05/2014"})
      test_purchase_date.save
      test_expense.add_purchase_date(test_purchase_date.id)
      expect(test_expense.show_date).to eq ["11/05/2014"]
    end
  end
end









