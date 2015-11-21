require 'json'

#Create a hash using JSON
file = File.read('eight_ball_responses.json')
@response_hash = JSON.parse(file)
@responses = @response_hash["default_answers"].collect {|hash| hash["text"].strip }

puts @responses.inspect
easter_eggs = {
	"print_answers" => { method: Proc.new{ print_answers } },
	"add_answers" => { method: Proc.new { add_answers } },
	"reset_answers" => { method: Proc.new { reset_answers } },
	"quit" => { method: Proc.new {puts "Goodbye"; exit(0)} }
}
########EASTER EGGS METHODS

#helper
def get_input
	gets.strip.downcase
end

def add_answers
	puts "Enter questions return hit type quit to exit"
	while true
		input = get_input
		break if input == 'quit' || input == 'q'
		if @responses.include?(input)
			puts "#{input} already in questions"
		else
			@responses << input
		end
	end
end

def reset_answers
	@responses = @response_hash["default_answers"].collect {|hash| hash["text"].strip }
	puts "Your answers have been removed"
end

def print_answers
	@responses.each {|response| puts response.capitalize }
end



# Main Program
while true
	puts "Ask a question or type 'quit' to exit"
	input = get_input
	if easter_eggs.keys.include? input
		easter_eggs[input][:method].call 
	else
		puts @response_hash["default_answers"][rand(3)]["text"].capitalize
	end
end





# end



