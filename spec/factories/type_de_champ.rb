FactoryGirl.define do
  factory :type_de_champ do
    libelle 'Libellé'
    description 'description de votre projet'
    type_champs 'textarea'
    order_place 1
  end
end