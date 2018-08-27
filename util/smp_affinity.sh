#!/usr/bin/env bash

#############################################################################
## smp_affinity.sh
##
## Script to set IRQ SMP affinity for NVMe devices on pre-4.8 Linux kernels
##
## See https://itpeernetwork.intel.com/tuning-performance-intel-optane-ssds-linux-operating-systems/
##
#############################################################################


Usage() {
  echo "smp_affinity.sh <check|write>"
  exit
}

(( $# == 1 )) || Usage

case "$1" in
  "check") cmd=check ;;
  "write") cmd=write ;;
  *)       Usage ;;
esac

count=0

for dir in /proc/irq/*; do
  for file in ${dir}/*; do
    if [[ "$file" == *"nvme"* ]]; then
      if [[ -e "${dir}/affinity_hint" ]]; then
        hint=$(cat ${dir}/affinity_hint)
        if [[ "$cmd" == "check" ]]; then
          current=$(cat ${dir}/smp_affinity) 
          if [[ "$hint" != "$current" ]]; then
            echo "nonzero diff found in $dir"
            (( count++ ))
          fi
        else
          cat "${dir}/affinity_hint" > "${dir}/smp_affinity"
          (( count++ ))
        fi
      else         
        echo "ERROR: File ${dir}/affinity_hint does not exist"
      fi
    fi 
  done
done

if [[ "$cmd" == "check" ]]; then
  echo "Found $count differences between smp_affinity and affinity_hint"
else
  echo "Wrote affinity_hint to smp_affinity for $count IRQ's"
fi
