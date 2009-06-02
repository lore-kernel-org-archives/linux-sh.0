From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 02 Jun 2009 08:43:59 +0000
Subject: [PATCH] sh: clock div4 frequency table offset fix
Message-Id: <20090602084359.26801.63708.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch fixes the per clock offset calculation in
sh_clk_div4_register(). Without this patch the offset
to the frequency table for each clock is incorrect.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/kernel/cpu/clock-cpg.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- 0001/arch/sh/kernel/cpu/clock-cpg.c
+++ work/arch/sh/kernel/cpu/clock-cpg.c	2009-06-02 16:25:29.000000000 +0900
@@ -71,8 +71,9 @@ int __init sh_clk_div4_register(struct c
 	int ret = 0;
 	int k;
 
-	k = nr_divs + 1;
-	freq_table = alloc_bootmem(freq_table_size * nr * (nr_divs + 1));
+	freq_table_size *= (nr_divs + 1);
+
+	freq_table = alloc_bootmem(freq_table_size * nr);
 	if (!freq_table)
 		return -ENOMEM;
 
