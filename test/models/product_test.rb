require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "Product without any attributes" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:price].any?
    assert product.errors[:description].any?
    assert product.errors[:image_url].any?
  end

  test "Product price must be positive" do
    product = Product.new(
      title: "YY",
      description: "KK",
      image_url: "XX.jpg"
    )
    assert product.invalid?

    product.price = -1
    assert product.invalid?

    product.price = 0
    assert product.invalid?

    product.price = 1
    assert product.valid?
  end

  test "Product image url" do
    product = Product.new(
      title: "YY",
      description: "XX",
      price: "30"
    )
    ok = %w{fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg}
    bad = %w{fred.doc fred.gif/more fred.gif.more}
    ok.each {|k|
      product.image_url = k
      assert product.valid?, "#{k} should be valid"
    }
    bad.each {|k|
      product.image_url = k
      assert product.invalid?, "#{k} should be invalid"
    }
  end

  test "Product Name duplicate" do
   product = Product.new(title: products(:ruby).title,
                        description: "I am description",
                        price: 100,
                        image_url: "aa.jpg")
   assert product.invalid?, "product title can not be duplicate"
  end
end
