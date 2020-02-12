module Universign
  class DocSignatureField < SignatureField
    attr_reader :params

    # signer_index [M] int The index of the signer which uses this field. Signers are enumerated starting at 0.
    # patternName [O] string The name of the pattern. May be used if more than one pattern
    #   is set. The default value is "default". The magic value "invisible"
    #   means that the field will not be visible in the PDF.
    # label [O] string A label which defines the signature field. This label will be
    #   printed in the signature page if set. If a signer has more than
    #   one field on the same document, label becomes mandatory.
    # image [O] byte[] The image to be displayed in the signature field, it will replace
    #   the default UNIVERSIGN logo. Image format must be JPG, JPEG
    #   or PNG. A recommended resolution for this image is 150x36px.
    #   The image will be resized if the image has a different resolution.
    def initialize(coordinate:, name: nil, page:, signer_index: 0, pattern_name: nil, label: nil)
      @signer_index = signer_index
      @pattern_name = pattern_name
      @label = label

      @params = super(coordinate: coordinate, name: name, page: page).tap do |params|
        params[:signerIndex] = @signer_index
        params[:patternName]  = @pattern_name unless @pattern_name.nil?
        params[:label]        = @label unless @label.nil?
      end

      @params
    end
  end
end
