# timing constraints: board clock 50 MHz (period 20 ns)
create_clock -name CLOCK_50 -period 20 [get_ports CLOCK_50]
derive_clock_uncertainty
