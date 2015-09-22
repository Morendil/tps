require 'spec_helper'

describe 'backoffice/index.html.haml', type: :view do
  let!(:procedure) { create(:procedure) }
  let!(:decorated_dossier) { create(:dossier, procedure: procedure).decorate }
  before do
    assign(:dossiers, [decorated_dossier])
    render
  end
  subject { rendered }
  it { is_expected.to have_css('#backoffice') }
  it { is_expected.to have_content('Demande de subvention') }
  it { is_expected.to have_content(procedure.libelle) }
  it { is_expected.to have_content(decorated_dossier.nom_projet) }
  it { is_expected.to have_content(decorated_dossier.last_update) }
end