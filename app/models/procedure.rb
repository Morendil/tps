class Procedure < ActiveRecord::Base
  has_many :types_de_piece_justificative, dependent: :destroy
  has_many :types_de_champ, dependent: :destroy
  has_many :dossiers, dependent: :destroy

  has_one :module_api_carto, dependent: :destroy

  belongs_to :administrateur

  delegate :use_api_carto, to: :module_api_carto

  accepts_nested_attributes_for :types_de_champ,:reject_if => proc { |attributes| attributes['libelle'].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :types_de_piece_justificative, :reject_if => proc { |attributes| attributes['libelle'].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :module_api_carto

  mount_uploader :logo, ProcedureLogoUploader

  validates :libelle, presence: true, allow_blank: false, allow_nil: false
  validates :description, presence: true, allow_blank: false, allow_nil: false

  def types_de_champ_ordered
    types_de_champ.order(:order_place)
  end

  def switch_types_de_champ index_of_first_element
    return false if index_of_first_element < 0
    types_de_champ_tmp = types_de_champ_ordered
    nb_types_de_champ = types_de_champ_tmp.count
    return false if index_of_first_element == nb_types_de_champ - 1
    return false if types_de_champ_ordered.count < 1
    types_de_champ_tmp[index_of_first_element].update_attributes(order_place: index_of_first_element + 1)
    types_de_champ_tmp[index_of_first_element + 1].update_attributes(order_place: index_of_first_element)
    true
  end

  def locked?
    dossiers.where.not(state: :draft).count > 0
  end
end
