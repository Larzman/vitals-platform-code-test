
#
# award types (name)
#    Blue First
#    Blue Compare
#    Blue Distinction Plus
#    some other type such as 'Normal Item'
#    Blue Star 

class Award
	attr_accessor	:name, :expires_in, :quality
	
	def initialize(name, expires_in, quality)
		@name = name
		@expires_in = expires_in
		@quality = quality
	end
	
	def self.update_quality(awards)
		awards.each{|award| award.update_quality}		
	end

	def update_quality
		upd_quality
		upd_expiration
	end	

	private
	
	# update quality field based on current value and award name
	def upd_quality
		award = self
		if award.name != 'Blue Distinction Plus'
			if ['Blue First', 'Blue Compare'].include?(award.name)
				if award.quality < 50
					award.quality += 1
					if award.name == 'Blue Compare'						
						if award.expires_in < 6
							award.quality += 2 # by 3
						elsif award.expires_in < 11
							award.quality += 1	# by 2
						end
					end
					award_quality = 50 if award.quality > 50
				end					
			elsif award.quality > 0				
				if award.name == 'Blue Star'
					award.quality -= 2
				else
					award.quality -= 1 
				end							
			end
		end
	end

	#
    # update the expires_in experation field.
	# if experation_in indicates an expired award (by being negative),
	# then further changes to quality may occur here.
	#
	def upd_expiration	
		award = self
		if award.name != 'Blue Distinction Plus'
			award.expires_in -= 1
		
			if award.expires_in < 0
				if award.name != 'Blue First'
					if award.name != 'Blue Compare'
						if award.quality > 0							
							if award.name.eql?('Blue Star')
								award.quality -= 2
							else	
								award.quality -= 1
							end							
						end
					else
						award.quality = 0
					end
				elsif award.quality < 50 
					# blue first scenario
					award.quality += 1					
				end
			end
		end
	end

	
end	

