From: npiggin@suse.de
Date: Thu, 22 Apr 2010 16:06:26 +0000
Subject: [patch 13/14] sh: invoke oom-killer from page fault
Message-Id: <20100422161224.768947406@suse.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20100422160613.723698029@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arch@vger.kernel.org
Cc: David Rientjes <rientjes@google.com>, Andrew Morton <akpm@linux-foundation.org>, linux-sh@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>

As explained in commit 1c0fe6e3bd, we want to call the architecture independent
oom killer when getting an unexplained OOM from handle_mm_fault, rather than
simply killing current.

Cc: linux-sh@vger.kernel.org
Cc: Paul Mundt <lethal@linux-sh.org>
Cc: linux-arch@vger.kernel.org
Signed-off-by: Nick Piggin <npiggin@suse.de>
---
Index: linux-2.6/arch/sh/mm/fault_32.c
=================================--- linux-2.6.orig/arch/sh/mm/fault_32.c
+++ linux-2.6/arch/sh/mm/fault_32.c
@@ -290,15 +290,10 @@ no_context:
  */
 out_of_memory:
 	up_read(&mm->mmap_sem);
-	if (is_global_init(current)) {
-		yield();
-		down_read(&mm->mmap_sem);
-		goto survive;
-	}
-	printk("VM: killing process %s\n", tsk->comm);
-	if (user_mode(regs))
-		do_group_exit(SIGKILL);
-	goto no_context;
+	if (!user_mode(regs))
+		goto no_context;
+	pagefault_out_of_memory();
+	return;
 
 do_sigbus:
 	up_read(&mm->mmap_sem);
Index: linux-2.6/arch/sh/mm/tlbflush_64.c
=================================--- linux-2.6.orig/arch/sh/mm/tlbflush_64.c
+++ linux-2.6/arch/sh/mm/tlbflush_64.c
@@ -294,22 +294,11 @@ no_context:
  * us unable to handle the page fault gracefully.
  */
 out_of_memory:
-	if (is_global_init(current)) {
-		panic("INIT out of memory\n");
-		yield();
-		goto survive;
-	}
-	printk("fault:Out of memory\n");
 	up_read(&mm->mmap_sem);
-	if (is_global_init(current)) {
-		yield();
-		down_read(&mm->mmap_sem);
-		goto survive;
-	}
-	printk("VM: killing process %s\n", tsk->comm);
-	if (user_mode(regs))
-		do_group_exit(SIGKILL);
-	goto no_context;
+	if (!user_mode(regs))
+		goto no_context;
+	pagefault_out_of_memory();
+	return;
 
 do_sigbus:
 	printk("fault:Do sigbus\n");


