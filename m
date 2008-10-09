From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 09 Oct 2008 09:42:55 +0000
Subject: [PATCH] sh: add dynamic crash base address support
Message-Id: <20081009094255.6471.16563.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Add support for dynamic crash kernel base address.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/kernel/setup.c |   15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

--- 0001/arch/sh/kernel/setup.c
+++ work/arch/sh/kernel/setup.c	2008-10-09 16:54:51.000000000 +0900
@@ -147,6 +147,7 @@ static void __init reserve_crashkernel(v
 {
 	unsigned long long free_mem;
 	unsigned long long crash_size, crash_base;
+	void *vp;
 	int ret;
 
 	free_mem = ((unsigned long long)max_low_pfn - min_low_pfn) << PAGE_SHIFT;
@@ -155,12 +156,14 @@ static void __init reserve_crashkernel(v
 			&crash_size, &crash_base);
 	if (ret = 0 && crash_size) {
 		if (crash_base <= 0) {
-			printk(KERN_INFO "crashkernel reservation failed - "
-					"you have to specify a base address\n");
-			return;
-		}
-
-		if (reserve_bootmem(crash_base, crash_size,
+			vp = alloc_bootmem_nopanic(crash_size); 
+			if (!vp) {
+				printk(KERN_INFO "crashkernel allocation "
+				       "failed\n");
+				return;
+			}
+			crash_base = __pa(vp);
+		} else if (reserve_bootmem(crash_base, crash_size,
 					BOOTMEM_EXCLUSIVE) < 0) {
 			printk(KERN_INFO "crashkernel reservation failed - "
 					"memory is in use\n");
