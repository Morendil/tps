require 'spec_helper'

describe Admin::PiecesJustificativesController, type: :controller  do
  let(:admin) { create(:administrateur) }
  before do
    sign_in admin
  end

  describe 'GET #show' do
    let(:procedure) { create(:procedure, administrateur: admin) }
    let(:procedure_id) { procedure.id }

    subject { get :show, procedure_id: procedure_id }

    context 'when procedure is not found' do
      let(:procedure_id) { 9_999_999 }
      it { expect(subject.status).to eq(404) }
    end

    context 'when procedure have at least a file' do
      let!(:dossier) { create(:dossier,  procedure: procedure, state: :initiated) }
      it { is_expected.to redirect_to admin_procedure_path id: procedure_id }
    end

    context 'when procedure does not belong to admin' do
      let(:admin_2) { create(:administrateur) }
      let(:procedure) { create(:procedure, administrateur: admin_2) }
      it { expect(subject.status).to eq(404) }
    end
  end

  describe 'PUT #update' do
    let(:procedure) { create(:procedure, administrateur: admin) }
    let(:procedure_id) { procedure.id }
    let(:libelle) { 'RIB' }
    let(:description) { "relevé d'identité bancaire" }
    let(:update_params) do
      {
        types_de_piece_justificative_attributes:
        {
          '0' =>
          {
            libelle: libelle,
            description: description
          }
        }
      }
    end

    let(:request) { put :update, procedure_id: procedure_id, format: :js, procedure: update_params }
    subject { request }

    it { is_expected.to render_template('show') }
    it { expect{ subject }.to change(TypeDePieceJustificative, :count).by(1) }
    it 'adds type de pj to procedure' do
      request
      procedure.reload
      pj = procedure.types_de_piece_justificative.first
      expect(pj.libelle).to eq(libelle)
      expect(pj.description).to eq(description)
    end

    context 'when procedure is not found' do
      let(:procedure_id) { 9_999_999 }
      it { expect(subject.status).to eq(404) }
    end

    context 'when libelle is blank' do
      let(:libelle) { '' }
      it { expect{ subject }.not_to change(TypeDePieceJustificative, :count) }
    end
  end

  describe 'DELETE #destroy' do
    let(:procedure) { create(:procedure, administrateur: admin) }
    let!(:pj) { create(:type_de_piece_justificative, procedure: procedure) }
    let(:procedure_id) { procedure.id }
    let(:pj_id) { pj.id }
    let(:request) { delete :destroy, procedure_id: procedure_id, id: pj_id }
    subject { request }
    context 'when procedure is not found' do
      let(:procedure_id) { 9_999_999 }
      it { expect(subject.status).to eq(404) }
    end
    context 'when pj id does not exist' do
      let(:pj_id) { 9_999_999 }
      it { expect(subject.status).to eq(404) }
    end
    context 'when pj id exist but is not linked to procedure' do
      let(:procedure_1) { create(:procedure, administrateur: admin) }
      let!(:pj_1) { create(:type_de_piece_justificative, procedure: procedure_1) }
      let(:pj_id) { pj_1 }
      it { expect(subject.status).to eq(404) }
    end
    context 'when pj is found' do
      it { expect(subject.status).to eq(200) }
      it { expect{ subject }.to change(TypeDePieceJustificative, :count).by(-1) }
    end
  end
end