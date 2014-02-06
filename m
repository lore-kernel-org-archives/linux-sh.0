From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 06 Feb 2014 06:19:08 +0000
Subject: [PATCH 16/21] ARM: shmobile: mackerel: Conditionally select SMSC_PHY
Message-Id: <c5c2a294a4b24778cd3cab880bf05becee471edb.1391665225.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1391665225.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1391665225.git.horms+renesas@verge.net.au>
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
index b735ea8..f8005ef 100644
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
1.8.5.2

