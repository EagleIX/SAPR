#!/bin/sh
# сборка и запуск светофора без Eclipse (запускать в Nios II Command Shell):
#   sh files/run_traffic.sh      (из папки lab3_dima)
cd "$(dirname "$0")/.." || exit 1

echo "=== 1. BSP from nios_system.sopcinfo ==="
nios2-bsp hal software/traffic_bsp nios_system.sopcinfo \
  --set hal.enable_small_c_library true \
  --set hal.enable_reduced_device_drivers true || exit 1

echo "=== 2. Application Makefile ==="
mkdir -p software/traffic
cp files/traffic.c software/traffic/
cd software/traffic || exit 1
nios2-app-generate-makefile --bsp-dir ../traffic_bsp --elf-name traffic.elf --src-files traffic.c || exit 1

echo "=== 3. Build ==="
make || exit 1
cd ../..

echo "=== 4. Configure FPGA ==="
nios2-configure-sof output_files/DE2_115_traffic.sof || exit 1

echo "=== 5. Download program, terminal (exit: Ctrl+C) ==="
nios2-download -g software/traffic/traffic.elf || exit 1
nios2-terminal
