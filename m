From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Thu, 22 Feb 2018 09:13:59 +0000
Subject: [PATCH] sh: ptrace: remove a bogus check
Message-Id: <20180222091359.GB9883@mwanda>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

We made "addr" unsigned back in 2010 in commit 9b05a69e0534 ("ptrace:
change signature of arch_ptrace()").  The check for negatives was always
just a basic sanity check that duplicated other stricter checks, but now
it causes static checker warnings so we should remove it.

Here is the Smatch warning for reference:

    arch/sh/kernel/ptrace_64.c:399 arch_ptrace()
    warn: unsigned 'addr' is never less than zero.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/arch/sh/kernel/ptrace_64.c b/arch/sh/kernel/ptrace_64.c
index 1e0656d9e7af..b38d53be168a 100644
--- a/arch/sh/kernel/ptrace_64.c
+++ b/arch/sh/kernel/ptrace_64.c
@@ -396,7 +396,7 @@ long arch_ptrace(struct task_struct *child, long request,
 		unsigned long tmp;
 
 		ret = -EIO;
-		if ((addr & 3) || addr < 0)
+		if (addr & 3)
 			break;
 
 		if (addr < sizeof(struct pt_regs))
@@ -424,7 +424,7 @@ long arch_ptrace(struct task_struct *child, long request,
                    this could crash the kernel or result in a security
                    loophole. */
 		ret = -EIO;
-		if ((addr & 3) || addr < 0)
+		if (addr & 3)
 			break;
 
 		if (addr < sizeof(struct pt_regs)) {
