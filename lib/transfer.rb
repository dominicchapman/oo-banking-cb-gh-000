class Transfer

  attr_accessor :sender, :receiver, :amount, :status

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = 'pending'
  end

  def valid?
    sender.valid? && receiver.valid?
  end

  def execute_transaction
    if valid?
      receiver.deposit(amount)
      sender.deposit(amount * -1)
      self.status = 'complete'
    else
      self.status = 'rejected'
      "Transaction rejected. Please check your account balance."
    end
  end

end
