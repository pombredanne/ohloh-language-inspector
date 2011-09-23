#!/usr/bin/env ruby

require 'rubygems'
#require 'json'
require 'xmlsimple'
require 'rest_client'

HOST = 'http://www.ohloh.net/'
API_KEY = 'PMxMU0RSKixTVJZWEcRsbg'

def getResponse (path, data = {})
	request = HOST + path
	request += '?api_key=' + API_KEY
	data.each { |k, v| request += '&' + k + '=' + v }

	response = RestClient.get request
	XmlSimple.xml_in(response)
end

if __FILE__ == $0
	test = getResponse 'languages.xml', { 'query' => 'java'}
	#puts test
	puts test.inspect
end
