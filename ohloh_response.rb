require 'rubygems'
require 'xmlsimple'
require 'rest_client'

HOST = 'http://www.ohloh.net/'
API_KEY = 'PMxMU0RSKixTVJZWEcRsbg'

class OhlohResponse
	attr_reader :items_returned, :first_item_position, :items_available, :collection, :result

	def initialize (xmlHash, keyName) 
		if xmlHash['status'][0] != 'success'
			raise xmlHash['error'][0]
		end

		result = xmlHash['result'][0].first[1]

		@collection = false
		if xmlHash['items_returned'] # is this a collection?
			@items_returned = Integer(xmlHash['items_returned'][0]) 
			@first_item_position =  Integer(xmlHash['first_item_position'][0])
			@items_available = Integer(xmlHash['items_available'][0])
			@collection = true
			
			# construct result hash
			@result = {}
			result.each do | item |
				key = item[keyName][0]
				@result[key] = item
			end
		else
			@items_returned = 1
			@first_item_position = 0
			@items_available = 1
			@result = result[0]
		end
	end
	
	def self.getResponse (path, data = {}, keyName = 'name')
		# craft request string
		request = HOST + path
		request += '?api_key=' + API_KEY
		data.each { |k, v| request += '&' + k + '=' + v }

		# get response and parse into xml
		response = RestClient.get request
		xml = XmlSimple.xml_in(response)
		OhlohResponse.new(xml, keyName)
	end
end

