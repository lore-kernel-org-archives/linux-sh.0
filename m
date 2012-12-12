From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 12 Dec 2012 14:38:08 +0000
Subject: [PATCH 04/14] mmc: sh_mmcif: Add support for eMMC Dual Data Rate
Message-Id: <1355323098-18061-5-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1355323098-18061-1-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1355323098-18061-1-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Chris Ball <cjb@laptop.org>, Teppei Kamijou <teppei.kamijou.yb@renesas.com>, Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>

From: Teppei Kamijou <teppei.kamijou.yb@renesas.com>

Some MMCIF implementations support the Dual Data Rate. With this patch,
platforms can set the MMC_CAP_UHS_DDR50 capability flag in MMCIF platform
data. This will let the MMC core to actually use the DDR mode.

Signed-off-by: Teppei Kamijou <teppei.kamijou.yb@renesas.com>
Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/sh_mmcif.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index d80c294..1ec3339 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -88,6 +88,7 @@
 #define CMD_SET_TBIT		(1 << 7) /* 1: tran mission bit "Low" */
 #define CMD_SET_OPDM		(1 << 6) /* 1: open/drain */
 #define CMD_SET_CCSH		(1 << 5)
+#define CMD_SET_DARS		(1 << 2) /* Dual Data Rate */
 #define CMD_SET_DATW_1		((0 << 1) | (0 << 0)) /* 1bit */
 #define CMD_SET_DATW_4		((0 << 1) | (1 << 0)) /* 4bit */
 #define CMD_SET_DATW_8		((1 << 1) | (0 << 0)) /* 8bit */
@@ -216,6 +217,7 @@ struct sh_mmcif_host {
 	struct clk *hclk;
 	unsigned int clk;
 	int bus_width;
+	unsigned char timing;
 	bool sd_error;
 	bool dying;
 	long timeout;
@@ -781,6 +783,17 @@ static u32 sh_mmcif_set_cmd(struct sh_mmcif_host *host,
 			dev_err(&host->pd->dev, "Unsupported bus width.\n");
 			break;
 		}
+		switch (host->timing) {
+		case MMC_TIMING_UHS_DDR50:
+			/*
+			 * MMC core will only set this timing, if the host
+			 * advertises the MMC_CAP_UHS_DDR50 capability. MMCIF
+			 * implementations with this capability, e.g. sh73a0,
+			 * will have to set it in their platform data.
+			 */
+			tmp |= CMD_SET_DARS;
+			break;
+		}
 	}
 	/* DWEN */
 	if (opc = MMC_WRITE_BLOCK || opc = MMC_WRITE_MULTIPLE_BLOCK)
@@ -1002,6 +1015,7 @@ static void sh_mmcif_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		sh_mmcif_clock_control(host, ios->clock);
 	}
 
+	host->timing = ios->timing;
 	host->bus_width = ios->bus_width;
 	host->state = STATE_IDLE;
 }
-- 
1.7.2.5

