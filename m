From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 13 Mar 2013 23:00:19 +0000
Subject: [PATCH v4 74/88] ARM: shmobile: sh73a0: Remove pull-up function GPIOS
Message-Id: <1363215633-4264-75-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Those GPIOs have been deprecated by the pinconf API. They are unused and
unneeded, remove them.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/include/mach/sh73a0.h | 41 ----------------------------
 1 file changed, 41 deletions(-)

diff --git a/arch/arm/mach-shmobile/include/mach/sh73a0.h b/arch/arm/mach-shmobile/include/mach/sh73a0.h
index 563a48d..5b9620e 100644
--- a/arch/arm/mach-shmobile/include/mach/sh73a0.h
+++ b/arch/arm/mach-shmobile/include/mach/sh73a0.h
@@ -397,47 +397,6 @@ enum {
 	GPIO_FN_EDBGREQ_PD,
 	GPIO_FN_EDBGREQ_PU,
 
-	/* Functions with pull-ups */
-	GPIO_FN_KEYIN0_PU,
-	GPIO_FN_KEYIN1_PU,
-	GPIO_FN_KEYIN2_PU,
-	GPIO_FN_KEYIN3_PU,
-	GPIO_FN_KEYIN4_PU,
-	GPIO_FN_KEYIN5_PU,
-	GPIO_FN_KEYIN6_PU,
-	GPIO_FN_KEYIN7_PU,
-	GPIO_FN_SDHICD0_PU,
-	GPIO_FN_SDHID0_0_PU,
-	GPIO_FN_SDHID0_1_PU,
-	GPIO_FN_SDHID0_2_PU,
-	GPIO_FN_SDHID0_3_PU,
-	GPIO_FN_SDHICMD0_PU,
-	GPIO_FN_SDHIWP0_PU,
-	GPIO_FN_SDHID1_0_PU,
-	GPIO_FN_SDHID1_1_PU,
-	GPIO_FN_SDHID1_2_PU,
-	GPIO_FN_SDHID1_3_PU,
-	GPIO_FN_SDHICMD1_PU,
-	GPIO_FN_SDHID2_0_PU,
-	GPIO_FN_SDHID2_1_PU,
-	GPIO_FN_SDHID2_2_PU,
-	GPIO_FN_SDHID2_3_PU,
-	GPIO_FN_SDHICMD2_PU,
-	GPIO_FN_MMCCMD0_PU,
-	GPIO_FN_MMCCMD1_PU,
-	GPIO_FN_MMCD0_0_PU,
-	GPIO_FN_MMCD0_1_PU,
-	GPIO_FN_MMCD0_2_PU,
-	GPIO_FN_MMCD0_3_PU,
-	GPIO_FN_MMCD0_4_PU,
-	GPIO_FN_MMCD0_5_PU,
-	GPIO_FN_MMCD0_6_PU,
-	GPIO_FN_MMCD0_7_PU,
-	GPIO_FN_FSIACK_PU,
-	GPIO_FN_FSIAILR_PU,
-	GPIO_FN_FSIAIBT_PU,
-	GPIO_FN_FSIAISLD_PU,
-
 	/* end of GPIO */
 	GPIO_NR,
 };
-- 
1.8.1.5

