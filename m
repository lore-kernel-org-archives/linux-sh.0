From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 13 Dec 2013 02:29:44 +0000
Subject: [PATCH 03/33] ARM: shmobile: Select IRQC in case of the r8a7791 SoC
Message-Id: <e08d287afb76b3b6925f7261918fa611a7e0b3ca.1386897180.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1386897180.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1386897180.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Magnus Damm <damm@opensource.se>

The r8a7791 contains IRQC hardware so make sure
the driver gets built by selecting RENESAS_IRQC.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index a4a4b75..ff7c4ce 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -100,6 +100,7 @@ config ARCH_R8A7791
 	select ARM_GIC
 	select CPU_V7
 	select SH_CLK_CPG
+	select RENESAS_IRQC
 
 config ARCH_EMEV2
 	bool "Emma Mobile EV2"
-- 
1.8.4

