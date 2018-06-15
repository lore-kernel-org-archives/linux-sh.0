From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Date: Fri, 15 Jun 2018 15:50:10 +0000
Subject: [PATCH] arch/sh: fix SH4 flush_dcache_all() for SMP
Message-Id: <20180615155010.8019-1-thomas.petazzoni@bootlin.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>

The SH4 flush_dcache_all() function uses current_cpu_data, which
internally uses smp_processor_id(). However, it is incorrect to use
smp_processor_id() in a context where migration is enabled, because
the processor on which the code is running can change at any point in
time.

To avoid this, we enclose the code flushing the dcache in a get_cpu()
/ put_cpu() section so that migration is disabled.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
---
Note: I am not sure at all this is the best fix. Careful review and
suggestions are welcome.

 arch/sh/mm/cache-sh4.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/sh/mm/cache-sh4.c b/arch/sh/mm/cache-sh4.c
index eee911422cf9..cde8d7f8acbb 100644
--- a/arch/sh/mm/cache-sh4.c
+++ b/arch/sh/mm/cache-sh4.c
@@ -149,13 +149,17 @@ static void flush_icache_all(void)
 static void flush_dcache_all(void)
 {
 	unsigned long addr, end_addr, entry_offset;
+	struct sh_cpuinfo *cpud;
+	int cpu;
+
+	cpu = get_cpu();
+	cpud = &cpu_data[cpu];
 
 	end_addr = CACHE_OC_ADDRESS_ARRAY +
-		(current_cpu_data.dcache.sets <<
-		 current_cpu_data.dcache.entry_shift) *
-			current_cpu_data.dcache.ways;
+		(cpud->dcache.sets << cpud->dcache.entry_shift) *
+		cpud->dcache.ways;
 
-	entry_offset = 1 << current_cpu_data.dcache.entry_shift;
+	entry_offset = 1 << cpud->dcache.entry_shift;
 
 	for (addr = CACHE_OC_ADDRESS_ARRAY; addr < end_addr; ) {
 		__raw_writel(0, addr); addr += entry_offset;
@@ -167,6 +171,8 @@ static void flush_dcache_all(void)
 		__raw_writel(0, addr); addr += entry_offset;
 		__raw_writel(0, addr); addr += entry_offset;
 	}
+
+	put_cpu();
 }
 
 static void sh4_flush_cache_all(void *unused)
-- 
2.14.4

