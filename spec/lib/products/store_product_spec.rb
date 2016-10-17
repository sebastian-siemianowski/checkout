require_relative '../../../lib/products/store_product'

module Products
  describe StoreProduct do
    subject(:product) do
      StoreProduct.new(
        "id" => '1',
        "name" => 'foo bar',
        "price" => '11.30',
        "product_code" => '001'
      )
    end

    it "has an id" do
      expect(product.id).to eq 1
    end

    it "has text" do
      expect(product.name).to eq "foo bar"
    end

    it "has price" do
      expect(product.price).to eq 11.30
    end

    it "has product code" do
      expect(product.product_code).to eq '001'
    end

    describe ".all" do
      subject(:all) { Products::StoreProduct.all }

      it "loads 3 products from the datastore" do
        expect(all.size).to eq 3
      end

      it "instantates instances of store_product" do
        all.all? { |product| expect(product).to be_a StoreProduct }
      end

      it "creates the store products with the correct data" do
        product_names = all.map(&:name)
        expect(product_names).to eq(["Lavender heart", "Personalised cufflinks", "Kids T-shirt "])
      end
    end

    describe ".find" do
      subject(:found) { StoreProduct.find(1) }
      let(:products) { [product].compact }

      before(:each) { allow(StoreProduct).to receive(:all).and_return(products) }

      context "when the product can't be found" do
        let(:product) {}

        it "returns nil" do
          expect(found).to be_nil
        end
      end

      context "when there is a product to find" do
        let(:product) { StoreProduct.new("id" => "1", "text" => "foo") }

        it "finds the product" do
          expect(found).to eq(product)
        end
      end
    end

  end
end