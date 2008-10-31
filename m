From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 31 Oct 2008 11:15:48 +0000
Subject: [PATCH] sh: sh_mobile mstpcr clocks for sh7722
Message-Id: <20081031111548.2969.82771.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Add sh7722 mstpcr bits and information about their parent clocks.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/kernel/cpu/sh4a/clock-sh7722.c |   25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

--- 0006/arch/sh/kernel/cpu/sh4a/clock-sh7722.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7722.c	2008-10-31 19:26:44.000000000 +0900
@@ -687,6 +687,31 @@ static struct clk sh7722_mstpcr[] = {
 }
 
 static struct clk sh7722_mstpcr_clocks[] = {
+#if defined(CONFIG_CPU_SUBTYPE_SH7722)
+	MSTPCR("uram0", "umem_clk", 0, 28),
+	MSTPCR("xymem0", "bus_clk", 0, 26),
+	MSTPCR("tmu0", "peripheral_clk", 0, 15),
+	MSTPCR("cmt0", "r_clk", 0, 14),
+	MSTPCR("rwdt0", "r_clk", 0, 13),
+	MSTPCR("flctl0", "peripheral_clk", 0, 10),
+	MSTPCR("scif0", "peripheral_clk", 0, 7),
+	MSTPCR("scif1", "peripheral_clk", 0, 6),
+	MSTPCR("scif2", "peripheral_clk", 0, 5),
+	MSTPCR("i2c0", "peripheral_clk", 1, 9),
+	MSTPCR("rtc0", "r_clk", 1, 8),
+	MSTPCR("sdhi0", "peripheral_clk", 2, 18),
+	MSTPCR("keysc0", "r_clk", 2, 14),
+	MSTPCR("usbf0", "peripheral_clk", 2, 11),
+	MSTPCR("2dg0", "bus_clk", 2, 9),
+	MSTPCR("siu0", "bus_clk", 2, 8),
+	MSTPCR("vou0", "bus_clk", 2, 5),
+	MSTPCR("jpu0", "bus_clk", 2, 6),
+	MSTPCR("beu0", "bus_clk", 2, 4),
+	MSTPCR("ceu0", "bus_clk", 2, 3),
+	MSTPCR("veu0", "bus_clk", 2, 2),
+	MSTPCR("vpu0", "bus_clk", 2, 1),
+	MSTPCR("lcdc0", "bus_clk", 2, 0),
+#endif
 };
 
 static struct clk *sh7722_clocks[] = {
