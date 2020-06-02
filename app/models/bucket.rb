class Bucket
	include Mongoid::Document
	include Mongoid::Timestamps
	include BaseModel

	index({ bucket: 1 }, { unique: true})
end