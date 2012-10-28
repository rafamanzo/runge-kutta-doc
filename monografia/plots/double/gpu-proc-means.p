set title "Tempos médios"
set terminal png size 800,600
set output "gpu-means.png"

plot "gpu-data/gt520mproccessing-means-CUDA-RK2.dat" with linespoints title "GT 520M - Método de ordem 2", "gpu-data/gt520mproccessing-means-CUDA-RK4.dat" with linespoints title "GT 520M - Método de ordem 4", "gpu-data/gts450proccessing-means-CUDA-RK2.dat" with linespoints title "GTS 450 - Método de ordem 2", "gpu-data/gts450proccessing-means-CUDA-RK4.dat" with linespoints title "GTS 450 - Método de ordem 4"
#pause -1