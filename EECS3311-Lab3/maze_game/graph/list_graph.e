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
	LIST_GRAPH[G -> COMPARABLE]
inherit
	ITERABLE[VERTEX[G]]
		redefine out end

	DEBUG_OUTPUT
		redefine out end

create
	make_empty

feature -- Model

	model: COMPARABLE_GRAPH[VERTEX[G]]
			-- abstraction function
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
			comment("Establishes model consistency invariants")
		end

feature {NONE} -- Initialization

	make_empty
			-- create empty graph
		do
			create {LINKED_LIST[VERTEX[G]]} vertices.make
			vertices.compare_objects
		ensure
			mm_empty_graph: model.is_empty
		end

	get_vertex(g: G): detachable VERTEX[G]
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
			mm_attached:
				attached Result implies model.has_vertex (create {VERTEX[G]}.make (g))
			mm_not_attached:
				not attached Result implies not model.has_vertex (create {VERTEX[G]}.make (g))
		end


feature -- Iterator Pattern
	new_cursor: ITERATION_CURSOR [VERTEX[G]]
		do
			Result := vertices.new_cursor
		end

feature -- queries

	vertices: LIST[VERTEX[G]]

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

	has_vertex(a_vertex: VERTEX[G]): BOOLEAN
		do
		-- DONE
			Result := vertices.has (a_vertex)
		ensure
			mm_has_vertex: Result = model.has_vertex (a_vertex)
		end

	has_edge(a_edge: EDGE[G]): BOOLEAN
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

	edges: ARRAY[EDGE[G]]
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
			mm_edges_count:
				Result.count = model.edge_count
			mm_edges_membership:
				across Result as l_edge all
					model.has_edge ([l_edge.item.source, l_edge.item.destination])
				end
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

	-- is the destination vertex reachable from the source vertex
	is_reachable(src : VERTEX[G]; dst : VERTEX[G]) : BOOLEAN
		require
			mm_existing_source_and_dest:
					model.has_vertex (src) and model.has_vertex (dst)
		local
			reachable_v : ARRAY [VERTEX[G]]
		do
			reachable_v := reachable (src)
			Result := false

			across 1 |..| reachable_v.count as i loop
			  if reachable_v[i.item] ~ dst then
			  		Result := true
			  end
			end

		ensure
			mm_unchanged:
					model ~ (old model.deep_twin)
		end


	shortest_path (v1, v2: VERTEX[G]): SEQ [VERTEX[G]]
			-- Return the shortest path between v1 and v2 if it exists.
			-- Bredth-First Search is used without assuming that there are no self-loops.
		local
			parent: FUN [VERTEX[G], VERTEX[G]]
			complete: BOOLEAN
			current_vertex: VERTEX[G]
		do
			create Result.make_empty
			parent := bfs_for_shortest_path (v1)
			if parent.domain.has (v2) then
				from
					current_vertex := v2
					create Result.make_empty
				until
					complete
				loop
					Result.prepend (current_vertex)
					if current_vertex ~ v1 then
						complete := True
					else
						check
								parent.domain.has (current_vertex)
						end
						current_vertex := parent [current_vertex]
					end
				end
			elseif v1 ~ v2 then
				create Result.make_empty
				Result.prepend (v1)
			end
		ensure

		end

	bfs_for_shortest_path (src: VERTEX[G]): FUN [VERTEX[G], VERTEX[G]]
			-- Breadth-First Search
			-- Starting with vertex src,
			-- return the parent of each reachable vertex on their shortest path back to src.
		local
			visited: SET [VERTEX[G]]
			q: ARRAYED_QUEUE [VERTEX[G]]
			l_front, l_adjacent: VERTEX[G]
		do
			create Result.make_empty
			create visited.make_empty
			create q.make (vertices.count)
			from
				q.extend (src)
			until
				q.is_empty
			loop
				l_front := q.item
				if not visited.has (l_front) then
					visited.extend (l_front)
					across
						l_front.outgoing_sorted as v
					loop
						l_adjacent := v.item.destination
						if visited.has (l_adjacent) then
						else
							q.extend (l_adjacent)
							if not Result.domain.has (l_adjacent) then
								Result.extend (create {PAIR [VERTEX[G], VERTEX[G]]}.make_from_tuple ([l_adjacent, l_front]))
							end
						end
					end
				end
				q.remove
			end
		end


