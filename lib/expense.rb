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

  def add_role author_id
    DB.exec("INSERT INTO authors_roles (author_id, role_id) VALUES (#{author_id}, #{self.id});")
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
end
