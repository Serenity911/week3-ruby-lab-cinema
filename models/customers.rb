require_relative("../db/sql_runner")

class Customer

  attr_reader :id
  attr_accessor :name, :funds

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds'].to_i
  end

  def self.all()
    sql = "SELECT * FROM customers"
    result = SqlRunner.run(sql).map{|customer| Customer.new(customer)}
    return result
  end

  def save()
    sql = "INSERT INTO customers (name, funds) VALUES ($1, $2) RETURNING id"
    values = [@name, @funds]
    @id = SqlRunner.run(sql, values).first['id'].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end

  def update()
    sql = "UPDATE customers SET (name, funds) = ($1, $2) WHERE id = $3"
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end

  def get_films()
    sql = "SELECT films.* FROM films
    INNER JOIN tickets
    ON tickets.film_id = films.id
    WHERE tickets.customer_id =$1"
    values = [@id]
    result = SqlRunner.run(sql, values).map{|film| Film.new(film)}
    return result
  end

  def get_tickets()
    sql = "SELECT * FROM tickets WHERE customer_id =$1"
    values = [@id]
    SqlRunner.run(sql, values).ntuples
  end


  def decrease_funds(money)
    return if sufficient_funds?(money) == false
    @funds -= money
  end

  def sufficient_funds?(money)
    return false if @funds < money
    return true
  end

end
