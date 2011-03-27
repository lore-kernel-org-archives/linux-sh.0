From: Daniel Palmer <me@danielpalmer.co.uk>
Date: Sun, 27 Mar 2011 06:37:22 +0000
Subject: Re: [PATCH 2/2] sh: Add sh_io_port_base check in __ioport_map function
Message-Id: <4D8EDB22.4040300@danielpalmer.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1301200307-5321-2-git-send-email-iwamatsu@nigauri.org>
In-Reply-To: <1301200307-5321-2-git-send-email-iwamatsu@nigauri.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi,

This patch seems to correct my Landisk HDL-??? board from accessing the 
wrong address in 2.6.38 in the pata_artop module;
It was accessing 0x13FF when the IO port for the PATA interface seems to 
be at 0x1400. However it still creates an oops.


pci mapping:

[    0.068000] pci 0000:00:01.0: BAR 4: assigned [io  0x1400-0x140f]
[    0.068000] pci 0000:00:01.0: BAR 4: set to [io  0x1400-0x140f] (PCI 
address [0x1400-0x140f])


vanilla 2.6.38

[   21.120000] Unable to handle kernel paging request at virtual address 
000013ff
[   21.208000] pc = c00fa28e
[   21.240000] *pde = 00000000
[   21.272000] Oops: 0000 [#1]
[   21.272000] last sysfs file:
[   21.272000] Modules linked in: pata_artop(+) libata ext3 mbcache jbd
[   21.272000]
[   21.272000] Pid : 819, Comm:                 insmod
[   21.272000] CPU : 0                  Not tainted  (2.6.38dgp #1)
[   21.272000]
[   21.272000] PC is at artop_init_one+0xee/0x1e0 [pata_artop]
[   21.272000] PR is at artop_init_one+0xee/0x1e0 [pata_artop]
[   21.272000] PC  : c00fa28e SP  : 8f837e58 SR  : 40008001 TEA : 000013ff
[   21.272000] R0  : 000013ff R1  : 8c2dd098 R2  : 00000001 R3  : 00001000
[   21.272000] R4  : 00001400 R5  : 00000001 R6  : 00000005 R7  : 00000005
[   21.272000] R8  : 8f837e58 R9  : 8fc54940 R10 : c00fa81c R11 : 8fc54940
[   21.272000] R12 : 8c003a80 R13 : 8c17f5c0 R14 : 004ae284
[   21.272000] MACH: 00000099 MACL: 000000cd GBR : 0051c470 PR  : c00fa28e
[   21.272000]
[   21.272000] Call trace:
[   21.272000]  [<8c14632a>] local_pci_probe+0x4a/0x120
[   21.272000]  [<8c003a80>] arch_local_save_flags+0x0/0x20
[   21.272000]  [<8c003a40>] arch_local_irq_restore+0x0/0x40
[   21.272000]  [<8c12ea50>] kobject_get+0x10/0x20
[   21.272000]  [<8c146862>] pci_device_probe+0x62/0xa0
[   21.272000]  [<8c003a80>] arch_local_save_flags+0x0/0x20
[   21.272000]  [<8c17a8a4>] driver_probe_device+0xa4/0x220
[   21.272000]  [<8c003a40>] arch_local_irq_restore+0x0/0x40
[   21.272000]  [<8c17aaa6>] __driver_attach+0x86/0xa0
[   21.272000]  [<8c258540>] mutex_lock+0x0/0x60
[   21.272000]  [<8c179f4e>] bus_for_each_dev+0x4e/0x80
[   21.272000]  [<8c251880>] klist_next+0x0/0xe0
[   21.272000]  [<8c17aa20>] __driver_attach+0x0/0xa0
[   21.272000]  [<8c179722>] bus_add_driver+0x82/0x240
[   21.272000]  [<8c17ae32>] driver_register+0x52/0x160
[   21.272000]  [<c00fd000>] artop_init+0x0/0x1c [pata_artop]
[   21.272000]  [<c00fd000>] artop_init+0x0/0x1c [pata_artop]
[   21.272000]  [<8c146aae>] __pci_register_driver+0x2e/0xa0
[   21.272000]  [<c00fd000>] artop_init+0x0/0x1c [pata_artop]
[   21.272000]  [<8c002084>] do_one_initcall+0x24/0x1c0
[   21.272000]  [<8c04c992>] sys_init_module+0x92/0x1c0
[   21.272000]  [<8c03a620>] blocking_notifier_call_chain+0x0/0x20
[   21.272000]  [<8c008232>] syscall_call+0xc/0x10
[   21.272000]  [<8c04c900>] sys_init_module+0x0/0x1c0
[   21.272000]
[   21.272000] Process: insmod (pid: 819, stack limit = 8f836001)
[   21.272000] Stack: (0x8f837e58 to 0x8f838000)
[   21.272000] 
7e40:                                                       c00fa718 
00000000
[   21.272000] 7e60: 004ae284 8c14632a 8c003a80 8fc54940 8fc5499c 
8c003a40 8f837ea4 8c12ea50
[   21.272000] 7e80: 8c146862 004ae284 c00fa884 8c003a80 8c429ae8 
8fc549dc c00fa854 8fc54940
[   21.272000] 7ea0: 8fc5499c c00fa854 8fc54940 c00fa81c 8c17a8a4 
8c003a40 8fc5499c 8f842e60
[   21.272000] 7ec0: 8c17aaa6 004ae284 00423ae0 00000000 8c258540 
8fc549d0 c00fa884 8fc5499c
[   21.272000] 7ee0: 8c179f4e 8c251880 8c17aa20 8c2e5508 c00fa884 
8fc32918 8fc5da10 8c179722
[   21.272000] 7f00: 00000000 fffffff4 8f842e60 8c2e5508 c00fa884 
8c17ae32 004ae284 00423ae0
[   21.272000] 7f20: fffffff0 c00fd000 8c41b064 c00fa884 c00fa854 
c00fd000 8c146aae 00000000
[   21.272000] 7f40: c00fd000 8c41b064 c00fa884 c00fa854 40008001 
8c002084 8c41b064 00000000
[   21.272000] 7f60: c00fab34 00000000 00000000 8ffcc540 8c04c992 
004ae284 00423ae0 00000000
[   21.272000] 7f80: c00fac30 8c03a620 c00fab34 c00fab34 8c008232 
00000000 00000071 00000100
[   21.272000] 7fa0: 8c04c900 00000000 ffffffff fffffff4 00000080 
0051d688 00002046 004e0028
[   21.272000] 7fc0: 00002050 7be8cec8 004e0028 7be8cd7c 7be8cecc 
00000000 00423ae0 004ae284
[   21.272000] 7fe0: 7be8cc2c 00455006 004b3a28 00008001 0051c470 
00000022 ffffe000 00000054
[   25.208000] ---[ end trace e495e7239fe8e43b ]---


Patched 2.6.38:

[   22.828000] Unable to handle kernel paging request at virtual address 
00001400
[   22.916000] pc = c00fa28e
[   22.948000] *pde = 00000000
[   22.980000] Oops: 0000 [#1]
[   22.980000] last sysfs file:
[   22.980000] Modules linked in: pata_artop(+) libata ext3 mbcache jbd
[   22.980000]
[   22.980000] Pid : 809, Comm:                 insmod
[   22.980000] CPU : 0                  Not tainted  (2.6.38dgp #1)
[   22.980000]
[   22.980000] PC is at artop_init_one+0xee/0x1e0 [pata_artop]
[   22.980000] PR is at artop_init_one+0xee/0x1e0 [pata_artop]
[   22.980000] PC  : c00fa28e SP  : 8f807e58 SR  : 40008101 TEA : 00001400
[   22.980000] R0  : 00001400 R1  : 00000000 R2  : 00000001 R3  : 00001000
[   22.980000] R4  : 00001400 R5  : 00000001 R6  : 00000005 R7  : 00000005
[   22.980000] R8  : 8f807e58 R9  : 8fc3b020 R10 : c00fa81c R11 : 8fc3b020
[   22.980000] R12 : 8c003a80 R13 : 8c182780 R14 : 004ae284
[   22.980000] MACH: 00000423 MACL: 00000668 GBR : 0051c470 PR  : c00fa28e
[   22.980000]
[   22.980000] Call trace:
[   22.980000]  [<8c1494ea>] local_pci_probe+0x4a/0x120
[   22.980000]  [<8c003a80>] arch_local_save_flags+0x0/0x20
[   22.980000]  [<8c003a40>] arch_local_irq_restore+0x0/0x40
[   22.980000]  [<8c131c10>] kobject_get+0x10/0x20
[   22.980000]  [<8c149a22>] pci_device_probe+0x62/0xa0
[   22.980000]  [<8c003a80>] arch_local_save_flags+0x0/0x20
[   22.980000]  [<8c17da64>] driver_probe_device+0xa4/0x220
[   22.980000]  [<8c003a40>] arch_local_irq_restore+0x0/0x40
[   22.980000]  [<8c17dc66>] __driver_attach+0x86/0xa0
[   22.980000]  [<8c232a00>] mutex_lock+0x0/0x60
[   22.980000]  [<8c17d10e>] bus_for_each_dev+0x4e/0x80
[   22.980000]  [<8c22bd60>] klist_next+0x0/0xe0
[   22.980000]  [<8c17dbe0>] __driver_attach+0x0/0xa0
[   22.980000]  [<8c17c8e2>] bus_add_driver+0x82/0x240
[   22.980000]  [<8c17dff2>] driver_register+0x52/0x160
[   22.980000]  [<c00fd000>] artop_init+0x0/0x1c [pata_artop]
[   22.980000]  [<8c149c6e>] __pci_register_driver+0x2e/0xa0
[   22.980000]  [<c00fd000>] artop_init+0x0/0x1c [pata_artop]
[   22.980000]  [<8c002084>] do_one_initcall+0x24/0x1c0
[   22.980000]  [<8c04c992>] sys_init_module+0x92/0x1c0
[   22.980000]  [<8c03a620>] blocking_notifier_call_chain+0x0/0x20
[   22.980000]  [<8c008232>] syscall_call+0xc/0x10
[   22.980000]  [<8c04c900>] sys_init_module+0x0/0x1c0
[   22.980000]
[   22.980000] Process: insmod (pid: 809, stack limit = 8f806001)
[   22.980000] Stack: (0x8f807e58 to 0x8f808000)
[   22.980000] 
7e40:                                                       c00fa718 
00000000
[   22.980000] 7e60: 004ae284 8c1494ea 8c003a80 8fc3b020 8fc3b07c 
8c003a40 8f807ea4 8c131c10
[   22.980000] 7e80: 8c149a22 004ae284 c00fa884 8c003a80 8c3f9ae8 
8fc3b0bc c00fa854 8fc3b020
[   22.980000] 7ea0: 8fc3b07c c00fa854 8fc3b020 c00fa81c 8c17da64 
8c003a40 8fc3b07c 8f8048a0
[   22.980000] 7ec0: 8c17dc66 004ae284 00423ae0 00000000 8c232a00 
8fc3b0b0 c00fa884 8fc3b07c
[   22.980000] 7ee0: 8c17d10e 8c22bd60 8c17dbe0 8c2b5570 c00fa884 
8fc2e918 8fc3f7f0 8c17c8e2
[   22.980000] 7f00: 00000000 fffffff4 8f8048a0 8c2b5570 c00fa884 
8c17dff2 004ae284 00423ae0
[   22.980000] 7f20: fffffff0 c00fd000 8c3eb064 c00fa884 c00fa854 
00000000 8c149c6e 00000000
[   22.980000] 7f40: c00fd000 8c3eb064 c00fa884 c00fa854 00000000 
8c002084 8c3eb064 00000000
[   22.980000] 7f60: c00fab34 00000000 00000000 8f804400 8c04c992 
004ae284 00423ae0 00000000
[   22.980000] 7f80: c00fac30 8c03a620 c00fab34 c00fab34 8c008232 
00000000 00000071 00000100
[   22.980000] 7fa0: 8c04c900 00000000 ffffffff fffffff4 00000080 
0051d688 00002046 004e0028
[   22.980000] 7fc0: 00002050 7bb84ec8 004e0028 7bb84d7c 7bb84ecc 
00000000 00423ae0 004ae284
[   22.980000] 7fe0: 7bb84c2c 00455006 004b3a28 00008001 0051c470 
00000022 ffffe000 00000054
[   26.848000] ---[ end trace dd8748f036d87de6 ]---


