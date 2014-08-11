class Wallet

  attr_reader :name, :id

  def initialize attributes
    @name = attributes[:name]
    @id = attributes[:id]
  end

  def save
    result = DB.exec("INSERT INTO #{self.class.to_s.downcase + 's'} (name) VALUES ('#{self.name}') RETURNING id;")
    @id = result.first['id'].to_i
  end

  def delete
    DB.exec("DELETE FROM #{self.class.to_s.downcase + 's'} WHERE id = '#{self.id}';")
  end

    def self.all
    results = []
    DB.exec("SELECT * FROM #{self.to_s.downcase + 's'};").each do |result|
      results << self.new({:name => result["name"], :id => result["id"]})
    end
    results
  end

  def edit name
    DB.exec("UPDATE #{self.class.to_s.downcase + 's'} SET name = '#{name}' WHERE id = #{self.id};")
  end

  def == name
    name == self.name
  end

  def self.by_id id
    result = DB.exec("SELECT * FROM #{self.to_s.downcase + 's'} WHERE id = '#{id}';")[0]
    target_object = self.new({:name => result['name'], :id => result['id']})
    target_object
  end

end