feature -- commands

	add_vertex(a_vertex: VERTEX[G])
		require
			mm_non_existing_vertex:
				not model.has_vertex (a_vertex)
		do
			--DONE
			vertices.force (a_vertex)
		ensure
			mm_vertex_added:
				model ~ (old model.deep_twin) + a_vertex
		end

	add_edge(a_edge: EDGE[G])
		require
			mm_existing_source_vertex:
				model.has_vertex (a_edge.source)
			mm_existing_destination_vertex:
				model.has_vertex (a_edge.destination)
			mm_non_existing_edge:
				not model.has_edge ([a_edge.source, a_edge.destination])
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
			mm_edge_added:
				model ~ (old model.deep_twin) |\/| [a_edge.source, a_edge.destination]
		end

	remove_edge(a_edge: EDGE[G])
		require
			mm_existing_edge:
				model.has_edge ([a_edge.source, a_edge.destination])
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
			mm_edge_removed:
				model ~ (old model.deep_twin) |\ [a_edge.source, a_edge.destination]
		end

	remove_vertex(a_vertex: VERTEX[G])
		require
			mm_existing_vertex:
				model.has_vertex (a_vertex)
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
			mm_vertex_removed:
				model ~ (old model.deep_twin) - a_vertex
		end

feature -- out

	comment(s: STRING): BOOLEAN
		do
			Result := true
		end

	debug_output: STRING
		do
			Result := ""
			across vertices as l_vertex loop
				Result := Result + "[" + l_vertex.item.debug_output + "]"
			end
		end

	out: STRING
		do
			Result := ""
			across vertices as l_vertex loop
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
			Result := {NUMERIC_ITERABLE[VERTEX[G]]}.sumf(
								vertices,
								agent (v: VERTEX[G]): INTEGER
									do
										Result := v.outgoing_edge_count
									end)
		end

	vertices_incoming_edge_count: INTEGER
			-- total number of incoming edges of all vertices in `vertices`
			-- Result = (Σv ∈ vertices : v.incoming_edge_count)
		do
			Result := {NUMERIC_ITERABLE[VERTEX[G]]}.sumf(
								vertices,
								agent (v: VERTEX[G]): INTEGER
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
		across 1 |..| vertex_count as i all
		across 1 |..| vertex_count as j all
		i.item /= j.item implies vertices[i.item] /~ vertices[j.item]
		end
		end

	consistency_incoming_outgoing:
		across vertices is l_vertex all
			across l_vertex.outgoing is l_edge all
				l_edge.destination.has_incoming_edge(l_edge)
			end
			and
			across l_vertex.incoming is l_edge all
				l_edge.source.has_outgoing_edge(l_edge)
			end
		end

	consistency_incoming_outgoing2:
		-- ∀e ∈ edges:
		--	   ∧ e ∈ e.source.outgoing
		--	   ∧ e ∈ e.destination.incoming
		across edges as l_edge all
			l_edge.item.source.has_outgoing_edge(l_edge.item)
			and
			l_edge.item.destination.has_incoming_edge(l_edge.item)
		end

	model_consistency_vertex_count:
		model.vertex_count = vertex_count

	model_consistency_edge_count:
		model.edge_count = edge_count

	model_consistency_vertices:
		across model.vertices as l_v all
			has_vertex (l_v.item)
		end

	model_consistency_edges:
		across model.edges as l_e all
			has_edge ([l_e.item.first, l_e.item.second])
		end

	count_property_symmetry_1: -- (Σv ∈ vertices : v.outgoing_edge_count + v.incoming_edge_count) = 2 * edge_count
		vertices_edge_count = 2 * edge_count

	count_property_symmetry_2: -- (Σv ∈ vertices : v.outgoing_edge_count) = (Σv ∈ vertices : v.incoming_edge_count)
		vertices_outgoing_edge_count = vertices_incoming_edge_count

	self_loops_are_incomng_and_outgoing:
		across
			vertices is l_vertex
		all
			across l_vertex.incoming is l_edge  some
				l_edge.source ~ l_edge.destination
			end
			=
			across l_vertex.outgoing is l_edge  some
				l_edge.source ~ l_edge.destination
			end
		end
end
