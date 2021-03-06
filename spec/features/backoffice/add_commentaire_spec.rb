require 'spec_helper'

feature 'add commentaire on backoffice' do
  let(:dossier) { create(:dossier, :with_entreprise, :with_procedure) }
  let(:dossier_id) { dossier.id }
  let!(:commentaire) { create(:commentaire, dossier: dossier, email: 'toto@toto.com') }
  let(:email_commentaire) { 'test@test.com' }
  let(:gestionnaire) { create(:gestionnaire) }
  let(:email_pre_rempli) { 'toto@sgmap.fr' }
  let(:body) { 'Commentaire de test' }

  before do
    login_as gestionnaire, scope: :gestionnaire
    visit backoffice_dossier_path(dossier)
  end

  context 'Affichage du flux de commentaire' do
    scenario 'l\'email du contact est présent' do
      expect(page).to have_selector('span[id=email_contact]')
    end

    scenario 'la date du commentaire est présent' do
      expect(page).to have_selector('span[id=created_at]')
    end

    scenario 'le corps du commentaire est présent' do
      expect(page).to have_selector('div[class=description][id=body]')
    end
  end

  context 'Affichage du formulaire de commentaire' do
    scenario 'Le formulaire envoie vers /dossiers/:dossier_id/commentaire en #POST' do
      expect(page).to have_selector("form[action='/backoffice/commentaires?dossier_id=#{dossier_id}'][method=post]")
    end

    scenario 'Champs de texte' do
      expect(page).to have_selector('textarea[id=texte_commentaire][name=texte_commentaire]')
    end
  end
end
