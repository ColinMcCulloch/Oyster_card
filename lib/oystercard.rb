class Oystercard

attr_reader :balance, :entry_station, :exit_station
LIMIT=90
MINIMUM_FARE=1

  def initialize
    self.balance = 0
  end

  def top_up(cash)
    raise "Balance cannot exceed £#{LIMIT}" if balance + cash > LIMIT
    self.balance += cash
  end

  def in_journey?
    !!entry_station
  end

  def touch_in(entry_station)
    fail "Insufficient funds: Please add top up" if balance < MINIMUM_FARE
    @entry_station = entry_station
  end

  def touch_out(exit_station)
    deduct(MINIMUM_FARE)
    @entry_station = nil
    @exit_station = exit_station
  end


  private

  def balance=(cash) # excluding condition => equivalent to attr_writer :balance
    @balance = cash if cash.is_a?(Fixnum)
  end

  def deduct(cash)
    self.balance -= cash
  end

end
