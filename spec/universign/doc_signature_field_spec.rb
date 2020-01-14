require 'spec_helper'

describe Universign::DocSignatureField do

  describe '.new' do
    it 'sets a variable + a params in Universign format' do
      params = {
        coordinate: [450, 130],
        page: 1,
        name: 'test'
      }

      document = described_class.new(params)

      expect(document.params[:x]).to eq(450)
      expect(document.params[:y]).to eq(130)
      expect(document.params[:page]).to eq(1)
      expect(document.params[:name]).to eq('test')
      expect(document.params[:label]).to eq(nil)
      expect(document.params[:signerIndex]).to eq(0)
      expect(document.params[:patternName]).to eq(nil)
    end
  end

end
