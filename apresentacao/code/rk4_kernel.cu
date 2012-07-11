__global__ void rk4_kernel(vector *v0, int count_v0, double h, int n_x, int n_y, int n_z,
                           vector_field field, vector *points, int *n_points, int max_points)
{
  vector k1, k2, k3, k4, initial, direction;
  int i, n_points_aux;
  
  n_points_aux = 0;
  
  i = threadIdx.x;
  
  set( &initial, v0[i] );
  set( &direction, field[cuda_offset(n_x, n_y, initial.x, initial.y, initial.z)] );
  
  while(floor(module(direction)) > 0.0 && n_points_aux < max_points){
    n_points_aux++;
        
    set( &(points[cuda_offset(count_v0, 0, i, n_points_aux - 1, 0)]), initial );
  
    set( &k1, mult_scalar( direction, h ) );
    set( &k2, sum( mult_scalar(k1, 0.5), mult_scalar( direction, h ) ) );
    set( &k3, sum( mult_scalar(k2, 0.5), mult_scalar( direction, h ) ) );
    set( &k4, sum( k3, mult_scalar( direction, h ) ) );
    
    set( &initial, sum( initial, sum( mult_scalar( k1 , 1.0/6.0 ), sum( mult_scalar( k2, 1.0/3.0 ),
         sum( mult_scalar( k3, 1.0/3.0 ), mult_scalar( k4, 1.0/6.0 ) ) ) ) ) );
    set( &direction, trilinear_interpolation(initial, n_x, n_y, n_z, field) );
  }
  
  n_points[i] = n_points_aux;
}
