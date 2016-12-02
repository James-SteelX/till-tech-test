require './lib/coffee_shop.rb'

describe CoffeeShop do

  let(:shop) { described_class.new }

  describe 'New Shop' do

    it 'gives coffee shop a name from json file' do
      expect(shop.shop_name).to eq "The Coffee Connection"
    end

    it 'has a phone number given from the json file' do
      expect(shop.phone_number).to eq "16503600708"
    end

    it 'has an address given from the json file' do
      expect(shop.address).to eq "123 Lakeside Way"
    end

    it 'has a menu passed in from the json file' do
      expect(shop.menu).to be_a Array
      expect(shop.menu).not_to be_empty
    end
  end

  describe 'Order' do
    it 'adds the ordered item to your current_order' do
      shop.order('Tea')
      expect(shop.current_order[0]).to include('Tea')
    end

    it 'adds multiple items to the current_order' do
      shop.order('Tea', 3)
      expect(shop.current_order[0]).to include('Tea', 3)
    end

    it 'updates order total (before tax)' do
      shop.order('Tea')
      expect(shop.order_total).to eq(3.65)
    end

    it 'raises error if item doesnt exist' do
      expect { shop.order('Welsh Cakes') }.to raise_error("This item doesn't exist")
    end
  end

  describe 'Add Tax' do
    it 'adds tax to current order total' do
      shop.order('Tea')
      shop.add_tax
      expect(shop.order_total.round(2)).to eq(3.97)
    end
  end

  describe 'Print Recipt' do
    it 'resets the current order and total' do
      shop.order('Tea')
      shop.print_recipt
      expect(shop.current_order).to be_empty
      expect(shop.order_total).to eq(0.0)
    end
  end

end
