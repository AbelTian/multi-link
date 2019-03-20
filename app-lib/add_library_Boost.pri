#----------------------------------------------------------------
#add_library_Boost.pri
#这是给用户提供的方便pri
#这个比较common，允许拷贝到用户工程中更改。
#----------------------------------------------------------------
#_bundle的取舍，在于macOS系统下，使用的library为bundle形式，还是dylib形式。

#######################################################################################
#初始化设置
#######################################################################################
#1
LIBRARYVER =

#######################################################################################
#定义函数
#######################################################################################
#修改
defineTest(add_include_Boost){
    #不为空，肯定是源码里的路径。 用于导出头文件
    #header_path = $$1
    #如果参数1为空，那么是用SDK里的路径 用于链接时包含头文件
    #此处_bundle代表 mac下头文件在bundle里。 留意
    header_path=$$get_add_include(Boost, Boost)

    command =
    #basic
    command += $${header_path}
    #这里添加$${path}下的子文件夹
    #...
    command += $${header_path}/boost
    command += $${header_path}/boost/accumulators
    command += $${header_path}/boost/accumulators/framework
    command += $${header_path}/boost/accumulators/framework/accumulators
    command += $${header_path}/boost/accumulators/framework/parameters
    command += $${header_path}/boost/accumulators/numeric
    command += $${header_path}/boost/accumulators/numeric/detail
    command += $${header_path}/boost/accumulators/numeric/functional
    command += $${header_path}/boost/accumulators/statistics
    command += $${header_path}/boost/accumulators/statistics/parameters
    command += $${header_path}/boost/accumulators/statistics/variates
    command += $${header_path}/boost/algorithm
    command += $${header_path}/boost/algorithm/cxx11
    command += $${header_path}/boost/algorithm/cxx14
    command += $${header_path}/boost/algorithm/cxx17
    command += $${header_path}/boost/algorithm/searching
    command += $${header_path}/boost/algorithm/searching/detail
    command += $${header_path}/boost/algorithm/string
    command += $${header_path}/boost/algorithm/string/detail
    command += $${header_path}/boost/algorithm/string/std
    command += $${header_path}/boost/align
    command += $${header_path}/boost/align/detail
    command += $${header_path}/boost/archive
    command += $${header_path}/boost/archive/detail
    command += $${header_path}/boost/archive/impl
    command += $${header_path}/boost/archive/iterators
    command += $${header_path}/boost/asio
    command += $${header_path}/boost/asio/detail
    command += $${header_path}/boost/asio/detail/impl
    command += $${header_path}/boost/asio/experimental
    command += $${header_path}/boost/asio/experimental/impl
    command += $${header_path}/boost/asio/generic
    command += $${header_path}/boost/asio/generic/detail
    command += $${header_path}/boost/asio/generic/detail/impl
    command += $${header_path}/boost/asio/impl
    command += $${header_path}/boost/asio/ip
    command += $${header_path}/boost/asio/ip/detail
    command += $${header_path}/boost/asio/ip/detail/impl
    command += $${header_path}/boost/asio/ip/impl
    command += $${header_path}/boost/asio/local
    command += $${header_path}/boost/asio/local/detail
    command += $${header_path}/boost/asio/local/detail/impl
    command += $${header_path}/boost/asio/posix
    command += $${header_path}/boost/asio/ssl
    command += $${header_path}/boost/asio/ssl/detail
    command += $${header_path}/boost/asio/ssl/detail/impl
    command += $${header_path}/boost/asio/ssl/impl
    command += $${header_path}/boost/asio/ts
    command += $${header_path}/boost/asio/windows
    command += $${header_path}/boost/assign
    command += $${header_path}/boost/assign/std
    command += $${header_path}/boost/atomic
    command += $${header_path}/boost/atomic/detail
    command += $${header_path}/boost/atomic/detail/type_traits
    command += $${header_path}/boost/beast
    command += $${header_path}/boost/beast/core
    command += $${header_path}/boost/beast/core/detail
    command += $${header_path}/boost/beast/core/impl
    command += $${header_path}/boost/beast/http
    command += $${header_path}/boost/beast/http/detail
    command += $${header_path}/boost/beast/http/impl
    command += $${header_path}/boost/beast/websocket
    command += $${header_path}/boost/beast/websocket/detail
    command += $${header_path}/boost/beast/websocket/impl
    command += $${header_path}/boost/beast/zlib
    command += $${header_path}/boost/beast/zlib/detail
    command += $${header_path}/boost/beast/zlib/impl
    command += $${header_path}/boost/bimap
    command += $${header_path}/boost/bimap/container_adaptor
    command += $${header_path}/boost/bimap/container_adaptor/detail
    command += $${header_path}/boost/bimap/container_adaptor/support
    command += $${header_path}/boost/bimap/detail
    command += $${header_path}/boost/bimap/detail/debug
    command += $${header_path}/boost/bimap/detail/test
    command += $${header_path}/boost/bimap/property_map
    command += $${header_path}/boost/bimap/relation
    command += $${header_path}/boost/bimap/relation/detail
    command += $${header_path}/boost/bimap/relation/support
    command += $${header_path}/boost/bimap/support
    command += $${header_path}/boost/bimap/tags
    command += $${header_path}/boost/bimap/tags/support
    command += $${header_path}/boost/bimap/views
    command += $${header_path}/boost/bind
    command += $${header_path}/boost/callable_traits
    command += $${header_path}/boost/callable_traits/detail
    command += $${header_path}/boost/callable_traits/detail/polyfills
    command += $${header_path}/boost/callable_traits/detail/unguarded
    command += $${header_path}/boost/chrono
    command += $${header_path}/boost/chrono/detail
    command += $${header_path}/boost/chrono/detail/inlined
    command += $${header_path}/boost/chrono/detail/inlined/mac
    command += $${header_path}/boost/chrono/detail/inlined/posix
    command += $${header_path}/boost/chrono/detail/inlined/win
    command += $${header_path}/boost/chrono/detail/no_warning
    command += $${header_path}/boost/chrono/io
    command += $${header_path}/boost/chrono/io/utility
    command += $${header_path}/boost/chrono/io_v1
    command += $${header_path}/boost/chrono/typeof
    command += $${header_path}/boost/chrono/typeof/boost
    command += $${header_path}/boost/chrono/typeof/boost/chrono
    command += $${header_path}/boost/circular_buffer
    command += $${header_path}/boost/compatibility
    command += $${header_path}/boost/compatibility/cpp_c_headers
    command += $${header_path}/boost/compute
    command += $${header_path}/boost/compute/algorithm
    command += $${header_path}/boost/compute/algorithm/detail
    command += $${header_path}/boost/compute/allocator
    command += $${header_path}/boost/compute/async
    command += $${header_path}/boost/compute/container
    command += $${header_path}/boost/compute/container/detail
    command += $${header_path}/boost/compute/detail
    command += $${header_path}/boost/compute/exception
    command += $${header_path}/boost/compute/experimental
    command += $${header_path}/boost/compute/functional
    command += $${header_path}/boost/compute/functional/detail
    command += $${header_path}/boost/compute/image
    command += $${header_path}/boost/compute/interop
    command += $${header_path}/boost/compute/interop/eigen
    command += $${header_path}/boost/compute/interop/opencv
    command += $${header_path}/boost/compute/interop/opengl
    command += $${header_path}/boost/compute/interop/qt
    command += $${header_path}/boost/compute/interop/vtk
    command += $${header_path}/boost/compute/iterator
    command += $${header_path}/boost/compute/iterator/detail
    command += $${header_path}/boost/compute/lambda
    command += $${header_path}/boost/compute/memory
    command += $${header_path}/boost/compute/random
    command += $${header_path}/boost/compute/type_traits
    command += $${header_path}/boost/compute/type_traits/detail
    command += $${header_path}/boost/compute/types
    command += $${header_path}/boost/compute/utility
    command += $${header_path}/boost/concept
    command += $${header_path}/boost/concept/detail
    command += $${header_path}/boost/concept_check
    command += $${header_path}/boost/config
    command += $${header_path}/boost/config/abi
    command += $${header_path}/boost/config/compiler
    command += $${header_path}/boost/config/detail
    command += $${header_path}/boost/config/no_tr1
    command += $${header_path}/boost/config/platform
    command += $${header_path}/boost/config/stdlib
    command += $${header_path}/boost/container
    command += $${header_path}/boost/container/detail
    command += $${header_path}/boost/container/pmr
    command += $${header_path}/boost/container_hash
    command += $${header_path}/boost/container_hash/detail
    command += $${header_path}/boost/context
    command += $${header_path}/boost/context/detail
    command += $${header_path}/boost/context/posix
    command += $${header_path}/boost/context/windows
    command += $${header_path}/boost/contract
    command += $${header_path}/boost/contract/core
    command += $${header_path}/boost/contract/detail
    command += $${header_path}/boost/contract/detail/condition
    command += $${header_path}/boost/contract/detail/inlined
    command += $${header_path}/boost/contract/detail/inlined/core
    command += $${header_path}/boost/contract/detail/inlined/detail
    command += $${header_path}/boost/contract/detail/operation
    command += $${header_path}/boost/contract/detail/preprocessor
    command += $${header_path}/boost/contract/detail/preprocessor/keyword
    command += $${header_path}/boost/contract/detail/preprocessor/keyword/utility
    command += $${header_path}/boost/contract/detail/type_traits
    command += $${header_path}/boost/convert
    command += $${header_path}/boost/convert/detail
    command += $${header_path}/boost/core
    command += $${header_path}/boost/coroutine
    command += $${header_path}/boost/coroutine/detail
    command += $${header_path}/boost/coroutine/posix
    command += $${header_path}/boost/coroutine/windows
    command += $${header_path}/boost/coroutine2
    command += $${header_path}/boost/coroutine2/detail
    command += $${header_path}/boost/date_time
    command += $${header_path}/boost/date_time/gregorian
    command += $${header_path}/boost/date_time/local_time
    command += $${header_path}/boost/date_time/posix_time
    command += $${header_path}/boost/detail
    command += $${header_path}/boost/detail/winapi
    command += $${header_path}/boost/detail/winapi/detail
    command += $${header_path}/boost/dll
    command += $${header_path}/boost/dll/detail
    command += $${header_path}/boost/dll/detail/demangling
    command += $${header_path}/boost/dll/detail/posix
    command += $${header_path}/boost/dll/detail/windows
    command += $${header_path}/boost/dynamic_bitset
    command += $${header_path}/boost/endian
    command += $${header_path}/boost/endian/detail
    command += $${header_path}/boost/exception
    command += $${header_path}/boost/exception/detail
    command += $${header_path}/boost/fiber
    command += $${header_path}/boost/fiber/algo
    command += $${header_path}/boost/fiber/algo/numa
    command += $${header_path}/boost/fiber/cuda
    command += $${header_path}/boost/fiber/detail
    command += $${header_path}/boost/fiber/future
    command += $${header_path}/boost/fiber/future/detail
    command += $${header_path}/boost/fiber/hip
    command += $${header_path}/boost/fiber/numa
    command += $${header_path}/boost/filesystem
    command += $${header_path}/boost/filesystem/detail
    command += $${header_path}/boost/flyweight
    command += $${header_path}/boost/flyweight/detail
    command += $${header_path}/boost/format
    command += $${header_path}/boost/format/detail
    command += $${header_path}/boost/function
    command += $${header_path}/boost/function/detail
    command += $${header_path}/boost/function_types
    command += $${header_path}/boost/function_types/config
    command += $${header_path}/boost/function_types/detail
    command += $${header_path}/boost/function_types/detail/classifier_impl
    command += $${header_path}/boost/function_types/detail/components_impl
    command += $${header_path}/boost/function_types/detail/encoding
    command += $${header_path}/boost/function_types/detail/pp_cc_loop
    command += $${header_path}/boost/function_types/detail/pp_retag_default_cc
    command += $${header_path}/boost/function_types/detail/pp_tags
    command += $${header_path}/boost/function_types/detail/pp_variate_loop
    command += $${header_path}/boost/function_types/detail/synthesize_impl
    command += $${header_path}/boost/functional
    command += $${header_path}/boost/functional/hash
    command += $${header_path}/boost/functional/overloaded_function
    command += $${header_path}/boost/functional/overloaded_function/detail
    command += $${header_path}/boost/fusion
    command += $${header_path}/boost/fusion/adapted
    command += $${header_path}/boost/fusion/adapted/adt
    command += $${header_path}/boost/fusion/adapted/adt/detail
    command += $${header_path}/boost/fusion/adapted/array
    command += $${header_path}/boost/fusion/adapted/boost_array
    command += $${header_path}/boost/fusion/adapted/boost_array/detail
    command += $${header_path}/boost/fusion/adapted/boost_tuple
    command += $${header_path}/boost/fusion/adapted/boost_tuple/detail
    command += $${header_path}/boost/fusion/adapted/boost_tuple/mpl
    command += $${header_path}/boost/fusion/adapted/mpl
    command += $${header_path}/boost/fusion/adapted/mpl/detail
    command += $${header_path}/boost/fusion/adapted/std_array
    command += $${header_path}/boost/fusion/adapted/std_array/detail
    command += $${header_path}/boost/fusion/adapted/std_tuple
    command += $${header_path}/boost/fusion/adapted/std_tuple/detail
    command += $${header_path}/boost/fusion/adapted/std_tuple/mpl
    command += $${header_path}/boost/fusion/adapted/struct
    command += $${header_path}/boost/fusion/adapted/struct/detail
    command += $${header_path}/boost/fusion/adapted/struct/detail/preprocessor
    command += $${header_path}/boost/fusion/algorithm
    command += $${header_path}/boost/fusion/algorithm/auxiliary
    command += $${header_path}/boost/fusion/algorithm/iteration
    command += $${header_path}/boost/fusion/algorithm/iteration/detail
    command += $${header_path}/boost/fusion/algorithm/iteration/detail/preprocessed
    command += $${header_path}/boost/fusion/algorithm/query
    command += $${header_path}/boost/fusion/algorithm/query/detail
    command += $${header_path}/boost/fusion/algorithm/transformation
    command += $${header_path}/boost/fusion/algorithm/transformation/detail
    command += $${header_path}/boost/fusion/algorithm/transformation/detail/preprocessed
    command += $${header_path}/boost/fusion/container
    command += $${header_path}/boost/fusion/container/deque
    command += $${header_path}/boost/fusion/container/deque/detail
    command += $${header_path}/boost/fusion/container/deque/detail/cpp03
    command += $${header_path}/boost/fusion/container/deque/detail/cpp03/preprocessed
    command += $${header_path}/boost/fusion/container/generation
    command += $${header_path}/boost/fusion/container/generation/detail
    command += $${header_path}/boost/fusion/container/generation/detail/preprocessed
    command += $${header_path}/boost/fusion/container/list
    command += $${header_path}/boost/fusion/container/list/detail
    command += $${header_path}/boost/fusion/container/list/detail/cpp03
    command += $${header_path}/boost/fusion/container/list/detail/cpp03/preprocessed
    command += $${header_path}/boost/fusion/container/map
    command += $${header_path}/boost/fusion/container/map/detail
    command += $${header_path}/boost/fusion/container/map/detail/cpp03
    command += $${header_path}/boost/fusion/container/map/detail/cpp03/preprocessed
    command += $${header_path}/boost/fusion/container/set
    command += $${header_path}/boost/fusion/container/set/detail
    command += $${header_path}/boost/fusion/container/set/detail/cpp03
    command += $${header_path}/boost/fusion/container/set/detail/cpp03/preprocessed
    command += $${header_path}/boost/fusion/container/vector
    command += $${header_path}/boost/fusion/container/vector/detail
    command += $${header_path}/boost/fusion/container/vector/detail/cpp03
    command += $${header_path}/boost/fusion/container/vector/detail/cpp03/preprocessed
    command += $${header_path}/boost/fusion/functional
    command += $${header_path}/boost/fusion/functional/adapter
    command += $${header_path}/boost/fusion/functional/adapter/detail
    command += $${header_path}/boost/fusion/functional/generation
    command += $${header_path}/boost/fusion/functional/generation/detail
    command += $${header_path}/boost/fusion/functional/invocation
    command += $${header_path}/boost/fusion/functional/invocation/detail
    command += $${header_path}/boost/fusion/include
    command += $${header_path}/boost/fusion/iterator
    command += $${header_path}/boost/fusion/iterator/detail
    command += $${header_path}/boost/fusion/iterator/mpl
    command += $${header_path}/boost/fusion/mpl
    command += $${header_path}/boost/fusion/mpl/detail
    command += $${header_path}/boost/fusion/sequence
    command += $${header_path}/boost/fusion/sequence/comparison
    command += $${header_path}/boost/fusion/sequence/comparison/detail
    command += $${header_path}/boost/fusion/sequence/intrinsic
    command += $${header_path}/boost/fusion/sequence/intrinsic/detail
    command += $${header_path}/boost/fusion/sequence/io
    command += $${header_path}/boost/fusion/sequence/io/detail
    command += $${header_path}/boost/fusion/support
    command += $${header_path}/boost/fusion/support/detail
    command += $${header_path}/boost/fusion/tuple
    command += $${header_path}/boost/fusion/tuple/detail
    command += $${header_path}/boost/fusion/tuple/detail/preprocessed
    command += $${header_path}/boost/fusion/view
    command += $${header_path}/boost/fusion/view/detail
    command += $${header_path}/boost/fusion/view/filter_view
    command += $${header_path}/boost/fusion/view/filter_view/detail
    command += $${header_path}/boost/fusion/view/flatten_view
    command += $${header_path}/boost/fusion/view/iterator_range
    command += $${header_path}/boost/fusion/view/iterator_range/detail
    command += $${header_path}/boost/fusion/view/joint_view
    command += $${header_path}/boost/fusion/view/joint_view/detail
    command += $${header_path}/boost/fusion/view/nview
    command += $${header_path}/boost/fusion/view/nview/detail
    command += $${header_path}/boost/fusion/view/nview/detail/cpp03
    command += $${header_path}/boost/fusion/view/repetitive_view
    command += $${header_path}/boost/fusion/view/repetitive_view/detail
    command += $${header_path}/boost/fusion/view/reverse_view
    command += $${header_path}/boost/fusion/view/reverse_view/detail
    command += $${header_path}/boost/fusion/view/single_view
    command += $${header_path}/boost/fusion/view/single_view/detail
    command += $${header_path}/boost/fusion/view/transform_view
    command += $${header_path}/boost/fusion/view/transform_view/detail
    command += $${header_path}/boost/fusion/view/zip_view
    command += $${header_path}/boost/fusion/view/zip_view/detail
    command += $${header_path}/boost/geometry
    command += $${header_path}/boost/geometry/algorithms
    command += $${header_path}/boost/geometry/algorithms/detail
    command += $${header_path}/boost/geometry/algorithms/detail/buffer
    command += $${header_path}/boost/geometry/algorithms/detail/centroid
    command += $${header_path}/boost/geometry/algorithms/detail/closest_feature
    command += $${header_path}/boost/geometry/algorithms/detail/comparable_distance
    command += $${header_path}/boost/geometry/algorithms/detail/covered_by
    command += $${header_path}/boost/geometry/algorithms/detail/disjoint
    command += $${header_path}/boost/geometry/algorithms/detail/distance
    command += $${header_path}/boost/geometry/algorithms/detail/envelope
    command += $${header_path}/boost/geometry/algorithms/detail/equals
    command += $${header_path}/boost/geometry/algorithms/detail/expand
    command += $${header_path}/boost/geometry/algorithms/detail/intersection
    command += $${header_path}/boost/geometry/algorithms/detail/intersects
    command += $${header_path}/boost/geometry/algorithms/detail/is_simple
    command += $${header_path}/boost/geometry/algorithms/detail/is_valid
    command += $${header_path}/boost/geometry/algorithms/detail/overlaps
    command += $${header_path}/boost/geometry/algorithms/detail/overlay
    command += $${header_path}/boost/geometry/algorithms/detail/relate
    command += $${header_path}/boost/geometry/algorithms/detail/relation
    command += $${header_path}/boost/geometry/algorithms/detail/sections
    command += $${header_path}/boost/geometry/algorithms/detail/touches
    command += $${header_path}/boost/geometry/algorithms/detail/turns
    command += $${header_path}/boost/geometry/algorithms/detail/within
    command += $${header_path}/boost/geometry/algorithms/dispatch
    command += $${header_path}/boost/geometry/arithmetic
    command += $${header_path}/boost/geometry/core
    command += $${header_path}/boost/geometry/formulas
    command += $${header_path}/boost/geometry/geometries
    command += $${header_path}/boost/geometry/geometries/adapted
    command += $${header_path}/boost/geometry/geometries/adapted/boost_polygon
    command += $${header_path}/boost/geometry/geometries/adapted/boost_range
    command += $${header_path}/boost/geometry/geometries/concepts
    command += $${header_path}/boost/geometry/geometries/register
    command += $${header_path}/boost/geometry/index
    command += $${header_path}/boost/geometry/index/adaptors
    command += $${header_path}/boost/geometry/index/detail
    command += $${header_path}/boost/geometry/index/detail/algorithms
    command += $${header_path}/boost/geometry/index/detail/rtree
    command += $${header_path}/boost/geometry/index/detail/rtree/kmeans
    command += $${header_path}/boost/geometry/index/detail/rtree/linear
    command += $${header_path}/boost/geometry/index/detail/rtree/node
    command += $${header_path}/boost/geometry/index/detail/rtree/quadratic
    command += $${header_path}/boost/geometry/index/detail/rtree/rstar
    command += $${header_path}/boost/geometry/index/detail/rtree/utilities
    command += $${header_path}/boost/geometry/index/detail/rtree/visitors
    command += $${header_path}/boost/geometry/io
    command += $${header_path}/boost/geometry/io/dsv
    command += $${header_path}/boost/geometry/io/svg
    command += $${header_path}/boost/geometry/io/wkt
    command += $${header_path}/boost/geometry/io/wkt/detail
    command += $${header_path}/boost/geometry/iterators
    command += $${header_path}/boost/geometry/iterators/detail
    command += $${header_path}/boost/geometry/iterators/detail/point_iterator
    command += $${header_path}/boost/geometry/iterators/detail/segment_iterator
    command += $${header_path}/boost/geometry/iterators/dispatch
    command += $${header_path}/boost/geometry/multi
    command += $${header_path}/boost/geometry/multi/algorithms
    command += $${header_path}/boost/geometry/multi/algorithms/detail
    command += $${header_path}/boost/geometry/multi/algorithms/detail/overlay
    command += $${header_path}/boost/geometry/multi/algorithms/detail/sections
    command += $${header_path}/boost/geometry/multi/core
    command += $${header_path}/boost/geometry/multi/geometries
    command += $${header_path}/boost/geometry/multi/geometries/concepts
    command += $${header_path}/boost/geometry/multi/geometries/register
    command += $${header_path}/boost/geometry/multi/io
    command += $${header_path}/boost/geometry/multi/io/dsv
    command += $${header_path}/boost/geometry/multi/io/wkt
    command += $${header_path}/boost/geometry/multi/io/wkt/detail
    command += $${header_path}/boost/geometry/multi/strategies
    command += $${header_path}/boost/geometry/multi/strategies/cartesian
    command += $${header_path}/boost/geometry/multi/views
    command += $${header_path}/boost/geometry/multi/views/detail
    command += $${header_path}/boost/geometry/policies
    command += $${header_path}/boost/geometry/policies/is_valid
    command += $${header_path}/boost/geometry/policies/relate
    command += $${header_path}/boost/geometry/policies/robustness
    command += $${header_path}/boost/geometry/srs
    command += $${header_path}/boost/geometry/srs/projections
    command += $${header_path}/boost/geometry/srs/projections/impl
    command += $${header_path}/boost/geometry/srs/projections/proj
    command += $${header_path}/boost/geometry/strategies
    command += $${header_path}/boost/geometry/strategies/agnostic
    command += $${header_path}/boost/geometry/strategies/cartesian
    command += $${header_path}/boost/geometry/strategies/concepts
    command += $${header_path}/boost/geometry/strategies/geographic
    command += $${header_path}/boost/geometry/strategies/spherical
    command += $${header_path}/boost/geometry/strategies/transform
    command += $${header_path}/boost/geometry/util
    command += $${header_path}/boost/geometry/views
    command += $${header_path}/boost/geometry/views/detail
    command += $${header_path}/boost/geometry/views/detail/boundary_view
    command += $${header_path}/boost/gil
    command += $${header_path}/boost/gil/extension
    command += $${header_path}/boost/gil/extension/dynamic_image
    command += $${header_path}/boost/gil/extension/io
    command += $${header_path}/boost/graph
    command += $${header_path}/boost/graph/detail
    command += $${header_path}/boost/graph/distributed
    command += $${header_path}/boost/graph/distributed/adjlist
    command += $${header_path}/boost/graph/distributed/detail
    command += $${header_path}/boost/graph/parallel
    command += $${header_path}/boost/graph/parallel/detail
    command += $${header_path}/boost/graph/planar_detail
    command += $${header_path}/boost/graph/property_maps
    command += $${header_path}/boost/hana
    command += $${header_path}/boost/hana/concept
    command += $${header_path}/boost/hana/core
    command += $${header_path}/boost/hana/detail
    command += $${header_path}/boost/hana/detail/operators
    command += $${header_path}/boost/hana/detail/variadic
    command += $${header_path}/boost/hana/detail/variadic/reverse_apply
    command += $${header_path}/boost/hana/experimental
    command += $${header_path}/boost/hana/ext
    command += $${header_path}/boost/hana/ext/boost
    command += $${header_path}/boost/hana/ext/boost/fusion
    command += $${header_path}/boost/hana/ext/boost/fusion/detail
    command += $${header_path}/boost/hana/ext/boost/mpl
    command += $${header_path}/boost/hana/ext/std
    command += $${header_path}/boost/hana/functional
    command += $${header_path}/boost/hana/fwd
    command += $${header_path}/boost/hana/fwd/concept
    command += $${header_path}/boost/hana/fwd/core
    command += $${header_path}/boost/heap
    command += $${header_path}/boost/heap/detail
    command += $${header_path}/boost/hof
    command += $${header_path}/boost/hof/detail
    command += $${header_path}/boost/icl
    command += $${header_path}/boost/icl/concept
    command += $${header_path}/boost/icl/detail
    command += $${header_path}/boost/icl/predicates
    command += $${header_path}/boost/icl/type_traits
    command += $${header_path}/boost/integer
    command += $${header_path}/boost/interprocess
    command += $${header_path}/boost/interprocess/allocators
    command += $${header_path}/boost/interprocess/allocators/detail
    command += $${header_path}/boost/interprocess/containers
    command += $${header_path}/boost/interprocess/detail
    command += $${header_path}/boost/interprocess/indexes
    command += $${header_path}/boost/interprocess/ipc
    command += $${header_path}/boost/interprocess/mem_algo
    command += $${header_path}/boost/interprocess/mem_algo/detail
    command += $${header_path}/boost/interprocess/smart_ptr
    command += $${header_path}/boost/interprocess/smart_ptr/detail
    command += $${header_path}/boost/interprocess/streams
    command += $${header_path}/boost/interprocess/sync
    command += $${header_path}/boost/interprocess/sync/detail
    command += $${header_path}/boost/interprocess/sync/posix
    command += $${header_path}/boost/interprocess/sync/shm
    command += $${header_path}/boost/interprocess/sync/spin
    command += $${header_path}/boost/interprocess/sync/windows
    command += $${header_path}/boost/intrusive
    command += $${header_path}/boost/intrusive/detail
    command += $${header_path}/boost/io
    command += $${header_path}/boost/io/detail
    command += $${header_path}/boost/iostreams
    command += $${header_path}/boost/iostreams/detail
    command += $${header_path}/boost/iostreams/detail/adapter
    command += $${header_path}/boost/iostreams/detail/broken_overload_resolution
    command += $${header_path}/boost/iostreams/detail/config
    command += $${header_path}/boost/iostreams/detail/streambuf
    command += $${header_path}/boost/iostreams/device
    command += $${header_path}/boost/iostreams/filter
    command += $${header_path}/boost/iterator
    command += $${header_path}/boost/iterator/detail
    command += $${header_path}/boost/lambda
    command += $${header_path}/boost/lambda/detail
    command += $${header_path}/boost/lexical_cast
    command += $${header_path}/boost/lexical_cast/detail
    command += $${header_path}/boost/local_function
    command += $${header_path}/boost/local_function/aux_
    command += $${header_path}/boost/local_function/aux_/macro
    command += $${header_path}/boost/local_function/aux_/macro/code_
    command += $${header_path}/boost/local_function/aux_/preprocessor
    command += $${header_path}/boost/local_function/aux_/preprocessor/traits
    command += $${header_path}/boost/local_function/aux_/preprocessor/traits/decl_
    command += $${header_path}/boost/local_function/aux_/preprocessor/traits/decl_/validate_
    command += $${header_path}/boost/local_function/aux_/preprocessor/traits/decl_sign_
    command += $${header_path}/boost/local_function/aux_/preprocessor/traits/decl_sign_/validate_
    command += $${header_path}/boost/local_function/detail
    command += $${header_path}/boost/local_function/detail/preprocessor
    command += $${header_path}/boost/local_function/detail/preprocessor/keyword
    command += $${header_path}/boost/local_function/detail/preprocessor/keyword/facility
    command += $${header_path}/boost/locale
    command += $${header_path}/boost/locale/boundary
    command += $${header_path}/boost/lockfree
    command += $${header_path}/boost/lockfree/detail
    command += $${header_path}/boost/log
    command += $${header_path}/boost/log/attributes
    command += $${header_path}/boost/log/core
    command += $${header_path}/boost/log/detail
    command += $${header_path}/boost/log/expressions
    command += $${header_path}/boost/log/expressions/formatters
    command += $${header_path}/boost/log/expressions/predicates
    command += $${header_path}/boost/log/keywords
    command += $${header_path}/boost/log/sinks
    command += $${header_path}/boost/log/sources
    command += $${header_path}/boost/log/support
    command += $${header_path}/boost/log/utility
    command += $${header_path}/boost/log/utility/functional
    command += $${header_path}/boost/log/utility/ipc
    command += $${header_path}/boost/log/utility/manipulators
    command += $${header_path}/boost/log/utility/setup
    command += $${header_path}/boost/log/utility/type_dispatch
    command += $${header_path}/boost/logic
    command += $${header_path}/boost/math
    command += $${header_path}/boost/math/bindings
    command += $${header_path}/boost/math/bindings/detail
    command += $${header_path}/boost/math/complex
    command += $${header_path}/boost/math/concepts
    command += $${header_path}/boost/math/constants
    command += $${header_path}/boost/math/cstdfloat
    command += $${header_path}/boost/math/distributions
    command += $${header_path}/boost/math/distributions/detail
    command += $${header_path}/boost/math/interpolators
    command += $${header_path}/boost/math/interpolators/detail
    command += $${header_path}/boost/math/policies
    command += $${header_path}/boost/math/quadrature
    command += $${header_path}/boost/math/quadrature/detail
    command += $${header_path}/boost/math/special_functions
    command += $${header_path}/boost/math/special_functions/detail
    command += $${header_path}/boost/math/tools
    command += $${header_path}/boost/math/tools/detail
    command += $${header_path}/boost/metaparse
    command += $${header_path}/boost/metaparse/error
    command += $${header_path}/boost/metaparse/util
    command += $${header_path}/boost/metaparse/v1
    command += $${header_path}/boost/metaparse/v1/cpp11
    command += $${header_path}/boost/metaparse/v1/cpp11/fwd
    command += $${header_path}/boost/metaparse/v1/cpp11/impl
    command += $${header_path}/boost/metaparse/v1/cpp98
    command += $${header_path}/boost/metaparse/v1/cpp98/fwd
    command += $${header_path}/boost/metaparse/v1/cpp98/impl
    command += $${header_path}/boost/metaparse/v1/error
    command += $${header_path}/boost/metaparse/v1/fwd
    command += $${header_path}/boost/metaparse/v1/impl
    command += $${header_path}/boost/metaparse/v1/impl/fwd
    command += $${header_path}/boost/metaparse/v1/util
    command += $${header_path}/boost/move
    command += $${header_path}/boost/move/algo
    command += $${header_path}/boost/move/algo/detail
    command += $${header_path}/boost/move/detail
    command += $${header_path}/boost/mp11
    command += $${header_path}/boost/mp11/detail
    command += $${header_path}/boost/mpi
    command += $${header_path}/boost/mpi/collectives
    command += $${header_path}/boost/mpi/detail
    command += $${header_path}/boost/mpi/python
    command += $${header_path}/boost/mpl
    command += $${header_path}/boost/mpl/aux_
    command += $${header_path}/boost/mpl/aux_/config
    command += $${header_path}/boost/mpl/aux_/preprocessed
    command += $${header_path}/boost/mpl/aux_/preprocessed/bcc
    command += $${header_path}/boost/mpl/aux_/preprocessed/bcc551
    command += $${header_path}/boost/mpl/aux_/preprocessed/bcc_pre590
    command += $${header_path}/boost/mpl/aux_/preprocessed/dmc
    command += $${header_path}/boost/mpl/aux_/preprocessed/gcc
    command += $${header_path}/boost/mpl/aux_/preprocessed/msvc60
    command += $${header_path}/boost/mpl/aux_/preprocessed/msvc70
    command += $${header_path}/boost/mpl/aux_/preprocessed/mwcw
    command += $${header_path}/boost/mpl/aux_/preprocessed/no_ctps
    command += $${header_path}/boost/mpl/aux_/preprocessed/no_ttp
    command += $${header_path}/boost/mpl/aux_/preprocessed/plain
    command += $${header_path}/boost/mpl/aux_/preprocessor
    command += $${header_path}/boost/mpl/aux_/range_c
    command += $${header_path}/boost/mpl/aux_/test
    command += $${header_path}/boost/mpl/limits
    command += $${header_path}/boost/mpl/list
    command += $${header_path}/boost/mpl/list/aux_
    command += $${header_path}/boost/mpl/list/aux_/preprocessed
    command += $${header_path}/boost/mpl/list/aux_/preprocessed/plain
    command += $${header_path}/boost/mpl/map
    command += $${header_path}/boost/mpl/map/aux_
    command += $${header_path}/boost/mpl/map/aux_/preprocessed
    command += $${header_path}/boost/mpl/map/aux_/preprocessed/no_ctps
    command += $${header_path}/boost/mpl/map/aux_/preprocessed/plain
    command += $${header_path}/boost/mpl/map/aux_/preprocessed/typeof_based
    command += $${header_path}/boost/mpl/math
    command += $${header_path}/boost/mpl/multiset
    command += $${header_path}/boost/mpl/multiset/aux_
    command += $${header_path}/boost/mpl/set
    command += $${header_path}/boost/mpl/set/aux_
    command += $${header_path}/boost/mpl/set/aux_/preprocessed
    command += $${header_path}/boost/mpl/set/aux_/preprocessed/plain
    command += $${header_path}/boost/mpl/vector
    command += $${header_path}/boost/mpl/vector/aux_
    command += $${header_path}/boost/mpl/vector/aux_/preprocessed
    command += $${header_path}/boost/mpl/vector/aux_/preprocessed/no_ctps
    command += $${header_path}/boost/mpl/vector/aux_/preprocessed/plain
    command += $${header_path}/boost/mpl/vector/aux_/preprocessed/typeof_based
    command += $${header_path}/boost/msm
    command += $${header_path}/boost/msm/back
    command += $${header_path}/boost/msm/front
    command += $${header_path}/boost/msm/front/detail
    command += $${header_path}/boost/msm/front/euml
    command += $${header_path}/boost/msm/mpl_graph
    command += $${header_path}/boost/msm/mpl_graph/detail
    command += $${header_path}/boost/multi_array
    command += $${header_path}/boost/multi_index
    command += $${header_path}/boost/multi_index/detail
    command += $${header_path}/boost/multiprecision
    command += $${header_path}/boost/multiprecision/concepts
    command += $${header_path}/boost/multiprecision/cpp_bin_float
    command += $${header_path}/boost/multiprecision/cpp_int
    command += $${header_path}/boost/multiprecision/detail
    command += $${header_path}/boost/multiprecision/detail/functions
    command += $${header_path}/boost/multiprecision/traits
    command += $${header_path}/boost/numeric
    command += $${header_path}/boost/numeric/conversion
    command += $${header_path}/boost/numeric/conversion/detail
    command += $${header_path}/boost/numeric/conversion/detail/preprocessed
    command += $${header_path}/boost/numeric/interval
    command += $${header_path}/boost/numeric/interval/compare
    command += $${header_path}/boost/numeric/interval/detail
    command += $${header_path}/boost/numeric/interval/ext
    command += $${header_path}/boost/numeric/odeint
    command += $${header_path}/boost/numeric/odeint/algebra
    command += $${header_path}/boost/numeric/odeint/algebra/detail
    command += $${header_path}/boost/numeric/odeint/external
    command += $${header_path}/boost/numeric/odeint/external/blaze
    command += $${header_path}/boost/numeric/odeint/external/compute
    command += $${header_path}/boost/numeric/odeint/external/eigen
    command += $${header_path}/boost/numeric/odeint/external/gsl
    command += $${header_path}/boost/numeric/odeint/external/mkl
    command += $${header_path}/boost/numeric/odeint/external/mpi
    command += $${header_path}/boost/numeric/odeint/external/mtl4
    command += $${header_path}/boost/numeric/odeint/external/nt2
    command += $${header_path}/boost/numeric/odeint/external/openmp
    command += $${header_path}/boost/numeric/odeint/external/thrust
    command += $${header_path}/boost/numeric/odeint/external/vexcl
    command += $${header_path}/boost/numeric/odeint/external/viennacl
    command += $${header_path}/boost/numeric/odeint/integrate
    command += $${header_path}/boost/numeric/odeint/integrate/detail
    command += $${header_path}/boost/numeric/odeint/iterator
    command += $${header_path}/boost/numeric/odeint/iterator/detail
    command += $${header_path}/boost/numeric/odeint/iterator/impl
    command += $${header_path}/boost/numeric/odeint/iterator/integrate
    command += $${header_path}/boost/numeric/odeint/iterator/integrate/detail
    command += $${header_path}/boost/numeric/odeint/stepper
    command += $${header_path}/boost/numeric/odeint/stepper/base
    command += $${header_path}/boost/numeric/odeint/stepper/detail
    command += $${header_path}/boost/numeric/odeint/stepper/generation
    command += $${header_path}/boost/numeric/odeint/util
    command += $${header_path}/boost/numeric/odeint/util/detail
    command += $${header_path}/boost/numeric/ublas
    command += $${header_path}/boost/numeric/ublas/detail
    command += $${header_path}/boost/numeric/ublas/experimental
    command += $${header_path}/boost/numeric/ublas/operation
    command += $${header_path}/boost/numeric/ublas/traits
    command += $${header_path}/boost/optional
    command += $${header_path}/boost/optional/detail
    command += $${header_path}/boost/parameter
    command += $${header_path}/boost/parameter/aux_
    command += $${header_path}/boost/parameter/aux_/preprocessor
    command += $${header_path}/boost/parameter/aux_/python
    command += $${header_path}/boost/pending
    command += $${header_path}/boost/pending/detail
    command += $${header_path}/boost/phoenix
    command += $${header_path}/boost/phoenix/bind
    command += $${header_path}/boost/phoenix/bind/detail
    command += $${header_path}/boost/phoenix/bind/detail/cpp03
    command += $${header_path}/boost/phoenix/bind/detail/cpp03/preprocessed
    command += $${header_path}/boost/phoenix/core
    command += $${header_path}/boost/phoenix/core/detail
    command += $${header_path}/boost/phoenix/core/detail/cpp03
    command += $${header_path}/boost/phoenix/core/detail/cpp03/preprocessed
    command += $${header_path}/boost/phoenix/function
    command += $${header_path}/boost/phoenix/function/detail
    command += $${header_path}/boost/phoenix/function/detail/cpp03
    command += $${header_path}/boost/phoenix/function/detail/cpp03/preprocessed
    command += $${header_path}/boost/phoenix/fusion
    command += $${header_path}/boost/phoenix/object
    command += $${header_path}/boost/phoenix/object/detail
    command += $${header_path}/boost/phoenix/object/detail/cpp03
    command += $${header_path}/boost/phoenix/object/detail/cpp03/preprocessed
    command += $${header_path}/boost/phoenix/operator
    command += $${header_path}/boost/phoenix/operator/detail
    command += $${header_path}/boost/phoenix/operator/detail/cpp03
    command += $${header_path}/boost/phoenix/operator/detail/cpp03/preprocessed
    command += $${header_path}/boost/phoenix/scope
    command += $${header_path}/boost/phoenix/scope/detail
    command += $${header_path}/boost/phoenix/scope/detail/cpp03
    command += $${header_path}/boost/phoenix/scope/detail/cpp03/preprocessed
    command += $${header_path}/boost/phoenix/statement
    command += $${header_path}/boost/phoenix/statement/detail
    command += $${header_path}/boost/phoenix/statement/detail/preprocessed
    command += $${header_path}/boost/phoenix/stl
    command += $${header_path}/boost/phoenix/stl/algorithm
    command += $${header_path}/boost/phoenix/stl/algorithm/detail
    command += $${header_path}/boost/phoenix/stl/container
    command += $${header_path}/boost/phoenix/stl/container/detail
    command += $${header_path}/boost/phoenix/support
    command += $${header_path}/boost/phoenix/support/detail
    command += $${header_path}/boost/phoenix/support/preprocessed
    command += $${header_path}/boost/phoenix/support/preprocessor
    command += $${header_path}/boost/poly_collection
    command += $${header_path}/boost/poly_collection/detail
    command += $${header_path}/boost/polygon
    command += $${header_path}/boost/polygon/detail
    command += $${header_path}/boost/pool
    command += $${header_path}/boost/pool/detail
    command += $${header_path}/boost/predef
    command += $${header_path}/boost/predef/architecture
    command += $${header_path}/boost/predef/architecture/x86
    command += $${header_path}/boost/predef/compiler
    command += $${header_path}/boost/predef/detail
    command += $${header_path}/boost/predef/hardware
    command += $${header_path}/boost/predef/hardware/simd
    command += $${header_path}/boost/predef/hardware/simd/arm
    command += $${header_path}/boost/predef/hardware/simd/ppc
    command += $${header_path}/boost/predef/hardware/simd/x86
    command += $${header_path}/boost/predef/hardware/simd/x86_amd
    command += $${header_path}/boost/predef/language
    command += $${header_path}/boost/predef/library
    command += $${header_path}/boost/predef/library/c
    command += $${header_path}/boost/predef/library/std
    command += $${header_path}/boost/predef/os
    command += $${header_path}/boost/predef/os/bsd
    command += $${header_path}/boost/predef/other
    command += $${header_path}/boost/predef/platform
    command += $${header_path}/boost/preprocessor
    command += $${header_path}/boost/preprocessor/arithmetic
    command += $${header_path}/boost/preprocessor/arithmetic/detail
    command += $${header_path}/boost/preprocessor/array
    command += $${header_path}/boost/preprocessor/array/detail
    command += $${header_path}/boost/preprocessor/comparison
    command += $${header_path}/boost/preprocessor/config
    command += $${header_path}/boost/preprocessor/control
    command += $${header_path}/boost/preprocessor/control/detail
    command += $${header_path}/boost/preprocessor/control/detail/dmc
    command += $${header_path}/boost/preprocessor/control/detail/edg
    command += $${header_path}/boost/preprocessor/control/detail/msvc
    command += $${header_path}/boost/preprocessor/debug
    command += $${header_path}/boost/preprocessor/detail
    command += $${header_path}/boost/preprocessor/detail/dmc
    command += $${header_path}/boost/preprocessor/facilities
    command += $${header_path}/boost/preprocessor/facilities/detail
    command += $${header_path}/boost/preprocessor/iteration
    command += $${header_path}/boost/preprocessor/iteration/detail
    command += $${header_path}/boost/preprocessor/iteration/detail/bounds
    command += $${header_path}/boost/preprocessor/iteration/detail/iter
    command += $${header_path}/boost/preprocessor/list
    command += $${header_path}/boost/preprocessor/list/detail
    command += $${header_path}/boost/preprocessor/list/detail/dmc
    command += $${header_path}/boost/preprocessor/list/detail/edg
    command += $${header_path}/boost/preprocessor/logical
    command += $${header_path}/boost/preprocessor/punctuation
    command += $${header_path}/boost/preprocessor/punctuation/detail
    command += $${header_path}/boost/preprocessor/repetition
    command += $${header_path}/boost/preprocessor/repetition/detail
    command += $${header_path}/boost/preprocessor/repetition/detail/dmc
    command += $${header_path}/boost/preprocessor/repetition/detail/edg
    command += $${header_path}/boost/preprocessor/repetition/detail/msvc
    command += $${header_path}/boost/preprocessor/selection
    command += $${header_path}/boost/preprocessor/seq
    command += $${header_path}/boost/preprocessor/seq/detail
    command += $${header_path}/boost/preprocessor/slot
    command += $${header_path}/boost/preprocessor/slot/detail
    command += $${header_path}/boost/preprocessor/tuple
    command += $${header_path}/boost/preprocessor/tuple/detail
    command += $${header_path}/boost/preprocessor/variadic
    command += $${header_path}/boost/preprocessor/variadic/detail
    command += $${header_path}/boost/process
    command += $${header_path}/boost/process/detail
    command += $${header_path}/boost/process/detail/posix
    command += $${header_path}/boost/process/detail/traits
    command += $${header_path}/boost/process/detail/windows
    command += $${header_path}/boost/program_options
    command += $${header_path}/boost/program_options/detail
    command += $${header_path}/boost/property_map
    command += $${header_path}/boost/property_map/parallel
    command += $${header_path}/boost/property_map/parallel/detail
    command += $${header_path}/boost/property_map/parallel/impl
    command += $${header_path}/boost/property_tree
    command += $${header_path}/boost/property_tree/detail
    command += $${header_path}/boost/property_tree/json_parser
    command += $${header_path}/boost/property_tree/json_parser/detail
    command += $${header_path}/boost/proto
    command += $${header_path}/boost/proto/context
    command += $${header_path}/boost/proto/context/detail
    command += $${header_path}/boost/proto/context/detail/preprocessed
    command += $${header_path}/boost/proto/detail
    command += $${header_path}/boost/proto/detail/preprocessed
    command += $${header_path}/boost/proto/functional
    command += $${header_path}/boost/proto/functional/fusion
    command += $${header_path}/boost/proto/functional/range
    command += $${header_path}/boost/proto/functional/std
    command += $${header_path}/boost/proto/transform
    command += $${header_path}/boost/proto/transform/detail
    command += $${header_path}/boost/proto/transform/detail/preprocessed
    command += $${header_path}/boost/ptr_container
    command += $${header_path}/boost/ptr_container/detail
    command += $${header_path}/boost/python
    command += $${header_path}/boost/python/converter
    command += $${header_path}/boost/python/detail
    command += $${header_path}/boost/python/numpy
    command += $${header_path}/boost/python/object
    command += $${header_path}/boost/python/suite
    command += $${header_path}/boost/python/suite/indexing
    command += $${header_path}/boost/python/suite/indexing/detail
    command += $${header_path}/boost/qvm
    command += $${header_path}/boost/qvm/detail
    command += $${header_path}/boost/qvm/gen
    command += $${header_path}/boost/random
    command += $${header_path}/boost/random/detail
    command += $${header_path}/boost/range
    command += $${header_path}/boost/range/adaptor
    command += $${header_path}/boost/range/algorithm
    command += $${header_path}/boost/range/algorithm_ext
    command += $${header_path}/boost/range/detail
    command += $${header_path}/boost/ratio
    command += $${header_path}/boost/ratio/detail
    command += $${header_path}/boost/ratio/detail/mpl
    command += $${header_path}/boost/ratio/mpl
    command += $${header_path}/boost/regex
    command += $${header_path}/boost/regex/config
    command += $${header_path}/boost/regex/pending
    command += $${header_path}/boost/regex/v4
    command += $${header_path}/boost/serialization
    command += $${header_path}/boost/serialization/detail
    command += $${header_path}/boost/signals
    command += $${header_path}/boost/signals/detail
    command += $${header_path}/boost/signals2
    command += $${header_path}/boost/signals2/detail
    command += $${header_path}/boost/smart_ptr
    command += $${header_path}/boost/smart_ptr/detail
    command += $${header_path}/boost/sort
    command += $${header_path}/boost/sort/block_indirect_sort
    command += $${header_path}/boost/sort/block_indirect_sort/blk_detail
    command += $${header_path}/boost/sort/common
    command += $${header_path}/boost/sort/common/util
    command += $${header_path}/boost/sort/flat_stable_sort
    command += $${header_path}/boost/sort/heap_sort
    command += $${header_path}/boost/sort/insert_sort
    command += $${header_path}/boost/sort/parallel_stable_sort
    command += $${header_path}/boost/sort/pdqsort
    command += $${header_path}/boost/sort/sample_sort
    command += $${header_path}/boost/sort/spinsort
    command += $${header_path}/boost/sort/spreadsort
    command += $${header_path}/boost/sort/spreadsort/detail
    command += $${header_path}/boost/spirit
    command += $${header_path}/boost/spirit/home
    command += $${header_path}/boost/spirit/home/classic
    command += $${header_path}/boost/spirit/home/classic/actor
    command += $${header_path}/boost/spirit/home/classic/attribute
    command += $${header_path}/boost/spirit/home/classic/core
    command += $${header_path}/boost/spirit/home/classic/core/composite
    command += $${header_path}/boost/spirit/home/classic/core/composite/impl
    command += $${header_path}/boost/spirit/home/classic/core/impl
    command += $${header_path}/boost/spirit/home/classic/core/non_terminal
    command += $${header_path}/boost/spirit/home/classic/core/non_terminal/impl
    command += $${header_path}/boost/spirit/home/classic/core/primitives
    command += $${header_path}/boost/spirit/home/classic/core/primitives/impl
    command += $${header_path}/boost/spirit/home/classic/core/scanner
    command += $${header_path}/boost/spirit/home/classic/core/scanner/impl
    command += $${header_path}/boost/spirit/home/classic/debug
    command += $${header_path}/boost/spirit/home/classic/debug/impl
    command += $${header_path}/boost/spirit/home/classic/dynamic
    command += $${header_path}/boost/spirit/home/classic/dynamic/impl
    command += $${header_path}/boost/spirit/home/classic/error_handling
    command += $${header_path}/boost/spirit/home/classic/error_handling/impl
    command += $${header_path}/boost/spirit/home/classic/iterator
    command += $${header_path}/boost/spirit/home/classic/iterator/impl
    command += $${header_path}/boost/spirit/home/classic/meta
    command += $${header_path}/boost/spirit/home/classic/meta/impl
    command += $${header_path}/boost/spirit/home/classic/phoenix
    command += $${header_path}/boost/spirit/home/classic/symbols
    command += $${header_path}/boost/spirit/home/classic/symbols/impl
    command += $${header_path}/boost/spirit/home/classic/tree
    command += $${header_path}/boost/spirit/home/classic/tree/impl
    command += $${header_path}/boost/spirit/home/classic/utility
    command += $${header_path}/boost/spirit/home/classic/utility/impl
    command += $${header_path}/boost/spirit/home/classic/utility/impl/chset
    command += $${header_path}/boost/spirit/home/karma
    command += $${header_path}/boost/spirit/home/karma/action
    command += $${header_path}/boost/spirit/home/karma/auto
    command += $${header_path}/boost/spirit/home/karma/auxiliary
    command += $${header_path}/boost/spirit/home/karma/binary
    command += $${header_path}/boost/spirit/home/karma/char
    command += $${header_path}/boost/spirit/home/karma/detail
    command += $${header_path}/boost/spirit/home/karma/directive
    command += $${header_path}/boost/spirit/home/karma/nonterminal
    command += $${header_path}/boost/spirit/home/karma/nonterminal/detail
    command += $${header_path}/boost/spirit/home/karma/numeric
    command += $${header_path}/boost/spirit/home/karma/numeric/detail
    command += $${header_path}/boost/spirit/home/karma/operator
    command += $${header_path}/boost/spirit/home/karma/stream
    command += $${header_path}/boost/spirit/home/karma/stream/detail
    command += $${header_path}/boost/spirit/home/karma/string
    command += $${header_path}/boost/spirit/home/lex
    command += $${header_path}/boost/spirit/home/lex/detail
    command += $${header_path}/boost/spirit/home/lex/lexer
    command += $${header_path}/boost/spirit/home/lex/lexer/lexertl
    command += $${header_path}/boost/spirit/home/lex/qi
    command += $${header_path}/boost/spirit/home/qi
    command += $${header_path}/boost/spirit/home/qi/action
    command += $${header_path}/boost/spirit/home/qi/auto
    command += $${header_path}/boost/spirit/home/qi/auxiliary
    command += $${header_path}/boost/spirit/home/qi/binary
    command += $${header_path}/boost/spirit/home/qi/char
    command += $${header_path}/boost/spirit/home/qi/detail
    command += $${header_path}/boost/spirit/home/qi/directive
    command += $${header_path}/boost/spirit/home/qi/nonterminal
    command += $${header_path}/boost/spirit/home/qi/nonterminal/detail
    command += $${header_path}/boost/spirit/home/qi/numeric
    command += $${header_path}/boost/spirit/home/qi/numeric/detail
    command += $${header_path}/boost/spirit/home/qi/operator
    command += $${header_path}/boost/spirit/home/qi/stream
    command += $${header_path}/boost/spirit/home/qi/stream/detail
    command += $${header_path}/boost/spirit/home/qi/string
    command += $${header_path}/boost/spirit/home/qi/string/detail
    command += $${header_path}/boost/spirit/home/support
    command += $${header_path}/boost/spirit/home/support/algorithm
    command += $${header_path}/boost/spirit/home/support/auto
    command += $${header_path}/boost/spirit/home/support/auxiliary
    command += $${header_path}/boost/spirit/home/support/char_encoding
    command += $${header_path}/boost/spirit/home/support/char_encoding/unicode
    command += $${header_path}/boost/spirit/home/support/char_set
    command += $${header_path}/boost/spirit/home/support/detail
    command += $${header_path}/boost/spirit/home/support/detail/endian
    command += $${header_path}/boost/spirit/home/support/detail/lexer
    command += $${header_path}/boost/spirit/home/support/detail/lexer/containers
    command += $${header_path}/boost/spirit/home/support/detail/lexer/conversion
    command += $${header_path}/boost/spirit/home/support/detail/lexer/parser
    command += $${header_path}/boost/spirit/home/support/detail/lexer/parser/tokeniser
    command += $${header_path}/boost/spirit/home/support/detail/lexer/parser/tree
    command += $${header_path}/boost/spirit/home/support/detail/lexer/partition
    command += $${header_path}/boost/spirit/home/support/detail/math
    command += $${header_path}/boost/spirit/home/support/detail/math/detail
    command += $${header_path}/boost/spirit/home/support/iterators
    command += $${header_path}/boost/spirit/home/support/iterators/detail
    command += $${header_path}/boost/spirit/home/support/nonterminal
    command += $${header_path}/boost/spirit/home/support/utree
    command += $${header_path}/boost/spirit/home/support/utree/detail
    command += $${header_path}/boost/spirit/home/x3
    command += $${header_path}/boost/spirit/home/x3/auxiliary
    command += $${header_path}/boost/spirit/home/x3/binary
    command += $${header_path}/boost/spirit/home/x3/char
    command += $${header_path}/boost/spirit/home/x3/char/detail
    command += $${header_path}/boost/spirit/home/x3/core
    command += $${header_path}/boost/spirit/home/x3/core/detail
    command += $${header_path}/boost/spirit/home/x3/directive
    command += $${header_path}/boost/spirit/home/x3/nonterminal
    command += $${header_path}/boost/spirit/home/x3/nonterminal/detail
    command += $${header_path}/boost/spirit/home/x3/numeric
    command += $${header_path}/boost/spirit/home/x3/operator
    command += $${header_path}/boost/spirit/home/x3/operator/detail
    command += $${header_path}/boost/spirit/home/x3/string
    command += $${header_path}/boost/spirit/home/x3/string/detail
    command += $${header_path}/boost/spirit/home/x3/support
    command += $${header_path}/boost/spirit/home/x3/support/ast
    command += $${header_path}/boost/spirit/home/x3/support/numeric_utils
    command += $${header_path}/boost/spirit/home/x3/support/numeric_utils/detail
    command += $${header_path}/boost/spirit/home/x3/support/traits
    command += $${header_path}/boost/spirit/home/x3/support/utility
    command += $${header_path}/boost/spirit/include
    command += $${header_path}/boost/spirit/repository
    command += $${header_path}/boost/spirit/repository/home
    command += $${header_path}/boost/spirit/repository/home/karma
    command += $${header_path}/boost/spirit/repository/home/karma/directive
    command += $${header_path}/boost/spirit/repository/home/karma/nonterminal
    command += $${header_path}/boost/spirit/repository/home/qi
    command += $${header_path}/boost/spirit/repository/home/qi/directive
    command += $${header_path}/boost/spirit/repository/home/qi/nonterminal
    command += $${header_path}/boost/spirit/repository/home/qi/operator
    command += $${header_path}/boost/spirit/repository/home/qi/operator/detail
    command += $${header_path}/boost/spirit/repository/home/qi/primitive
    command += $${header_path}/boost/spirit/repository/home/support
    command += $${header_path}/boost/spirit/repository/include
    command += $${header_path}/boost/stacktrace
    command += $${header_path}/boost/stacktrace/detail
    command += $${header_path}/boost/statechart
    command += $${header_path}/boost/statechart/detail
    command += $${header_path}/boost/system
    command += $${header_path}/boost/system/detail
    command += $${header_path}/boost/test
    command += $${header_path}/boost/test/data
    command += $${header_path}/boost/test/data/monomorphic
    command += $${header_path}/boost/test/data/monomorphic/generators
    command += $${header_path}/boost/test/detail
    command += $${header_path}/boost/test/impl
    command += $${header_path}/boost/test/included
    command += $${header_path}/boost/test/output
    command += $${header_path}/boost/test/tools
    command += $${header_path}/boost/test/tools/detail
    command += $${header_path}/boost/test/tools/old
    command += $${header_path}/boost/test/tree
    command += $${header_path}/boost/test/utils
    command += $${header_path}/boost/test/utils/basic_cstring
    command += $${header_path}/boost/test/utils/iterator
    command += $${header_path}/boost/test/utils/runtime
    command += $${header_path}/boost/test/utils/runtime/cla
    command += $${header_path}/boost/test/utils/runtime/env
    command += $${header_path}/boost/thread
    command += $${header_path}/boost/thread/concurrent_queues
    command += $${header_path}/boost/thread/concurrent_queues/detail
    command += $${header_path}/boost/thread/csbl
    command += $${header_path}/boost/thread/csbl/memory
    command += $${header_path}/boost/thread/detail
    command += $${header_path}/boost/thread/executors
    command += $${header_path}/boost/thread/executors/detail
    command += $${header_path}/boost/thread/experimental
    command += $${header_path}/boost/thread/experimental/config
    command += $${header_path}/boost/thread/experimental/parallel
    command += $${header_path}/boost/thread/experimental/parallel/v1
    command += $${header_path}/boost/thread/experimental/parallel/v2
    command += $${header_path}/boost/thread/futures
    command += $${header_path}/boost/thread/pthread
    command += $${header_path}/boost/thread/v2
    command += $${header_path}/boost/thread/win32
    command += $${header_path}/boost/timer
    command += $${header_path}/boost/tti
    command += $${header_path}/boost/tti/detail
    command += $${header_path}/boost/tti/gen
    command += $${header_path}/boost/tuple
    command += $${header_path}/boost/tuple/detail
    command += $${header_path}/boost/type_erasure
    command += $${header_path}/boost/type_erasure/detail
    command += $${header_path}/boost/type_index
    command += $${header_path}/boost/type_index/detail
    command += $${header_path}/boost/type_index/runtime_cast
    command += $${header_path}/boost/type_index/runtime_cast/detail
    command += $${header_path}/boost/type_traits
    command += $${header_path}/boost/type_traits/detail
    command += $${header_path}/boost/typeof
    command += $${header_path}/boost/typeof/dmc
    command += $${header_path}/boost/typeof/msvc
    command += $${header_path}/boost/typeof/std
    command += $${header_path}/boost/units
    command += $${header_path}/boost/units/base_units
    command += $${header_path}/boost/units/base_units/angle
    command += $${header_path}/boost/units/base_units/astronomical
    command += $${header_path}/boost/units/base_units/cgs
    command += $${header_path}/boost/units/base_units/imperial
    command += $${header_path}/boost/units/base_units/information
    command += $${header_path}/boost/units/base_units/metric
    command += $${header_path}/boost/units/base_units/si
    command += $${header_path}/boost/units/base_units/temperature
    command += $${header_path}/boost/units/base_units/us
    command += $${header_path}/boost/units/detail
    command += $${header_path}/boost/units/physical_dimensions
    command += $${header_path}/boost/units/systems
    command += $${header_path}/boost/units/systems/angle
    command += $${header_path}/boost/units/systems/cgs
    command += $${header_path}/boost/units/systems/detail
    command += $${header_path}/boost/units/systems/information
    command += $${header_path}/boost/units/systems/si
    command += $${header_path}/boost/units/systems/si/codata
    command += $${header_path}/boost/units/systems/temperature
    command += $${header_path}/boost/unordered
    command += $${header_path}/boost/unordered/detail
    command += $${header_path}/boost/utility
    command += $${header_path}/boost/utility/detail
    command += $${header_path}/boost/uuid
    command += $${header_path}/boost/uuid/detail
    command += $${header_path}/boost/variant
    command += $${header_path}/boost/variant/detail
    command += $${header_path}/boost/vmd
    command += $${header_path}/boost/vmd/array
    command += $${header_path}/boost/vmd/detail
    command += $${header_path}/boost/vmd/detail/recurse
    command += $${header_path}/boost/vmd/detail/recurse/data_equal
    command += $${header_path}/boost/vmd/detail/recurse/equal
    command += $${header_path}/boost/vmd/list
    command += $${header_path}/boost/vmd/seq
    command += $${header_path}/boost/vmd/tuple
    command += $${header_path}/boost/wave
    command += $${header_path}/boost/wave/cpplexer
    command += $${header_path}/boost/wave/cpplexer/re2clex
    command += $${header_path}/boost/wave/grammars
    command += $${header_path}/boost/wave/util
    command += $${header_path}/boost/winapi
    command += $${header_path}/boost/winapi/detail
    command += $${header_path}/boost/xpressive
    command += $${header_path}/boost/xpressive/detail
    command += $${header_path}/boost/xpressive/detail/core
    command += $${header_path}/boost/xpressive/detail/core/matcher
    command += $${header_path}/boost/xpressive/detail/dynamic
    command += $${header_path}/boost/xpressive/detail/static
    command += $${header_path}/boost/xpressive/detail/static/transforms
    command += $${header_path}/boost/xpressive/detail/utility
    command += $${header_path}/boost/xpressive/detail/utility/chset
    command += $${header_path}/boost/xpressive/traits
    command += $${header_path}/boost/xpressive/traits/detail

    INCLUDEPATH += $$command
    export(INCLUDEPATH)
    return (1)
}

