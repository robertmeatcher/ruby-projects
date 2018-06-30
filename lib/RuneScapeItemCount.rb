require 'rubygems'
require 'rest-client'
require 'json'

require_relative "../lib/RuneScapeItemCount/data_processing.rb"

module RuneScapeItemCount
    @data_processing = DataProcessing.new
    category_number = -1
    response = ""
    parsedtext = ""
    texttooutput = ""
    itemcount = 0

    until @data_processing.validate_input?(category_number) do
      category_number = @data_processing.get_category_number
    end

    response = @data_processing.get_JSON_from_API(category_number)

    parsedtext = @data_processing.parse_JSON_from_API(response)

    itemcount = @data_processing.count_items(parsedtext)

    texttooutput = @data_processing.format_output(itemcount, category_number)

    puts texttooutput
end
