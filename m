From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 17 Jul 2008 10:05:54 +0000
Subject: [PATCH] sh: Show all clocks and their state in /proc/clocks
Message-Id: <20080717100554.19593.15173.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Show all clocks in /proc/clocks, and also show if they are enabled or
disabled. This is useful to show MSTPCR bits on SuperH Mobile processors.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/kernel/cpu/clock.c |   14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

--- 0001/arch/sh/kernel/cpu/clock.c
+++ work/arch/sh/kernel/cpu/clock.c	2008-07-17 12:17:16.000000000 +0900
@@ -308,15 +308,11 @@ static int show_clocks(char *buf, char *
 	list_for_each_entry_reverse(clk, &clock_list, node) {
 		unsigned long rate = clk_get_rate(clk);
 
-		/*
-		 * Don't bother listing dummy clocks with no ancestry
-		 * that only support enable and disable ops.
-		 */
-		if (unlikely(!rate && !clk->parent))
-			continue;
-
-		p += sprintf(p, "%-12s\t: %ld.%02ldMHz\n", clk->name,
-			     rate / 1000000, (rate % 1000000) / 10000);
+		p += sprintf(p, "%-12s\t: %ld.%02ldMHz\t%s\n", clk->name,
+			     rate / 1000000, (rate % 1000000) / 10000,
+			     ((clk->flags & CLK_ALWAYS_ENABLED) ||
+			      (atomic_read(&clk->kref.refcount) != 1)) ?
+			     "enabled" : "disabled");
 	}
 
 	return p - buf;
