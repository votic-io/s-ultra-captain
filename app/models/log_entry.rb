class LogEntry
	include Mongoid::Document
	include Mongoid::Timestamps
	include BaseModel

	field :message, type: String
	field :binaries, type: Array, default: [] #[{name: String, remote_path: String}]
	field :keyStore, type: Hash, default: {} #{key: Hash}
	field :tags, type: Array, default: [] #[Strings]

	index({ bucket: 1, tags: 1 }, { background: true })
	
end