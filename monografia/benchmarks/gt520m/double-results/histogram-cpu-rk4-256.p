set yzeroaxis

set boxwidth 3.5 absolute
set style fill solid 1.0 noborder
set title "Histograma RK4 Core 2 Duo - 256 Pontos"
bin_width = 7;
set yrange[0:10]
set output "histogram-cpu-rk4-256.png"
set terminal png

bin_number(x) = floor(x/bin_width)

rounded(x) = bin_width * ( bin_number(x))

plot 'proccessing-histogram-256-C-RK4.dat' using (rounded($1)):(1) smooth frequency with boxes title "Contagem"
#pause -1