#修改
defineTest(add_defines_Boost){
    #添加这个SDK里的defines
    #add_defines()

    #--------------------------------------------
    #留意 Boost 使用的控制宏
    #--------------------------------------------

    #--------------------------------------------
    #Multi-link 提供 Template 的自有控制宏，
    #留意 Template 使用的控制宏
    #--------------------------------------------

    #--------------------------------------------
    #根据 Boost 使用的控制宏，修改 Boost 编译时、链接时的不同的宏配置。编译时，修改前两个判断分支；链接时，修改后两个判断分支。
    #可以用于转换使用不同宏、两套宏控制的链接库。
    #--------------------------------------------
    #Boost 动态编译时
    contains(DEFINES, BOOST_LIBRARY){
        message($${TARGET} build Boost dynamic library)
    }
    #Boost 静态编译、链接时
    else:contains(DEFINES, BOOST_STATIC_LIBRARY){
        message($${TARGET} build-link Boost static library)
    }
    #Boost 动态链接时
    else:!contains(DEFINES, BOOST_LIBRARY){
        message($${TARGET} link Boost dynamic library)
    }

    #--------------------------------------------
    #添加库的宏配置信息，编译时、链接时通用，需要注意区分不同宏控制
    #建议先写动态编译、链接时的通用配置，然后增加对动态编译、链接，对静态编译、链接时的兼容处理。处理多个子模块时特别好用。
    #--------------------------------------------

    export(QT)
    export(DEFINES)
    export(CONFIG)
    return (1)
}

