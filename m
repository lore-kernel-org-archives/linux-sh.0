From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 31 Oct 2008 11:19:38 +0000
Subject: [PATCH] sh: sh_mobile mstpcr clocks for sh7343
Message-Id: <20081031111938.2973.54286.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
References: <20081031111548.2969.82771.sendpatchset@rx1.opensource.se>
In-Reply-To: <20081031111548.2969.82771.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Add sh7343 mstpcr bits and information about their parent clocks.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/kernel/cpu/sh4a/clock-sh7722.c |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

--- 0006/arch/sh/kernel/cpu/sh4a/clock-sh7722.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7722.c	2008-10-31 12:13:09.000000000 +0900
@@ -761,6 +761,30 @@ static struct clk sh7722_mstpcr_clocks[]
 	MSTPCR("vpu0", "bus_clk", 2, 1),
 	MSTPCR("lcdc0", "bus_clk", 2, 0),
 #endif
+#if defined(CONFIG_CPU_SUBTYPE_SH7343)
+	MSTPCR("uram0", "umem_clk", 0, 28),
+	MSTPCR("xymem0", "bus_clk", 0, 26),
+	MSTPCR("tmu0", "peripheral_clk", 0, 15),
+	MSTPCR("cmt0", "r_clk", 0, 14),
+	MSTPCR("rwdt0", "r_clk", 0, 13),
+	MSTPCR("scif0", "peripheral_clk", 0, 7),
+	MSTPCR("scif1", "peripheral_clk", 0, 6),
+	MSTPCR("scif2", "peripheral_clk", 0, 5),
+	MSTPCR("scif3", "peripheral_clk", 0, 4),
+	MSTPCR("i2c0", "peripheral_clk", 1, 9),
+	MSTPCR("i2c1", "peripheral_clk", 1, 8),
+	MSTPCR("sdhi0", "peripheral_clk", 2, 18),
+	MSTPCR("keysc0", "r_clk", 2, 14),
+	MSTPCR("usbf0", "peripheral_clk", 2, 11),
+	MSTPCR("siu0", "bus_clk", 2, 8),
+	MSTPCR("jpu0", "bus_clk", 2, 6),
+	MSTPCR("vou0", "bus_clk", 2, 5),
+	MSTPCR("beu0", "bus_clk", 2, 4),
+	MSTPCR("ceu0", "bus_clk", 2, 3),
+	MSTPCR("veu0", "bus_clk", 2, 2),
+	MSTPCR("vpu0", "bus_clk", 2, 1),
+	MSTPCR("lcdc0", "bus_clk", 2, 0),
+#endif
 };
 
 static struct clk *sh7722_clocks[] = {
