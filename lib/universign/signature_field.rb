module Universign
  class SignatureField
    attr_reader :params

    def initialize(coordinate: [0, 0], name: nil, page: 1, signer_index: 0)
      @coordinate   = coordinate
      @signer_index = signer_index
      @name         = name
      @page         = page

      @params = {
        page: @page,
        x:    @coordinate[0],
        y:    @coordinate[1],
        signerIndex: @signer_index
      }

      @params[:name] = @name unless @name.nil?

      @params
    end
  end
end
