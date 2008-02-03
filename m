From: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Date: Sun, 03 Feb 2008 23:21:02 +0000
Subject: Various section mismatches
Message-Id: <1202080862.9936.4.camel@localhost.localdomain>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

I am going to bed now, so won't try to fix these now...


adrian@bossclass:~/gdrom-dev$ make ARCH=sh CROSS_COMPILE=/home/adrian/dreamy-linux/buildroot/build_sh4/staging_dir/bin/sh4-linux- modules zImage -j3

...

  LD      arch/sh/kernel/cpu/built-in.o
WARNING: arch/sh/kernel/cpu/built-in.o(.cpuinit.text+0x164): Section mismatch in reference from the function sh_cpu_init() to the function .init.text:detect_cpu_and_cache_system()
The function __cpuinit sh_cpu_init() references
a function __init detect_cpu_and_cache_system().
If sh_cpu_init is only used by detect_cpu_and_cache_system then
annotate sh_cpu_init with a matching annotation.

WARNING: arch/sh/kernel/cpu/built-in.o(.cpuinit.text+0x2f0): Section mismatch in reference from the function sh_cpu_init() to the variable .init.data:sh7750_devices
The function __cpuinit sh_cpu_init() references
a variable __initdata sh7750_devices.
If sh_cpu_init is only used by sh7750_devices then
annotate sh_cpu_init with a matching annotation.

  
  LD      arch/sh/kernel/built-in.o
WARNING: arch/sh/kernel/built-in.o(.cpuinit.text+0x184): Section mismatch in reference from the function sh_cpu_init() to the function .init.text:detect_cpu_and_cache_system()
The function __cpuinit sh_cpu_init() references
a function __init detect_cpu_and_cache_system().
If sh_cpu_init is only used by detect_cpu_and_cache_system then
annotate sh_cpu_init with a matching annotation.

WARNING: arch/sh/kernel/built-in.o(.cpuinit.text+0x310): Section mismatch in reference from the function sh_cpu_init() to the variable .init.data:__setup_str_early_parse_mv
The function __cpuinit sh_cpu_init() references
a variable __initdata __setup_str_early_parse_mv.
If sh_cpu_init is only used by __setup_str_early_parse_mv then
annotate sh_cpu_init with a matching annotation.

 
  LD      mm/built-in.o
WARNING: mm/built-in.o(.meminit.text+0x8e4): Section mismatch in reference from the function free_area_init_node() to the function .init.text:__alloc_bootmem_node()
The function __meminit free_area_init_node() references
a function __init __alloc_bootmem_node().
If free_area_init_node is only used by __alloc_bootmem_node then
annotate free_area_init_node with a matching annotation.

  
  LD      drivers/pci/built-in.o
WARNING: drivers/pci/built-in.o(__ksymtab+0x58): Section mismatch in reference from the variable __ksymtab_pci_do_scan_bus to the function .devinit.text:pci_do_scan_bus()
The symbol pci_do_scan_bus is exported and annotated __devinit 
Fix this by removing the __devinit annotation of pci_do_scan_bus or drop the export.

  
  LD      drivers/video/built-in.o
WARNING: drivers/video/built-in.o(.text+0xd980): Section mismatch in reference from the function pvr2fb_check_var() to the variable .devinit.data:pvr2fb_pci_tbl
The function  pvr2fb_check_var() references
the variable __devinitdata pvr2fb_pci_tbl.
This is often because pvr2fb_check_var lacks a __devinitdata 
annotation or the annotation of pvr2fb_pci_tbl is wrong.

  LD      drivers/built-in.o
  CC      net/core/netevent.o
WARNING: drivers/built-in.o(.text+0x15bc0): Section mismatch in reference from the function pvr2fb_check_var() to the variable .devinit.data:pvr2fb_pci_tbl
The function  pvr2fb_check_var() references
the variable __devinitdata pvr2fb_pci_tbl.
This is often because pvr2fb_check_var lacks a __devinitdata 
annotation or the annotation of pvr2fb_pci_tbl is wrong.

WARNING: drivers/built-in.o(__ksymtab+0x58): Section mismatch in reference from the variable __ksymtab_pci_do_scan_bus to the function .devinit.text:pci_do_scan_bus()
The symbol pci_do_scan_bus is exported and annotated __devinit 
Fix this by removing the __devinit annotation of pci_do_scan_bus or drop the export.

  
  LD      vmlinux.o
  MODPOST vmlinux.o
  GEN     .version
  CHK     include/linux/compile.h
WARNING: vmlinux.o(.text+0x1095f8): Section mismatch in reference from the function pci_scan_child_bus() to the function .devinit.text:pcibios_fixup_bus()
The function  pci_scan_child_bus() references
the function __devinit pcibios_fixup_bus().
This is often because pci_scan_child_bus lacks a __devinit 
annotation or the annotation of pcibios_fixup_bus is wrong.

WARNING: vmlinux.o(.text+0x11d3c0): Section mismatch in reference from the function pvr2fb_check_var() to the variable .devinit.data:pvr2fb_pci_tbl
The function  pvr2fb_check_var() references
the variable __devinitdata pvr2fb_pci_tbl.
This is often because pvr2fb_check_var lacks a __devinitdata 
annotation or the annotation of pvr2fb_pci_tbl is wrong.

  UPD     include/linux/compile.h
  CC      init/version.o
WARNING: vmlinux.o(.cpuinit.text+0x184): Section mismatch in reference from the function sh_cpu_init() to the function .init.text:detect_cpu_and_cache_system()
The function __cpuinit sh_cpu_init() references
a function __init detect_cpu_and_cache_system().
If sh_cpu_init is only used by detect_cpu_and_cache_system then
annotate sh_cpu_init with a matching annotation.

WARNING: vmlinux.o(.cpuinit.text+0x310): Section mismatch in reference from the function sh_cpu_init() to the variable .init.data:__setup_str_nosoftlockup_setup
The function __cpuinit sh_cpu_init() references
a variable __initdata __setup_str_nosoftlockup_setup.
If sh_cpu_init is only used by __setup_str_nosoftlockup_setup then
annotate sh_cpu_init with a matching annotation.

WARNING: vmlinux.o(.meminit.text+0x8e4): Section mismatch in reference from the function free_area_init_node() to the function .init.text:__alloc_bootmem_node()
The function __meminit free_area_init_node() references
a function __init __alloc_bootmem_node().
If free_area_init_node is only used by __alloc_bootmem_node then
annotate free_area_init_node with a matching annotation.

WARNING: vmlinux.o(__ksymtab+0x2440): Section mismatch in reference from the variable __ksymtab_pci_do_scan_bus to the function .devinit.text:pci_do_scan_bus()
The symbol pci_do_scan_bus is exported and annotated __devinit 
Fix this by removing the __devinit annotation of pci_do_scan_bus or drop the export.

  

