From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 27 Aug 2008 09:19:01 +0000
Subject: [PATCH] sh: fix kexec entry point for crash kernels
Message-Id: <20080827091901.9103.63305.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

The crash kernel entry point is currently checked by the kexec kernel
code and only physical addresses in the reserved memory window are
accepted. This means that we can't pass P2 or P1 addresses as entry
points in the case of crash kernels. This patch makes sure we can start
crash kernels by adding support for physical address entry points.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/kernel/machine_kexec.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 0001/arch/sh/kernel/machine_kexec.c
+++ work/arch/sh/kernel/machine_kexec.c	2008-08-25 19:31:39.000000000 +0900
@@ -102,7 +102,7 @@ void machine_kexec(struct kimage *image)
 
 	/* now call it */
 	rnk = (relocate_new_kernel_t) reboot_code_buffer;
-	(*rnk)(page_list, reboot_code_buffer, image->start, vbr_reg);
+	(*rnk)(page_list, reboot_code_buffer, P2SEGADDR(image->start), vbr_reg);
 }
 
 void arch_crash_save_vmcoreinfo(void)
