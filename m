From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Sat, 20 Jul 2013 11:28:48 +0000
Subject: [PATCH v3 07/15] DMA: shdma: add sh73a0 DMAC data to the device ID table
Message-Id: <Pine.LNX.4.64.1307201326110.3716@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <1374251374-30186-1-git-send-email-g.liakhovetski@gmx.de>
 <1374251374-30186-8-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1374251374-30186-8-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Vinod Koul <vinod.koul@intel.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

This configuration data will be re-used, when DMAC DT support is added to
sh73a0, DMAC platform data in setup-sh73a0.c will be removed.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---

v3: also add an of_device_id entry for sh73a0.

 drivers/dma/sh/Kconfig        |    4 +
 drivers/dma/sh/Makefile       |    1 +
 drivers/dma/sh/shdma-sh73a0.c |  181 +++++++++++++++++++++++++++++++++++++++++
 drivers/dma/sh/shdma.h        |    7 ++
 drivers/dma/sh/shdmac.c       |    2 +
 5 files changed, 195 insertions(+), 0 deletions(-)
 create mode 100644 drivers/dma/sh/shdma-sh73a0.c

diff --git a/drivers/dma/sh/Kconfig b/drivers/dma/sh/Kconfig
index 6921ba2..040d780 100644
--- a/drivers/dma/sh/Kconfig
+++ b/drivers/dma/sh/Kconfig
@@ -30,3 +30,7 @@ config SHDMA_R8A73A4
 config SHDMA_R8A7740
 	def_bool y
 	depends on ARCH_R8A7740 && SH_DMAE != n
+
+config SHDMA_SH73A0
+	def_bool y
+	depends on ARCH_SH73A0 && SH_DMAE != n
diff --git a/drivers/dma/sh/Makefile b/drivers/dma/sh/Makefile
index e08489c..24c3149 100644
--- a/drivers/dma/sh/Makefile
+++ b/drivers/dma/sh/Makefile
@@ -3,5 +3,6 @@ obj-$(CONFIG_SH_DMAE) += shdma.o
 shdma-y := shdmac.o
 shdma-$(CONFIG_SHDMA_R8A7740) += shdma-r8a7740.o
 shdma-$(CONFIG_SHDMA_R8A73A4) += shdma-r8a73a4.o
+shdma-$(CONFIG_SHDMA_SH73A0) += shdma-sh73a0.o
 shdma-objs := $(shdma-y)
 obj-$(CONFIG_SUDMAC) += sudmac.o
