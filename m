From: Simon Horman <horms+renesas@verge.net.au>
Date: Tue, 07 Jan 2014 08:48:05 +0000
Subject: [PATCH 5/8] ARM: shmobile: kzm9d: Conditionally select SMSC_PHY
Message-Id: <1389084488-25984-6-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1389084488-25984-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1389084488-25984-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

The kzm9d board uses has an SMSC911X ethernet controller which uses an
SMSC phy. Select SMSC_PHY for kzm9d if SMSC911X is enabled to make use of the
SMSC-specific phy driver rather than relying on the generic phy driver.

This only covers the case of multiplatform kzm9d
as there is currently no Kconfig node for non-multiplatform kzm9d.
One could be added if desired.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index fdd274d..e88d2e5 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -51,6 +51,7 @@ config MACH_KZM9D
 	bool "KZM9D board"
 	depends on ARCH_EMEV2
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
+	select SMSC_PHY if SMSC911X
 
 config MACH_LAGER
 	bool "Lager board"
-- 
1.8.4

