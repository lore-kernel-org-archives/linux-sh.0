From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 06 Feb 2014 06:19:04 +0000
Subject: [PATCH 12/21] ARM: shmobile: ape6evm: Conditionally select SMSC_PHY
Message-Id: <9edaca863ea6807aca7bb8aa5c7791f7387f6022.1391665225.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1391665225.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1391665225.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

The ape6evm board uses has an SMSC911X ethernet controller which uses an
SMSC phy. Select SMSC_PHY for ape6evm if SMSC911X is enabled to make use of the
SMSC-specific phy driver rather than relying on the generic phy driver.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 958ccf3d..2673f68 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -156,11 +156,13 @@ comment "Renesas ARM SoCs Board Type"
 config MACH_APE6EVM
 	bool "APE6EVM board"
 	depends on ARCH_R8A73A4
+	select SMSC_PHY if SMSC911X
 	select USE_OF
 
 config MACH_APE6EVM_REFERENCE
 	bool "APE6EVM board - Reference Device Tree Implementation"
 	depends on ARCH_R8A73A4
+	select SMSC_PHY if SMSC911X
 	select USE_OF
 	---help---
 	   Use reference implementation of APE6EVM board support
-- 
1.8.5.2

