From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 11 Nov 2011 02:45:02 +0000
Subject: [PATCH 06/20] ARM: mach-shmobile: clock-sh7372: remove un-necessary index
Message-Id: <87sjlv9y39.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

it is not necessary to have sh7372_xxxx index on static variable

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/clock-sh7372.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-sh7372.c b/arch/arm/mach-shmobile/clock-sh7372.c
index 6697592..995a9c3 100644
--- a/arch/arm/mach-shmobile/clock-sh7372.c
+++ b/arch/arm/mach-shmobile/clock-sh7372.c
@@ -476,7 +476,7 @@ static struct clk_ops fsidiv_clk_ops = {
 	.disable	= fsidiv_disable,
 };
 
-static struct clk_mapping sh7372_fsidiva_clk_mapping = {
+static struct clk_mapping fsidiva_clk_mapping = {
 	.phys	= FSIDIVA,
 	.len	= 8,
 };
@@ -484,10 +484,10 @@ static struct clk_mapping sh7372_fsidiva_clk_mapping = {
 struct clk sh7372_fsidiva_clk = {
 	.ops		= &fsidiv_clk_ops,
 	.parent		= &div6_reparent_clks[DIV6_FSIA], /* late install */
-	.mapping	= &sh7372_fsidiva_clk_mapping,
+	.mapping	= &fsidiva_clk_mapping,
 };
 
-static struct clk_mapping sh7372_fsidivb_clk_mapping = {
+static struct clk_mapping fsidivb_clk_mapping = {
 	.phys	= FSIDIVB,
 	.len	= 8,
 };
@@ -495,7 +495,7 @@ static struct clk_mapping sh7372_fsidivb_clk_mapping = {
 struct clk sh7372_fsidivb_clk = {
 	.ops		= &fsidiv_clk_ops,
 	.parent		= &div6_reparent_clks[DIV6_FSIB],  /* late install */
-	.mapping	= &sh7372_fsidivb_clk_mapping,
+	.mapping	= &fsidivb_clk_mapping,
 };
 
 static struct clk *late_main_clks[] = {
-- 
1.7.5.4

