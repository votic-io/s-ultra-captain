module BaseModel
    extend ActiveSupport::Concern
	include Mongoid::Extensions::Hash::IndifferentAccess

    included do
      	field :bucket, type: String

      	before_create :set_bucket
		
		default_scope lambda {
			where(bucket: Thread.current[:bucket])
		}
		
    	def set_bucket
	    	set(bucket: Thread.current[:bucket])
	    end

    end
end