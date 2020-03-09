class Corgi < ApplicationRecord
    include Toyable
    # has_many :toys,
    # foreign_key: :toyable_id,
    # class_name: 'Toy'
end
