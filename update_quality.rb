require 'award'

#
# award types (name)
#    Blue First
#    Blue Compare
#    Blue Distinction Plus
#    some other type such as 'Normal Item'
#    Blue Star 

def update_quality(awards)
  awards.each do |award|
    if award.name != 'Blue First' && award.name != 'Blue Compare'
      if award.quality > 0
        if award.name != 'Blue Distinction Plus'
	  if award.name == 'Blue Star'
	    award.quality -= 2
	  else
            award.quality -= 1 
	  end
        end
      end
    else
#    blue first or blue  compare
      if award.quality < 50
        award.quality += 1
        if award.name == 'Blue Compare'
          if award.expires_in < 11
            if award.quality < 50
              award.quality += 1 # by 2
            end
          end
          if award.expires_in < 6
            if award.quality < 50
              award.quality += 1 # by 3
            end
          end
        end
      end
    end
    
    if award.name != 'Blue Distinction Plus'
      #  decrease for all other types
      award.expires_in -= 1
    end
    if award.expires_in < 0
      if award.name != 'Blue First'
        if award.name != 'Blue Compare'
          if award.quality > 0
            if award.name != 'Blue Distinction Plus'
	      if award.name.eql?('Blue Star')
		award.quality -= 2
	      else	
                award.quality -= 1
	      end
            end
          end
        else
          award.quality = 0 # award.quality - award.quality
        end
      else
        if award.quality < 50
	  # blue first
          award.quality += 1
        end
      end
    end
  end
end