diff --git a/drivers/dma/sh/shdma-sh73a0.c b/drivers/dma/sh/shdma-sh73a0.c
new file mode 100644
index 0000000..efd80ea
--- /dev/null
+++ b/drivers/dma/sh/shdma-sh73a0.c
@@ -0,0 +1,181 @@
+#include <linux/sh_dma.h>
+
+#include <mach/dma-register.h>
+#include <mach/sh73a0.h>
+
+static const struct sh_dmae_slave_config sh73a0_dmae_slaves[] = {
+	{
+		.slave_id	= SHDMA_SLAVE_SCIF0_TX,
+		.addr		= 0xe6c40020,
+		.chcr		= CHCR_TX(XMIT_SZ_8BIT),
+		.mid_rid	= 0x21,
+	}, {
+		.slave_id	= SHDMA_SLAVE_SCIF0_RX,
+		.addr		= 0xe6c40024,
+		.chcr		= CHCR_RX(XMIT_SZ_8BIT),
+		.mid_rid	= 0x22,
+	}, {
+		.slave_id	= SHDMA_SLAVE_SCIF1_TX,
+		.addr		= 0xe6c50020,
+		.chcr		= CHCR_TX(XMIT_SZ_8BIT),
+		.mid_rid	= 0x25,
+	}, {
+		.slave_id	= SHDMA_SLAVE_SCIF1_RX,
+		.addr		= 0xe6c50024,
+		.chcr		= CHCR_RX(XMIT_SZ_8BIT),
+		.mid_rid	= 0x26,
+	}, {
+		.slave_id	= SHDMA_SLAVE_SCIF2_TX,
+		.addr		= 0xe6c60020,
+		.chcr		= CHCR_TX(XMIT_SZ_8BIT),
+		.mid_rid	= 0x29,
+	}, {
+		.slave_id	= SHDMA_SLAVE_SCIF2_RX,
+		.addr		= 0xe6c60024,
+		.chcr		= CHCR_RX(XMIT_SZ_8BIT),
+		.mid_rid	= 0x2a,
+	}, {
+		.slave_id	= SHDMA_SLAVE_SCIF3_TX,
+		.addr		= 0xe6c70020,
+		.chcr		= CHCR_TX(XMIT_SZ_8BIT),
+		.mid_rid	= 0x2d,
+	}, {
+		.slave_id	= SHDMA_SLAVE_SCIF3_RX,
+		.addr		= 0xe6c70024,
+		.chcr		= CHCR_RX(XMIT_SZ_8BIT),
+		.mid_rid	= 0x2e,
+	}, {
+		.slave_id	= SHDMA_SLAVE_SCIF4_TX,
+		.addr		= 0xe6c80020,
+		.chcr		= CHCR_TX(XMIT_SZ_8BIT),
+		.mid_rid	= 0x39,
+	}, {
+		.slave_id	= SHDMA_SLAVE_SCIF4_RX,
+		.addr		= 0xe6c80024,
+		.chcr		= CHCR_RX(XMIT_SZ_8BIT),
+		.mid_rid	= 0x3a,
+	}, {
+		.slave_id	= SHDMA_SLAVE_SCIF5_TX,
+		.addr		= 0xe6cb0020,
+		.chcr		= CHCR_TX(XMIT_SZ_8BIT),
+		.mid_rid	= 0x35,
+	}, {
+		.slave_id	= SHDMA_SLAVE_SCIF5_RX,
+		.addr		= 0xe6cb0024,
+		.chcr		= CHCR_RX(XMIT_SZ_8BIT),
+		.mid_rid	= 0x36,
+	}, {
+		.slave_id	= SHDMA_SLAVE_SCIF6_TX,
+		.addr		= 0xe6cc0020,
+		.chcr		= CHCR_TX(XMIT_SZ_8BIT),
+		.mid_rid	= 0x1d,
+	}, {
+		.slave_id	= SHDMA_SLAVE_SCIF6_RX,
+		.addr		= 0xe6cc0024,
+		.chcr		= CHCR_RX(XMIT_SZ_8BIT),
+		.mid_rid	= 0x1e,
+	}, {
+		.slave_id	= SHDMA_SLAVE_SCIF7_TX,
+		.addr		= 0xe6cd0020,
+		.chcr		= CHCR_TX(XMIT_SZ_8BIT),
+		.mid_rid	= 0x19,
+	}, {
+		.slave_id	= SHDMA_SLAVE_SCIF7_RX,
+		.addr		= 0xe6cd0024,
+		.chcr		= CHCR_RX(XMIT_SZ_8BIT),
+		.mid_rid	= 0x1a,
+	}, {
+		.slave_id	= SHDMA_SLAVE_SCIF8_TX,
+		.addr		= 0xe6c30040,
+		.chcr		= CHCR_TX(XMIT_SZ_8BIT),
+		.mid_rid	= 0x3d,
+	}, {
+		.slave_id	= SHDMA_SLAVE_SCIF8_RX,
+		.addr		= 0xe6c30060,
+		.chcr		= CHCR_RX(XMIT_SZ_8BIT),
+		.mid_rid	= 0x3e,
+	}, {
+		.slave_id	= SHDMA_SLAVE_SDHI0_TX,
+		.addr		= 0xee100030,
+		.chcr		= CHCR_TX(XMIT_SZ_16BIT),
+		.mid_rid	= 0xc1,
+	}, {
+		.slave_id	= SHDMA_SLAVE_SDHI0_RX,
+		.addr		= 0xee100030,
+		.chcr		= CHCR_RX(XMIT_SZ_16BIT),
+		.mid_rid	= 0xc2,
+	}, {
+		.slave_id	= SHDMA_SLAVE_SDHI1_TX,
+		.addr		= 0xee120030,
+		.chcr		= CHCR_TX(XMIT_SZ_16BIT),
+		.mid_rid	= 0xc9,
+	}, {
+		.slave_id	= SHDMA_SLAVE_SDHI1_RX,
+		.addr		= 0xee120030,
+		.chcr		= CHCR_RX(XMIT_SZ_16BIT),
+		.mid_rid	= 0xca,
+	}, {
+		.slave_id	= SHDMA_SLAVE_SDHI2_TX,
+		.addr		= 0xee140030,
+		.chcr		= CHCR_TX(XMIT_SZ_16BIT),
+		.mid_rid	= 0xcd,
+	}, {
+		.slave_id	= SHDMA_SLAVE_SDHI2_RX,
+		.addr		= 0xee140030,
+		.chcr		= CHCR_RX(XMIT_SZ_16BIT),
+		.mid_rid	= 0xce,
+	}, {
+		.slave_id	= SHDMA_SLAVE_MMCIF_TX,
+		.addr		= 0xe6bd0034,
+		.chcr		= CHCR_TX(XMIT_SZ_32BIT),
+		.mid_rid	= 0xd1,
+	}, {
+		.slave_id	= SHDMA_SLAVE_MMCIF_RX,
+		.addr		= 0xe6bd0034,
+		.chcr		= CHCR_RX(XMIT_SZ_32BIT),
+		.mid_rid	= 0xd2,
+	},
+};
+
+#define DMAE_CHANNEL(_offset)					\
+	{							\
+		.offset         = _offset - 0x20,		\
+		.dmars          = _offset - 0x20 + 0x40,	\
+	}
+
+static const struct sh_dmae_channel sh73a0_dmae_channels[] = {
+	DMAE_CHANNEL(0x8000),
+	DMAE_CHANNEL(0x8080),
+	DMAE_CHANNEL(0x8100),
+	DMAE_CHANNEL(0x8180),
+	DMAE_CHANNEL(0x8200),
+	DMAE_CHANNEL(0x8280),
+	DMAE_CHANNEL(0x8300),
+	DMAE_CHANNEL(0x8380),
+	DMAE_CHANNEL(0x8400),
+	DMAE_CHANNEL(0x8480),
+	DMAE_CHANNEL(0x8500),
+	DMAE_CHANNEL(0x8580),
+	DMAE_CHANNEL(0x8600),
+	DMAE_CHANNEL(0x8680),
+	DMAE_CHANNEL(0x8700),
+	DMAE_CHANNEL(0x8780),
+	DMAE_CHANNEL(0x8800),
+	DMAE_CHANNEL(0x8880),
+	DMAE_CHANNEL(0x8900),
+	DMAE_CHANNEL(0x8980),
+};
+
+struct sh_dmae_pdata sh73a0_dma_pdata = {
+	.slave          = sh73a0_dmae_slaves,
+	.slave_num      = ARRAY_SIZE(sh73a0_dmae_slaves),
+	.channel        = sh73a0_dmae_channels,
+	.channel_num    = ARRAY_SIZE(sh73a0_dmae_channels),
+	.ts_low_shift   = TS_LOW_SHIFT,
+	.ts_low_mask    = TS_LOW_BIT << TS_LOW_SHIFT,
+	.ts_high_shift  = TS_HI_SHIFT,
+	.ts_high_mask   = TS_HI_BIT << TS_HI_SHIFT,
+	.ts_shift       = dma_ts_shift,
+	.ts_shift_num   = ARRAY_SIZE(dma_ts_shift),
+	.dmaor_init     = DMAOR_DME,
+};
diff --git a/drivers/dma/sh/shdma.h b/drivers/dma/sh/shdma.h
index ae0c65f..8394424 100644
--- a/drivers/dma/sh/shdma.h
+++ b/drivers/dma/sh/shdma.h
@@ -75,4 +75,11 @@ extern struct sh_dmae_pdata r8a7740_dma_pdata;
 #define r8a7740_shdma_devid NULL
 #endif
 
