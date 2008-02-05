From: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Date: Tue, 05 Feb 2008 17:43:47 +0000
Subject: [BUG_REPORT] - HP6XX section_mismatch errors at buildtime. (should
Message-Id: <20080205184347.8571fbce.Kristoffer.ericson@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Greetings paul,

Building a defconf against linux-2.6.git gives 5 section_mismatch. Just thought I should report them.
Non seem to be hp6xx specific so might be worth taking a look at them.

1:___________________________
LD      arch/sh/kernel/built-in.o
WARNING: arch/sh/kernel/built-in.o(.cpuinit.text+0x240): Section mismatch in reference from the function sh_cpu_init() to the variable .init.data:__setup_str_early_parse_mv
The function __cpuinit sh_cpu_init() references
a variable __initdata __setup_str_early_parse_mv.
If sh_cpu_init is only used by __setup_str_early_parse_mv then
annotate sh_cpu_init with a matching annotation.

2:_________________________
CC      mm/quicklist.o
LD      mm/built-in.o
WARNING: mm/built-in.o(.meminit.text+0x920): Section mismatch in reference from the function free_area_init_node() to the function .init.text:__alloc_bootmem_node()
The function __meminit free_area_init_node() references
a function __init __alloc_bootmem_node().
If free_area_init_node is only used by __alloc_bootmem_node then
annotate free_area_init_node with a matching annotation.

3:__________________________
CC      drivers/pcmcia/rsrc_mgr.o
CC      drivers/pcmcia/socket_sysfs.o
LD      drivers/pcmcia/pcmcia_core.o
WARNING: drivers/pcmcia/pcmcia_core.o(.data+0x12c): Section mismatch in reference from the variable pccard_sysfs_interface to the function .devinit.text:pccard_sysfs_add_socket()
The variable pccard_sysfs_interface references
the function __devinit pccard_sysfs_add_socket()
If the reference is valid then annotate the
variable with __init* (see linux/init.h) or name the variable:
*driver, *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console, 

WARNING: drivers/pcmcia/pcmcia_core.o(.data+0x130): Section mismatch in reference from the variable pccard_sysfs_interface to the function .devexit.text:pccard_sysfs_remove_socket()
The variable pccard_sysfs_interface references
the function __devexit pccard_sysfs_remove_socket()
If the reference is valid then annotate the
variable with __exit* (see linux/init.h) or name the variable:
*driver, *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console, 

LD      drivers/pcmcia/pcmcia.o
WARNING: drivers/pcmcia/pcmcia.o(.data+0x13c): Section mismatch in reference from the variable pcmcia_bus_interface to the function .devinit.text:pcmcia_bus_add_socket()
The variable pcmcia_bus_interface references
the function __devinit pcmcia_bus_add_socket()
If the reference is valid then annotate the
variable with __init* (see linux/init.h) or name the variable:
*driver, *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console, 

LD      drivers/pcmcia/built-in.o
WARNING: drivers/pcmcia/built-in.o(.data+0x12c): Section mismatch in reference from the variable pccard_sysfs_interface to the function .devinit.text:pccard_sysfs_add_socket()
The variable pccard_sysfs_interface references
the function __devinit pccard_sysfs_add_socket()
If the reference is valid then annotate the
variable with __init* (see linux/init.h) or name the variable:
*driver, *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console, 

WARNING: drivers/pcmcia/built-in.o(.data+0x130): Section mismatch in reference from the variable pccard_sysfs_interface to the function .devexit.text:pccard_sysfs_remove_socket()
The variable pccard_sysfs_interface references
the function __devexit pccard_sysfs_remove_socket()
If the reference is valid then annotate the
variable with __exit* (see linux/init.h) or name the variable:
*driver, *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console, 

WARNING: drivers/pcmcia/built-in.o(.data+0x36c): Section mismatch in reference from the variable pcmcia_bus_interface to the function .devinit.text:pccard_sysfs_add_socket()
The variable pcmcia_bus_interface references
the function __devinit pccard_sysfs_add_socket()
If the reference is valid then annotate the
variable with __init* (see linux/init.h) or name the variable:
*driver, *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console, 
CC      drivers/rtc/rtc-lib.o

4:_______________________________________________
LD      drivers/video/built-in.o
LD      drivers/built-in.o
WARNING: drivers/built-in.o(.data+0x4ed0): Section mismatch in reference from the variable pccard_sysfs_interface to the function .devinit.text:sci_probe()
The variable pccard_sysfs_interface references
the function __devinit sci_probe()
If the reference is valid then annotate the
variable with __init* (see linux/init.h) or name the variable:
*driver, *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console, 

WARNING: drivers/built-in.o(.data+0x4ed4): Section mismatch in reference from the variable pccard_sysfs_interface to the function .devexit.text:hitfb_remove()
The variable pccard_sysfs_interface references
the function __devexit hitfb_remove()
If the reference is valid then annotate the
variable with __exit* (see linux/init.h) or name the variable:
*driver, *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console, 

WARNING: drivers/built-in.o(.data+0x5110): Section mismatch in reference from the variable pcmcia_bus_interface to the function .devinit.text:sci_probe()
The variable pcmcia_bus_interface references
the function __devinit sci_probe()
If the reference is valid then annotate the
variable with __init* (see linux/init.h) or name the variable:
*driver, *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console, 
CC      arch/sh/drivers/dma/dma-api.o

5:_______________________________________________________
MODPOST vmlinux.o
WARNING: vmlinux.o(.cpuinit.text+0x240): Section mismatch in reference from the function sh_cpu_init() to the variable .init.data:__setup_str_nosoftlockup_setup
The function __cpuinit sh_cpu_init() references
a variable __initdata __setup_str_nosoftlockup_setup.
If sh_cpu_init is only used by __setup_str_nosoftlockup_setup then
annotate sh_cpu_init with a matching annotation.

WARNING: vmlinux.o(.meminit.text+0x920): Section mismatch in reference from the function free_area_init_node() to the function .init.text:__alloc_bootmem_node()
The function __meminit free_area_init_node() references
a function __init __alloc_bootmem_node().
If free_area_init_node is only used by __alloc_bootmem_node then
annotate free_area_init_node with a matching annotation.

WARNING: vmlinux.o(.data+0x12fe0): Section mismatch in reference from the variable pccard_sysfs_interface to the function .devinit.text:calibrate_delay()
The variable pccard_sysfs_interface references
the function __devinit calibrate_delay()
If the reference is valid then annotate the
variable with __init* (see linux/init.h) or name the variable:
*driver, *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console, 

WARNING: vmlinux.o(.data+0x12fe4): Section mismatch in reference from the variable pccard_sysfs_interface to the function .devexit.text:hitfb_remove()
The variable pccard_sysfs_interface references
the function __devexit hitfb_remove()
If the reference is valid then annotate the
variable with __exit* (see linux/init.h) or name the variable:
*driver, *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console, 

WARNING: vmlinux.o(.data+0x13220): Section mismatch in reference from the variable pcmcia_bus_interface to the function .devinit.text:calibrate_delay()
The variable pcmcia_bus_interface references
the function __devinit calibrate_delay()
If the reference is valid then annotate the
variable with __init* (see linux/init.h) or name the variable:
*driver, *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console, 
GEN     .version
CHK     include/linux/compile.h
