From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 01 Oct 2015 14:38:07 +0000
Subject: [PATCH v8 05/05] drivers: sh: Handle PM_GENERIC_DOMAINS_OF=n with r8a7795 MSSR
Message-Id: <20151001143807.20618.67920.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
References: <20151001143717.20618.26365.sendpatchset@little-apple>
In-Reply-To: <20151001143717.20618.26365.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-clk@vger.kernel.org
Cc: kuninori.morimoto.gx@renesas.com, linux-sh@vger.kernel.org, mturquette@baylibre.com, gaku.inami.xw@bp.renesas.com, sboyd@codeaurora.org, horms@verge.net.au, geert@linux-m68k.org, laurent.pinchart@ideasonboard.com, Magnus Damm <magnus.damm@gmail.com>

From: Geert Uytterhoeven <geert+renesas@glider.be>

If the new CPG/MSSR device node is present, but
CONFIG_PM_GENERIC_DOMAINS_OF=n, the legacy clock domain should be
enabled. Else the module clocks are not properly enabled when needed.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Changes since V7: (Magnus Damm <damm+renesas@opensource.se>)
 - New patch, based on local r8a7791 patch from Geert
   "drivers: sh: Handle CONFIG_PM_GENERIC_DOMAINS_OF=n with new CPG/MSSR"
 - Modified to match on r8a7795

 drivers/sh/pm_runtime.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- 0001/drivers/sh/pm_runtime.c
+++ work/drivers/sh/pm_runtime.c	2015-10-01 18:51:47.280513000 +0900
@@ -36,7 +36,10 @@ static int __init sh_pm_runtime_init(voi
 {
 	if (IS_ENABLED(CONFIG_ARCH_SHMOBILE)) {
 		if (!of_find_compatible_node(NULL, NULL,
-					     "renesas,cpg-mstp-clocks"))
+					     "renesas,cpg-mstp-clocks") &&
+		    (IS_ENABLED(CONFIG_PM_GENERIC_DOMAINS_OF) ||
+		     !of_find_compatible_node(NULL, NULL,
+					     "renesas,r8a7795-cpg-mssr")))
 			return 0;
 		if (IS_ENABLED(CONFIG_PM_GENERIC_DOMAINS_OF) &&
 		    of_find_node_with_property(NULL, "#power-domain-cells"))
