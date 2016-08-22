require 'json'

class EpochTimeGenerator
	attr_accessor :time

	def initialize(time)
		@time = time
	end

	def in_ms
		(time.to_f * 1000).to_i
	end

	def in_seconds
		time.to_i
	end
end

class AlfredOutput

	def generate
		time = EpochTimeGenerator.new(Time.now)
		line_items = []

		line_items << {
			type: "default",
			title: "Time in milliseconds",
			subtitle: "#{time.in_ms}, Hit ENTER to copy to clipboard",
			arg: time.in_ms
		}

		line_items << {
			type: "default",
			title: "Time in seconds",
			subtitle: "#{time.in_seconds}, Hit ENTER to copy to clipboard",
			arg: time.in_seconds
		}

		puts ({items: line_items}.to_json)
	end
end

AlfredOutput.new.generate
