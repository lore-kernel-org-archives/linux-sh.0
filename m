From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 02 Nov 2010 11:28:33 +0000
Subject: [PATCH] ARM: mach-shmobile: fix sh7372 after a recent clock framework
Message-Id: <Pine.LNX.4.64.1011021227560.4552@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The updated sh clock framework has introduced a .nr_freqs element of struct
clk, which has to be initialised with the number of possible frequencies.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/arm/mach-shmobile/clock-sh7372.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-sh7372.c b/arch/arm/mach-shmobile/clock-sh7372.c
index 8565aef..7e6a671 100644
--- a/arch/arm/mach-shmobile/clock-sh7372.c
+++ b/arch/arm/mach-shmobile/clock-sh7372.c
@@ -288,6 +288,7 @@ struct clk sh7372_pllc2_clk = {
 	.ops		= &pllc2_clk_ops,
 	.parent		= &extal1_div2_clk,
 	.freq_table	= pllc2_freq_table,
+	.nr_freqs	= ARRAY_SIZE(pllc2_freq_table) - 1,
 	.parent_table	= pllc2_parent,
 	.parent_num	= ARRAY_SIZE(pllc2_parent),
 };
-- 
1.7.2.3

