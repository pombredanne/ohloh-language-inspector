#!/usr/bin/env ruby

require 'ohloh_response'


def getProjectID (name)
	response = getResponse 'projects.xml', { 'query' => name }
end

if __FILE__ == $0
	test = OhlohResponse.getResponse 'projects.xml', { 'query' => 'xmonad' }
	puts test.result['xmonad'].inspect
end


