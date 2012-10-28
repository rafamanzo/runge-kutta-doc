set yzeroaxis

set boxwidth 0.000005 absolute
set style fill solid 1.0 noborder
set title "Histograma RK4 GT 520M - 256 Pontos"
bin_width = 0.00001;
set yrange[0:20]
#set output "histogram-gpu-rk4-256.png"
#set terminal png

bin_number(x) = floor(x/bin_width)

rounded(x) = bin_width * ( bin_number(x))

plot 'proccessing-histogram-256-CUDA-RK4.dat' using (rounded($1)):(1) smooth frequency with boxes title "Contagem"
pause -1