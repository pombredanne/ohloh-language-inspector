#!/usr/bin/env ruby

require 'ohloh_response'
require 'test/unit'

class OhlohResponseTests < Test::Unit::TestCase 

	def testProjectResponse
		testResponse = OhlohResponse.getResponse 'projects.xml', { 'query' => 'xmonad' }
		assert(testResponse.items_returned > 1)
		assert(testResponse.first_item_position == 0)
		assert(testResponse.items_available > 1)
		assert(testResponse.collection)
		
		xmonadItem = testResponse.result['xmonad']
		assert(xmonadItem['name'][0] == 'xmonad')
	end	

end
