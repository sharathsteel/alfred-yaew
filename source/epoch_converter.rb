require 'json'
require 'time'

class EpochTimeConverter
	attr_accessor :time

	def initialize(time)
		@time = time.strip
	end

	def is_epoch?
		time.gsub(/[0-9]/, '').size == 0
	end

	def to_epoch
		Time.parse(time).to_i rescue "Input Error: No time information"
	end

	def strip_input
		time[0..9].to_i
	end

	def to_datetime
		Time.at(strip_input)
	end

	def convert
		self.is_epoch? ? self.to_datetime : self.to_epoch
	rescue
		"Well well well! Couldnt parse the input '#{time}'"
	end		
end

class AlfredOutput
	def input
		@input ||= ARGV[0].empty? ? `pbpaste` : ARGV[0]
	end

	def generate
		output = EpochTimeConverter.new(input).convert
		line_items = []

		line_items << {
			type: "default",
			title: "Epoch converter",
			subtitle: "#{output} for #{input}",
			arg: output
		}

		puts ({items: line_items}.to_json)
	end
end

AlfredOutput.new.generate


