From: Matt Fleming <matt@console-pimps.org>
Date: Mon, 31 Aug 2009 22:19:31 +0000
Subject: [PATCH] sh: Fix dcache flushing with 4-way write-through cache
Message-Id: <1251757171-17201-1-git-send-email-matt@console-pimps.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

We can't use the same code to flush a 4-way dcache in both write-through
and write-back mode. For write-through mode, use the same technique as
is currently used for a 2-way cache and stop writing garbage to memory.

Signed-off-by: Matt Fleming <matt@console-pimps.org>
---
 arch/sh/mm/cache-sh4.c |   21 ++++++++++++++++++++-
 1 files changed, 20 insertions(+), 1 deletions(-)

diff --git a/arch/sh/mm/cache-sh4.c b/arch/sh/mm/cache-sh4.c
index 397c103..08678c5 100644
--- a/arch/sh/mm/cache-sh4.c
+++ b/arch/sh/mm/cache-sh4.c
@@ -673,6 +673,25 @@ static void __flush_dcache_segment_2way(unsigned long start,
 		extent_per_way -= cpu_data->dcache.linesz;
 	}
 }
+
+static void __flush_dcache_segment_4way(unsigned long start,
+					unsigned long extent_per_way)
+{
+	unsigned long array_addr, way_addr;
+	int i;
+
+	array_addr = CACHE_OC_ADDRESS_ARRAY |
+		(start & cpu_data->dcache.entry_mask);
+
+	while (extent_per_way) {
+		for (i = 0; i < 4; i++) {
+			way_addr = array_addr + cpu_data->dcache.way_incr * i;
+			ctrl_outl(0, way_addr);
+		}
+		array_addr += cpu_data->dcache.linesz;
+		extent_per_way -= cpu_data->dcache.linesz;
+	}
+}
 #else
 static void __flush_dcache_segment_2way(unsigned long start,
 					unsigned long extent_per_way)
@@ -732,7 +751,6 @@ static void __flush_dcache_segment_2way(unsigned long start,
 		a1 += linesz;
 	} while (a0 < a0e);
 }
-#endif
 
 static void __flush_dcache_segment_4way(unsigned long start,
 					unsigned long extent_per_way)
@@ -818,3 +836,4 @@ static void __flush_dcache_segment_4way(unsigned long start,
 		a3 += linesz;
 	} while (a0 < a0e);
 }
+#endif /* CONFIG_CACHE_WRITETHROUGH */
-- 
1.6.3.3

