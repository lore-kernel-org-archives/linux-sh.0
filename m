From: Simon Horman <horms+renesas@verge.net.au>
Date: Mon, 02 Dec 2013 02:19:07 +0000
Subject: [PATCH 05/28] ARM: shmobile: Select GPIO in case of the r8a7791 SoC
Message-Id: <aeee29c56ae524c188d15fcb6a1aca617e1e601a.1385950394.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1385950394.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1385950394.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Make it possible to build GPIO on r8a7791.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index ff7c4ce..4e1cc76 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -97,6 +97,7 @@ config ARCH_R8A7790
 
 config ARCH_R8A7791
 	bool "R-Car M2 (R8A77910)"
+	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_GIC
 	select CPU_V7
 	select SH_CLK_CPG
-- 
1.8.4

