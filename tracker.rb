require 'pry'
class Tracker

  def initialize(trans_list)
    @trans_list = trans_list
    @balance = 0
    @overdraft_fee = 0
    @income = 0
    @expenses = 0
    @overdrafts = []
  end

  def income
    @trans_list.each do |money|
      @income += money[:amount].to_f if money[:amount].to_f > 0
    end
  end

  def expenses
    @trans_list.each do |money|
      @expenses += money[:amount].to_f if money[:amount].to_f < 0
    end
  end

  def balance_tracker
    @trans_list.each do |money|
      @balance += money[:amount].to_f
      if @balance < 0
        @overdraft_fee += 20.00
        @overdrafts << [@balance, money]
      end
    end
    financial_summary
  end

  def financial_summary
    income
    expenses
    final_balance = @balance - @overdraft_fee
    puts "Ending Balance: $#{"%.2f" % final_balance}"
    puts "Total Income: $#{"%.2f" % @income}"
    puts "Total Expenses: $#{"%.2f" % @expenses.abs}"
    overdraft_summary
  end

  def overdraft_summary
    puts "Total Overdraft Charges: $#{"%.2f" % @overdraft_fee}\n\n"
    puts "Overdrafts (balance, expense, description, date)"
    @overdrafts.each do |draft|
      puts "#{"%.2f" % (draft[0] - 20)}, #{draft[1][:amount]}, #{draft[1][:description]}, #{draft[1][:date]}"
    end
  end

end