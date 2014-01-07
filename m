From: Simon Horman <horms+renesas@verge.net.au>
Date: Tue, 07 Jan 2014 08:48:07 +0000
Subject: [PATCH 7/8] ARM: shmobile: mackerel: Conditionally select SMSC_PHY
Message-Id: <1389084488-25984-8-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1389084488-25984-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1389084488-25984-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

The mackerel board uses has an SMSC911X ethernet controller which uses an
SMSC phy. Select SMSC_PHY for mackerel if SMSC911X is enabled to make use of the
SMSC-specific phy driver rather than relying on the generic phy driver.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 2ccd597..d745b1f 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -177,6 +177,7 @@ config MACH_MACKEREL
 	depends on ARCH_SH7372
 	select ARCH_REQUIRE_GPIOLIB
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
+	select SMSC_PHY if SMSC911X
 	select SND_SOC_AK4642 if SND_SIMPLE_CARD
 	select USE_OF
 
-- 
1.8.4

