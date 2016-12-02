require 'json'

class CoffeeShop

 attr_reader :shop_name, :address, :phone_number, :menu, :current_order, :order_total

 TAX = 8.64

 def initialize(file = './price-list.json')
  read_file = File.read(file)
  parsed = JSON.parse(read_file)
  @shop_name = parsed[0]['shopName']
  @address = parsed[0]['address']
  @phone_number = parsed[0]['phone']
  @menu = parsed[0]['prices']
  @current_order = []
  @order_total = 0.0
 end

 def order(item, quantity = 1)
   item_check = menu[0].assoc(item)
  if item_check
    item_check.push(quantity)
    update_order_total(menu[0][item], quantity)
    @current_order.push(item_check)
  else
    raise "This item doesn't exist"
  end
 end

 def add_tax
  tax = @order_total / 100 * TAX
  @order_total += tax
 end

 def print_recipt
  @current_order.each do |item|
    p "#{item[2]}x  #{item[0]}  price: #{item[1] * item[2]}"
   end
  add_tax
  p "Total: £#{@order_total.round(2)}"
  save_recipt
  reset
 end

 private

 def save_recipt
  File.open("./oldrecipts.txt","w") do |file|
     file.write(shop_name + "\n")
     file.write(address + "\n")
     @current_order.each do |item|
      list = "#{item[2]}x  #{item[0]}  price: #{item[1] * item[2]}\n"
      file.write(list)
    end
     file.write("Total: £#{@order_total.round(2)}\n")
   end
 end

 def update_order_total(price, quantity)
  @order_total += price * quantity
 end

 def reset
   @current_order = []
   @order_total = 0.0
 end

end
