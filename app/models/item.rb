class Item < ApplicationRecord
has_one_attached :image
has_many :genre, dependent: :destroy
end
