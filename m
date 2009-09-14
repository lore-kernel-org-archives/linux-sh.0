From: Rafael Ignacio Zurita <rizurita@yahoo.com>
Date: Mon, 14 Sep 2009 00:48:51 +0000
Subject: [PATCH] sh: remove .init from sh7709_cpu_clk_ops
Message-Id: <20090914004851.GA14697@rafazurita.homelinux.net>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

It avoids to change the parent of sh7709_cpu_clk. With this change
master_clk is the parent of cpu_clk (from clk_cpg_legacy), and it
prevents the second mutex_lock(&clock_list_sem) while the first
one is still locked.

Signed-off-by: Rafael Ignacio Zurita <rizurita@yahoo.com>
---
 arch/sh/kernel/cpu/sh3/clock-sh7709.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh3/clock-sh7709.c b/arch/sh/kernel/cpu/sh3/clock-sh7709.c
index fa30b60..f3064f9 100644
--- a/arch/sh/kernel/cpu/sh3/clock-sh7709.c
+++ b/arch/sh/kernel/cpu/sh3/clock-sh7709.c
@@ -78,7 +78,6 @@ static unsigned long cpu_clk_recalc(struct clk *clk)
 }
 
 static struct clk_ops sh7709_cpu_clk_ops = {
-	.init		= set_bus_parent,
 	.recalc		= cpu_clk_recalc,
 };
 
