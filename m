From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 13 Feb 2014 08:04:33 +0000
Subject: [PATCH 1/4] ARM: shmobile: koelsch: Enable I2C in defconfig
Message-Id: <ab44f75f1142edde5737203a0d259853f34686fb.1392276997.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1392276997.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1392276997.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Valentine Barshak <valentine.barshak@cogentembedded.com>

This enables I2C support in koelsch_defconfig.

Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/koelsch_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/koelsch_defconfig b/arch/arm/configs/koelsch_defconfig
index 3015797..c3b3c9d 100644
--- a/arch/arm/configs/koelsch_defconfig
+++ b/arch/arm/configs/koelsch_defconfig
@@ -62,6 +62,8 @@ CONFIG_SH_ETH=y
 CONFIG_SERIAL_SH_SCI=y
 CONFIG_SERIAL_SH_SCI_NR_UARTS 
 CONFIG_SERIAL_SH_SCI_CONSOLE=y
+CONFIG_I2C=y
+CONFIG_I2C_RCAR=y
 # CONFIG_HWMON is not set
 CONFIG_THERMAL=y
 CONFIG_RCAR_THERMAL=y
-- 
1.8.5.2

