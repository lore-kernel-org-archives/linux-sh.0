From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 11 Nov 2011 02:44:24 +0000
Subject: [PATCH 04/20] ARM: mach-shmobile: sh73a0: add MMC data pin pull-up
Message-Id: <87vcqr9y4b.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch adds MMC data pin pull-up option for pfc-sh73a0.c,
and select it on ag5evm board.
The MMC read/write will be error without this patch.

Cc: Takashi YOSHII <takashi.yoshii.zj@renesas.com>
Tested-by: Simon Horman <horms@verge.net.au>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-ag5evm.c        |   16 ++++++------
 arch/arm/mach-shmobile/include/mach/sh73a0.h |    8 ++++++
 arch/arm/mach-shmobile/pfc-sh73a0.c          |   34 ++++++++++++++++++++++++++
 3 files changed, 50 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ag5evm.c b/arch/arm/mach-shmobile/board-ag5evm.c
index 83624e2..b862e9f 100644
--- a/arch/arm/mach-shmobile/board-ag5evm.c
+++ b/arch/arm/mach-shmobile/board-ag5evm.c
@@ -515,14 +515,14 @@ static void __init ag5evm_init(void)
 	/* enable MMCIF */
 	gpio_request(GPIO_FN_MMCCLK0, NULL);
 	gpio_request(GPIO_FN_MMCCMD0_PU, NULL);
-	gpio_request(GPIO_FN_MMCD0_0, NULL);
-	gpio_request(GPIO_FN_MMCD0_1, NULL);
-	gpio_request(GPIO_FN_MMCD0_2, NULL);
-	gpio_request(GPIO_FN_MMCD0_3, NULL);
-	gpio_request(GPIO_FN_MMCD0_4, NULL);
-	gpio_request(GPIO_FN_MMCD0_5, NULL);
-	gpio_request(GPIO_FN_MMCD0_6, NULL);
-	gpio_request(GPIO_FN_MMCD0_7, NULL);
+	gpio_request(GPIO_FN_MMCD0_0_PU, NULL);
+	gpio_request(GPIO_FN_MMCD0_1_PU, NULL);
+	gpio_request(GPIO_FN_MMCD0_2_PU, NULL);
+	gpio_request(GPIO_FN_MMCD0_3_PU, NULL);
+	gpio_request(GPIO_FN_MMCD0_4_PU, NULL);
+	gpio_request(GPIO_FN_MMCD0_5_PU, NULL);
+	gpio_request(GPIO_FN_MMCD0_6_PU, NULL);
+	gpio_request(GPIO_FN_MMCD0_7_PU, NULL);
 	gpio_request(GPIO_PORT208, NULL); /* Reset */
 	gpio_direction_output(GPIO_PORT208, 1);
 
