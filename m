From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 31 Jul 2014 00:42:46 +0000
Subject: [PATCH repost] ARM: shmobile: sh73a0: Remove spurious 0x from SCIFB clock name
Message-Id: <20140731004246.GA31860@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1406766463.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1406766463.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

A stray '0x' crept into a0f7e7496d56ac2d ("ARM: shmobile: sh73a0: add CMT1
clock support for DT"). This  patch removes it.

This change should not have any run-time affect at this time as
the clock in question is used by a SCIF device that is not enabled by
default.

Reported-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/clock-sh73a0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Hi Olof,

this is a repost of the patch you asked for so you can apply it directly
rather than as pulling a pull request.

diff --git a/arch/arm/mach-shmobile/clock-sh73a0.c b/arch/arm/mach-shmobile/clock-sh73a0.c
index 0d77f65..b0993a5 100644
--- a/arch/arm/mach-shmobile/clock-sh73a0.c
+++ b/arch/arm/mach-shmobile/clock-sh73a0.c
@@ -644,7 +644,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh-sci.5", &mstp_clks[MSTP207]), /* SCIFA5 */
 	CLKDEV_DEV_ID("e6cb0000.serial", &mstp_clks[MSTP207]), /* SCIFA5 */
 	CLKDEV_DEV_ID("sh-sci.8", &mstp_clks[MSTP206]), /* SCIFB */
-	CLKDEV_DEV_ID("0xe6c3000.serial", &mstp_clks[MSTP206]), /* SCIFB */
+	CLKDEV_DEV_ID("e6c3000.serial", &mstp_clks[MSTP206]), /* SCIFB */
 	CLKDEV_DEV_ID("sh-sci.0", &mstp_clks[MSTP204]), /* SCIFA0 */
 	CLKDEV_DEV_ID("e6c40000.serial", &mstp_clks[MSTP204]), /* SCIFA0 */
 	CLKDEV_DEV_ID("sh-sci.1", &mstp_clks[MSTP203]), /* SCIFA1 */
-- 
2.0.1

