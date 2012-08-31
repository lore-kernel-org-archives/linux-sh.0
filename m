From: "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>
Date: Fri, 31 Aug 2012 07:26:52 +0000
Subject: [RFC][PATCH] sh: fix dma_generic_alloc_coherent for 32-bit mode
Message-Id: <5040673C.3000207@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Paul,

I found an issue when I used the following environment:
 - linux-3.6-rc3
 - SH7785 32-bit mode
 - EHCI PCI card
 - USBNIC

When I ran ifconfig for USBNIC, the panic happened:
===~ # ifconfig usb0 up
kernel BUG at /linux.git/mm/vmalloc.c:1330!
Kernel BUG: 003e [#1]
Modules linked in:

Pid : 525, Comm:                ifconfig
CPU : 0                 Not tainted  (3.6.0-rc3-00037-g2d809dc #6)

PC is at __get_vm_area_node+0x1a0/0x220
PR is at get_vm_area_caller+0x20/0x40
PC  : 800a0940 SP  : 9f69dacc SR  : 400081f0 TEA : c0012324
R0  : 800a07a0 R1  : 07ffff00 R2  : 00000103 R3  : 00000000
R4  : 00001000 R5  : 00000001 R6  : 00000001 R7  : c0000000
R8  : 5f695000 R9  : 00001000 R10 : 00000001 R11 : 00000001
R12 : 00003810 R13 : c0000000 R14 : 9f69dacc
MACH: 0000000b MACL: 00000000 GBR : 29799440 PR  : 800a09e0

Call trace:
 [<800a09e0>] get_vm_area_caller+0x20/0x40
 [<800a7754>] dma_pool_alloc+0xb4/0x240
 [<800a7754>] dma_pool_alloc+0xb4/0x240
 [<80436816>] __ioremap_caller+0x76/0x120
 [<800115d2>] dma_generic_alloc_coherent+0x92/0x140
 [<800a7754>] dma_pool_alloc+0xb4/0x240
 [<800a7754>] dma_pool_alloc+0xb4/0x240
 [<800a7754>] dma_pool_alloc+0xb4/0x240
 [<800080ec>] ret_from_exception+0x0/0x8
 [<800080ec>] ret_from_exception+0x0/0x8
 [<802cbf56>] ehci_qtd_alloc+0x16/0x60
 [<802cca1a>] qh_urb_transaction+0x13a/0x3e0
 [<802cc902>] qh_urb_transaction+0x22/0x3e0
 [<802c8300>] qtd_fill+0x0/0xc0
 [<8044dac0>] _raw_spin_unlock+0x20/0x40
 [<802ccd7a>] ehci_urb_enqueue+0xba/0xec0
 [<802ccd1c>] ehci_urb_enqueue+0x5c/0xec0
 [<8007ecde>] get_page_from_freelist+0x45e/0x5e0
 [<800031fc>] nommu_map_page+0x3c/0x80
 [<802b9ed8>] usb_hcd_map_urb_for_dma+0x378/0x3e0
 [<8007f202>] __alloc_pages_nodemask+0xa2/0x620
 [<802b9fae>] usb_hcd_submit_urb+0x6e/0x8e0
 [<802003e0>] debug_smp_processor_id+0x0/0xe0
 [<8044dbc0>] _raw_spin_lock+0x0/0x40
 [<8044daa0>] _raw_spin_unlock+0x0/0x40
 [<8044dbd6>] _raw_spin_lock+0x16/0x40
 [<8044dac0>] _raw_spin_unlock+0x20/0x40
 [<800ad36c>] kmem_cache_alloc+0x2c/0x140
 [<800ad442>] kmem_cache_alloc+0x102/0x140
 [<8038cd26>] build_skb+0x26/0xc0
 [<8038f226>] __netdev_alloc_skb+0x86/0x100
 [<802bad34>] usb_submit_urb+0xd4/0x340
 [<802af1e6>] rx_submit+0xe6/0x260
 [<802af3bc>] rx_alloc_submit+0x5c/0xc0
 [<802bb3c0>] usb_alloc_urb+0x0/0x60
 [<802b0246>] usbnet_bh+0x1e6/0x2a0
 [<8038c980>] consume_skb+0x0/0x60
 [<8038ba00>] skb_dequeue+0x0/0x80
 [<8002059c>] tasklet_action+0x5c/0xc0
 [<80003a20>] arch_local_irq_restore+0x0/0x40
 [<80020cb0>] __do_softirq+0xb0/0x1c0
 [<80021046>] do_softirq+0x66/0xa0
 [<803964e0>] dev_set_rx_mode+0x0/0x40
 [<80003a20>] arch_local_irq_restore+0x0/0x40
 [<80021258>] local_bh_enable_ip+0x78/0xe0
 [<80043d40>] sub_preempt_count+0x0/0xa0
 [<8044d9da>] _raw_spin_unlock_bh+0x1a/0x40
 [<80396502>] dev_set_rx_mode+0x22/0x40
 [<80396502>] dev_set_rx_mode+0x22/0x40
 [<80399920>] __dev_open+0xe0/0x160
 [<80396746>] __dev_change_flags+0xe6/0x1a0
 [<803997da>] dev_change_flags+0x1a/0x80
 [<803ed688>] devinet_ioctl+0x748/0x800
 [<803ee7fe>] inet_ioctl+0x1e/0x160
 [<80383e14>] sock_ioctl+0xf4/0x2e0
 [<800c6f0c>] do_vfs_ioctl+0x6c/0x640
 [<8044daaa>] _raw_spin_unlock+0xa/0x40
 [<8044dab0>] _raw_spin_unlock+0x10/0x40
 [<800b207c>] fd_install+0x3c/0x80
 [<80383c44>] sock_map_fd+0x24/0x40
 [<80384cc0>] sys_socket+0x60/0xa0
 [<800c7512>] sys_ioctl+0x32/0xa0
 [<8000826a>] syscall_call+0xc/0x10
 [<800c74e0>] sys_ioctl+0x0/0xa0
===
If I used the following patch, the panic didn't happen. But,
I don't know whether this modification is right.

---
Some drivers call dma_pool_alloc() in atomic context. When mmu
mode of sh4 is 32bit, get_vm_area_caller() is called finally.
Then, the BUG_ON() in __get_vm_area_node() will call panic().

This patch fixes this issue using ioremap_fixed().

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 arch/sh/mm/consistent.c    |    7 ++++++-
 arch/sh/mm/ioremap_fixed.c |    2 +-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/sh/mm/consistent.c b/arch/sh/mm/consistent.c
index b81d9db..06164ac 100644
--- a/arch/sh/mm/consistent.c
+++ b/arch/sh/mm/consistent.c
@@ -51,7 +51,12 @@ void *dma_generic_alloc_coherent(struct device *dev, size_t size,
 	 */
 	dma_cache_sync(dev, ret, size, DMA_BIDIRECTIONAL);

-	ret_nocache = (void __force *)ioremap_nocache(virt_to_phys(ret), size);
+	if (!__in_29bit_mode() && (gfp & GFP_ATOMIC))
+		ret_nocache = (void __force *)ioremap_fixed(virt_to_phys(ret),
+						size, PAGE_KERNEL_NOCACHE);
+	else
+		ret_nocache = (void __force *)ioremap_nocache(virt_to_phys(ret),
+							      size);
 	if (!ret_nocache) {
 		free_pages((unsigned long)ret, order);
 		return NULL;
diff --git a/arch/sh/mm/ioremap_fixed.c b/arch/sh/mm/ioremap_fixed.c
index efbe84a..ffae5c2 100644
--- a/arch/sh/mm/ioremap_fixed.c
+++ b/arch/sh/mm/ioremap_fixed.c
@@ -43,7 +43,7 @@ void __init ioremap_fixed_init(void)
 	}
 }

-void __init __iomem *
+void __iomem *
 ioremap_fixed(phys_addr_t phys_addr, unsigned long size, pgprot_t prot)
 {
 	enum fixed_addresses idx0, idx;
-- 
1.7.1
