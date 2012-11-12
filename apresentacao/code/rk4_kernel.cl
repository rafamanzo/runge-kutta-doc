__kernel void rk4_kernel(__global vector *v0, __global unsigned int* count_v0,__global double* h,
  __global int* n_x,__global int* n_y,__global int* n_z, __global vector* field,
  __global vector *points,__global unsigned int *n_points, __global unsigned int* max_points){

  vector k1, k2, k3, k4, initial, direction;
  unsigned int i, n_points_aux;
    
  n_points_aux = 0;
    
  i = get_global_id(0);

  set( &initial, v0[i] );
  set( &direction, field[opencl_offset(*n_x, *n_y,initial.x,initial.y,initial.z)] );

  while(module(direction) > 0.0 && (n_points_aux < (*max_points) && n_points_aux < MAX_POINTS)){
    n_points_aux++;

    points[opencl_offset((*count_v0), 0, i, n_points_aux - 1, 0)] =  initial;
           
    set( &k1, mult_scalar( direction, *h ) );
    set( &k2, mult_scalar( trilinear_interpolation(sum(initial, mult_scalar( k1, 0.5 )), n_x, n_y, n_z,
                                                   field), *h) ); 
    set( &k3, mult_scalar( trilinear_interpolation(sum(initial, mult_scalar( k2, 0.5 )), n_x, n_y, n_z,
                                                   field), *h) );
    set( &k4, mult_scalar( trilinear_interpolation(sum(initial, k3), n_x, n_y, n_z, field), *h) );
      
    set( &initial, sum( initial, sum( mult_scalar( k1 , 0.166666667 ), sum( mult_scalar( k2, 0.333333333 ),
                   sum( mult_scalar( k3, 0.333333333 ), mult_scalar( k4, 0.166666667 ) ) ) ) ) );
    set( &direction, trilinear_interpolation(initial, n_x, n_y, n_z, field) );
  }

  n_points[i] = n_points_aux;

}
