#!/usr/bin/env ruby
require 'csv'
require_relative 'tracker'
require 'pry'

trans_list = []
CSV.foreach('transactions.csv', headers: true) do |row|
  trans_list << {date: row['date'], amount: row['amount'], description: row['description']}
end

tracker = Tracker.new(trans_list)
tracker.balance_tracker