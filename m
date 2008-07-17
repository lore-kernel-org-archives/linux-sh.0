From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 17 Jul 2008 09:48:57 +0000
Subject: [PATCH] sh: Add arch_flags to struct clk
Message-Id: <20080717094857.19544.26956.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Add arch_flags to struct clk so we can keep per-clock private data
somewhere and share code between multiple clocks.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 include/asm-sh/clock.h |    1 +
 1 file changed, 1 insertion(+)

--- 0001/include/asm-sh/clock.h
+++ work/include/asm-sh/clock.h	2008-06-13 15:42:07.000000000 +0900
@@ -30,6 +30,7 @@ struct clk {
 
 	unsigned long		rate;
 	unsigned long		flags;
+	unsigned long		arch_flags;
 };
 
 #define CLK_ALWAYS_ENABLED	(1 << 0)
