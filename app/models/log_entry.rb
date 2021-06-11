class LogEntry
	include Mongoid::Document
	include Mongoid::Timestamps
	include BaseModel

	field :message, type: String
	field :binaries, type: Array, default: [] #[{name: String, remote_path: String}]
	field :keystore, type: Hash, default: {} #{key: Hash}
	field :tags, type: Array, default: [] #[Strings]

	index({ bucket: 1, tags: 1, created_at: -1 }, { background: true })
	index({ created_at: 1 }, { background: true })

	def as_json(options=nil)
		super(options).tap{|e| e['tags'] = e['tags'].select{|t| t.present?}}
	end
	
end