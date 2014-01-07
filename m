From: Simon Horman <horms+renesas@verge.net.au>
Date: Tue, 07 Jan 2014 08:48:02 +0000
Subject: [PATCH 2/8] ARM: shmobile: armadillo800eva: Conditionally select SMSC_PHY
Message-Id: <1389084488-25984-3-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1389084488-25984-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1389084488-25984-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

The armadillo800eva board uses has an SH ethernet controller which uses an
SMSC phy. Select SMSC_PHY for koelsch if SH_ETH is enabled to make use of the
SMSC-specific phy driver rather than relying on the generic phy driver.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 2673f68..b624b5a 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -184,6 +184,7 @@ config MACH_ARMADILLO800EVA
 	depends on ARCH_R8A7740
 	select ARCH_REQUIRE_GPIOLIB
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
+	select SMSC_PHY if SH_ETH
 	select SND_SOC_WM8978 if SND_SIMPLE_CARD
 	select USE_OF
 
@@ -192,6 +193,7 @@ config MACH_ARMADILLO800EVA_REFERENCE
 	depends on ARCH_R8A7740
 	select ARCH_REQUIRE_GPIOLIB
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
+	select SMSC_PHY if SH_ETH
 	select SND_SOC_WM8978 if SND_SIMPLE_CARD
 	select USE_OF
 	---help---
-- 
1.8.4

