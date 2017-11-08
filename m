From: Jacopo Mondi <jacopo+renesas@jmondi.org>
Date: Wed, 08 Nov 2017 18:05:46 +0000
Subject: [PATCH] sh: migor: Reserve memory block for CEU
Message-Id: <1510164346-21134-1-git-send-email-jacopo+renesas@jmondi.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ysato@users.sourceforge.jp, dalias@libc.org, laurent.pinchart@ideasonboard.com
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>, linux-sh@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org

A memory region for CEU video buffer has to be reserved during machine
initialization.

Originally, it was allocated through DMA API helpers and stored in the
second IORESOURCE_MEM entry, to be later remapped by the CEU driver with
a call to 'dma_declare_coherent_memory()'

As Linux does not allow anymore to remap system RAM regions with
'memremap' function, sh_mobile_ceu driver fails when trying to remap the
memory area:

WARN_ONCE(1, "memremap attempted on ram %pa size: %#lx\n",
	  &offset, (unsigned long) size)

from 'memremap()' function in kernel/memremap.c

To avoid hitting that WARN_ONCE() and have memory successfully remapped,
reserve a region using '.mv_mem_reserve' member of SH's 'struct
sh_machine_vector' to make sure memory is reserved early enough, and
removed from the available system RAM.

This is similar to what happens on ARM architecture with
'arm_memblock_steal()' function.

Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
---
 arch/sh/boards/mach-migor/setup.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/arch/sh/boards/mach-migor/setup.c b/arch/sh/boards/mach-migor/setup.c
index 0bcbe58..080627c 100644
--- a/arch/sh/boards/mach-migor/setup.c
+++ b/arch/sh/boards/mach-migor/setup.c
@@ -12,6 +12,7 @@
 #include <linux/interrupt.h>
 #include <linux/input.h>
 #include <linux/input/sh_keysc.h>
+#include <linux/memblock.h>
 #include <linux/mmc/host.h>
 #include <linux/mtd/physmap.h>
 #include <linux/mfd/tmio.h>
@@ -45,6 +46,9 @@
  * 0x18000000       8GB    8   NAND Flash (K9K8G08U0A)
  */

+#define CEU_BUFFER_MEMORY_SIZE		(4 << 20)
+static phys_addr_t ceu_dma_membase;
+
 static struct smc91x_platdata smc91x_info = {
 	.flags = SMC91X_USE_16BIT | SMC91X_NOWAIT,
 };
@@ -501,6 +505,8 @@ extern char migor_sdram_leave_end;

 static int __init migor_devices_setup(void)
 {
+	struct resource *r = &migor_ceu_device.resource[2];
+
 	/* register board specific self-refresh code */
 	sh_mobile_register_self_refresh(SUSP_SH_STANDBY | SUSP_SH_SF,
 					&migor_sdram_enter_start,
@@ -632,8 +638,6 @@ static int __init migor_devices_setup(void)
 #endif
 	__raw_writew(__raw_readw(PORT_MSELCRB) | 0x2000, PORT_MSELCRB); /* D15->D8 */

-	platform_resource_setup_memory(&migor_ceu_device, "ceu", 4 << 20);
-
 	/* SIU: Port B */
 	gpio_request(GPIO_FN_SIUBOLR, NULL);
 	gpio_request(GPIO_FN_SIUBOBT, NULL);
@@ -647,6 +651,12 @@ static int __init migor_devices_setup(void)
 	 */
 	__raw_writew(__raw_readw(PORT_MSELCRA) | 1, PORT_MSELCRA);

+	/* Setup additional memory resources for Migo-R */
+	r->flags = IORESOURCE_MEM;
+	r->start = ceu_dma_membase;
+	r->end = r->start + CEU_BUFFER_MEMORY_SIZE - 1;
+	r->name = "ceu";
+
 	i2c_register_board_info(0, migor_i2c_devices,
 				ARRAY_SIZE(migor_i2c_devices));

@@ -665,10 +675,24 @@ static int migor_mode_pins(void)
 	return MODE_PIN0 | MODE_PIN1 | MODE_PIN5;
 }

+/* Reserve a portion of memory for CEU buffers */
+static void __init migor_mv_mem_reserve(void)
+{
+	phys_addr_t phys;
+	phys_addr_t size = CEU_BUFFER_MEMORY_SIZE;
+
+	phys = memblock_alloc_base(size, PAGE_SIZE, MEMBLOCK_ALLOC_ANYWHERE);
+	memblock_free(phys, size);
+	memblock_remove(phys, size);
+
+	ceu_dma_membase = phys;
+}
+
 /*
  * The Machine Vector
  */
 static struct sh_machine_vector mv_migor __initmv = {
 	.mv_name		= "Migo-R",
 	.mv_mode_pins		= migor_mode_pins,
+	.mv_mem_reserve		= migor_mv_mem_reserve,
 };
--
2.7.4

