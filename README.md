# MATLAB Programming for Virtual Element Methods

--------------
## MESH

- We present some basic functions to show the polygonal meshes, including marking of the nodes, elements and (boundary) edges.

- For the convenience of computation, some auxiliary mesh data are introduced. 
  The idea stems from the treatment of triangulation in iFEM, which is generalized to polygonal meshes with certain modifications. 

- We also provide a boundary setting function to identify the Neumann and Dirichlet boundaries (See setboundary.m).

- The mesh generation algorithms are also described in detail.

- We present an efficient implementation of the mesh refinement for polygonal meshes. To the best of our knowledge, this is the first publicly available implementation of the polygonal mesh refinement algorithms. We remove the small edges by requiring the one-hanging-node rule.

-------------------------
## Conforming Virtual Element Methods

### Poisson equation (k <= 3)

We describe the details of designing the codes of conforming VEMs for Poisson equation with k up to 3, 
including the computation of elliptic projection and L2 projection, the matrix form of the approximated variational problems as well as the treatment of boundary conditions.
We also show how the errors under L2,H1 and energy norms can be computed using the numerical d.o.f.s.

### Linear elasticity problems (lowest order k = 1)

The VEM of lowest order for linear elasticity problems is introduced for both the displacement-type (or Navier-type) and tensor-type bilinear forms. 

### Plate bending problems (lowest order k = 2)

Three VEMs involved in the literature are described in detail, i.e., the C1, C0 and Morley-type elements.

### Fourth-order singular perturbation problems

 This problem combines the techniques in Poisson equation and plate bending problems.


---------------
## Nonconforming Virtual Element Methods

   We implement the nonconforming VEMs with a continuous treatment on the boundary of the domain.
   
   - Poisson equation
   
   - linear elasticity problem with tensor-type bilinear form


------------------
## Mixed Virtual Element Methods

 - Mixed vem for Darcy problem in the lowest order H(div)-conforming virtual element
 
 - Mixed vem for Darcy problem in the lowest order lifting H(div)-conforming virtual element
 
 - Divergence-free mixed vem for Stokes problem in the lowest order


------------------
##  Adaptive Virtual Element Methods

  - Mesh refinement of polygonal meshes
  
  - Adaptive VEM for Poisson equation in the lowest order


  PS: 

      程序对区域、边界条件等的处理都较为一般，可容易地移植到其他问题。
      
      编程过程完全遵循有限元的思路。
      
      相比网上有的程序，过程更加清晰，充分使用了 MATLAB 的向量运算。
      
      在计算各种投影的边界项时，部分程序中使用有限元载荷向量的装配技巧避免了繁琐的人为处理。

  Undo:

      - 3-D VEMs  
      
      - Time-dependent problems and nonlinear problems
      
      - Various applications: Cahn–Hilliard problem, Stokes–Darcy problem, Navier-Stokes, etc.
      
      - Mesh generation in 3-D


​      

