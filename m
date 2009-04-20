From: SUGIOKA Toshinobu <sugioka@itonet.co.jp>
Date: Mon, 20 Apr 2009 21:48:43 +0000
Subject: [PATCH] fix mmap2 syscall
Message-Id: <4.2.0.58.J.20090421052216.0362b680@router.itonet.co.jp>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi,

Last argument of mmap2 system call is always (offset >> 12) in glibc regardless of the PAGE_SIZE,
but do_mmap_pgoff function requires 'pgoff' parameter which is shifted by real PAGE_SHIFT.
So, we should adjust this argument if page size is not equal to 4k byte.

Signed-off-by: Toshinobu Sugioka <sugioka@itonet.co.jp>

diff --git a/arch/sh/kernel/sys_sh.c b/arch/sh/kernel/sys_sh.c
index 58dfc02..15a56be 100644
--- a/arch/sh/kernel/sys_sh.c
+++ b/arch/sh/kernel/sys_sh.c
@@ -63,7 +63,9 @@ asmlinkage long sys_mmap2(unsigned long addr, unsigned long len,
 	unsigned long prot, unsigned long flags,
 	unsigned long fd, unsigned long pgoff)
 {
-	return do_mmap2(addr, len, prot, flags, fd, pgoff);
+	/* Make sure the shift for mmap2 is constant (12), no matter what PAGE_SIZE
+	   we have. */
+	return do_mmap2(addr, len, prot, flags, fd, pgoff >> (PAGE_SHIFT - 12));
 }
 
 /*


SUGIOKA Toshinobu

