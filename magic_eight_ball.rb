#need json gem to read json file containing responses
require 'json'
require 'pry'

#Create a hash using json and array of responses
file = File.read('eight_ball_responses.json')
@response_hash = JSON.parse(file)
@responses = @response_hash["default_answers"].collect {|hash| hash["text"].strip }

#holds procs for extra methods and exiting program 
easter_eggs = {
	"print_answers" => { method: Proc.new{ print_answers } },
	"add_answers" => { method: Proc.new { add_answers } },
	"reset_answers" => { method: Proc.new { reset_answers } },
	"quit" => { method: Proc.new {puts "Goodbye"; exit(0)} },
	"q" => { method: Proc.new {puts "Goodbye"; exit(0)} }
}

########EASTER EGGS METHODS

#helper remove white space and make input case insentive
def get_input
	gets.strip.downcase
end

# allows user to add unique responses(not case senstive)
def add_answers
	puts "Enter a question and hit return to add to responses.  type '(q)uit' to exit"
	while true
		input = get_input
		break if input == 'quit' || input == 'q'
		@responses.include?(input) ? (puts "#{input} already in questions") : @responses << input
		puts "Add another question or type '(q)uit'  to exit"
	end
end

# resets answers
def reset_answers
	@responses = @response_hash["default_answers"].collect {|hash| hash["text"].strip }
	puts "Your answers have been removed"
end

#prints all responses (original and responses and by user)
def print_answers
	@responses.each {|response| puts response.capitalize }
end

# Entry into main Program
first_arg = ARGV[0].strip if ARGV[0]
Binding.pry
ARGV.clear
puts first_arg
add_answers if first_arg == 'add_answers'

while true
	puts "Ask a question or type '(q)uit' to exit"
	input = get_input
	#if user entered an easter egg option call the assciocated proc, else prints random response
	easter_eggs.keys.include?(input) ? easter_eggs[input][:method].call : (puts "#{@responses.sample}")	
end


