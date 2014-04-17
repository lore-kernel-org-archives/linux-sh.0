From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 17 Apr 2014 22:44:57 +0000
Subject: [PATCH 08/14] ARM: shmobile: Add Lager clock workarounds for SDHI and MMCIF
Message-Id: <f98b55d730492e664fb2649bd7054fec0fe81acd.1397774191.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1397774190.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1397774190.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add MMCIF1, SDHI0 and SDHI2 to the clock workaround list for
Lager multiplatform. Without these additional lines wakeup
from Suspend-to-RAM never happens.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-lager-reference.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-lager-reference.c b/arch/arm/mach-shmobile/board-lager-reference.c
index 313118c..1eb48cf 100644
--- a/arch/arm/mach-shmobile/board-lager-reference.c
+++ b/arch/arm/mach-shmobile/board-lager-reference.c
@@ -114,7 +114,10 @@ static const struct clk_name clk_names[] __initconst = {
 static const struct clk_name clk_enables[] __initconst = {
 	{ "ether", NULL, "ee700000.ethernet" },
 	{ "msiof1", NULL, "e6e10000.spi" },
+	{ "mmcif1", NULL, "ee220000.mmc" },
 	{ "qspi_mod", NULL, "e6b10000.spi" },
+	{ "sdhi0", NULL, "ee100000.sd" },
+	{ "sdhi2", NULL, "ee140000.sd" },
 	{ "thermal", NULL, "e61f0000.thermal" },
 };
 
-- 
1.8.4

