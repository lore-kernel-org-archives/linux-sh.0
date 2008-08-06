From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 06 Aug 2008 10:36:00 +0000
Subject: [PATCH 2/3] binfmt_elf_fdpic: Convert initial stack alignment to arch_align_stack()
Message-Id: <20080806103600.GB5194@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080806103458.GE2610@linux-sh.org>
In-Reply-To: <20080806103458.GE2610@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Howells <dhowells@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

binfmt_elf_fdpic seems to have grabbed a hard-coded hack from an ancient
version of binfmt_elf in order to try and fix up initial stack alignment
on multi-threaded x86, which while in addition to being unused, was also
pushed down beyond the first set of operations on the stack pointer,
negating the entire purpose.

These days, we have an architecture independent arch_align_stack(), so we
switch to using that instead. Move the initial alignment up before the
initial stores while we're at it.

Signed-off-by: Paul Mundt <lethal@linux-sh.org>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/binfmt_elf_fdpic.c |   25 ++++++++-----------------
 1 files changed, 8 insertions(+), 17 deletions(-)


diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index 7c83605..f9d6eaa 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -466,7 +466,8 @@ error_kill:
 #endif
 
 /*
- * present useful information to the program
+ * present useful information to the program by shovelling it onto the new
+ * process's stack
  */
 static int create_elf_fdpic_tables(struct linux_binprm *bprm,
 				   struct mm_struct *mm,
@@ -482,9 +483,13 @@ static int create_elf_fdpic_tables(struct linux_binprm *bprm,
 	int loop;
 	int nr;	/* reset for each csp adjustment */
 
-	/* we're going to shovel a whole load of stuff onto the stack */
 #ifdef CONFIG_MMU
-	sp = bprm->p;
+	/* In some cases (e.g. Hyper-Threading), we want to avoid L1 evictions
+	 * by the processes running on the same package. One thing we can do is
+	 * to shuffle the initial stack for them, so we give the architecture
+	 * an opportunity to do so here.
+	 */
+	sp = arch_align_stack(bprm->p);
 #else
 	sp = mm->start_stack;
 
@@ -527,20 +532,6 @@ static int create_elf_fdpic_tables(struct linux_binprm *bprm,
 			return -EFAULT;
 	}
 
-#if defined(__i386__) && defined(CONFIG_SMP)
-	/* in some cases (e.g. Hyper-Threading), we want to avoid L1 evictions
-	 * by the processes running on the same package. One thing we can do is
-	 * to shuffle the initial stack for them.
-	 *
-	 * the conditionals here are unneeded, but kept in to make the code
-	 * behaviour the same as pre change unless we have hyperthreaded
-	 * processors. This keeps Mr Marcelo Person happier but should be
-	 * removed for 2.5
-	 */
-	if (smp_num_siblings > 1)
-		sp = sp - ((current->pid % 64) << 7);
-#endif
-
 	sp &= ~7UL;
 
 	/* stack the load map(s) */
