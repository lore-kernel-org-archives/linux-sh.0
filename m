From: Simon Horman <horms+renesas@verge.net.au>
Date: Wed, 23 Apr 2014 01:25:40 +0000
Subject: [PATCH 1/4] ARM: shmobile: armadillo800eva: Spelling and grammar
Message-Id: <1668a7a699f8c96bc99a50e94aadfe328adf9b76.1398216284.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1398216284.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1398216284.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 0f92ba8..edb1a91 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -205,8 +205,8 @@ config MACH_ARMADILLO800EVA_REFERENCE
 	select SND_SOC_WM8978 if SND_SIMPLE_CARD
 	select USE_OF
 	---help---
-	   Use reference implementation of Aramdillo800 EVA board support
-	   which makes a greater use of device tree at the expense
+	   Use reference implementation of Armadillo800 EVA board support
+	   which makes greater use of device tree at the expense
 	   of not supporting a number of devices.
 
 	   This is intended to aid developers
-- 
1.8.5.2

