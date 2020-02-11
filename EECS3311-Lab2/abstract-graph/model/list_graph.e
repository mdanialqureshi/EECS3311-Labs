note
	description: "[
			Directed Graph implemented as Adjacency List 
		    in generic parameter G that is Comparable:
				vertices: LIST[VERTEX[G]]
				edges: ARRAY [EDGE [G]]
				-- commands
				add_edge (e: EDGE [G])
				add_vertex (v: VERTEX [G])
				remove_edge (a_edge: EDGE [G])
				remove_vertex (a_vertex: VERTEX [G])
				
				A vertex has outgoing and incoming edges.
				An edge has a source vertex and destination vertex.
				Vertices and Edges must be attached.
	]"
	ca_ignore: "CA023", "CA023: Undeed parentheses", "CA017", "CA107: Empty compound after then part of if"
	author: "JSO and JW"
	date: "$Date$"
	revision: "$Revision$"

class
	LIST_GRAPH [G -> COMPARABLE]

inherit

	ITERABLE [VERTEX [G]]
		redefine
			out
		end

	DEBUG_OUTPUT
		redefine
			out
		end

create
	make_empty, make_from_array

feature -- Model

	model: COMPARABLE_GRAPH [VERTEX [G]]
			-- abstraction function
			-- This must be implemented so that the contracts will work properly
			-- You must find a way to translate the `LIST_GRAPH` implementation into the mathematical
			-- model representation of a graph: `COMPARABLE_GRAPH` (which inherits from `GRAPH`).
		local
			new_edge : PAIR[VERTEX [G],VERTEX[G]]
		do
			create Result.make_empty
			across 1 |..| vertices.count as i loop
				Result.vertex_extend (vertices[i.item])
			end

			across 1 |..| vertices.count as i loop
				-- add incoming edges
				across 1 |..| vertices[i.item].incoming_edge_count as j loop
					create new_edge.make (vertices[i.item].incoming[j.item].source,vertices[i.item])
					Result.edge_extend (new_edge)
				end

				-- add outgoing edges
				across 1 |..| vertices[i.item].outgoing_edge_count as j loop
					create new_edge.make (vertices[i.item],vertices[i.item].outgoing[j.item].destination)
					Result.edge_extend (new_edge)
				end

			end
				-- DONE
		ensure
			comment ("Establishes model consistency invariants")
		end

feature {NONE} -- Initialization

	make_empty
			-- create empty graph
		do
			create {LINKED_LIST [VERTEX [G]]} vertices.make
			vertices.compare_objects
		ensure
			mm_empty_graph: model.is_empty
		end

	get_vertex (g: G): detachable VERTEX [G]
			-- Return the associated vertext object storing `g`, if any.
			-- Note. In the invariant, it is asserted that all vertices are unique.
		do
				-- DONE
			across
				vertices as v
			loop
				if v.item.item ~ g then
					Result := v.item
				end
			end

		ensure
			mm_attached: attached Result implies model.has_vertex (create {VERTEX [G]}.make (g))
			mm_not_attached: not attached Result implies not model.has_vertex (create {VERTEX [G]}.make (g))
		end

	make_from_array (a: ARRAY [TUPLE [src: G; dst: G]])
			-- create a new graph from an array of tuples
			-- each tuple stores contents for the source and the destination
		require
			a.object_comparison
		local
			l_v1, l_v2: VERTEX [G]
			l_e: EDGE [G]
		do
			create {LINKED_LIST [VERTEX [G]]} vertices.make
			vertices.compare_objects
			across
				a as tuple
			loop
				if attached get_vertex (tuple.item.src) as v1 then
					l_v1 := v1 -- so that we do not reset the `income` and `outgoing` lists of the existing vertex
				else
					create l_v1.make (tuple.item.src)
				end
				if attached get_vertex (tuple.item.dst) as v2 then
					l_v2 := v2 -- so that we do not reset the `income` and `outgoing` lists of the existing vertex
				else
					create l_v2.make (tuple.item.dst)
				end
				create l_e.make (l_v1, l_v2)
				if not has_vertex (l_v1) then
					add_vertex (l_v1)
				end
				if not has_vertex (l_v2) then
					add_vertex (l_v2)
				end
				if not has_edge (l_e) then
					add_edge (l_e)
				end
			end
		ensure
			mm_edges:
				-- ∀ [src, dst] ∈ a : [src, dst] ∈ model.edges
				across a as l_edge all
					model.has_edge ([create {VERTEX [G]}.make (l_edge.item.src),
												 create {VERTEX [G]}.make (l_edge.item.dst)])
				end

			mm_vertices:
				-- ∀ [src, dst] ∈ a : src ∈ model.vertices ∧ dst ∈ model.vertices
				across a as l_edge all
					model.has_vertex (create {VERTEX [G]}.make (l_edge.item.src))
					and
					model.has_vertex (create {VERTEX [G]}.make (l_edge.item.dst))
				end
		end

