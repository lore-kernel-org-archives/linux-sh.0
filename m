From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 12 Jun 2013 02:02:20 +0000
Subject: [PATCH] sh-pfc: r8a7778: tidyup MMC_D1 pin
Message-Id: <87fvwo6q8u.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

MMC_D1 is RCAR_GP_PIN(1, 8), not RCAR_GP_PIN(2, 8)

Reported-by: Yusuke Goda <yusuke.goda.sx@renesas.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
This patch is based on renesas-next-20130611v2

 drivers/pinctrl/sh-pfc/pfc-r8a7778.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7778.c b/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
index 1dcbabc..f903910 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
@@ -1447,11 +1447,11 @@ MMC_PFC_PINS(mmc_ctrl,		RCAR_GP_PIN(1, 5),	RCAR_GP_PIN(1, 6));
 MMC_PFC_CTRL(mmc_ctrl,		MMC_CLK,		MMC_CMD);
 MMC_PFC_PINS(mmc_data1,		RCAR_GP_PIN(1, 7));
 MMC_PFC_DAT1(mmc_data1,		MMC_D0);
-MMC_PFC_PINS(mmc_data4,		RCAR_GP_PIN(1, 7),	RCAR_GP_PIN(2, 8),
+MMC_PFC_PINS(mmc_data4,		RCAR_GP_PIN(1, 7),	RCAR_GP_PIN(1, 8),
 				RCAR_GP_PIN(0, 5),	RCAR_GP_PIN(0, 6));
 MMC_PFC_DAT4(mmc_data4,		MMC_D0,			MMC_D1,
 				MMC_D2,			MMC_D3);
-MMC_PFC_PINS(mmc_data8,		RCAR_GP_PIN(1, 7),	RCAR_GP_PIN(2, 8),
+MMC_PFC_PINS(mmc_data8,		RCAR_GP_PIN(1, 7),	RCAR_GP_PIN(1, 8),
 				RCAR_GP_PIN(0, 5),	RCAR_GP_PIN(0, 6),
 				RCAR_GP_PIN(1, 4),	RCAR_GP_PIN(1, 0),
 				RCAR_GP_PIN(0, 30),	RCAR_GP_PIN(0, 31));
-- 
1.7.9.5

