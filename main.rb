#!/usr/bin/env ruby

require 'ohloh_response'
require 'monthly_metrics'

def getProjectID (name)
	response = OhlohResponse.getResponse 'projects.xml', { 'query' => name }
	response.result[name]['id'][0]
end

def getActivityFacts (name)
	id = getProjectID name
	response = OhlohResponse.getResponse 'projects/' + id + '/analyses/latest/activity_facts.xml', {} , 'month'
	MonthlyMetrics.makeList response.result
end

if __FILE__ == $0
	facts = getActivityFacts 'xmonad'
	facts.each do | fact |
		puts "month #{fact.month}\tcode added #{fact.code_added}\tcode removed #{fact.code_removed}"
	end
end