#留意
defineTest(add_library_Boost){
    #这个地方add_library_bundle代表 macOS下，lib在bundle里。 留意
    #添加这个SDK里的library

    add_library(Boost, boost_atomic)
    add_library(Boost, boost_chrono)
    add_library(Boost, boost_container)
    add_library(Boost, boost_context)
    add_library(Boost, boost_contract)
    add_library(Boost, boost_coroutine)
    add_library(Boost, boost_date_time)
    add_library(Boost, boost_exception)
    add_library(Boost, boost_filesystem)
    add_library(Boost, boost_graph)
    add_library(Boost, boost_iostreams)
    add_library(Boost, boost_locale)
    add_library(Boost, boost_log)
    add_library(Boost, boost_log_setup)
    add_library(Boost, boost_math_c99)
    add_library(Boost, boost_math_c99f)
    add_library(Boost, boost_math_c99l)
    add_library(Boost, boost_math_tr1)
    add_library(Boost, boost_math_tr1f)
    add_library(Boost, boost_math_tr1l)
    add_library(Boost, boost_numpy27)
    add_library(Boost, boost_prg_exec_monitor)
    add_library(Boost, boost_program_options)
    add_library(Boost, boost_python27)
    add_library(Boost, boost_random)
    add_library(Boost, boost_regex)
    add_library(Boost, boost_serialization)
    add_library(Boost, boost_signals)
    add_library(Boost, boost_stacktrace_addr2line)
    add_library(Boost, boost_stacktrace_basic)
    add_library(Boost, boost_stacktrace_noop)
    add_library(Boost, boost_system)
    add_library(Boost, boost_test_exec_monitor)
    add_library(Boost, boost_thread)
    add_library(Boost, boost_timer)
    add_library(Boost, boost_type_erasure)
    add_library(Boost, boost_unit_test_framework)
    add_library(Boost, boost_wave)
    add_library(Boost, boost_wserialization)

    return (1)
}


