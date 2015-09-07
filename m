From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 07 Sep 2015 16:33:25 +0000
Subject: [PATCH v7 03/05] clk: shmobile: Make MSTP clock-output-names optional
Message-Id: <20150907163325.475.66286.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
References: <20150907163252.475.18281.sendpatchset@little-apple>
In-Reply-To: <20150907163252.475.18281.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-clk@vger.kernel.org
Cc: kuninori.morimoto.gx@renesas.com, linux-sh@vger.kernel.org, mturquette@baylibre.com, gaku.inami.xw@bp.renesas.com, sboyd@codeaurora.org, horms@verge.net.au, geert@linux-m68k.org, laurent.pinchart@ideasonboard.com, Magnus Damm <magnus.damm@gmail.com>

From: Magnus Damm <damm+renesas@opensource.se>

This patch updates the MSTP driver to make the "clock-output-names"
DT property optional instead of mandatory. In case the DT property
is omitted then the function clk_register_clkdev() is skipped.

The default for new SoCs is to not use "clock-output-names".

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Changes since V6:
 - None

 Changes since V5:
 - Simplified code using const char *allocated_name - thanks Geert!

 Changes since V4:
 - None

 Changes since V3:
 - Added support for multiple MSTP bits. =)

 drivers/clk/shmobile/clk-mstp.c |   24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

--- 0001/drivers/clk/shmobile/clk-mstp.c
+++ work/drivers/clk/shmobile/clk-mstp.c	2015-09-02 11:52:02.182366518 +0900
@@ -193,26 +193,26 @@ static void __init cpg_mstp_clocks_init(
 	for (i = 0; i < MSTP_MAX_CLOCKS; ++i) {
 		const char *parent_name;
 		const char *name;
+		const char *allocated_name = NULL;
 		u32 clkidx;
 		int ret;
 
-		/* Skip clocks with no name. */
-		ret = of_property_read_string_index(np, "clock-output-names",
-						    i, &name);
-		if (ret < 0 || strlen(name) = 0)
-			continue;
-
 		parent_name = of_clk_get_parent_name(np, i);
 		ret = of_property_read_u32_index(np, idxname, i, &clkidx);
 		if (parent_name = NULL || ret < 0)
 			break;
 
 		if (clkidx >= MSTP_MAX_CLOCKS) {
-			pr_err("%s: invalid clock %s %s index %u)\n",
-			       __func__, np->name, name, clkidx);
+			pr_err("%s: invalid clock %s index %u)\n",
+			       __func__, np->name, clkidx);
 			continue;
 		}
 
+		if (of_property_read_string_index(np, "clock-output-names",
+						  i, &name) < 0)
+			allocated_name = name = kasprintf(GFP_KERNEL, "%s.%u",
+							   np->name, clkidx);
+
 		clks[clkidx] = cpg_mstp_clock_register(name, parent_name,
 						       clkidx, group);
 		if (!IS_ERR(clks[clkidx])) {
@@ -225,12 +225,18 @@ static void __init cpg_mstp_clocks_init(
 			 *
 			 * FIXME: Remove this when all devices that require a
 			 * clock will be instantiated from DT.
+			 *
+			 * We currently register clkdev only when the DT
+			 * property clock-output-names is present.
 			 */
-			clk_register_clkdev(clks[clkidx], name, NULL);
+			if (!allocated_name)
+				clk_register_clkdev(clks[clkidx], name, NULL);
 		} else {
 			pr_err("%s: failed to register %s %s clock (%ld)\n",
 			       __func__, np->name, name, PTR_ERR(clks[clkidx]));
 		}
+
+		kfree(allocated_name);
 	}
 
 	of_clk_add_provider(np, of_clk_src_onecell_get, &group->data);
