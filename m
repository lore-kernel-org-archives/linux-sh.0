From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 27 Aug 2008 09:15:43 +0000
Subject: [PATCH] sh: crash kernel resource fix
Message-Id: <20080827091543.9100.82819.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

The reserved crash kernel memory range is currently missing from
/proc/iomem. crashk_res is mistakenly setup after __add_active_range().
Reorder things to make sure the resource shows up in /proc/iomem.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/kernel/setup.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

--- 0001/arch/sh/kernel/setup.c
+++ work/arch/sh/kernel/setup.c	2008-08-25 12:20:04.000000000 +0900
@@ -171,6 +171,7 @@ static void __init reserve_crashkernel(v
 				(unsigned long)(free_mem >> 20));
 		crashk_res.start = crash_base;
 		crashk_res.end   = crash_base + crash_size - 1;
+		insert_resource(&iomem_resource, &crashk_res);
 	}
 }
 #else
@@ -204,11 +205,6 @@ void __init __add_active_range(unsigned 
 	request_resource(res, &data_resource);
 	request_resource(res, &bss_resource);
 
-#ifdef CONFIG_KEXEC
-	if (crashk_res.start != crashk_res.end)
-		request_resource(res, &crashk_res);
-#endif
-
 	add_active_range(nid, start_pfn, end_pfn);
 }
 
