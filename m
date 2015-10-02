From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 02 Oct 2015 01:57:55 +0000
Subject: [PATCH] clk: shmobile: Fix r8a7795 MSSR support
Message-Id: <20151002015755.7116.10457.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-clk@vger.kernel.org
Cc: kuninori.morimoto.gx@renesas.com, gaku.inami.xw@bp.renesas.com, mturquette@baylibre.com, linux-sh@vger.kernel.org, sboyd@codeaurora.org, horms@verge.net.au, geert@linux-m68k.org, laurent.pinchart@ideasonboard.com, Magnus Damm <magnus.damm@gmail.com>

From: Magnus Damm <damm+renesas@opensource.se>

This is an incremental fix for the series posted yesterday:
[PATCH v8 00/05] Renesas R-Car Gen3 CPG support V8

As pointed out by Geert, I missed one r8a7791 instance
when doing manual search-and-replace. This fix will in
the future be folded into patch 3/5 and 4/5, but for
now this incremental patch will have to do.

Thanks to Geert for keeping his eyes open!

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 drivers/clk/shmobile/clk-mssr.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 0005/drivers/clk/shmobile/clk-mssr.c
+++ work/drivers/clk/shmobile/clk-mssr.c	2015-10-02 10:48:27.560513000 +0900
@@ -323,7 +323,7 @@ static int cpg_mssr_attach_dev(struct ge
 	while (!of_parse_phandle_with_args(np, "clocks", "#clock-cells", i,
 					   &clkspec)) {
 		if (of_device_is_compatible(clkspec.np,
-					    "renesas,r8a7791-cpg-mssr"))
+					    "renesas,r8a7795-cpg-mssr"))
 			goto found;
 
 		of_node_put(clkspec.np);
