note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_MOVE
inherit
	ETF_MOVE_INTERFACE
create
	make
feature -- command
	move(a_direction: INTEGER_32)
		require else
			move_precond(a_direction)
    	local

    	do
			-- perform some update on the model state
			if model.is_in_game then
				model.set_msg ("ok")
				model.move(a_direction)
			else
				model.set_msg ("Error! Not in a game.")
				model.next_state
			end

			etf_cmd_container.on_change.notify ([Current])
    	end

end
