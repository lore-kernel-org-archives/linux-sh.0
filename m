From: Adam Iwaniuk <adami@cubiware.com>
Date: Mon, 13 Oct 2014 11:59:12 +0000
Subject: [PATCH] sh: fix mmap_sem deadlock in sys_cacheflush
Message-Id: <1413201552-2730-1-git-send-email-adami@cubiware.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Adam Iwaniuk <adami@cubiware.com>

From: Adam Iwaniuk <adami@cubiware.com>

We can't be holding the mmap_sem while calling __flush_XXX_region/flush_icache_range
because the flush can fault. If we fault on a user address, the page fault handler
will try to take mmap_sem again. Since both places acquire the read lock, most of the
time it succeeds. However, if another thread tries to acquire the write lock on the
mmap_sem (e.g. mmap) in between the call to __flush_XXX_region/flush_icache_range and
the fault, the down_read in do_page_fault will deadlock.

Signed-off-by: Adam Iwaniuk <adami@cubiware.com>
---
 arch/sh/kernel/sys_sh.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/kernel/sys_sh.c b/arch/sh/kernel/sys_sh.c
index 8c6a350..4aa294c 100644
--- a/arch/sh/kernel/sys_sh.c
+++ b/arch/sh/kernel/sys_sh.c
@@ -74,6 +74,7 @@ asmlinkage int sys_cacheflush(unsigned long addr, unsigned long len, int op)
 		up_read(&current->mm->mmap_sem);
 		return -EFAULT;
 	}
+	up_read(&current->mm->mmap_sem);
 
 	switch (op & CACHEFLUSH_D_PURGE) {
 		case CACHEFLUSH_D_INVAL:
@@ -90,6 +91,5 @@ asmlinkage int sys_cacheflush(unsigned long addr, unsigned long len, int op)
 	if (op & CACHEFLUSH_I)
 		flush_icache_range(addr, addr+len);
 
-	up_read(&current->mm->mmap_sem);
 	return 0;
 }
-- 
1.7.9.5

