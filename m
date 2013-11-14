From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 14 Nov 2013 10:31:38 +0000
Subject: [PATCH 11/17] mmc: SDHI: add SoC specific workaround via HW version
Message-Id: <871u2jz33t.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87li0rz3to.wl%kuninori.morimoto.gx@renesas.com>
	<8761rvz37d.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <8761rvz37d.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Chris Ball <cjb@laptop.org>
Cc: Simon <horms@verge.net.au>, Laurent <laurent.pinchart@ideasonboard.com>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, linux-mmc@vger.kernel.org

One of Renesas SDHI chip needs workaround to use it,
and, we can judge it based on chip version.
This patch adds very quick-hack workaround method,
since we still don't know how many chips
need workaround in the future.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 drivers/mmc/host/sh_mobile_sdhi.c |   11 +++++++++++
 include/linux/mmc/tmio.h          |    1 +
 2 files changed, 12 insertions(+)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index f1e35a7..d241d86 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -33,6 +33,8 @@
 
 #include "tmio_mmc.h"
 
+#define EXT_ACC           0xe4
+
 struct sh_mobile_sdhi_of_data {
 	unsigned long tmio_flags;
 };
@@ -137,6 +139,7 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
 	int irq, ret, i = 0;
 	bool multiplexed_isr = true;
 	struct tmio_mmc_dma *dma_priv;
+	u16 ver;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res)
@@ -219,6 +222,14 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
 		goto eprobe;
 
 	/*
+	 * FIXME:
+	 * this Workaround can be more clever method
+	 */
+	ver = sd_ctrl_read16(host, CTL_VERSION);
+	if (ver = 0xCB0D)
+		sd_ctrl_write16(host, EXT_ACC, 1);
+
+	/*
 	 * Allow one or more specific (named) ISRs or
 	 * one or more multiplexed (un-named) ISRs.
 	 */
diff --git a/include/linux/mmc/tmio.h b/include/linux/mmc/tmio.h
index a1c1f32..84d9053 100644
--- a/include/linux/mmc/tmio.h
+++ b/include/linux/mmc/tmio.h
@@ -33,6 +33,7 @@
 #define CTL_SDIO_IRQ_MASK 0x38
 #define CTL_DMA_ENABLE 0xd8
 #define CTL_RESET_SD 0xe0
+#define CTL_VERSION 0xe2
 #define CTL_SDIO_REGS 0x100
 #define CTL_CLK_AND_WAIT_CTL 0x138
 #define CTL_RESET_SDIO 0x1e0
-- 
1.7.9.5

