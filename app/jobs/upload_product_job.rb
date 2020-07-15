class UploadProductJob < ApplicationJob
    queue_as :default
  
    def perform(product)
      key = product.user.access_code
      Stripe.api_key = key
  
        Stripe::Product.create({
          id: "#{product.title.parameterize}-p#{product.id}",
          name: "#{product.title.parameterize}-p#{product.id}"
         
        })
  
        Stripe::Price.create({
          currency: 'gbp',
          unit_amount: (product.price.to_r * 100).to_i,
          product: "#{product.title.parameterize}-p#{product.id}",
          nickname: product.title.parameterize
        })

    end
  end
  