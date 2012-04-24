From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 24 Apr 2012 09:20:41 +0000
Subject: [PATCH 1/2][for LTSI] ARM: mach-shmobile: clock-r8a7740: add FSI clock
Message-Id: <87vckpeba2.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/clock-r8a7740.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-r8a7740.c b/arch/arm/mach-shmobile/clock-r8a7740.c
index 927d42a..89a2f9d 100644
--- a/arch/arm/mach-shmobile/clock-r8a7740.c
+++ b/arch/arm/mach-shmobile/clock-r8a7740.c
@@ -355,7 +355,7 @@ enum {
 	MSTP222,
 	MSTP207, MSTP206, MSTP204, MSTP203, MSTP202, MSTP201, MSTP200,
 
-	MSTP329, MSTP323, MSTP320,
+	MSTP329, MSTP328, MSTP323, MSTP320,
 	MSTP314, MSTP313, MSTP312,
 
 	MSTP416, MSTP415, MSTP407, MSTP406,
@@ -381,6 +381,7 @@ static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP200] = SH_CLK_MSTP32(&div6_clks[DIV6_SUB],	SMSTPCR2,  0, 0), /* SCIFA4 */
 
 	[MSTP329] = SH_CLK_MSTP32(&r_clk,		SMSTPCR3, 29, 0), /* CMT10 */
+	[MSTP328] = SH_CLK_MSTP32(&div4_clks[DIV4_HP],	SMSTPCR3, 28, 0), /* FSI */
 	[MSTP323] = SH_CLK_MSTP32(&div6_clks[DIV6_SUB],	SMSTPCR3, 23, 0), /* IIC1 */
 	[MSTP320] = SH_CLK_MSTP32(&div4_clks[DIV4_HP],	SMSTPCR3, 20, 0), /* USBF */
 	[MSTP314] = SH_CLK_MSTP32(&div4_clks[DIV4_HP],	SMSTPCR3, 14, 0), /* SDHI0 */
@@ -445,6 +446,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh-sci.6",		&mstp_clks[MSTP230]),
 
 	CLKDEV_DEV_ID("sh_cmt.10",		&mstp_clks[MSTP329]),
+	CLKDEV_DEV_ID("sh_fsi2",		&mstp_clks[MSTP328]),
 	CLKDEV_DEV_ID("i2c-sh_mobile.1",	&mstp_clks[MSTP323]),
 	CLKDEV_DEV_ID("renesas_usbhs",		&mstp_clks[MSTP320]),
 	CLKDEV_DEV_ID("sh_mobile_sdhi.0",	&mstp_clks[MSTP314]),
-- 
1.7.5.4

