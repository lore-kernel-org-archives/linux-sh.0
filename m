From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 10 May 2010 11:23:26 +0000
Subject: [PATCH 01/13] sh: Skip uninitialized hwblk clocks
Message-Id: <20100510112326.14587.52488.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Update the common hwblk clk code to skip over uninitialized
clocks. Useful when registering clocks in an [HWBLK_NR] array.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/kernel/cpu/hwblk.c |    5 +++++
 1 file changed, 5 insertions(+)

--- 0001/arch/sh/kernel/cpu/hwblk.c
+++ work/arch/sh/kernel/cpu/hwblk.c	2010-05-10 18:28:11.000000000 +0900
@@ -146,6 +146,11 @@ int __init sh_hwblk_clk_register(struct 
 
 	for (k = 0; !ret && (k < nr); k++) {
 		clkp = clks + k;
+
+		/* skip over clocks using hwblk 0 (HWBLK_UNKNOWN) */
+		if (!clkp->arch_flags)
+			continue;
+
 		clkp->ops = &sh_hwblk_clk_ops;
 		ret |= clk_register(clkp);
 	}
