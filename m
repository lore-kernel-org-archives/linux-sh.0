From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 01 Dec 2008 06:40:33 +0000
Subject: [PATCH] sh: propagate r_clk
Message-Id: <20081201064033.28841.90287.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Make sure the 32 KHz r_clk rate gets propagated correctly. Without
this fix the clocks for RTC, CMT, KEYSC and RWDT are stuck at 0 Hz.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/kernel/cpu/sh4a/clock-sh7722.c |    2 ++
 1 file changed, 2 insertions(+)

--- 0001/arch/sh/kernel/cpu/sh4a/clock-sh7722.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7722.c	2008-11-27 18:16:06.000000000 +0900
@@ -838,5 +838,7 @@ int __init arch_clk_init(void)
 		clk_put(clk);
 	}
 
+	clk_recalc_rate(&sh7722_r_clock); /* make sure rate gets propagated */
+
 	return 0;
 }
