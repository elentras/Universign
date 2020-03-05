require 'spec_helper'

describe Universign::Document do
  let(:signature_params) {
    { coordinate: [450, 130], page: 1, signer_index: 0 }
  }

  describe '.new' do
    it 'sets a variable + a params in Universign format' do
      [
        # VARIABLE    # UNIVERSIGN  # VALUE
        ['name',      'name',       'DocumentName'],
        ['url',       'url',        'DocumentUrl'],
        ['meta_data', 'metaData',   { data: 1 }]
      ].each do |key, universign_name, params|
        document = described_class.new(key => params)

        expect(document.params).to have_key(universign_name)
        expect(document.send(key)).to eql(params)
      end
    end

    it "set signature_fields is provided in Universign format" do
      key = 'signature_fields'
      universign_name = 'signatureFields'
      params = [signature_params]

      document = described_class.new(key => params)
      expect(document.params).to have_key(universign_name)
      expect(document.send(key)).to eql([{"page"=>1, "signerIndex"=>0, "x"=>450, "y"=>130}])
    end

    context 'meta_data is not a hash' do
      it 'raises an exception' do
        expect {
          described_class.new(meta_data: 1)
        }.to raise_error(Universign::Document::MetaDataMustBeAHash)
      end
    end

    context 'content is set' do
      it 'convert the content to XMLRPC::Base64 on params' do
        file = File.dirname(__FILE__) + '/../fixtures/png_file.png'
        document = described_class.new(content: File.open(file).read)

        expect(document.params[:content]).to be_instance_of(XMLRPC::Base64)
      end
    end

    context 'doc_signature_fields is not a hash or an array' do
      it 'raises an exception if not an array' do
        expect {
          described_class.new(signature_fields: 1)
        }.to raise_error(Universign::Document::DocSignatureFieldMustBeAnArray)
      end
    end
  end

  describe '.from_data' do
    let(:data) { {
      documentType: 'application/pdf',
      content:      'AAA...',
      metaData: { data: 1 }
    } }

    it 'returns a new Document' do
      document = described_class.from_data(data)
      expect(document).to be_instance_of(described_class)
    end

    it 'sets param = data' do
      document = described_class.from_data(data)

      expect(document.params).to eql(HashWithIndifferentAccess.new(data))
    end

    it 'keep the HashWithIndifferentAccess' do
      document = described_class.from_data(data)

      expect(document.params.class).to eql HashWithIndifferentAccess
    end
  end
end
