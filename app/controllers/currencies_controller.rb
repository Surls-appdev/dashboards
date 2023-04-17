class CurrenciesController < ApplicationController
  def first_currency
   @raw_data = open("https://api.exchangerate.host/symbols").read
   @parsed_data = JSON.parse(@raw_data)
   @symbols_hash = @parsed_data.fetch("symbols")
    
    
    @array_of_symbols = @symbols_hash.keys
    render({ :template => "currency_templates/step_one.html.erb"})

  end
  def second_currency
    @raw_data = open("https://api.exchangerate.host/symbols").read
    @parsed_data = JSON.parse(@raw_data)
    @symbols_hash = @parsed_data.fetch("symbols")
    
    # params are
    # Parameters: {"from_currency=>"ARS"}

    @from_symbol = params.fetch("from_currency")
    
    @array_of_symbols = @symbols_hash.keys

    render({ :template => "currency_templates/step_two.html.erb"})
  end
  def conversion
    @raw_data = open("https://api.exchangerate.host/symbols").read
    @parsed_data = JSON.parse(@raw_data) # this turns the JSON into ruby hash rockets
    @symbols_hash = @parsed_data.fetch("symbols") #I use "symbols", which gives me "description"=>"" and "code"=>""
    
    # params are
    # Parameters: {"from_currency=>"ARS", last_currency => "BAM"}

    @from_symbol = params.fetch("from_currency")
    @last_symbol = params.fetch("last_currency")
    @array_of_symbols = @symbols_hash.keys
    
    #Conversion Code:
    @raw_conversion = open("https://api.exchangerate.host/convert?from=#{@from_symbol}&to=#{@last_symbol}").read
    @parsed_conversion = JSON.parse(@raw_conversion) # this turns the JSON into ruby hash rockets
    @conversion_hash = @parsed_conversion.fetch("info") # Instead of "symbols", I use "query", which gives me "from"=>"" and "amount"=>"". INFO gives me the "rate"
    @conversion_rate = @conversion_hash.fetch("rate")

    @array_of_conversion = @conversion_hash.keys
    

    render({ :template => "currency_templates/step_three.html.erb"})

  end

end
