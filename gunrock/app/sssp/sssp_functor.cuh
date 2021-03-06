// ----------------------------------------------------------------
// Gunrock -- Fast and Efficient GPU Graph Library
// ----------------------------------------------------------------
// This source code is distributed under the terms of LICENSE.TXT
// in the root directory of this source distribution.
// ----------------------------------------------------------------

/**
 * @file
 * sssp_functor.cuh
 *
 * @brief Device functions for SSSP problem.
 */

#pragma once
#include <gunrock/app/problem_base.cuh>
#include <gunrock/app/sssp/sssp_problem.cuh>
#include <stdio.h>

namespace gunrock { namespace app {
namespace sssp {

/**
 * @brief Structure contains device functions in SSSP graph traverse.
 *
 * @tparam VertexId            Type of signed integer to use as vertex id (e.g., uint32)
 * @tparam SizeT               Type of unsigned integer to use for array indexing. (e.g., uint32)
 * @tparam ProblemData         Problem data type which contains data slice for SSSP problem
 *
 */
template<typename VertexId, typename SizeT, typename ProblemData>
struct SSSPFunctor
{
    typedef typename ProblemData::DataSlice DataSlice;

    /**
     * @brief Forward Edge Mapping condition function. Check if the destination node
     * has been claimed as someone else's child.
     *
     * @param[in] s_id Vertex Id of the edge source node
     * @param[in] d_id Vertex Id of the edge destination node
     * @param[in] problem Data slice object
     * @param[in] e_id output edge id
     * @param[in] e_id_in input edge id
     *
     * \return Whether to load the apply function for the edge and include the destination node in the next frontier.
     */
    static __device__ __forceinline__ bool CondEdge(VertexId s_id, VertexId d_id, DataSlice *problem, VertexId e_id = 0, VertexId e_id_in = 0)
    {
        unsigned int label, weight;

        util::io::ModifiedLoad<ProblemData::COLUMN_READ_MODIFIER>::Ld(
                        label, problem->d_labels + s_id);
        util::io::ModifiedLoad<ProblemData::COLUMN_READ_MODIFIER>::Ld(
                        weight, problem->d_weights + e_id);
        unsigned int new_weight = weight + label;
       
        
        // Check if the destination node has been claimed as someone's child
        return (new_weight < atomicMin(&problem->d_labels[d_id], new_weight));
    }

    /**
     * @brief Forward Edge Mapping apply function. Now we know the source node
     * has succeeded in claiming child, so it is safe to set label to its child
     * node (destination node).
     *
     * @param[in] s_id Vertex Id of the edge source node
     * @param[in] d_id Vertex Id of the edge destination node
     * @param[in] problem Data slice object
     * @param[in] e_id output edge id
     * @param[in] e_id_in input edge id
     *
     */
    static __device__ __forceinline__ void ApplyEdge(VertexId s_id, VertexId d_id, DataSlice *problem, VertexId e_id = 0, VertexId e_id_in = 0)
    { 
        if (ProblemData::MARK_PATHS)
            util::io::ModifiedStore<ProblemData::QUEUE_WRITE_MODIFIER>::St(
                    s_id, problem->d_preds + d_id); 
    }

    /**
     * @brief Vertex mapping condition function. Check if the Vertex Id is valid (not equal to -1).
     *
     * @param[in] node Vertex Id
     * @param[in] problem Data slice object
     * @param[in] v auxiliary value
     *
     * \return Whether to load the apply function for the node and include it in the outgoing vertex frontier.
     */
    static __device__ __forceinline__ bool CondFilter(VertexId node, DataSlice *problem, unsigned int v =0, SizeT nid=0)
    {
        return (node != -1);
    }

    /**
     * @brief Vertex mapping apply function. Doing nothing for SSSP problem.
     *
     * @param[in] node Vertex Id
     * @param[in] problem Data slice object
     * @param[in] v auxiliary value
     *
     */
    static __device__ __forceinline__ void ApplyFilter(VertexId node, DataSlice *problem, unsigned int v = 0, SizeT nid=0)
    {
        // Doing nothing here
    }
};

template<typename VertexId, typename SizeT, typename ProblemData>
struct PQFunctor
{
    typedef typename ProblemData::DataSlice DataSlice;

    /**
     * @brief Forward Edge Mapping condition function. Check if the destination node
     * has been claimed as someone else's child.
     *
     * @param[in] s_id Vertex Id of the edge source node
     * @param[in] d_id Vertex Id of the edge destination node
     * @param[in] problem Data slice object
     *
     * \return Whether to load the apply function for the edge and include the destination node in the next frontier.
     */
    static __device__ __forceinline__ unsigned int ComputePriorityScore(VertexId node_id, DataSlice *problem)
    {
        unsigned int weight;
        util::io::ModifiedLoad<ProblemData::COLUMN_READ_MODIFIER>::Ld(
                        weight, problem->d_labels + node_id);
        float delta;
        util::io::ModifiedLoad<ProblemData::COLUMN_READ_MODIFIER>::Ld(
                        delta, problem->d_delta);
        return (delta == 0) ? weight : weight/delta;
    }
};
 

} // sssp
} // app
} // gunrock

// Leave this at the end of the file
// Local Variables:
// mode:c++
// c-file-style: "NVIDIA"
// End:
