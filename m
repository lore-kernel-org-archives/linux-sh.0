From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 26 Oct 2009 10:30:48 +0000
Subject: [PATCH] sh: fix kexec by removing check for old kexec-tools
Message-Id: <20091026103048.24085.71003.sendpatchset@rxone.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

This unbreaks kexec support. Without this fix all
cases of kexec fails since __pa() does not behave
like PHYSADDR(). The downside is that we also kill
the code blocking users running old kexec-tools.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/kernel/machine_kexec.c |    6 ------
 1 file changed, 6 deletions(-)

--- 0001/arch/sh/kernel/machine_kexec.c
+++ work/arch/sh/kernel/machine_kexec.c	2009-10-26 19:15:04.000000000 +0900
@@ -46,12 +46,6 @@ void machine_crash_shutdown(struct pt_re
  */
 int machine_kexec_prepare(struct kimage *image)
 {
-	/* older versions of kexec-tools are passing
-	 * the zImage entry point as a virtual address.
-	 */
-	if (image->start != __pa(image->start))
-		return -EINVAL; /* upgrade your kexec-tools */
-
 	return 0;
 }
 
