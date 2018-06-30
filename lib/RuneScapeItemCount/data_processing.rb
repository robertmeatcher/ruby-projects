require 'rubygems'
require 'rest-client'
require 'json'

class DataProcessing
  def get_category_number
    puts "Please enter a category number between 0 and 9"
    input = gets.strip
    return input
  end

  def validate_input?(input)
    result = false

    if input.to_s.ord > 47 and input.to_s.ord < 58
      if input.to_i > -1 and input.to_i < 10
        result = true
      end
    end

    return result
  end

  def get_JSON_from_API(categorynumber)
    begin
      url = "http://services.runescape.com/m=itemdb_rs/api/catalogue/category.json?category=" + categorynumber.to_s

      response = RestClient.get(url)

      return response.body
    rescue Exception => e
      puts e.message
      puts e.backtrace.inspect
      raise e
    end
  end

  def parse_JSON_from_API(texttoparse)
    parsedstring = JSON.parse(texttoparse)['alpha']

    return parsedstring
  end

  def count_items(result)
    itemcount = 0

    result.each do |alpha|
      itemcount += alpha['items']
    end

    return itemcount
  end

  def format_output(itemcount, categorynumber)
    categories = ["Miscellaneous", "Ammo", "Arrows", "Bolts", "Construction Materials",
                  "Construction Projects", "Cooking Ingredients", "Costumes",
                  "Crafting Materials", "Familiars"]

    outputtext = "Number of items in " + categories[categorynumber.to_i] + " is " + itemcount.to_s + "\n"

    return outputtext
  end
end
