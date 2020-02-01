class Task < ApplicationRecord
  belongs_to :project
	validates :project_id, presence: true
	validates :content, presence: true
end
