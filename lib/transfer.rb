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

  def reject_transfer
    self.status = "rejected"
    "Transaction rejected. Please check your account balance."
  end

  def execute_transaction
    if valid? && sender.balance > amount && self.status == "pending"
      receiver.deposit(amount)
      sender.deposit(amount * -1)
      self.status = 'complete'
    else
      reject_transfer
    end
  end

  def reverse_transfer
    if valid? && receiver.balance > amount && self.status == "complete"
      receiver.deposit(amount * -1)
      sender.deposit(amount)
      self.status = 'reversed'
    else
      reject_transfer
    end
  end

end
