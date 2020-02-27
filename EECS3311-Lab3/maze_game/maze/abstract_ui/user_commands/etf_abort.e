note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_ABORT
inherit
	ETF_ABORT_INTERFACE
create
	make
feature -- command
	abort
    	do
			-- perform some update on the model state
			if model.is_in_game then
				model.abort
			else
				model.set_msg ("Error! Not in a game.")
				model.next_state
				model.set_abort(true)
			end
			etf_cmd_container.on_change.notify ([Current])
    	end

end
