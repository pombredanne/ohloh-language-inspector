#!/usr/bin/env ruby

require 'rubygems'
#require 'json'
require 'xmlsimple'
require 'rest_client'

HOST = 'http://www.ohloh.net/'
API_KEY = 'PMxMU0RSKixTVJZWEcRsbg'
DEFAULT_PARAMS = { :api_key => API_KEY }

def getResponse (path, data = {})
	request = HOST + path
	params = DEFAULT_PARAMS.merge(data)
	response = RestClient.get request, params
	XmlSimple.xml_in(response)
end

if __FILE__ == $0
	test = getResponse 'languages'
	#puts test
	puts test.inspect
end
