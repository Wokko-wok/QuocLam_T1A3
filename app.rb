require 'csv'
require 'tty-prompt'
require_relative './loading'

prompt = TTY::Prompt.new
# make csv into an array of hashes
table = CSV.open('orders.csv', headers: true)
table_array = []
table.each do |line|
  table_array << [line['Name'], line['NumOrders'], line['Status'], line['Priority']]
end

pending_orders_arr = get_pending_customers(table_array)
started_orders_arr = get_started_customers(table_array)
dispatched_orders_arr = get_dispatched_customers(table_array)

menu = 'Home'
loop do
  case menu
  when 'Home'
    menu = prompt.select(
      'What would you like to do?',
      [
        'View Pending Orders',
        'View Started Orders',
        'View Dispatched Orders',
        'Exit'
      ], cycle: true
    )
  when 'View Pending Orders'
    create_customers = create_customers(pending_orders_arr)
    menu = prompt.select(
      'Select a customer', create_customers, 'Return'
    )
  when 'View Started Orders'
    create_customers = create_customers(started_orders_arr)
    menu = prompt.select(
      'Select a customer', create_customers, 'Return'
    )
  when 'View Dispatched Orders'
    create_customers = create_customers(dispatched_orders_arr)
    menu = prompt.select(
      'Select a customer', create_customers, 'Return'
    )
    puts dispatched_orders_arr[0][0].class
    puts menu.class
    function(menu, dispatched_orders_arr)
  when 'Return'
    menu = 'Home'

  when 'Exit'
    break
  end
end