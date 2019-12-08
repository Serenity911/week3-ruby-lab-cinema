require_relative("../db/sql_runner")

class Ticket

attr_reader :id, :customer_id, :film_id

  def initialize( options )
    @id = options['id'] if options['id']
    @film_id = options['film_id'].to_i
    @customer_id = options['customer_id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM tickets"
    result = SqlRunner.run(sql).map{|ticket| Ticket.new(ticket)}
    return result
  end

  def save()
    sql = "INSERT INTO tickets (film_id, customer_id) VALUES ($1, $2) RETURNING id"
    values = [@film_id, @customer_id]
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

end