#发布依赖library
#注意Android也需要这个函数，使用这个函数Android才会发布Library到运行时。上边的只是链接作用。
#修改
defineTest(add_deploy_library_Boost) {
    #这个地方add_deploy_library_bundle代表macOS下发布的是bundle格式。
    #add_deploy_libraryes(Boost)

    add_deploy_library(Boost, boost_atomic)
    add_deploy_library(Boost, boost_chrono)
    add_deploy_library(Boost, boost_container)
    add_deploy_library(Boost, boost_context)
    add_deploy_library(Boost, boost_contract)
    add_deploy_library(Boost, boost_coroutine)
    add_deploy_library(Boost, boost_date_time)
    add_deploy_library(Boost, boost_exception)
    add_deploy_library(Boost, boost_filesystem)
    add_deploy_library(Boost, boost_graph)
    add_deploy_library(Boost, boost_iostreams)
    add_deploy_library(Boost, boost_locale)
    add_deploy_library(Boost, boost_log)
    add_deploy_library(Boost, boost_log_setup)
    add_deploy_library(Boost, boost_math_c99)
    add_deploy_library(Boost, boost_math_c99f)
    add_deploy_library(Boost, boost_math_c99l)
    add_deploy_library(Boost, boost_math_tr1)
    add_deploy_library(Boost, boost_math_tr1f)
    add_deploy_library(Boost, boost_math_tr1l)
    add_deploy_library(Boost, boost_numpy27)
    add_deploy_library(Boost, boost_prg_exec_monitor)
    add_deploy_library(Boost, boost_program_options)
    add_deploy_library(Boost, boost_python27)
    add_deploy_library(Boost, boost_random)
    add_deploy_library(Boost, boost_regex)
    add_deploy_library(Boost, boost_serialization)
    add_deploy_library(Boost, boost_signals)
    add_deploy_library(Boost, boost_stacktrace_addr2line)
    add_deploy_library(Boost, boost_stacktrace_basic)
    add_deploy_library(Boost, boost_stacktrace_noop)
    add_deploy_library(Boost, boost_system)
    add_deploy_library(Boost, boost_test_exec_monitor)
    add_deploy_library(Boost, boost_thread)
    add_deploy_library(Boost, boost_timer)
    add_deploy_library(Boost, boost_type_erasure)
    add_deploy_library(Boost, boost_unit_test_framework)
    add_deploy_library(Boost, boost_wave)
    add_deploy_library(Boost, boost_wserialization)
    return (1)
}
