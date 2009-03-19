From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 19 Mar 2009 10:04:29 +0000
Subject: [PATCH] sh: disallow kexec virtual entry
Message-Id: <20090319100429.9817.21412.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Older versions of kexec-tools has a zImage loader that
passes a virtual address as entry point. The elf loader
otoh it passes a physical address as entry point, and
pages are always passed as physical addresses as well.

Only allow physical addresses from now on.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/kernel/machine_kexec.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- 0001/arch/sh/kernel/machine_kexec.c
+++ work/arch/sh/kernel/machine_kexec.c	2009-03-18 20:25:56.000000000 +0900
@@ -46,6 +46,12 @@ void machine_crash_shutdown(struct pt_re
  */
 int machine_kexec_prepare(struct kimage *image)
 {
+	/* older versions of kexec-tools are passing
+	 * the zImage entry point as a virtual address.
+	 */
+	if (image->start != PHYSADDR(image->start))
+		return -EINVAL; /* upgrade your kexec-tools */
+
 	return 0;
 }
 
@@ -125,7 +131,8 @@ void machine_kexec(struct kimage *image)
 
 	/* now call it */
 	rnk = (relocate_new_kernel_t) reboot_code_buffer;
-	(*rnk)(page_list, reboot_code_buffer, image->start);
+	(*rnk)(page_list, reboot_code_buffer,
+	       (unsigned long)phys_to_virt(image->start));
 
 #ifdef CONFIG_KEXEC_JUMP
 	asm volatile("ldc %0, vbr" : : "r" (&vbr_base) : "memory");
