class MonthlyMetrics
	@@ATTRS = [ :blanks_removed, :comments_added, :month, :code_removed, :contributors, :blanks_added, :code_added, :commits, :comments_removed ]
	@@ATTRS.each { | attr | attr_reader attr }
	attr_accessor :metrics

	def initialize (hash) 
		hash.each do | k, v |
			value = v[0]
			value = Integer(value) if k != 'month' # convert everything but month to int
			instance_variable_set('@' + k, value)
		end

		# default metrics we want to get
		@metrics = @@ATTRS
	end

	# gets an ascending list sorted by date of MontlyMentrics 
	def self.makeList (xmlHash)
		keys = xmlHash.keys.sort
		Array.new keys.length do | i |
			MonthlyMetrics.new(xmlHash[keys[i]])
		end
	end

	# makes a hash of date to MonthlyMetrics
	def self.makeHash (xmlHash)
		hash = {}
		xmlHash.keys.each { |k|  hash[k] = MonthlyMetrics.new(xmlHash[k]) }
		hash
	end

	def to_hash 
		hash = {}
		@metrics.each { | attr | hash[attr] = send attr }
		hash
	end

	# derived attributes
	# -------------------------------
	def net_code_added
		@code_added - @code_removed
	end

	def net_comments_added
		@comments_added - @comments_removed
	end	

	def net_blanks_added
		@blanks_added - @blanks_removed
	end

end
