=begin
#OPEX API

#No description provided (generated by Swagger Codegen https://github.com/swagger-api/swagger-codegen)

OpenAPI spec version: 2.0.14-alpha

Generated by: https://github.com/swagger-api/swagger-codegen.git
Swagger Codegen version: 2.4.0

=end

require 'uri'

module SwaggerClient
  class AccountApi
    attr_accessor :api_client

    def initialize(api_client = ApiClient.default)
      @api_client = api_client
    end
    # Get list of user accounts
    # @param [Hash] opts the optional parameters
    # @return [Array<Account>]
    def get_account_balances(opts = {})
      data, _status_code, _headers = get_account_balances_with_http_info(opts)
      data
    end

    # Get list of user accounts
    # @param [Hash] opts the optional parameters
    # @return [Array<(Array<Account>, Fixnum, Hash)>] Array<Account> data, response status code and response headers
    def get_account_balances_with_http_info(opts = {})
      if @api_client.config.debugging
        @api_client.config.logger.debug 'Calling API: AccountApi.get_account_balances ...'
      end
      # resource path
      local_var_path = '/peatio/account/balances'

      # query parameters
      query_params = {}

      # header parameters
      header_params = {}
      # HTTP header 'Accept' (if needed)
      header_params['Accept'] = @api_client.select_header_accept(['application/json'])

      # form parameters
      form_params = {}

      # http body (model)
      post_body = nil
      auth_names = []
      data, status_code, headers = @api_client.call_api(:GET, local_var_path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => 'Array<Account>')
      if @api_client.config.debugging
        @api_client.config.logger.debug "API called: AccountApi#get_account_balances\nData: #{data.inspect}\nStatus code: #{status_code}\nHeaders: #{headers}"
      end
      return data, status_code, headers
    end
    # Get user account by currency
    # @param currency The currency code.
    # @param [Hash] opts the optional parameters
    # @return [Account]
    def get_account_balances_currency(currency, opts = {})
      data, _status_code, _headers = get_account_balances_currency_with_http_info(currency, opts)
      data
    end

    # Get user account by currency
    # @param currency The currency code.
    # @param [Hash] opts the optional parameters
    # @return [Array<(Account, Fixnum, Hash)>] Account data, response status code and response headers
    def get_account_balances_currency_with_http_info(currency, opts = {})
      if @api_client.config.debugging
        @api_client.config.logger.debug 'Calling API: AccountApi.get_account_balances_currency ...'
      end
      # verify the required parameter 'currency' is set
      if @api_client.config.client_side_validation && currency.nil?
        fail ArgumentError, "Missing the required parameter 'currency' when calling AccountApi.get_account_balances_currency"
      end
      # verify enum value
      if @api_client.config.client_side_validation && !['bch', 'btc', 'dash', 'eth', 'ltc', 'trst', 'usd', 'xrp'].include?(currency)
        fail ArgumentError, "invalid value for 'currency', must be one of bch, btc, dash, eth, ltc, trst, usd, xrp"
      end
      # resource path
      local_var_path = '/peatio/account/balances/{currency}'.sub('{' + 'currency' + '}', currency.to_s)

      # query parameters
      query_params = {}

      # header parameters
      header_params = {}
      # HTTP header 'Accept' (if needed)
      header_params['Accept'] = @api_client.select_header_accept(['application/json'])

      # form parameters
      form_params = {}

      # http body (model)
      post_body = nil
      auth_names = []
      data, status_code, headers = @api_client.call_api(:GET, local_var_path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => 'Account')
      if @api_client.config.debugging
        @api_client.config.logger.debug "API called: AccountApi#get_account_balances_currency\nData: #{data.inspect}\nStatus code: #{status_code}\nHeaders: #{headers}"
      end
      return data, status_code, headers
    end
    # Returns deposit address for account you want to deposit to by currency. The address may be blank because address generation process is still in progress. If this case you should try again later.
    # @param currency The account you want to deposit to.
    # @param [Hash] opts the optional parameters
    # @option opts [String] :address_format Address format legacy/cash
    # @return [Deposit]
    def get_account_deposit_address_currency(currency, opts = {})
      data, _status_code, _headers = get_account_deposit_address_currency_with_http_info(currency, opts)
      data
    end

    # Returns deposit address for account you want to deposit to by currency. The address may be blank because address generation process is still in progress. If this case you should try again later.
    # @param currency The account you want to deposit to.
    # @param [Hash] opts the optional parameters
    # @option opts [String] :address_format Address format legacy/cash
    # @return [Array<(Deposit, Fixnum, Hash)>] Deposit data, response status code and response headers
    def get_account_deposit_address_currency_with_http_info(currency, opts = {})
      if @api_client.config.debugging
        @api_client.config.logger.debug 'Calling API: AccountApi.get_account_deposit_address_currency ...'
      end
      # verify the required parameter 'currency' is set
      if @api_client.config.client_side_validation && currency.nil?
        fail ArgumentError, "Missing the required parameter 'currency' when calling AccountApi.get_account_deposit_address_currency"
      end
      # verify enum value
      if @api_client.config.client_side_validation && !['bch', 'btc', 'dash', 'eth', 'ltc', 'trst', 'xrp', 'BCH', 'BTC', 'DASH', 'ETH', 'LTC', 'TRST', 'XRP'].include?(currency)
        fail ArgumentError, "invalid value for 'currency', must be one of bch, btc, dash, eth, ltc, trst, xrp, BCH, BTC, DASH, ETH, LTC, TRST, XRP"
      end
      if @api_client.config.client_side_validation && opts[:'address_format'] && !['legacy', 'cash'].include?(opts[:'address_format'])
        fail ArgumentError, 'invalid value for "address_format", must be one of legacy, cash'
      end
      # resource path
      local_var_path = '/peatio/account/deposit_address/{currency}'.sub('{' + 'currency' + '}', currency.to_s)

      # query parameters
      query_params = {}
      query_params[:'address_format'] = opts[:'address_format'] if !opts[:'address_format'].nil?

      # header parameters
      header_params = {}
      # HTTP header 'Accept' (if needed)
      header_params['Accept'] = @api_client.select_header_accept(['application/json'])

      # form parameters
      form_params = {}

      # http body (model)
      post_body = nil
      auth_names = []
      data, status_code, headers = @api_client.call_api(:GET, local_var_path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => 'Deposit')
      if @api_client.config.debugging
        @api_client.config.logger.debug "API called: AccountApi#get_account_deposit_address_currency\nData: #{data.inspect}\nStatus code: #{status_code}\nHeaders: #{headers}"
      end
      return data, status_code, headers
    end
    # Get your deposits history.
    # @param [Hash] opts the optional parameters
    # @option opts [String] :currency Currency value contains bch,btc,dash,eth,ltc,trst,usd,xrp,BCH,BTC,DASH,ETH,LTC,TRST,USD,XRP
    # @option opts [Integer] :limit Set result limit. (default to 3)
    # @option opts [String] :state
    # @return [Array<Deposit>]
    def get_account_deposits(opts = {})
      data, _status_code, _headers = get_account_deposits_with_http_info(opts)
      data
    end

    # Get your deposits history.
    # @param [Hash] opts the optional parameters
    # @option opts [String] :currency Currency value contains bch,btc,dash,eth,ltc,trst,usd,xrp,BCH,BTC,DASH,ETH,LTC,TRST,USD,XRP
    # @option opts [Integer] :limit Set result limit.
    # @option opts [String] :state 
    # @return [Array<(Array<Deposit>, Fixnum, Hash)>] Array<Deposit> data, response status code and response headers
    def get_account_deposits_with_http_info(opts = {})
      if @api_client.config.debugging
        @api_client.config.logger.debug 'Calling API: AccountApi.get_account_deposits ...'
      end
      if @api_client.config.client_side_validation && opts[:'currency'] && !['bch', 'btc', 'dash', 'eth', 'ltc', 'trst', 'usd', 'xrp', 'BCH', 'BTC', 'DASH', 'ETH', 'LTC', 'TRST', 'USD', 'XRP'].include?(opts[:'currency'])
        fail ArgumentError, 'invalid value for "currency", must be one of bch, btc, dash, eth, ltc, trst, usd, xrp, BCH, BTC, DASH, ETH, LTC, TRST, USD, XRP'
      end
      if @api_client.config.client_side_validation && opts[:'state'] && !['submitted', 'canceled', 'rejected', 'accepted', 'collected'].include?(opts[:'state'])
        fail ArgumentError, 'invalid value for "state", must be one of submitted, canceled, rejected, accepted, collected'
      end
      # resource path
      local_var_path = '/peatio/account/deposits'

      # query parameters
      query_params = {}
      query_params[:'currency'] = opts[:'currency'] if !opts[:'currency'].nil?
      query_params[:'limit'] = opts[:'limit'] if !opts[:'limit'].nil?
      query_params[:'state'] = opts[:'state'] if !opts[:'state'].nil?

      # header parameters
      header_params = {}
      # HTTP header 'Accept' (if needed)
      header_params['Accept'] = @api_client.select_header_accept(['application/json'])

      # form parameters
      form_params = {}

      # http body (model)
      post_body = nil
      auth_names = []
      data, status_code, headers = @api_client.call_api(:GET, local_var_path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => 'Array<Deposit>')
      if @api_client.config.debugging
        @api_client.config.logger.debug "API called: AccountApi#get_account_deposits\nData: #{data.inspect}\nStatus code: #{status_code}\nHeaders: #{headers}"
      end
      return data, status_code, headers
    end
    # Get details of specific deposit.
    # @param txid 
    # @param [Hash] opts the optional parameters
    # @return [Deposit]
    def get_account_deposits_txid(txid, opts = {})
      data, _status_code, _headers = get_account_deposits_txid_with_http_info(txid, opts)
      data
    end

    # Get details of specific deposit.
    # @param txid 
    # @param [Hash] opts the optional parameters
    # @return [Array<(Deposit, Fixnum, Hash)>] Deposit data, response status code and response headers
    def get_account_deposits_txid_with_http_info(txid, opts = {})
      if @api_client.config.debugging
        @api_client.config.logger.debug 'Calling API: AccountApi.get_account_deposits_txid ...'
      end
      # verify the required parameter 'txid' is set
      if @api_client.config.client_side_validation && txid.nil?
        fail ArgumentError, "Missing the required parameter 'txid' when calling AccountApi.get_account_deposits_txid"
      end
      # resource path
      local_var_path = '/peatio/account/deposits/{txid}'.sub('{' + 'txid' + '}', txid.to_s)

      # query parameters
      query_params = {}

      # header parameters
      header_params = {}
      # HTTP header 'Accept' (if needed)
      header_params['Accept'] = @api_client.select_header_accept(['application/json'])

      # form parameters
      form_params = {}

      # http body (model)
      post_body = nil
      auth_names = []
      data, status_code, headers = @api_client.call_api(:GET, local_var_path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => 'Deposit')
      if @api_client.config.debugging
        @api_client.config.logger.debug "API called: AccountApi#get_account_deposits_txid\nData: #{data.inspect}\nStatus code: #{status_code}\nHeaders: #{headers}"
      end
      return data, status_code, headers
    end
    # List your withdraws as paginated collection.
    # @param [Hash] opts the optional parameters
    # @option opts [String] :currency Any supported currencies: bch,btc,dash,eth,ltc,trst,usd,xrp,BCH,BTC,DASH,ETH,LTC,TRST,USD,XRP.
    # @option opts [Integer] :page Page number (defaults to 1). (default to 1)
    # @option opts [Integer] :limit Number of withdraws per page (defaults to 100, maximum is 1000). (default to 100)
    # @return [Array<Withdraw>]
    def get_account_withdraws(opts = {})
      data, _status_code, _headers = get_account_withdraws_with_http_info(opts)
      data
    end

    # List your withdraws as paginated collection.
    # @param [Hash] opts the optional parameters
    # @option opts [String] :currency Any supported currencies: bch,btc,dash,eth,ltc,trst,usd,xrp,BCH,BTC,DASH,ETH,LTC,TRST,USD,XRP.
    # @option opts [Integer] :page Page number (defaults to 1).
    # @option opts [Integer] :limit Number of withdraws per page (defaults to 100, maximum is 1000).
    # @return [Array<(Array<Withdraw>, Fixnum, Hash)>] Array<Withdraw> data, response status code and response headers
    def get_account_withdraws_with_http_info(opts = {})
      if @api_client.config.debugging
        @api_client.config.logger.debug 'Calling API: AccountApi.get_account_withdraws ...'
      end
      if @api_client.config.client_side_validation && opts[:'currency'] && !['bch', 'btc', 'dash', 'eth', 'ltc', 'trst', 'usd', 'xrp', 'BCH', 'BTC', 'DASH', 'ETH', 'LTC', 'TRST', 'USD', 'XRP'].include?(opts[:'currency'])
        fail ArgumentError, 'invalid value for "currency", must be one of bch, btc, dash, eth, ltc, trst, usd, xrp, BCH, BTC, DASH, ETH, LTC, TRST, USD, XRP'
      end
      # resource path
      local_var_path = '/peatio/account/withdraws'

      # query parameters
      query_params = {}
      query_params[:'currency'] = opts[:'currency'] if !opts[:'currency'].nil?
      query_params[:'page'] = opts[:'page'] if !opts[:'page'].nil?
      query_params[:'limit'] = opts[:'limit'] if !opts[:'limit'].nil?

      # header parameters
      header_params = {}
      # HTTP header 'Accept' (if needed)
      header_params['Accept'] = @api_client.select_header_accept(['application/json'])

      # form parameters
      form_params = {}

      # http body (model)
      post_body = nil
      auth_names = []
      data, status_code, headers = @api_client.call_api(:GET, local_var_path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => 'Array<Withdraw>')
      if @api_client.config.debugging
        @api_client.config.logger.debug "API called: AccountApi#get_account_withdraws\nData: #{data.inspect}\nStatus code: #{status_code}\nHeaders: #{headers}"
      end
      return data, status_code, headers
    end
  end
end
