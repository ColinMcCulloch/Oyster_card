class Oystercard

attr_reader :balance, :history
LIMIT=90
MINIMUM_FARE=1

  def initialize
    self.balance = 0
    @history = {}
    @current_journey = []
    @counter = 0
  end

  def top_up(cash)
    raise "Balance cannot exceed £#{LIMIT}" if balance + cash > LIMIT
    self.balance += cash
  end

  def in_journey?
    @current_journey[0] != nil
  end

  def touch_in(entry_station)
    fail "Insufficient funds: Please add top up" if balance < MINIMUM_FARE
    # @in_journey = true
    @current_journey[0] = entry_station
  end

  def touch_out(exit_station)
    deduct(MINIMUM_FARE)
    @counter += 1
    @current_journey[1] = exit_station
    @history[:"J#{@counter}"] = @current_journey
    @current_journey = []
  end


  private

  def balance=(cash) # excluding condition => equivalent to attr_writer :balance
    @balance = cash if cash.is_a?(Fixnum)
  end

  def deduct(cash)
    self.balance -= cash
  end

end
