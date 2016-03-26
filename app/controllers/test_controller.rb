class TestController < ApplicationController
	def test
	end

	def act
		remote = params.require(:remote)
		command = params.require(:command)

		`irsend SEND_ONCE #{remote} KEY_#{command}`

		render json: '{ status: "ok" }' 
	end
end
