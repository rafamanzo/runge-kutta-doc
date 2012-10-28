set title "Tempos médios"
set terminal png size 800,600
set output "cpu-means.png"

plot "cpu-data/i7proccessing-means-C-RK2.dat" with linespoints title "i7 - Método de ordem 2", "cpu-data/i7proccessing-means-C-RK4.dat" with linespoints title "i7 - Método de ordem 4", "cpu-data/c2dproccessing-means-C-RK2.dat" with linespoints title "Core 2 Duo - Método de ordem 2", "cpu-data/c2dproccessing-means-C-RK4.dat" with linespoints title "Core 2 Duo - Método de ordem 4"
#pause -1