feature -- Iterator Pattern

	new_cursor: ITERATION_CURSOR [VERTEX [G]]
			-- returns a new cursor for current graph
		do
			Result := vertices.new_cursor
		end

feature -- queries

	vertices: LIST [VERTEX [G]]
			-- list of vertices

	vertex_count: INTEGER
			-- number of vertices
		do
				-- DONE
				Result := vertices.count
		ensure
			mm_vertex_count: Result = model.vertex_count
		end

	edge_count: INTEGER
			-- number of outgoing edges
		do
				-- DONE
			across
				vertices as l_vertex
			loop
				Result := Result + l_vertex.item.outgoing_edge_count
			end
		ensure
			mm_edge_count: Result = model.edge_count
		end

	is_empty: BOOLEAN
			-- does the graph contain no vertices?
		do
				-- DONE
				Result := vertices.is_empty
		ensure
			comment ("See invariant empty_consistency")
			mm_is_empty: Result = model.is_empty
		end

	has_vertex (a_vertex: VERTEX [G]): BOOLEAN
			-- does the current graph have `a_vertex`?
		do
				-- DONE
			Result := vertices.has (a_vertex)
		ensure
			mm_has_vertex: Result = model.has_vertex (a_vertex)
		end

	has_edge (a_edge: EDGE [G]): BOOLEAN
			-- does the current graph have `a_edge`?
			-- DONE
		local
			i: INTEGER
		do
			from
				i := 1
			until
				i > vertex_count or Result
			loop
				if vertices [i].has_outgoing_edge (a_edge) then
					Result := True
				end
				i := i + 1
			end
		ensure
			mm_has_edge: Result = model.has_edge ([a_edge.source, a_edge.destination])
		end

	edges: ARRAY [EDGE [G]]
			-- array of all outgoing edges
		do
			create Result.make_empty
				-- DONE
			across
				vertices as l_vertex
			loop
				across
					l_vertex.item.outgoing as l_edge
				loop
					Result.force (l_edge.item, Result.count + 1)
				end
			end
			Result.compare_objects
		ensure
			mm_edges_count: Result.count = model.edge_count
			mm_edges_membership: across Result as l_edge all model.has_edge ([l_edge.item.source, l_edge.item.destination]) end
		end

