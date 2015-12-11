From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 11 Dec 2015 10:45:27 +0000
Subject: [PATCH 3/3] ARM: multi_v7_defconfig: Enable frame buffer console for armadillo800eva
Message-Id: <1449830727-325-4-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1449830727-325-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1449830727-325-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Enabling the frame buffer device on r8a7740/armadillo800eva requires the
board staging code.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 3d3c2b8522a23a93..ea7c7002b1def601 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -663,6 +663,7 @@ CONFIG_QCOM_SMD_RPM=y
 CONFIG_QCOM_SMEM=y
 CONFIG_COMMON_CLK_QCOM=y
 CONFIG_CHROME_PLATFORMS=y
+CONFIG_STAGING_BOARD=y
 CONFIG_CROS_EC_CHARDEV=m
 CONFIG_COMMON_CLK_MAX77686=y
 CONFIG_COMMON_CLK_MAX77802=m
-- 
1.9.1

