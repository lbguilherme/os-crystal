require "./pointer"

# HEAP_BEGIN = 0x00100000u64 + 0x1000u64
# HEAP_SIZE = 0x10000u64
#
# $first_free_page = Pointer(UInt64).new(HEAP_BEGIN);
# $first_free_page[0] = HEAP_SIZE - 8
# $first_free_page[1] = 0u64

# fun malloc(size : UInt64) : Pointer(Void)
#   best_prev = Pointer(UInt64).null
#   best = Pointer(UInt64).null
#   prev = Pointer(UInt64).null
#   page = $first_free_page
#   while (page)
#     page_size = page[0]
#     if (page_size >= size && (!best || best[0] > page_size))
#       best = page
#       best_prev = prev
#     end
#     prev = page
#     page = Pointer(UInt64).new(page[1])
#   end
#
#   if !best
#     return Pointer(Void).null
#   end
#
#   # TODO
#
#   if best_prev
#     best_prev[1] = best[1]
#   else
#     $first_free_page = Pointer(UInt64).new(best[1])
#   end
#
#   Pointer(Void).new(best.address + 8)
# end
#
# fun memset()
# end
