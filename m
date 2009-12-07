From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 07 Dec 2009 14:11:59 +0000
Subject: [PATCH] sh: fix size calculation for NUMA node 0
Message-Id: <20091207141159.6318.90269.sendpatchset@rxone.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Fix the NUMA size calculation for node 0. Do the same
as the UMA version of setup_memory() and use address
instead of pfn when calculating the size.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/mm/numa.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 0001/arch/sh/mm/numa.c
+++ work/arch/sh/mm/numa.c	2009-12-07 21:13:58.000000000 +0900
@@ -28,7 +28,7 @@ void __init setup_memory(void)
 {
 	unsigned long free_pfn = PFN_UP(__pa(_end));
 	u64 base = min_low_pfn << PAGE_SHIFT;
-	u64 size = (max_low_pfn << PAGE_SHIFT) - min_low_pfn;
+	u64 size = (max_low_pfn << PAGE_SHIFT) - base;
 
 	lmb_add(base, size);
 
