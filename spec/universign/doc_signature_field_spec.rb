require 'spec_helper'

describe Universign::DocSignatureField do

  describe '.new' do
    it 'sets a variable + a params in Universign format' do
      params = {
        coordinate: [450, 130],
        page: 1,
        name: 'test',
        signer_index: 1
      }

      document = described_class.new(params)
      doc_params = document.params

      expect(doc_params[:x]).to eq(450)
      expect(doc_params[:y]).to eq(130)
      expect(doc_params[:page]).to eq(1)
      expect(doc_params[:name]).to eq('test')
      expect(doc_params[:label]).to eq(nil)
      expect(doc_params[:signerIndex]).to eq(1)
      expect(doc_params[:patternName]).to eq(nil)
    end
  end

end
