class Product < ApplicationRecord
    validates :title, :description, :category_id, presence: true 
    validates :price, numericality: { greater_than_or_equal_to: 0.01 }
    belongs_to :user
    belongs_to :category
    has_many :line_items 
    before_destroy :ensure_not_referenced_by_any_line_item
    private 

    def ensure_not_referenced_by_any_line_item
        unless line_items.empty?
            errors.add(:base, 'Line Items present')
            throw :abort
        end
    end
end
