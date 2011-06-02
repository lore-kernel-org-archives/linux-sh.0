From: Srinivas KANDAGATLA <srinivas.kandagatla@st.com>
Date: Thu, 02 Jun 2011 10:30:44 +0000
Subject: sh: fix wrong icache/dcache address-array start addr in cache-debugfs.
Message-Id: <4DE76654.40605@st.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------020808010305040502010700"
List-Id: <linux-sh.vger.kernel.org>
To: linux-sh@vger.kernel.org

This is a multi-part message in MIME format.
--------------020808010305040502010700
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi All,
Recently we discovered a bug in cache-debugfs code. Problem is because 
of static variable (addrstart ) used to remember icache/dcache address 
array start address.
As its static the addrstart ends up with incorrect value after few 
passes of the function.

ex: Correct icache address array start address is 0xF000 0000 but with 
the existing code the start address ends up at 0xF000 8000

This patch makes the variable non-static, reset the start address every 
time it enters the function and cleanup unnecessary variables.

Thanks,
srini


--------------020808010305040502010700
Content-Type: text/x-patch;
 name="0001-sh-fix-wrong-icache-dcache-address-array-start-addr-.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0001-sh-fix-wrong-icache-dcache-address-array-start-addr-.pa";
 filename*1="tch"

From dff32307c0b29355bb9925a3cdd2c09db77a39b7 Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@st.com>
Date: Thu, 2 Jun 2011 10:32:36 +0100
Subject: [PATCH sh-2.6.32.y] sh: fix wrong icache/dcache address-array start addr in cache-debugfs.

This patch fixes a icache/dcache address-array start address while
dumping its entires in debugfs. Perviously the code was attempting to
remember the address in static variable, which is no more required
for debugfs, as the function can be executed in one pass.

Without this patch the start address ends up in wrong place and the
/sys/kernel/debug/sh/icache or dcache debugfs contents may not be correct.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@st.com>
---
 arch/sh/mm/cache-debugfs.c |   25 +++++--------------------
 1 files changed, 5 insertions(+), 20 deletions(-)

diff --git a/arch/sh/mm/cache-debugfs.c b/arch/sh/mm/cache-debugfs.c
index 5241146..1157251 100644
--- a/arch/sh/mm/cache-debugfs.c
+++ b/arch/sh/mm/cache-debugfs.c
@@ -26,9 +26,9 @@ static int cache_seq_show(struct seq_file *file, void *iter)
 {
 	unsigned int cache_type = (unsigned int)file->private;
 	struct cache_info *cache;
-	unsigned int waysize, way, cache_size;
-	unsigned long ccr, base;
-	static unsigned long addrstart = 0;
+	unsigned int waysize, way;
+	unsigned long ccr;
+	unsigned long addrstart = 0;
 
 	/*
 	 * Go uncached immediately so we don't skew the results any
@@ -45,28 +45,13 @@ static int cache_seq_show(struct seq_file *file, void *iter)
 	}
 
 	if (cache_type == CACHE_TYPE_DCACHE) {
-		base = CACHE_OC_ADDRESS_ARRAY;
+		addrstart = CACHE_OC_ADDRESS_ARRAY;
 		cache = &current_cpu_data.dcache;
 	} else {
-		base = CACHE_IC_ADDRESS_ARRAY;
+		addrstart = CACHE_IC_ADDRESS_ARRAY;
 		cache = &current_cpu_data.icache;
 	}
 
-	/*
-	 * Due to the amount of data written out (depending on the cache size),
-	 * we may be iterated over multiple times. In this case, keep track of
-	 * the entry position in addrstart, and rewind it when we've hit the
-	 * end of the cache.
-	 *
-	 * Likewise, the same code is used for multiple caches, so care must
-	 * be taken for bouncing addrstart back and forth so the appropriate
-	 * cache is hit.
-	 */
-	cache_size = cache->ways * cache->sets * cache->linesz;
-	if (((addrstart & 0xff000000) != base) ||
-	     (addrstart & 0x00ffffff) > cache_size)
-		addrstart = base;
-
 	waysize = cache->sets;
 
 	/*
-- 
1.6.3.3


--------------020808010305040502010700--
