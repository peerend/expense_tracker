class Expense

  attr_reader :name, :id, :cost

  def initialize attributes
    @name = attributes[:name]
    @id = attributes[:id]
    @cost = attributes[:cost]
  end

  def save
    result = DB.exec("INSERT INTO expenses (name, cost) VALUES ('#{self.name}', #{self.cost}) RETURNING id;")
    @id = result.first['id'].to_i
  end

  def delete
    DB.exec("DELETE FROM expenses WHERE id = '#{self.id}';")
  end

  def self.all
    results = []
    DB.exec("SELECT * FROM expenses;").each do |result|
      results << Expense.new({:name => result["name"], :cost => result["cost"].to_f, :id => result["id"]})
    end
  results
  end

  def self.total
    total = 0
    self.all.each do |expense|
      total += expense.cost
    end
    total
  end

  def edit_name name
    DB.exec("UPDATE expenses SET name = '#{name}' WHERE id = #{self.id};")
  end

  def edit_cost cost
    DB.exec("UPDATE expenses SET cost = '#{cost}' WHERE id = #{self.id};")
  end

  def == name
    name == self.name
  end

  def self.by_id id
    result = DB.exec("SELECT * FROM #{self.to_s.downcase + 's'} WHERE id = '#{id}';")[0]
    target_object = self.new({:name => result['name'], :id => result['id']})
    target_object
  end

  def add_company company_id
    DB.exec("INSERT INTO expense_company (expense_id, company_id) VALUES (#{self.id}, #{company_id});")
  end

  def show_company
    companies = []
    results = DB.exec("SELECT companys.name FROM companys JOIN expense_company ON (expense_company.company_id = companys.id) WHERE expense_id = #{self.id};")
    results.each do |company|
      companies << company['name']
    end
    companies
  end

  def add_category category_id
    DB.exec("INSERT INTO expense_category (expense_id, category_id) VALUES (#{self.id}, #{category_id});")
  end

  def show_category
    categories = []
    results = DB.exec("SELECT categorys.name FROM categorys JOIN expense_category ON (expense_category.category_id = categorys.id) WHERE expense_id = #{self.id};")
    results.each do |category|
      categories << category['name']
    end
    categories
  end

  def add_purchase_date purchase_date_id
    DB.exec("INSERT INTO expense_date (expense_id, purchase_date_id) VALUES (#{self.id}, #{purchase_date_id});")
  end

  def show_date
    dates = []
    results = DB.exec("SELECT purchase_dates.name FROM purchase_dates JOIN expense_date ON (expense_date.purchase_date_id = purchase_dates.id) WHERE expense_id = #{self.id};")
    results.each do |purchase_date|
      dates << purchase_date['name']
    end
    dates
  end

  def self.category_total cat_select
    total = 0
    self.all.each do |expense|
      if expense.show_category.include?(cat_select)
        total += expense.cost
      end
    end
    total
  end

  def self.category_percent cat_select
    percent = 0
    percent = self.category_total(cat_select) / self.total * 100
    percent
  end
end


