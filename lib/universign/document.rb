module Universign
  class Document
    include Universign::Safeguard

    attr_reader :name, :file_content, :file_url
    attr_accessor :params

    # Create a new Universign::Document
    #
    # @param [Hash] options
    # @option options [Array<Byte>] :content Content of the PDF
    # @option options [String] :url URL of the PDF
    # @option options [String] :name Name of the PDF
    # @option options [Array<String>] :checkbox_texts strings that signers must validates for signing
    # @option options [Hash] :meta_data Hash to join to the PDF
    # @option options [Array<DocSignatureField>] :signature_fields A description of a visible PDF signature field.
    def initialize(options = {})
      @params = HashWithIndifferentAccess.new

      options.each do |key, value|
        send("#{key}=", value)
      end
    end

    # Create a new document from a Hash
    #
    # @param [Hash] data
    # @return [Universign::Document]
    def self.from_data(data)
      @params = data

      document = Universign::Document.new
      document.params.merge!(@params)
      document
    end

    # The raw content of the PDF document
    #
    # @return [Array<Byte>]
    def content
      @content ||= params['content']
    end

    def content=(data)
      @content         = data
      params[:content] =  XMLRPC::Base64.new(data)
    end

    # The URL to download the PDF document
    #
    # @return [String]
    def url
      @url ||= params['url']
    end

    def url=(data)
      @url          = data
      params['url'] = data
    end

    # The type of this document
    #
    # @return [String]
    def document_type
      @document_type ||= params['documentType']
    end

    # The file name of this document
    #
    # @return [String]
    def name
      @name ||= params['name']
    end

    def name=(data)
      @name          = data
      params['name'] = data
    end

    # The checkboxes texts to display for the signing validity
    #
    # @return [Array<String>]
    def checkbox_texts
      @checkbox_texts ||= params['CheckBoxesTexts']
    end

    def checkbox_texts=(data)
      if !data.is_a?(Array)
        raise CheckBoxesTextsMustBeAnArray
      end

      @checkbox_texts         = data
      params['CheckBoxesTexts'] = data
    end

    # The meta data of the PDF document
    #
    # @return [Hash]
    def meta_data
      @meta_data ||= params['metaData']
    end

    def meta_data=(data)
      if !data.is_a?(Hash)
        raise MetaDataMustBeAHash
      end

      @meta_data         = data
      params['metaData'] = data
    end

    # The signature fields of the PDF document
    #
    # @return [Array<DocSignatureField>]
    def signature_fields
      @signature_fields ||= params['signatureFields']
    end

    def signature_fields=(data)
      if !data.is_a?(Array)
        raise DocSignatureFieldMustBeAnArray
      end

      data.each do |signature_entry|
        @signature_fields ||= []
        @signature_fields << Universign::DocSignatureField.new(signature_entry).params
      end
      params['signatureFields'] = @signature_fields
    end
    #                          _   _
    #   _____  _____ ___ _ __ | |_(_) ___  _ __  ___
    #  / _ \ \/ / __/ _ \ '_ \| __| |/ _ \| '_ \/ __|
    # |  __/>  < (_|  __/ |_) | |_| | (_) | | | \__ \
    #  \___/_/\_\___\___| .__/ \__|_|\___/|_| |_|___/
    #                   |_|
    class UnknownDocument < StandardError; end
    class NotSigned < StandardError; end
    class MissingDocument < StandardError; end
    class MetaDataMustBeAHash < StandardError; end
    class CheckBoxesTextsMustBeAnArray < StandardError; end
    class DocSignatureFieldMustBeAnArray < StandardError; end
    class DocumentURLInvalid < StandardError
      attr_accessor :url

      def initialize(url)
        @url = url
      end

      def to_s
        "Can't find document at '#{@url}''"
      end
    end
  end
end
