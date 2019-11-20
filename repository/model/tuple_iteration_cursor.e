note
	description: "Summary description for {TUPLE_ITERATION_CURSOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TUPLE_ITERATION_CURSOR[K -> HASHABLE, V1, V2]

inherit
	ITERATION_CURSOR[TUPLE[V1, V2, K]]

create
	make

feature {NONE}
	i: INTEGER
	keys: LINKED_LIST[K]
	values_1: ARRAY[V1] 
	table: HASH_TABLE[V2, K]

feature
	make (t: HASH_TABLE[V2, K]; ks: LINKED_LIST[K]; vs_1: ARRAY[V1])
		do
			keys := ks
			values_1 := vs_1
			table := t
			i := 1
			keys.start
		end

feature
	item: TUPLE[V1, V2, K]
		do
			check attached table[keys.item] as v2 then
				Result := [values_1[i], v2, keys.item]
			end
		end

	after: BOOLEAN
		do
			Result := keys.after
		end

	forth
		do
			keys.forth
			i := i + 1
		end
end
