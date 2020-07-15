class Category < ApplicationRecord
    validates :category, presence: true 
    
    has_many :products
    belongs_to :user
end
