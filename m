From: kuninori.morimoto.gx@renesas.com
Date: Thu, 02 Aug 2012 09:50:26 +0000
Subject: irqdomain breaks ap4 boot
Message-Id: <878vdxd3mq.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Paul

I noticed that sh irqdomain commit breaks mackerel boot.
below is "git bisect" result and kernel log

------- log -----------------------------
...
NR_IRQS:16 nr_irqs:16 16
intc: Registered controller 'sh7372-intca' with 108 IRQs
intc: Registered controller 'sh7372-intca-irq-lo' with 16 IRQs
intc: can't get irq_desc for 0
intc: can't get irq_desc for 1
intc: can't get irq_desc for 2
intc: can't get irq_desc for 3
intc: can't get irq_desc for 4
intc: can't get irq_desc for 5
intc: can't get irq_desc for 6
intc: can't get irq_desc for 7
intc: can't get irq_desc for 8
intc: can't get irq_desc for 9
intc: can't get irq_desc for 10
intc: can't get irq_desc for 11
intc: can't get irq_desc for 12
intc: can't get irq_desc for 13
intc: can't get irq_desc for 14
intc: can't get irq_desc for 15
intc: Registered controller 'sh7372-intca-irq-hi' with 16 IRQs
kmemleak: Kernel memory leak detector disabled
intc: Registered controller 'sh7372-intcs' with 61 IRQs
(snip)
tca6416-keypad: probe of 0-0020 failed with error -22
(snip)
smsc911x: probe of smsc911x failed with error -22
(snip)
renesas_usbhs: probe of renesas_usbhs.1 failed with error -22
(snip)
asoc-simple-card asoc-simple-card.1:  sh_mobile_hdmi-hifi <-> fsib-dai mapping k
ALSA device list:
  #0: FSI2A-AK4643
  #1: FSI2B-HDMI
Root-NFS: no NFS server address
VFS: Unable to mount root fs via NFS, trying floppy.
VFS: Cannot open root device "nfs" or unknown-block(2,0): error -6
Please append a correct "root=" boot option; here are the available partitions:
Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(2,0)
[<c000d1c8>] (unwind_backtrace+0x0/0xe0) from [<c029fa10>] (panic+0x84/0x1e4)
[<c029fa10>] (panic+0x84/0x1e4) from [<c03b0c20>] (mount_block_root+0x1d4/0x218)
[<c03b0c20>] (mount_block_root+0x1d4/0x218) from [<c03b0d50>] (mount_root+0xec/)
[<c03b0d50>] (mount_root+0xec/0x10c) from [<c03b0e88>] (prepare_namespace+0x118)
[<c03b0e88>] (prepare_namespace+0x118/0x16c) from [<c03b0888>] (kernel_init+0x1)
[<c03b0888>] (kernel_init+0x168/0x1a4) from [<c0009888>] (kernel_thread_exit+0x)

---------- commit -----------------------
1d6a21b0a672fb29b01ccf397d478e0541e17716 is the first bad commit
commit 1d6a21b0a672fb29b01ccf397d478e0541e17716
Author: Paul Mundt <lethal@linux-sh.org>
Date:   Wed Aug 1 17:13:46 2012 +0900

sh: intc: initial irqdomain support.

Trivial support for irq domains, using either a linear map or radix tree
depending on the vector layout.

Signed-off-by: Paul Mundt <lethal@linux-sh.org>

:040000 040000 2997b842c38d729a1a90842a4e6175844c4e4c2e fce82bc1fb83a3cd9ddd324c7baba897a3f131dc M	drivers
--------------------------------------------
