From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 19 Feb 2015 02:13:11 +0000
Subject: [PATCH] x86/vdso: Remove all generated files during clean
Message-Id: <20150219021311.24366.75477.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: luto@amacapital.net
Cc: linux-sh@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, hpa@zytor.com, Magnus Damm <magnus.damm@gmail.com>, tglx@linutronix.de

From: Magnus Damm <damm+renesas@opensource.se>

Make sure the following files are removed as expected during "make clean":
 + arch/x86/vdso/vdso-image-32-int80.c
 + arch/x86/vdso/vdso-image-32-syscall.c
 + arch/x86/vdso/vdso-image-32-sysenter.c
 + arch/x86/vdso/vdso-image-64.c

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 arch/x86/vdso/Makefile |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- 0001/arch/x86/vdso/Makefile
+++ work/arch/x86/vdso/Makefile	2015-02-19 10:50:15.975470639 +0900
@@ -1,3 +1,4 @@
+
 #
 # Building vDSO images for x86.
 #
@@ -206,4 +207,5 @@ $(vdso_img_insttargets): install_%: $(ob
 PHONY += vdso_install $(vdso_img_insttargets)
 vdso_install: $(vdso_img_insttargets) FORCE
 
-clean-files := vdso32-syscall* vdso32-sysenter* vdso32-int80* vdso64*
+clean-files := vdso32-syscall* vdso32-sysenter* vdso32-int80* vdso64* \
+               vdso-image-32* vdso-image-64*
