class Purchase_date < Wallet

  def self.date_range(start, finish)
    range = []
    self.all.each do |range_day|
      if range_day.name > start && range_day.name < finish
        range << range_day
      end
    end
    range
  end

  def show_expense
    expenses = []
    results = DB.exec("SELECT * FROM expenses JOIN expense_date ON (expense_date.purchase_date_id = #{self.id}) WHERE expense_id = expenses.id;")
    results.each do |result|
    expenses << result['name']
    end
    expenses
  end
end
