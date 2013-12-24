From: Simon Horman <horms+renesas@verge.net.au>
Date: Tue, 24 Dec 2013 06:07:05 +0000
Subject: [PATCH 12/13] ARM: shmobile: koelsch: Conditionally select MICREL_PHY
Message-Id: <8967136000668e10743758c84ddd39556b01cd57.1387857168.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1387857168.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1387857168.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

The koelsch board uses has an SH ethernet controller which uses a Micrel
phy. Select MICREL_PHY for koelsch if SH_ETH is enabled to make use of the
Micrel-specific phy driver rather than relying on the generic phy driver.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 8a1364e..8c88892 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -243,6 +243,7 @@ config MACH_KOELSCH
 	bool "Koelsch board"
 	depends on ARCH_R8A7791
 	select USE_OF
+	select MICREL_PHY if SH_ETH
 
 config MACH_KZM9G
 	bool "KZM-A9-GT board"
-- 
1.8.4

