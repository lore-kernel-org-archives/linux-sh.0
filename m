From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 13 Mar 2013 23:00:24 +0000
Subject: [PATCH v4 79/88] ARM: shmobile: r8a7740: Remove LCD0 and LCD1 function GPIOs
Message-Id: <1363215633-4264-80-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Those GPIOs have been deprecated by the pinctrl API. They are unused and
unneeded, remove them.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/include/mach/r8a7740.h | 39 ---------------------------
 1 file changed, 39 deletions(-)

diff --git a/arch/arm/mach-shmobile/include/mach/r8a7740.h b/arch/arm/mach-shmobile/include/mach/r8a7740.h
index 59d252f..0c417da 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7740.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7740.h
@@ -241,48 +241,9 @@ enum {
 
 	/* LCD0 */
 	GPIO_FN_LCDC0_SELECT,
-	GPIO_FN_LCD0_D0,	GPIO_FN_LCD0_D1,	GPIO_FN_LCD0_D2,
-	GPIO_FN_LCD0_D3,	GPIO_FN_LCD0_D4,	GPIO_FN_LCD0_D5,
-	GPIO_FN_LCD0_D6,	GPIO_FN_LCD0_D7,	GPIO_FN_LCD0_D8,
-	GPIO_FN_LCD0_D9,	GPIO_FN_LCD0_D10,	GPIO_FN_LCD0_D11,
-	GPIO_FN_LCD0_D12,	GPIO_FN_LCD0_D13,	GPIO_FN_LCD0_D14,
-	GPIO_FN_LCD0_D15,	GPIO_FN_LCD0_D16,	GPIO_FN_LCD0_D17,
-	GPIO_FN_LCD0_DON,	GPIO_FN_LCD0_VCPWC,	GPIO_FN_LCD0_VEPWC,
-
-	GPIO_FN_LCD0_DCK,	GPIO_FN_LCD0_VSYN, /* for RGB */
-	GPIO_FN_LCD0_HSYN,	GPIO_FN_LCD0_DISP, /* for RGB */
-
-	GPIO_FN_LCD0_WR,	GPIO_FN_LCD0_RD, /* for SYS */
-	GPIO_FN_LCD0_CS,	GPIO_FN_LCD0_RS, /* for SYS */
-
-	GPIO_FN_LCD0_D18_PORT163,	GPIO_FN_LCD0_D19_PORT162,
-	GPIO_FN_LCD0_D20_PORT161,	GPIO_FN_LCD0_D21_PORT158,
-	GPIO_FN_LCD0_D22_PORT160,	GPIO_FN_LCD0_D23_PORT159,
-	GPIO_FN_LCD0_LCLK_PORT165,	 /* MSEL5CR_6_1 */
-
-	GPIO_FN_LCD0_D18_PORT40,	GPIO_FN_LCD0_D19_PORT4,
-	GPIO_FN_LCD0_D20_PORT3,		GPIO_FN_LCD0_D21_PORT2,
-	GPIO_FN_LCD0_D22_PORT0,		GPIO_FN_LCD0_D23_PORT1,
-	GPIO_FN_LCD0_LCLK_PORT102,	/* MSEL5CR_6_0 */
 
 	/* LCD1 */
 	GPIO_FN_LCDC1_SELECT,
-	GPIO_FN_LCD1_D0,	GPIO_FN_LCD1_D1,	GPIO_FN_LCD1_D2,
-	GPIO_FN_LCD1_D3,	GPIO_FN_LCD1_D4,	GPIO_FN_LCD1_D5,
-	GPIO_FN_LCD1_D6,	GPIO_FN_LCD1_D7,	GPIO_FN_LCD1_D8,
-	GPIO_FN_LCD1_D9,	GPIO_FN_LCD1_D10,	GPIO_FN_LCD1_D11,
-	GPIO_FN_LCD1_D12,	GPIO_FN_LCD1_D13,	GPIO_FN_LCD1_D14,
-	GPIO_FN_LCD1_D15,	GPIO_FN_LCD1_D16,	GPIO_FN_LCD1_D17,
-	GPIO_FN_LCD1_D18,	GPIO_FN_LCD1_D19,	GPIO_FN_LCD1_D20,
-	GPIO_FN_LCD1_D21,	GPIO_FN_LCD1_D22,	GPIO_FN_LCD1_D23,
-	GPIO_FN_LCD1_DON,	GPIO_FN_LCD1_VCPWC,
-	GPIO_FN_LCD1_LCLK,	GPIO_FN_LCD1_VEPWC,
-
-	GPIO_FN_LCD1_DCK,	GPIO_FN_LCD1_VSYN, /* for RGB */
-	GPIO_FN_LCD1_HSYN,	GPIO_FN_LCD1_DISP, /* for RGB */
-
-	GPIO_FN_LCD1_WR,	GPIO_FN_LCD1_RD, /* for SYS */
-	GPIO_FN_LCD1_CS,	GPIO_FN_LCD1_RS, /* for SYS */
 
 	/* RSPI */
 	GPIO_FN_RSPI_SSL0_A,	GPIO_FN_RSPI_SSL1_A,
-- 
1.8.1.5