+#ifdef CONFIG_SHDMA_SH73A0
+extern struct sh_dmae_pdata sh73a0_dma_pdata;
+#define sh73a0_shdma_devid &sh73a0_dma_pdata
+#else
+#define sh73a0_shdma_devid NULL
+#endif
+
 #endif	/* __DMA_SHDMA_H */
diff --git a/drivers/dma/sh/shdmac.c b/drivers/dma/sh/shdmac.c
index f80543c..5e7b29d 100644
--- a/drivers/dma/sh/shdmac.c
+++ b/drivers/dma/sh/shdmac.c
@@ -669,6 +669,7 @@ static const struct of_device_id sh_dmae_of_match[] = {
 	{.compatible = "renesas,shdma",},
 	{.compatible = "renesas,shdma-r8a73a4", .data = r8a73a4_shdma_devid,},
 	{.compatible = "renesas,shdma-r8a7740", .data = r8a7740_shdma_devid,},
+	{.compatible = "renesas,shdma-sh73a0", .data = sh73a0_shdma_devid,},
 	{}
 };
 MODULE_DEVICE_TABLE(of, sh_dmae_of_match);
@@ -917,6 +918,7 @@ const struct platform_device_id sh_dmae_id_table[] = {
 	{.name = SH_DMAE_DRV_NAME,},
 	{.name = "shdma-r8a73a4", .driver_data = (kernel_ulong_t)r8a73a4_shdma_devid,},
 	{.name = "shdma-r8a7740", .driver_data = (kernel_ulong_t)r8a7740_shdma_devid,},
+	{.name = "shdma-sh73a0", .driver_data = (kernel_ulong_t)sh73a0_shdma_devid,},
 	{}
 };
 MODULE_DEVICE_TABLE(platform, sh_dmae_id_table);
-- 
1.7.2.5

