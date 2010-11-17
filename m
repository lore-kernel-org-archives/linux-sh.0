From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 17 Nov 2010 11:44:00 +0000
Subject: [PATCH] ARM: mach-shmobile: sh7372 USB0/IIC1 MSTP fix
Message-Id: <20101117114400.12467.85516.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Fix a MSTP assignment problem in the sh7372 clock
framework code. The USB drivers should attach to
MSTP322 not MSTP33 where IIC1 is located.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Fortunately it looks like no one is using USB0 on sh7372.

 arch/arm/mach-shmobile/clock-sh7372.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- 0001/arch/arm/mach-shmobile/clock-sh7372.c
+++ work/arch/arm/mach-shmobile/clock-sh7372.c	2010-11-17 20:38:46.000000000 +0900
@@ -647,8 +647,8 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh_cmt.10", &mstp_clks[MSTP329]), /* CMT10 */
 	CLKDEV_DEV_ID("sh_fsi2", &mstp_clks[MSTP328]), /* FSI2 */
 	CLKDEV_DEV_ID("i2c-sh_mobile.1", &mstp_clks[MSTP323]), /* IIC1 */
-	CLKDEV_DEV_ID("r8a66597_hcd.0", &mstp_clks[MSTP323]), /* USB0 */
-	CLKDEV_DEV_ID("r8a66597_udc.0", &mstp_clks[MSTP323]), /* USB0 */
+	CLKDEV_DEV_ID("r8a66597_hcd.0", &mstp_clks[MSTP322]), /* USB0 */
+	CLKDEV_DEV_ID("r8a66597_udc.0", &mstp_clks[MSTP322]), /* USB0 */
 	CLKDEV_DEV_ID("sh_mobile_sdhi.0", &mstp_clks[MSTP314]), /* SDHI0 */
 	CLKDEV_DEV_ID("sh_mobile_sdhi.1", &mstp_clks[MSTP313]), /* SDHI1 */
 	CLKDEV_DEV_ID("sh_mmcif.0", &mstp_clks[MSTP312]), /* MMC */
