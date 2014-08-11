require 'spec_helper'

describe 'category' do
  describe '#initialize' do
    it 'creates a category' do
      test_category = Category.new({:name => "Cyclone"})
      expect(test_category).to be_an_instance_of Category
    end
  end

  describe '.all' do
    it 'returns an empty array' do
      expect(Category.all).to eq []
    end
  end

  describe '#save' do
    it 'saves an category to the categorys table' do
      test_category = Category.new({:name => "Burger King"})
      test_category.save
      expect(Category.all).to eq [test_category]
    end
  end

  describe '#edit' do
    it "updates a category's information" do
      test_category = Category.new({:name => "McDonalds"})
      test_category.save
      test_category.edit("Jack in the Box")
      expect(Category.all[0].name).to eq "Jack in the Box"
    end
  end

  describe '.delete' do
    it "deletes a category" do
      test_category = Category.new({:name => "Freds"})
      test_category.save
      test_category.delete
      expect(Category.all).to eq []
    end
  end
end
