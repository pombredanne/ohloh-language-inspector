#!/usr/bin/env ruby

require 'ohloh_response'
require 'monthly_metrics'

require 'rubygems'
require 'json'
require 'sinatra'

def getProjectID (name)
	response = OhlohResponse.getResponse 'projects.xml', { 'query' => name }
	response.result[name]['id'][0]
end

def getActivityFacts (name)
	id = getProjectID name
	response = OhlohResponse.getResponse 'projects/' + id + '/analyses/latest/activity_facts.xml', {} , 'month'
	MonthlyMetrics.makeHash response.result
end

get '/stats.json' do
	content_type :json
	facts = getActivityFacts 'xmonad'

	jsonHash = {}
	facts.keys.each { |k|  jsonHash[k] = facts[k].to_hash }
	jsonHash.to_json
end

# old main method
if nil
#if __FILE__ == $0
	facts = getActivityFacts 'xmonad'
	facts.each do | fact |
		puts "month #{fact.month}\tcode added #{fact.code_added}\tcode removed #{fact.code_removed}"
	end
end


