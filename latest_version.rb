#!/usr/bin/ruby
require 'rest-client'
require 'nokogiri'
require 'pry'

username = 'xxxxxxx'
password = 'xxxxxxxx'
url = "https://#{username}:#{password}@artifactory_url"

r = RestClient.get url
html_doc = Nokogiri::HTML(r)
@munu = Array.new
html_doc.at_css("body").text.split.each do |ver|
  @munu << ver.match(/(\d+\.)(\d+\.)(\d+\.)(\*|\d+)/) unless ver.match(/(\d+\.)(\d+\.)(\d+\.)(\*|\d+)/).nil?
end
@actual = Array.new
@munu.each do |match|
  @actual << match[0]
end

@temp = []
@n = 0
def vers(ary)
  @m = []
  ary.each do |v|
    ver = v.split('.')
    val = ver[@n].to_i
    @m << val
  end
  mv = @m.max 
  ary.each do |v|
    ver = v.split('.')
    val = ver[@n].to_i
    if mv == val
      @temp.push(v)
    end
  end
  ary = @temp
  @n = @n + 1
  if ary.size > 1
    @temp = Array.new
    vers(ary)
  end
  if ary.size == 1
    puts ary
  end
end

vers(@actual)
