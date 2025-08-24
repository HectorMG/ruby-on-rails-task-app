# == Schema Information
#
# Table name: tasks
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  code        :string
#  due_date    :string
#  category_id :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Task < ApplicationRecord
  belongs_to :category

  validates :name, :description, presence: true
  validates :name, uniqueness: { case_sensitive: false }
  validate  :due_date_validation

  def due_date_validation
    return if due_date.blank?
    return if due_date.to_date > Date.today
    errors.add(:due_date, I18n.t("tasks.erros.invalid_due_date"))
  end
end
