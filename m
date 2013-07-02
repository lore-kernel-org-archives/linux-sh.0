From: Simon Horman <horms+renesas@verge.net.au>
Date: Tue, 02 Jul 2013 04:35:53 +0000
Subject: [PATCH 1/2] ARM: shmobile: r8a73a4: Fix resources for SCIFB0
Message-Id: <f820b60582f75e73e83b8505d7e48fe59770f558.1372739438.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1372739438.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1372739438.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Takanari Hayama <taki@igel.co.jp>

Fix base address and IRQ resources associated with SCIFB0.

This bug was introduced by e481a528901d0cd18b5b5fcbdc55207ea3b6ef68
("ARM: shmobile: r8a73a4 SCIF support V3") which was included in v3.10.

Signed-off-by: Takanari Hayama <taki@igel.co.jp>
Acked-by: Magnus Damm <damm@opensource.se>
[ horms+renesas@verge.net.au: Add information about commit and version
  this bug was added in ]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Cc: stable@vger.kernel.org
---
 arch/arm/mach-shmobile/setup-r8a73a4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a73a4.c b/arch/arm/mach-shmobile/setup-r8a73a4.c
index c5a75a7..7f45c2e 100644
--- a/arch/arm/mach-shmobile/setup-r8a73a4.c
+++ b/arch/arm/mach-shmobile/setup-r8a73a4.c
@@ -62,7 +62,7 @@ enum { SCIFA0, SCIFA1, SCIFB0, SCIFB1, SCIFB2, SCIFB3 };
 static const struct plat_sci_port scif[] = {
 	SCIFA_DATA(SCIFA0, 0xe6c40000, gic_spi(144)), /* SCIFA0 */
 	SCIFA_DATA(SCIFA1, 0xe6c50000, gic_spi(145)), /* SCIFA1 */
-	SCIFB_DATA(SCIFB0, 0xe6c50000, gic_spi(145)), /* SCIFB0 */
+	SCIFB_DATA(SCIFB0, 0xe6c20000, gic_spi(148)), /* SCIFB0 */
 	SCIFB_DATA(SCIFB1, 0xe6c30000, gic_spi(149)), /* SCIFB1 */
 	SCIFB_DATA(SCIFB2, 0xe6ce0000, gic_spi(150)), /* SCIFB2 */
 	SCIFB_DATA(SCIFB3, 0xe6cf0000, gic_spi(151)), /* SCIFB3 */
-- 
1.8.2.1

