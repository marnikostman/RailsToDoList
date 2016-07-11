class Task < ActiveRecord::Base
  validates :title, presence: true,
                    length: { minimum: 5 }
  belongs_to :column
end
