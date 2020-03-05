module Universign
  class SignatureField
    attr_reader :params

    def initialize(coordinate: [0, 0], name: nil, page: 1)
      @coordinate   = coordinate
      @name         = name
      @page         = page

      @params = {
        page: @page,
        x:    @coordinate[0],
        y:    @coordinate[1]
      }

      @params[:name] = @name unless @name.nil?

      @params
    end
  end
end