feature -- Advanced Queries

	topologically_sorted: ARRAY [VERTEX [G]]
			-- Return an array <<..., vi, ..., vj, ...>> such that
			-- (vi, vj) in edges => i < j
			-- A topological sort is performed.
		require
			is_acyclic: model.is_acyclic

		local
			top_sort : ARRAY[VERTEX [G]]
			front : VERTEX[G]
			-- the queue holds elements with in_degree = 0, i.e no dependencies
			queue : QUEUE [VERTEX [G]]
			counter : INTEGER
			-- in degree holds a vertex v at index i corisponding to the incoming edge count held in in_degree2 at index i
			-- of the vertex v.
			in_degree : ARRAY[VERTEX [G]]
			in_degree2 : ARRAY[INTEGER]
			temp : INTEGER
		do
			from
				create queue.make_empty
				create in_degree.make_empty
				create in_degree2.make_empty
				create top_sort.make_empty
				counter := 1
				temp := 1
				across 1 |..| vertices.count as i loop
					in_degree.force (vertices[i.item], i.item);
					in_degree2.force (vertices[i.item].incoming_edge_count, i.item);
				end

				across 1 |..| in_degree2.count as i loop
					if in_degree2[i.item] = 0 then
							queue.enqueue (in_degree[i.item])
					end
				end

			until
				queue.is_empty
			loop
				front := queue.first
				queue.dequeue
				top_sort.force (front,counter)
				counter := counter + 1

				across 1 |..| front.outgoing_sorted.count as i loop
					across 1 |..| in_degree.count as j loop
						if in_degree[j.item].is_equal (front.outgoing_sorted[i.item].destination) then
							temp := in_degree2[j.item] - 1
							in_degree2.force (temp,j.item)
							if in_degree2[j.item] = 0 then
								if not(queue.has (in_degree[j.item])) then
									queue.enqueue (in_degree[j.item])
								end
							end
						end
					end
				end
			end
				create Result.make_from_array (top_sort)
				Result.compare_objects
				-- DONE

		ensure
			mm_sorted: Result ~ model.topologically_sorted.as_array
		end

	is_topologically_sorted (seq: like topologically_sorted): BOOLEAN
			-- does `seq` represent a topological order of the current graph?
		local
			visited : ARRAY[VERTEX[G]]
		do
			create visited.make_empty
			Result := true
			across 1 |..| seq.count as i loop
				visited.force (seq[i.item], i.item)
				across 1 |..| seq[i.item].outgoing_edge_count as j loop
					if visited.has (seq[i.item].outgoing[j.item].destination) and
					 not (seq[i.item].outgoing[j.item].destination.is_equal (seq[i.item])) then
						Result := false;
					end
				end
			end
				-- DONE.
		end

feature -- advanced queries (Lab 1)

	reachable (src: VERTEX [G]): ARRAY [VERTEX [G]]
			-- Starting with vertex `src`, return the list of vertices visited via a breadth-first search.
			-- It is required that `outgoing_sorted` is used for each vertex to reach out to its neighbouring vertices,
			-- so that the resulting array is uniquely ordered.
			-- Note. `outgoing_sorted` is somewhat analogous to `adjacent` in the abstract algorithm documentation of BFS.
		require
			mm_existing_source: model.has_vertex (src)
		local
			queue : QUEUE [VERTEX[G]]
			front : VERTEX[G]
			visited : ARRAY [VERTEX[G]]
			next : VERTEX[G]
			counter : INTEGER
			-- Include declarations for local variables used here
			-- DONE
		do
			create visited.make_empty
			create front.make (src.item)
			create queue.make_empty

			from
				queue.enqueue (src)
				visited := <<src>>
				counter := 1
			until
				queue.is_empty
			loop
				front := queue.first
				queue.dequeue
				across 1|..| front.outgoing_sorted.count as i loop
					next := front.outgoing_sorted[i.item].destination
					if not(visited.has (next)) then
						counter := counter + 1
						visited.force (next, counter)
						queue.enqueue (next)
					end
				end
			end
			create Result.make_from_array (visited) -- Included for compilation
			Result.compare_objects

		ensure
			mm_reachable_in_model: model.reachable (src).as_array ~ Result
		end

