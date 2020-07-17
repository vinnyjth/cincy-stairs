require 'json'

class StairSet
  attr_accessor :raw_data

  def initialize(raw_data)
    @raw_data = raw_data
  end

  def description
    @raw_data["edge_media_to_caption"]["edges"].map { |edge| edge["node"]["text"] }.join("")
  end

  def steps
    matches = /(?<number_steps>(\d+)|(one)|(two)|(three)|(four)|(five)|(six)|(seven)|(eight)|(nine))\.?(:? \w*){0,5}(( steps)|( stairs))/i.match(self.description)
    matches[:number_steps] if matches
  end

  def link
    "https://www.instagram.com/p/#{@raw_data["shortcode"]}/"
  end

end

raw_stair_data = File.read("./cincystairs.json")
stair_data = JSON.parse(raw_stair_data)["GraphImages"].map { |data| StairSet.new(data) }



pp stair_data.each { |d| puts d.link, d.steps}
