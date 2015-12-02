class Oystercard

attr_reader :balance
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
    @in_journey
  end

  def touch_in
    fail "Insufficient funds: Please add top up" if balance < MINIMUM_FARE


    @in_journey = true

  end
  def touch_out
    deduct(MINIMUM_FARE)
    @in_journey = false
  end


  private

  def balance=(cash) # excluding condition => equivalent to attr_writer :balance
    @balance = cash if cash.is_a?(Fixnum)
  end

  def deduct(cash)
    self.balance -= cash
  end

end
