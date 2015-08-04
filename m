From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 04 Aug 2015 13:25:35 +0000
Subject: [PATCH v4 15/16] clk: shmobile: mstp: Consider "zb_clk" suitable for power management
Message-Id: <1438694735-11313-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1438691297-29235-16-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1438691297-29235-16-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Currently the CPG/MSTP Clock Domain code looks for MSTP clocks to power
manage a device.

Unfortunately, on R-Mobile APE6 (r8a73a4) and SH-Mobile AG5 (sh73a0),
the Bus State Controller (BSC) is not power-managed by an MSTP clock,
but by a plain CPG clock (zb_clk).  Add a special case to handle this,
so the clock is properly managed, and devices connected to the BSC work
as expected.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
---
v4:
  - Add Reviewed-by,

v3:
  - Use "CPG/MSTP Clock Domain" instead of "CPG Clock Domain",

v2:
  - New.
---
 drivers/clk/shmobile/clk-mstp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clk/shmobile/clk-mstp.c b/drivers/clk/shmobile/clk-mstp.c
index b1df7b2f1e970adb..a117c3f0f257b5e1 100644
--- a/drivers/clk/shmobile/clk-mstp.c
+++ b/drivers/clk/shmobile/clk-mstp.c
@@ -259,6 +259,10 @@ int cpg_mstp_attach_dev(struct generic_pm_domain *domain, struct device *dev)
 					    "renesas,cpg-mstp-clocks"))
 			goto found;
 
+		/* BSC on r8a73a4/sh73a0 uses zb_clk instead of an mstp clock */
+		if (!strcmp(clkspec.np->name, "zb_clk"))
+			goto found;
+
 		of_node_put(clkspec.np);
 		i++;
 	}
-- 
1.9.1

