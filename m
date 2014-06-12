From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 12 Jun 2014 09:42:55 +0000
Subject: [PATCH v2 06/07] ARM: shmobile: Koelsch SYS-DMAC prototype
Message-Id: <20140612094255.4132.94956.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Prototype code to enable part of the SYS-DMAC on Koelsch.
Written to exercise the SYS-DMAC - Not for upstream merge.

Based on the following patch by Kuninori Morimoto-san:
"Local: ARM: shmobile: r8a7791: add SYS-DMAC support"

This patch enables SYS-DMAC0 (= Low), it doesn't support
SYS-DMAC1 (= HI) today.
Because, SYS-DMAC HI/Low interrupt mapping is not
good match to SH-DMAC driver.

Thanks to Morimoto-san for his sample code!

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Changes since V1:
 - None

 arch/arm/mach-shmobile/board-koelsch-reference.c |   93 ++++++++++++++++++++++
 1 file changed, 93 insertions(+)

--- 0001/arch/arm/mach-shmobile/board-koelsch-reference.c
+++ work/arch/arm/mach-shmobile/board-koelsch-reference.c	2014-06-11 06:47:39.000000000 +0900
@@ -66,6 +66,98 @@ static const struct resource du_resource
 	DEFINE_RES_IRQ(gic_spi(268)),
 };
 
+#include <linux/sh_dma.h>
+#include <mach/dma-register.h>
+
+/* Local DMA slave IDs */
+enum {
+	RCAR_DMA_SLAVE_KOELSCH_INVALID = 0,
+};
+
+#define DMAE_CHANNEL(a, b)			\
+{						\
+	.offset		= (a) - 0x20,		\
+	.dmars		= (a) - 0x20 + 0x40,	\
+	.chclr_bit	= (b),			\
+	.chclr_offset	= 0x80 - 0x20,		\
+}
+
+/* Sys-DMAC */
+#define SYS_DMAC_SLAVE(_id, _bit, _addr, toffset, roffset, t, r)	\
+{								\
+	.slave_id	= SYS_DMAC_SLAVE_## _id ##_TX,		\
+	.addr		= _addr + toffset,			\
+	.chcr		= CHCR_TX(XMIT_SZ_## _bit ##BIT),	\
+	.mid_rid	= t,					\
+}, {								\
+	.slave_id	= SYS_DMAC_SLAVE_## _id ##_RX,		\
+	.addr		= _addr + roffset,			\
+	.chcr		= CHCR_RX(XMIT_SZ_## _bit ##BIT),	\
+	.mid_rid	= r,					\
+}
+
+static const struct sh_dmae_slave_config r8a7791_sys_dmac_slaves[] = {
+};
+
+static const struct sh_dmae_channel r8a7791_sys_dmac_channels[] = {
+	DMAE_CHANNEL(0x8000, 0),
+	DMAE_CHANNEL(0x8080, 1),
+	DMAE_CHANNEL(0x8100, 2),
+	DMAE_CHANNEL(0x8180, 3),
+	DMAE_CHANNEL(0x8200, 4),
+	DMAE_CHANNEL(0x8280, 5),
+	DMAE_CHANNEL(0x8300, 6),
+	DMAE_CHANNEL(0x8380, 7),
+	DMAE_CHANNEL(0x8400, 8),
+	DMAE_CHANNEL(0x8480, 9),
+	DMAE_CHANNEL(0x8500, 10),
+	DMAE_CHANNEL(0x8580, 11),
+	DMAE_CHANNEL(0x8600, 12),
+	DMAE_CHANNEL(0x8680, 13),
+	DMAE_CHANNEL(0x8700, 14),
+};
+
+static struct sh_dmae_pdata r8a7791_sys_dmac_platform_data = {
+	.slave		= r8a7791_sys_dmac_slaves,
+	.slave_num	= ARRAY_SIZE(r8a7791_sys_dmac_slaves),
+	.channel	= r8a7791_sys_dmac_channels,
+	.channel_num	= ARRAY_SIZE(r8a7791_sys_dmac_channels),
+	.ts_low_shift	= TS_LOW_SHIFT,
+	.ts_low_mask	= TS_LOW_BIT << TS_LOW_SHIFT,
+	.ts_high_shift	= TS_HI_SHIFT,
+	.ts_high_mask	= TS_HI_BIT << TS_HI_SHIFT,
+	.ts_shift	= dma_ts_shift,
+	.ts_shift_num	= ARRAY_SIZE(dma_ts_shift),
+	.dmaor_init	= DMAOR_DME,
+	.chclr_present	= 1,
+	.chclr_bitwise	= 1,
+	.fourty_bits_addr = 1,
+};
+
+static struct resource r8a7791_sys_dmac_resources[] = {
+	/* Channel registers and DMAOR for low */
+	DEFINE_RES_MEM(0xe6700020, 0x8763 - 0x20),
+	DEFINE_RES_IRQ(gic_spi(197)),
+	DEFINE_RES_NAMED(gic_spi(200), 15, NULL, IORESOURCE_IRQ),
+
+	/*
+	 * HI is not supported
+	 * since IRQ has strange mapping
+	 */
+};
+
+#define r8a7791_register_sys_dmac(id)				\
+	platform_device_register_resndata(			\
+		&platform_bus, "sh-dma-engine", 2 + id,		\
+		&r8a7791_sys_dmac_resources[id * 3],	3,	\
+		&r8a7791_sys_dmac_platform_data,		\
+		sizeof(r8a7791_sys_dmac_platform_data))
+
+static void __init koelsch_add_dmac_prototype(void)
+{
+	r8a7791_register_sys_dmac(0);
+}
+
 static void __init koelsch_add_du_device(void)
 {
 	struct platform_device_info info = {
@@ -96,6 +188,7 @@ static void __init koelsch_add_standard_
 {
 	shmobile_clk_workaround(clk_names, ARRAY_SIZE(clk_names), false);
 	r8a7791_add_dt_devices();
+	koelsch_add_dmac_prototype();
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 
 	koelsch_add_du_device();