feature -- commands

	add_vertex (a_vertex: VERTEX [G])
			-- adds `a_vertex` to current graph
		require
			mm_non_existing_vertex: not model.has_vertex (a_vertex)
		do
				-- DONE.
			vertices.force (a_vertex)
		ensure
			mm_vertex_added: model ~ (old model.deep_twin) + a_vertex
		end

	add_edge (a_edge: EDGE [G])
			-- adds `a_edge` to the current graph
			-- DONE
		require
			mm_existing_source_vertex: model.has_vertex (a_edge.source)
			mm_existing_destination_vertex: model.has_vertex (a_edge.destination)
			mm_non_existing_edge: not model.has_edge ([a_edge.source, a_edge.destination])
		local
			src, dst: VERTEX [G]
			new_edge: EDGE [G]
		do
			 src := a_edge.source
			 dst := a_edge.destination

			across 1 |..| vertices.count as i loop

				-- '~' checks all varibles/attributes of objects
				-- '=' compares addresses of objects for non primatives
				-- is_equal checks both ~ and =. i.e 2 references to same objectß
				if vertices[i.item] ~ a_edge.source then
					if not (vertices[i.item] = a_edge.source) then
						src := vertices[i.item]
					end
				end

				if vertices[i.item] ~ a_edge.destination then
					if not (vertices[i.item] = a_edge.destination) then
						dst := vertices[i.item]
					end
				end
			end

			create new_edge.make (src,dst)

			across 1 |..| vertices.count as i loop
				if vertices[i.item] ~ a_edge.source or vertices[i.item] ~ a_edge.destination then
					vertices[i.item].add_edge (new_edge)
				end
			end
		ensure
			mm_edge_added: model ~ (old model.deep_twin) |\/| [a_edge.source, a_edge.destination]
		end

	remove_edge (a_edge: EDGE [G])
			-- removes `a_edge` from the current graph
			-- DONE
		require
			mm_existing_edge: model.has_edge ([a_edge.source, a_edge.destination])
		local
			src, dst: VERTEX [G]
			new_edge : EDGE[G]
		do
			src := a_edge.source
			dst := a_edge.destination

			across 1|..| vertices.count as i loop

				if vertices[i.item] ~ a_edge.source and vertices[i.item].has_outgoing_edge (a_edge) then
					if not(vertices[i.item] = a_edge.source) then
						src := vertices[i.item]
					end
				end

				if vertices[i.item] ~ a_edge.destination and vertices[i.item].has_incoming_edge (a_edge)  then
					if not (vertices[i.item] = a_edge.destination) then
						dst := a_edge.destination
					end
				end
			end

			create new_edge.make (src,dst)

			across 1 |..| vertices.count as i  loop
				if vertices[i.item] ~ (a_edge.source) and vertices[i.item].has_outgoing_edge (a_edge) or
				(vertices[i.item] ~ (a_edge.destination) and vertices[i.item].has_incoming_edge (a_edge))  then
					vertices[i.item].remove_edge (new_edge)
				end
			end
		ensure
			mm_edge_removed: model ~ (old model.deep_twin) |\ [a_edge.source, a_edge.destination]
		end

	remove_vertex (a_vertex: VERTEX [G])
			-- removes `a_vertex` from the current graph
			-- DONE
		require
			mm_existing_vertex: model.has_vertex (a_vertex)
		local
			offset : INTEGER
		do
			across 1|..| vertices.count as i loop
			  offset := 0
			  across 1|..| vertices[i.item].outgoing.count as j loop
			    if not (vertices[i.item].outgoing.count = 0) then
				    if vertices[i.item].outgoing[j.item - offset].destination ~ a_vertex or vertices[i.item].outgoing[j.item - offset].source ~ a_vertex then
				      vertices[i.item].remove_edge (vertices[i.item].outgoing[j.item - offset])
				      offset := offset + 1
				    end
			    end
			  end

			  offset :=0
			  across 1|..| vertices[i.item].incoming.count as j loop
			    if not (vertices[i.item].incoming.count = 0) then
				    if vertices[i.item].incoming[j.item-offset].destination ~ a_vertex or vertices[i.item].incoming[j.item - offset].source ~ a_vertex then
				      vertices[i.item].remove_edge (vertices[i.item].incoming[j.item - offset])
				      offset := offset + 1
				    end
			    end
			  end
			end
			  vertices.prune_all(a_vertex)
		ensure
			mm_vertex_removed: model ~ (old model.deep_twin) - a_vertex
		end

