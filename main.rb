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

def getActivityFacts (name, factNames)
	id = getProjectID name
	response = OhlohResponse.getResponse 'projects/' + id + '/analyses/latest/activity_facts.xml', {} , 'month'
	MonthlyMetrics.makeHash response.result, factNames
end

get '/stats.json' do
	content_type :json
	factNames = [ 'contributors', 'net_code_added', 'net_comments_added', 'net_blanks_added' ]
	facts = getActivityFacts 'xmonad', factNames

	jsonHash = {}
	facts.keys.each do |k|
		month = facts[k]
		jsonHash[k] = month.to_hash
	end
	jsonHash.to_json
end

