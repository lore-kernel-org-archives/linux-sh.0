From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 27 Jun 2013 01:53:03 +0000
Subject: [PATCH v3 1/2] ARM: shmobile: r8a7790: add clocks for thermal
Message-Id: <1372297984-9315-2-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1372297984-9315-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1372297984-9315-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---

v3
* Correct title to refer to r8a7790

v2
* First post
---
 arch/arm/mach-shmobile/clock-r8a7790.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-shmobile/clock-r8a7790.c b/arch/arm/mach-shmobile/clock-r8a7790.c
index 5d71313..28eccd1 100644
--- a/arch/arm/mach-shmobile/clock-r8a7790.c
+++ b/arch/arm/mach-shmobile/clock-r8a7790.c
@@ -49,6 +49,7 @@
 
 #define SMSTPCR2 0xe6150138
 #define SMSTPCR3 0xe615013c
+#define SMSTPCR5 0xe6150144
 #define SMSTPCR7 0xe615014c
 
 #define MODEMR		0xE6160060
@@ -182,6 +183,7 @@ static struct clk div6_clks[DIV6_NR] = {
 enum {
 	MSTP721, MSTP720,
 	MSTP717, MSTP716,
+	MSTP522,
 	MSTP315, MSTP314, MSTP313, MSTP312, MSTP311, MSTP305, MSTP304,
 	MSTP216, MSTP207, MSTP206, MSTP204, MSTP203, MSTP202,
 	MSTP_NR
@@ -203,6 +205,7 @@ static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP204] = SH_CLK_MSTP32(&mp_clk, SMSTPCR2, 4, 0), /* SCIFA0 */
 	[MSTP203] = SH_CLK_MSTP32(&mp_clk, SMSTPCR2, 3, 0), /* SCIFA1 */
 	[MSTP202] = SH_CLK_MSTP32(&mp_clk, SMSTPCR2, 2, 0), /* SCIFA2 */
+	[MSTP522] = SH_CLK_MSTP32(&extal_clk, SMSTPCR5, 22, 0), /* Thermal */
 	[MSTP717] = SH_CLK_MSTP32(&zs_clk, SMSTPCR7, 17, 0), /* HSCIF0 */
 	[MSTP716] = SH_CLK_MSTP32(&zs_clk, SMSTPCR7, 16, 0), /* HSCIF1 */
 };
@@ -254,6 +257,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh-sci.7", &mstp_clks[MSTP720]),
 	CLKDEV_DEV_ID("sh-sci.8", &mstp_clks[MSTP717]),
 	CLKDEV_DEV_ID("sh-sci.9", &mstp_clks[MSTP716]),
+	CLKDEV_DEV_ID("rcar_thermal", &mstp_clks[MSTP522]),
 	CLKDEV_DEV_ID("ee200000.mmcif", &mstp_clks[MSTP315]),
 	CLKDEV_DEV_ID("sh_mmcif.0", &mstp_clks[MSTP315]),
 	CLKDEV_DEV_ID("ee100000.sdhi", &mstp_clks[MSTP314]),
-- 
1.8.2.1

