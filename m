From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 03 Jun 2014 22:33:04 +0000
Subject: [PATCH 01/03] ARM: shmobile: r8a7790: SYS-DMAC prototype
Message-Id: <20140603223304.2193.1096.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Prototype code to enable part of the SYS-DMAC on r8a7790.
Written to exercise the SYS-DMAC - Not for upstream merge.

Based on the following patch by Kuninori Morimoto-san:
"Local: ARM: shmobile: r8a7790: add SYS-DMAC support"

This patch enables SYS-DMAC0 (= Low), it doesn't support
SYS-DMAC1 (= HI) today.
Because, SYS-DMAC HI/Low interrupt mapping is not
good match to SH-DMAC driver.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
[horms+renesas@verge.net.au: Do not call r8a7790_register_sys_dmac()
 in r8a7790_add_standard_devices() as it is already called via
 r8a7790_add_dt_devices()]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
[damm+renesas@opensource.se: Remove SDHI bits, also remove legacy
code path to make sure to cover only the DT reference case]
Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Applies to renesas-devel-v3.15-rc7-20140530

 arch/arm/mach-shmobile/setup-r8a7790.c |   89 ++++++++++++++++++++++++++++----
 1 file changed, 80 insertions(+), 9 deletions(-)

--- 0001/arch/arm/mach-shmobile/setup-r8a7790.c
+++ work/arch/arm/mach-shmobile/setup-r8a7790.c	2014-06-03 21:24:37.000000000 +0900
@@ -32,6 +32,84 @@
 #include <mach/r8a7790.h>
 #include <asm/mach/arch.h>
 
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
+static const struct sh_dmae_slave_config r8a7790_sys_dmac_slaves[] = {
+};
+
+static const struct sh_dmae_channel r8a7790_sys_dmac_channels[] = {
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
+static struct sh_dmae_pdata r8a7790_sys_dmac_platform_data = {
+	.slave		= r8a7790_sys_dmac_slaves,
+	.slave_num	= ARRAY_SIZE(r8a7790_sys_dmac_slaves),
+	.channel	= r8a7790_sys_dmac_channels,
+	.channel_num	= ARRAY_SIZE(r8a7790_sys_dmac_channels),
+	.ts_low_shift	= TS_LOW_SHIFT,
+	.ts_low_mask	= TS_LOW_BIT << TS_LOW_SHIFT,
+	.ts_high_shift	= TS_HI_SHIFT,
+	.ts_high_mask	= TS_HI_BIT << TS_HI_SHIFT,
+	.ts_shift	= dma_ts_shift,
+	.ts_shift_num	= ARRAY_SIZE(dma_ts_shift),
+	.dmaor_init	= DMAOR_DME,
+	.chclr_present	= 1,
+	.chclr_bitwise	= 1,
+};
+
+static struct resource r8a7790_sys_dmac_resources[] = {
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
+#define r8a7790_register_sys_dmac(id)				\
+	platform_device_register_resndata(			\
+		&platform_bus, "sh-dma-engine", 2 + id,		\
+		&r8a7790_sys_dmac_resources[id * 3],	3,	\
+		&r8a7790_sys_dmac_platform_data,		\
+		sizeof(r8a7790_sys_dmac_platform_data))
+
 /* Audio-DMAC */
 #define AUDIO_DMAC_SLAVE(_id, _addr, t, r)			\
 {								\
@@ -59,14 +137,6 @@ static const struct sh_dmae_slave_config
 	AUDIO_DMAC_SLAVE(SSI9, 0xec241240, 0x13, 0x14),
 };
 
-#define DMAE_CHANNEL(a, b)			\
-{						\
-	.offset		= (a) - 0x20,		\
-	.dmars		= (a) - 0x20 + 0x40,	\
-	.chclr_bit	= (b),			\
-	.chclr_offset	= 0x80 - 0x20,		\
-}
-
 static const struct sh_dmae_channel r8a7790_audio_dmac_channels[] = {
 	DMAE_CHANNEL(0x8000, 0),
 	DMAE_CHANNEL(0x8080, 1),
@@ -282,6 +352,7 @@ static struct resource cmt0_resources[]
 void __init r8a7790_add_dt_devices(void)
 {
 	r8a7790_register_cmt(0);
+	r8a7790_register_sys_dmac(0);
 }
 
 void __init r8a7790_add_standard_devices(void)
@@ -296,7 +367,7 @@ void __init r8a7790_add_standard_devices
 	r8a7790_register_scif(7);
 	r8a7790_register_scif(8);
 	r8a7790_register_scif(9);
-	r8a7790_add_dt_devices();
+	r8a7790_register_cmt(0);
 	r8a7790_register_irqc(0);
 	r8a7790_register_thermal();
 	r8a7790_register_i2c(0);
