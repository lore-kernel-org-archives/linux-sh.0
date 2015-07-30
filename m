From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 30 Jul 2015 00:23:57 +0000
Subject: [PATCH] ARM: shmobile: Enable fixed voltage regulator in shmobile_defconfig
Message-Id: <4055a722d260ca30610fc52238d0aa49ff5bffa9.1438215768.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1438215768.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1438215768.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This is selected by MACH_MARZEN which is enabled in shmobile_defconfig,
however, MACH_MARZEN is going away along with the board code it enables.

Acked-by: Magnus Damm <damm@opensource.se>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/shmobile_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index 8da509327265..89bf31ccfbfa 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -122,6 +122,7 @@ CONFIG_WATCHDOG=y
 CONFIG_DA9063_WATCHDOG=y
 CONFIG_MFD_AS3711=y
 CONFIG_MFD_DA9063=y
+CONFIG_REGULATOR_FIXED_VOLTAGE=y
 CONFIG_REGULATOR_AS3711=y
 CONFIG_REGULATOR_DA9210=y
 CONFIG_REGULATOR_GPIO=y
-- 
2.1.4

