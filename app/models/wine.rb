class Wine < ApplicationRecord
  belongs_to :user
  belongs_to :varietal
  belongs_to :country
  has_many :wine_aromas
  has_many :aromas, through: :wine_aromas
  has_many :wine_tasting_terms
  has_many :tasting_terms, through: :wine_tasting_terms

  has_one_attached :picture

  # accepts_nested_attributes_for :country
  # accepts_nested_attributes_for :varietal

  validates :varietal_id, :country_id, :vintage, :user_id, :producer, :wine_name, presence: true
  validates :rating, numericality: { less_than_or_equal_to: 10, greater_than: 0,  only_integer: true }

  scope :is_favorite, -> {where(favorite: true)}

  def wine_attributes=(wine)
    self.wine = Wine.find_or_create_by(name: wine.name)
    self.wine.update(wine)
  end
end
