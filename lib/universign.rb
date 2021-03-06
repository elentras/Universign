require 'active_support/core_ext/hash/indifferent_access'

require "universign/version"
require 'xmlrpc/client'
require 'universign/service/document'
require 'universign/service/transaction'
require 'universign/safeguard'
require 'universign/signer'
require 'universign/transaction'
require 'universign/signature_field'
require 'universign/doc_signature_field'
require 'universign/signer_infos'
require 'universign/transaction_signer'
require 'universign/client'
require 'universign/document'
require 'universign/configuration'
require 'universign/error'

module Universign
  include Error
end
