note
	description: "[
		An Edge has a source and destination vertex:
			source: VERTEX [G]
			destination: VERTEX [G]
		An edge can be created from two vertices 
		or from a tuple (see convert).
	]"
	author: "JSO and JW"
	date: "$Date$"
	revision: "$Revision$"

class
	EDGE [G -> COMPARABLE]

inherit

	ANY
		redefine
			is_equal,
			out
		end

	DEBUG_OUTPUT
		redefine
			is_equal,
			out
		end

create
	make, make_from_tuple

convert
	make_from_tuple ({TUPLE [VERTEX [G], VERTEX [G]]})

feature {NONE} -- creation

	make (v1, v2: like source)
		do
			source := v1
			destination := v2
		end

	make_from_tuple (a_tuple: like as_tuple)
		do
			source := a_tuple.source
			destination := a_tuple.destination
		end

feature -- basic queries

	source: VERTEX [G]
			-- source of edge

	destination: VERTEX [G]
			-- destination of edge

feature -- derived queries

	reverse_edge: like Current
		do
			Result := [destination, source]
		ensure
			destination ~ Result.source
			source ~ Result.destination
		end

	as_tuple: TUPLE [source: VERTEX [G]; destination: VERTEX [G]]
		do
			Result := [source, destination]
		end


	is_equal (other: like Current): BOOLEAN
		do
			Result := source ~ other.source and destination ~ other.destination
		end

feature

	out: STRING
		do
			Result := source.out + "," + destination.item.out
		end

	debug_output: STRING
		do
				--			Result := source.item.out + "," + destination.item.out
			Result := destination.item.out
		end

end
