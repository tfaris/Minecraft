import cython


@cython.locals(int_f=int)
cpdef int normalize_float(float f)


@cython.locals(x=float, y=float, z=float)
cpdef tuple normalize(tuple position)


@cython.locals(x=int, y=int, z=int)
cpdef tuple sectorize(tuple position)


@cython.locals(spreading_mutations=dict)
cdef class World(dict):
    cdef public:
        batch
        transparency_batch
        group
        dict shown
        dict _shown
        sectors
        urgent_queue, lazy_queue
        spreading_mutable_blocks
        double spreading_time

    cpdef object add_block(self, tuple position, object block,
                           bint sync=?, bint force=?)

    @cython.locals(sector_position=tuple)
    cpdef object remove_block(self, object player, tuple position, bint sync=?, bint sound=?)

    # Generators are not handled by Cython for the moment.
    # @cython.locals(x=float, y=float, z=float,
    #                dx=float, dy=float, dz=float)
    # cpdef object neighbors_iterator(self, tuple position,
    #                                 tuple relative_neighbors_positions=?)

    @cython.locals(other_position=tuple)
    cpdef object check_neighbors(self, tuple position)

    @cython.locals(other_position=tuple)
    cpdef bint has_neighbors(self, tuple position,
                             tuple is_in=?,bint diagonals=?, tuple faces=?)

    @cython.locals(x=float, y=float, z=float, above_position=tuple)
    cpdef object check_spreading_mutable(self, tuple position, object block)

    @cython.locals(other_position=tuple)
    cpdef bint is_exposed(self, tuple position)

    @cython.locals(m=int, _=int,
                   x=float, y=float, z=float,
                   dx=float, dy=float, dz=float,
                   previous=tuple, key=tuple)
    cpdef tuple hit_test(self, tuple position, tuple vector,
                         int max_distance=?)

    cpdef object hide_block(self, tuple position, bint immediate=?)

    cpdef object _hide_block(self, tuple position)

    @cython.locals(block=object)
    cpdef object show_block(self, tuple position, bint immediate=?)

    @cython.locals(x=float, y=float, z=float,
                   index=int, count=int,
                   vertex_data=list, texture_data=list,
                   dx=float, dy=float, dz=float,
                   i=int, j=int, batch=object)
    cpdef object _show_block(self, tuple position, object block)

    cpdef object show_sector(self, tuple sector, bint immediate=?)

    @cython.locals(position=tuple)
    cpdef object _show_sector(self, tuple sector)

    cpdef object hide_sector(self, tuple sector, bint immediate=?)

    @cython.locals(position=tuple)
    cpdef object _hide_sector(self, tuple sector)

    @cython.locals(before_set=set, after_set=set, pad=int,
                   dx=int, dy=int, dz=int,
                   x=int, y=int, z=int,
                   show=set, hide=set, sector=tuple)
    cpdef object change_sectors(self, tuple before, tuple after)

    @cython.locals(queue=object)
    cpdef object dequeue(self)

    cpdef object process_queue(self, double dt)

    cpdef object process_entire_queue(self)

    @cython.locals(position=tuple)
    cpdef object content_update(self, double dt)
