require 'spec_helper'

describe 'Company' do
  describe '#initialize' do
    it 'creates a company' do
      test_company = Company.new({:name => "Cyclone"})
      expect(test_company).to be_an_instance_of Company
    end
  end

  describe '.all' do
    it 'returns an empty array' do
      expect(Company.all).to eq []
    end
  end

  describe '#save' do
    it 'saves an company to the companys table' do
      test_company = Company.new({:name => "Burger King"})
      test_company.save
      expect(Company.all).to eq [test_company]
    end
  end

  describe '#edit' do
    it "updates a company's information" do
      test_company = Company.new({:name => "McDonalds"})
      test_company.save
      test_company.edit("Jack in the Box")
      expect(Company.all[0].name).to eq "Jack in the Box"
    end
  end

  describe '.delete' do
    it "deletes a company" do
      test_company = Company.new({:name => "Freds"})
      test_company.save
      test_company.delete
      expect(Company.all).to eq []
    end
  end
end
