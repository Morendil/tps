class TypeDeChamp < ActiveRecord::Base
  enum type_champs: {text: 'text',
                     textarea: 'textarea',
                     datetime: 'datetime',
                     number: 'number'
       }

  belongs_to :procedure

  has_many :champ, dependent: :destroy

  validates :libelle, presence: true, allow_blank: false, allow_nil: false
  validates :type_champ, presence: true, allow_blank: false, allow_nil: false
  # validates :order_place, presence: true, allow_blank: false, allow_nil: false
end