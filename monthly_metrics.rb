
class MonthlyMetrics
	attr_reader :blanks_removed, :comments_added, :month, :code_removed, :contributors, :blanks_added, :code_added, :commits, :comments_removed

	def initialize (hash) 
		hash.each do | k, v |
			value = v[0]
			value = Integer(value) if k != 'month' # convert everything but month to int
			instance_variable_set('@' + k, value)
		end
	end

	# gets an ascending list sorted by date of MontlyMentrics 
	def self.makeList (xmlHash)
		keys = xmlHash.keys.sort
		Array.new keys.length do | i |
			MonthlyMetrics.new(xmlHash[keys[i]])
		end
	end

end
