From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 06 Mar 2013 13:47:17 +0000
Subject: [PATCH v2 38/39] ARM: shmobile: r8a7779: Remove DU1_DOTCLKOUT1 GPIO
Message-Id: <1362577638-15493-39-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The function is not documented in the r8a7779 datasheet. Remove it.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/include/mach/r8a7779.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/include/mach/r8a7779.h b/arch/arm/mach-shmobile/include/mach/r8a7779.h
index 8ab0cd6..badba57 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7779.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7779.h
@@ -308,7 +308,7 @@ enum {
 	GPIO_FN_SD2_CD, GPIO_FN_MT0_VCXO, GPIO_FN_SPA_TMS, GPIO_FN_HSPI_TX1_D,
 	GPIO_FN_VI1_DATA7_VI1_B7, GPIO_FN_SD2_WP, GPIO_FN_MT0_PWM,
 	GPIO_FN_SPA_TDI, GPIO_FN_HSPI_RX1_D, GPIO_FN_VI1_G0, GPIO_FN_VI3_DATA0,
-	GPIO_FN_DU1_DOTCLKOUT1, GPIO_FN_TS_SCK1, GPIO_FN_DREQ2_B, GPIO_FN_TX2,
+	GPIO_FN_TS_SCK1, GPIO_FN_DREQ2_B, GPIO_FN_TX2,
 	GPIO_FN_SPA_TDO, GPIO_FN_HCTS0_B, GPIO_FN_VI1_G1, GPIO_FN_VI3_DATA1,
 	GPIO_FN_SSI_SCK1, GPIO_FN_TS_SDEN1, GPIO_FN_DACK2_B, GPIO_FN_RX2,
 	GPIO_FN_HRTS0_B,
-- 
1.8.1.5