feature -- out

	comment (s: STRING): BOOLEAN
		do
			Result := true
		end

	debug_output: STRING
			-- returns a string representation of current graph
			-- in the debugger
		do
			Result := ""
			across
				vertices as l_vertex
			loop
				Result := Result + "[" + l_vertex.item.debug_output + "]"
			end
		end

	out: STRING
			-- returns a string representation of current graph
		do
			Result := ""
			across
				vertices as l_vertex
			loop
				Result := Result + "[" + l_vertex.item.out + "]"
			end
		end

feature -- agent functions

	vertices_edge_count: INTEGER
			-- total number of incoming and outgoing edges of all vertices in `vertices`
			-- Result = (Σv ∈ vertices : v.outgoing_edge_count + v.incoming_edge_count)
		do
			Result := vertices_outgoing_edge_count + vertices_incoming_edge_count
		end

	vertices_outgoing_edge_count: INTEGER
			-- total number of outgoing edges of all vertices in `vertices`
			-- Result = (Σv ∈ vertices : v.outgoing_edge_count)
		do
			Result := {NUMERIC_ITERABLE [VERTEX [G]]}.sumf (vertices, agent  (v: VERTEX [G]): INTEGER
				do
					Result := v.outgoing_edge_count
				end)
		end

	vertices_incoming_edge_count: INTEGER
			-- total number of incoming edges of all vertices in `vertices`
			-- Result = (Σv ∈ vertices : v.incoming_edge_count)
		do
			Result := {NUMERIC_ITERABLE [VERTEX [G]]}.sumf (vertices, agent  (v: VERTEX [G]): INTEGER
				do
					Result := v.incoming_edge_count
				end)
		end

invariant
	empty_consistency:
		vertices.count = 0 implies edges.count = 0
	vertex_count = vertices.count
	vertices.lower = 1
	unique_vertices:
		across 1 |..| vertex_count is i all
		across 1 |..| vertex_count is j all
			i /= j implies vertices [i] /~ vertices [j]
		end end
	consistency_incoming_outgoing:
		across vertices is l_vertex all
			across l_vertex.outgoing is l_edge all
				l_edge.destination.has_incoming_edge (l_edge)
			end
			and
			across l_vertex.incoming is l_edge all
				l_edge.source.has_outgoing_edge (l_edge)
			end
		end
	consistency_incoming_outgoing2:
			-- ∀e ∈ edges:
			--	   ∧ e ∈ e.source.outgoing
			--	   ∧ e ∈ e.destination.incoming
		across edges is l_edge all
			l_edge.source.has_outgoing_edge (l_edge)
			and
			l_edge.destination.has_incoming_edge (l_edge)
		end
	model_consistency_vertex_count:
		model.vertex_count = vertex_count
	model_consistency_edge_count:
		model.edge_count = edge_count
	model_consistency_vertices:
		across model.vertices is l_v all
			has_vertex (l_v)
		end
	model_consistency_edges:
		across model.edges is l_e all
			has_edge ([l_e.first, l_e.second])
		end
	count_property_symmetry_1:
		-- (Σv ∈ vertices : v.outgoing_edge_count + v.incoming_edge_count) = 2 * edge_count
		vertices_edge_count = 2 * edge_count
	count_property_symmetry_2:
		-- (Σv ∈ vertices : v.outgoing_edge_count) = (Σv ∈ vertices : v.incoming_edge_count)
		vertices_outgoing_edge_count = vertices_incoming_edge_count
	self_loops_are_incomng_and_outgoing:
		across vertices is l_vertex all
			across l_vertex.incoming is l_edge some
				l_edge.source ~ l_edge.destination
			end
			=
			across l_vertex.outgoing is l_edge some
				l_edge.source ~ l_edge.destination
			end
		end
end
