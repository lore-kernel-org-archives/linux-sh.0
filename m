From: Rob Landley <rob@landley.net>
Date: Fri, 03 Apr 2020 23:49:00 +0000
Subject: v5.6 is still throwing a stack trace on boot.
Message-Id: <24dbbbc2-644a-1f9e-4e82-b7b726a4ce42@landley.net>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Run /init as init process
------------[ cut here ]------------
WARNING: CPU: 0 PID: 1 at mm/slub.c:2468 ___slab_alloc.constprop.0+0x1f0/0x290

CPU: 0 PID: 1 Comm: swapper Not tainted 5.6.0 #2
PC is at ___slab_alloc.constprop.0+0x1f0/0x290
PR is at __slab_alloc.constprop.0+0x2e/0x54
PC  : 8c0a76c4 SP  : 8f829ea0 SR  : 400080f0
TEA : c0001240
R0  : 8c0a74d4 R1  : 00000100 R2  : 00000100 R3  : 00000000
R4  : 8f8020a0 R5  : 00000dc0 R6  : 8c01d678 R7  : 8fff5180
R8  : 8f8020a0 R9  : 8fff5180 R10 : 8c01d678 R11 : 80000000
R12 : 00007fff R13 : 00000dc0 R14 : 8f8020a0
MACH: 0000008b MACL: 0ae4849d GBR : 00000000 PR  : 8c0a7792

Call trace:
 [<(ptrval)>] mm_alloc+0xe/0x48
 [<(ptrval)>] do_IRQ+0x0/0x50
 [<(ptrval)>] __slab_alloc.constprop.0+0x2e/0x54
 [<(ptrval)>] arch_local_irq_restore+0x0/0x24
 [<(ptrval)>] mm_init.isra.0+0xdc/0x138
 [<(ptrval)>] kmem_cache_alloc+0xd0/0x15c
 [<(ptrval)>] mm_init.isra.0+0xdc/0x138
 [<(ptrval)>] mm_init.isra.0+0xdc/0x138
 [<(ptrval)>] memset+0x0/0x8c
 [<(ptrval)>] __do_execve_file+0x22e/0x5d8
 [<(ptrval)>] kmem_cache_alloc+0x0/0x15c
 [<(ptrval)>] do_execve+0x16/0x24
 [<(ptrval)>] arch_local_irq_restore+0x0/0x24
 [<(ptrval)>] printk+0x0/0x24
 [<(ptrval)>] kernel_init+0x34/0xe8
 [<(ptrval)>] ret_from_kernel_thread+0xc/0x14
 [<(ptrval)>] schedule_tail+0x0/0x5c
 [<(ptrval)>] kernel_init+0x0/0xe8

---[ end trace 76213c1325250d90 ]---
