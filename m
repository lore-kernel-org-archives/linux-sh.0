From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Thu, 12 Dec 2013 17:56:09 +0000
Subject: [PATCH] ARM: shmobile: Add select MIGHT_HAVE_PCI for PCI-AHB bridge code
Message-Id: <1386870969-22241-1-git-send-email-ben.dooks@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The PCI sub-system is not enabled by default on ARM and on certain
Renesas devices the build does not select it. This means that there
are configurations that do not allow the AHB-PCI bridge used for the
USB sub-systems to be built.

For the R8A7790, R8A7791 and EMEV-2 select MIGHT_HAVE_PCI to allow the
PCI drivers to be built. Also select MIGHT_HAVE_PCI for the multi-config
where there may be many Reneasas devices selected.

Cc: Simon Horman <horms@verge.net.au>
Cc: Magnus Damm <magnus.damm@gmail.com>
CC: Linux SH List <linux-sh@vger.kernel.org>
Reviewed-by: Ian Molton <ian.molton@codethink.co.uk>
Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 arch/arm/mach-shmobile/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 3e57d45..010d2a6 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -12,6 +12,7 @@ config ARCH_SHMOBILE_MULTI
 	select HAVE_SMP
 	select ARM_GIC
 	select MIGHT_HAVE_CACHE_L2X0
+	select MIGHT_HAVE_PCI
 	select NO_IOPORT
 	select PINCTRL
 	select ARCH_REQUIRE_GPIOLIB
@@ -101,6 +102,7 @@ config ARCH_R8A7779
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_GIC
 	select CPU_V7
+	select MIGHT_HAVE_PCI
 	select SH_CLK_CPG
 	select USB_ARCH_HAS_EHCI
 	select USB_ARCH_HAS_OHCI
@@ -111,6 +113,7 @@ config ARCH_R8A7790
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_GIC
 	select CPU_V7
+	select MIGHT_HAVE_PCI
 	select SH_CLK_CPG
 	select RENESAS_IRQC
 
@@ -127,6 +130,7 @@ config ARCH_EMEV2
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_GIC
 	select CPU_V7
+	select MIGHT_HAVE_PCI
 	select USE_OF
 	select AUTO_ZRELADDR
 
-- 
1.8.5.1