diff --git a/arch/arm/mach-shmobile/include/mach/sh73a0.h b/arch/arm/mach-shmobile/include/mach/sh73a0.h
index 18ae6a9..881d515 100644
--- a/arch/arm/mach-shmobile/include/mach/sh73a0.h
+++ b/arch/arm/mach-shmobile/include/mach/sh73a0.h
@@ -470,6 +470,14 @@ enum {
 	GPIO_FN_SDHICMD2_PU,
 	GPIO_FN_MMCCMD0_PU,
 	GPIO_FN_MMCCMD1_PU,
+	GPIO_FN_MMCD0_0_PU,
+	GPIO_FN_MMCD0_1_PU,
+	GPIO_FN_MMCD0_2_PU,
+	GPIO_FN_MMCD0_3_PU,
+	GPIO_FN_MMCD0_4_PU,
+	GPIO_FN_MMCD0_5_PU,
+	GPIO_FN_MMCD0_6_PU,
+	GPIO_FN_MMCD0_7_PU,
 	GPIO_FN_FSIACK_PU,
 	GPIO_FN_FSIAILR_PU,
 	GPIO_FN_FSIAIBT_PU,
diff --git a/arch/arm/mach-shmobile/pfc-sh73a0.c b/arch/arm/mach-shmobile/pfc-sh73a0.c
index 5abe02f..a2d99b3 100644
--- a/arch/arm/mach-shmobile/pfc-sh73a0.c
+++ b/arch/arm/mach-shmobile/pfc-sh73a0.c
@@ -508,6 +508,14 @@ enum {
 	SDHICMD2_PU_MARK,
 	MMCCMD0_PU_MARK,
 	MMCCMD1_PU_MARK,
+	MMCD0_0_PU_MARK,
+	MMCD0_1_PU_MARK,
+	MMCD0_2_PU_MARK,
+	MMCD0_3_PU_MARK,
+	MMCD0_4_PU_MARK,
+	MMCD0_5_PU_MARK,
+	MMCD0_6_PU_MARK,
+	MMCD0_7_PU_MARK,
 	FSIBISLD_PU_MARK,
 	FSIACK_PU_MARK,
 	FSIAILR_PU_MARK,
@@ -1561,6 +1569,24 @@ static pinmux_enum_t pinmux_data[] = {
 		MSEL4CR_MSEL15_0),
 	PINMUX_DATA(MMCCMD1_PU_MARK, PORT297_FN2, PORT297_IN_PU,
 		MSEL4CR_MSEL15_1),
+
+	PINMUX_DATA(MMCD0_0_PU_MARK,
+		    PORT271_FN1, PORT271_IN_PU, MSEL4CR_MSEL15_0),
+	PINMUX_DATA(MMCD0_1_PU_MARK,
+		    PORT272_FN1, PORT272_IN_PU, MSEL4CR_MSEL15_0),
+	PINMUX_DATA(MMCD0_2_PU_MARK,
+		    PORT273_FN1, PORT273_IN_PU, MSEL4CR_MSEL15_0),
+	PINMUX_DATA(MMCD0_3_PU_MARK,
+		    PORT274_FN1, PORT274_IN_PU, MSEL4CR_MSEL15_0),
+	PINMUX_DATA(MMCD0_4_PU_MARK,
+		    PORT275_FN1, PORT275_IN_PU, MSEL4CR_MSEL15_0),
+	PINMUX_DATA(MMCD0_5_PU_MARK,
+		    PORT276_FN1, PORT276_IN_PU, MSEL4CR_MSEL15_0),
+	PINMUX_DATA(MMCD0_6_PU_MARK,
+		    PORT277_FN1, PORT277_IN_PU, MSEL4CR_MSEL15_0),
+	PINMUX_DATA(MMCD0_7_PU_MARK,
+		    PORT278_FN1, PORT278_IN_PU, MSEL4CR_MSEL15_0),
+
 	PINMUX_DATA(FSIBISLD_PU_MARK, PORT39_FN1, PORT39_IN_PU),
 	PINMUX_DATA(FSIACK_PU_MARK, PORT49_FN1, PORT49_IN_PU),
 	PINMUX_DATA(FSIAILR_PU_MARK, PORT50_FN5, PORT50_IN_PU),
@@ -2236,6 +2262,14 @@ static struct pinmux_gpio pinmux_gpios[] = {
 	GPIO_FN(SDHICMD2_PU),
 	GPIO_FN(MMCCMD0_PU),
 	GPIO_FN(MMCCMD1_PU),
+	GPIO_FN(MMCD0_0_PU),
+	GPIO_FN(MMCD0_1_PU),
+	GPIO_FN(MMCD0_2_PU),
+	GPIO_FN(MMCD0_3_PU),
+	GPIO_FN(MMCD0_4_PU),
+	GPIO_FN(MMCD0_5_PU),
+	GPIO_FN(MMCD0_6_PU),
+	GPIO_FN(MMCD0_7_PU),
 	GPIO_FN(FSIACK_PU),
 	GPIO_FN(FSIAILR_PU),
 	GPIO_FN(FSIAIBT_PU),
-- 
1.7.5.4

