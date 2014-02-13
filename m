From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Thu, 13 Feb 2014 18:02:51 +0000
Subject: [PATCH 3/3] clk-mstp: add backwards comapt for indicies field
Message-Id: <1392314571-30107-3-git-send-email-ben.dooks@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add comaptibiltiy for older device trees by checking to see if
the clock-indicies property is there and falling back to the
older renesas,clock-indices field.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/clk/shmobile/clk-mstp.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/shmobile/clk-mstp.c b/drivers/clk/shmobile/clk-mstp.c
index 95a2aa7..d1ee757 100644
--- a/drivers/clk/shmobile/clk-mstp.c
+++ b/drivers/clk/shmobile/clk-mstp.c
@@ -156,6 +156,7 @@ cpg_mstp_clock_register(const char *name, const char *parent_name,
 static void __init cpg_mstp_clocks_init(struct device_node *np)
 {
 	struct mstp_clock_group *group;
+	const char *idxname;
 	struct clk **clks;
 	unsigned int i;
 
@@ -184,6 +185,11 @@ static void __init cpg_mstp_clocks_init(struct device_node *np)
 	for (i = 0; i < MSTP_MAX_CLOCKS; ++i)
 		clks[i] = ERR_PTR(-ENOENT);
 
+	if (of_find_property(np, "clock-indices"))
+		idxname = "clock-indices";
+	else
+		idxname = "renesas,clock-indices";
+
 	for (i = 0; i < MSTP_MAX_CLOCKS; ++i) {
 		const char *parent_name;
 		const char *name;
@@ -197,8 +203,7 @@ static void __init cpg_mstp_clocks_init(struct device_node *np)
 			continue;
 
 		parent_name = of_clk_get_parent_name(np, i);
-		ret = of_property_read_u32_index(np, "clock-indices", i,
-						 &clkidx);
+		ret = of_property_read_u32_index(np, idxname, i, &clkidx);
 		if (parent_name = NULL || ret < 0)
 			break;
 
-- 
1.8.5.3

