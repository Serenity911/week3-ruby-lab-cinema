require_relative("../db/sql_runner")

class Ticket

attr_reader :id, :customer_id, :screening_id

  def initialize( options )
    @id = options['id'] if options['id']
    @customer_id = options['customer_id'].to_i
    @screening_id = options['screening_id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM tickets"
    result = SqlRunner.run(sql).map{|ticket| Ticket.new(ticket)}
    return result
  end

  def save()
    sql = "INSERT INTO tickets (customer_id, screening_id) VALUES ($1, $2) RETURNING id"
    values = [@customer_id, @screening_id]
    @id = SqlRunner.run(sql, values).first['id'].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM tickets"
    SqlRunner.run(sql)
  end

  # def update()
  #   sql = "UPDATE tickets SET (film_id, customer_id) = ($1, $2) WHERE id = $3"
  #   values = [@film_id, @customer_id, @id]
  #   SqlRunner.run(sql, values)
  # end



  # def self.sell(customer, screening_time)
  #   return if film.find() == nil
  #   return if customer.sufficient_funds?(film.price) == false
  #   customer.decrease_funds(film.price)
  #   ticket = Ticket.new({"film_id" => film.id, "customer_id" => customer.id})
  #   ticket.save
  #   return ticket
  # end
end
