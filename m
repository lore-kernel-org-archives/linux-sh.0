From: Rob Landley <rob@landley.net>
Date: Thu, 31 Jan 2019 06:42:35 +0000
Subject: Boot-time warning?
Message-Id: <4fb01448-ad0e-379f-3a69-5ee70f370814@landley.net>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Is this still the same problem we had a couple releases back, or is it a new
one? (From today's git, but it's been around for a while...)

WARNING: CPU: 0 PID: 1 at mm/slub.c:2443 ___slab_alloc.constprop.34+0x196/0x288

CPU: 0 PID: 1 Comm: swapper Not tainted 4.20.0 #1
PC is at ___slab_alloc.constprop.34+0x196/0x288
PR is at __slab_alloc.constprop.33+0x2a/0x4c
PC  : 8c09d9f6 SP  : 8f829ea0 SR  : 400080f0
TEA : c0001240
R0  : 8c09d860 R1  : 8c01cbec R2  : 00000000 R3  : 00000000
R4  : 8f8020a0 R5  : 006080c0 R6  : 8c01d74e R7  : 8fff5180
R8  : 8c011a40 R9  : 8fff5180 R10 : 8f8020a0 R11 : 00008000
R12 : 8c01d74e R13 : 006080c0 R14 : 8f80211c
MACH: 00000080 MACL: 0ae4849d GBR : 00000000 PR  : 8c09db12

Call trace:
 [<(ptrval)>] arch_local_irq_restore+0x0/0x24
 [<(ptrval)>] unmask_irq.part.4+0x14/0x2c
 [<(ptrval)>] irq_exit+0x6a/0xc0
