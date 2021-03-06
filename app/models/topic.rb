# == Schema Information
#
# Table name: topics
#
#  id         :integer          not null, primary key
#  title      :string
#  subject_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_topics_on_subject_id  (subject_id)
#

class Topic < ApplicationRecord
  has_many :topic_assignments, dependent: :destroy
  has_many :tests, through: :topic_assignments

  has_many :questions, dependent: :destroy

  has_many :template_topic_assignments
  has_many :templates, through: :template_topic_assignments

  belongs_to :subject
end
