From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 12 May 2009 10:08:07 +0000
Subject: [PATCH] sh: clean vsyscall files V2
Message-Id: <20090512100807.25601.56979.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Fix so vsyscall-trapa.so and vsyscall.lds get
removed with a make distclean.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 Changes since V1:
 - use CLEAN_FILES instead of MRPROPER_FILES

 arch/sh/Makefile                 |    1 +
 arch/sh/kernel/vsyscall/Makefile |    2 ++
 2 files changed, 3 insertions(+)

--- 0001/arch/sh/Makefile
+++ work/arch/sh/Makefile	2009-05-12 14:12:09.000000000 +0900
@@ -204,6 +204,7 @@ archprepare: maketools
 
 archclean:
 	$(Q)$(MAKE) $(clean)=$(boot)
+	$(Q)$(MAKE) $(clean)=arch/sh/kernel/vsyscall
 
 define archhelp
 	@echo '* zImage 	           - Compressed kernel image'
--- 0001/arch/sh/kernel/vsyscall/Makefile
+++ work/arch/sh/kernel/vsyscall/Makefile	2009-05-12 14:12:35.000000000 +0900
@@ -34,3 +34,5 @@ SYSCFLAGS_vsyscall-syms.o = -r
 $(obj)/vsyscall-syms.o: $(src)/vsyscall.lds \
 			$(obj)/vsyscall-trapa.o $(obj)/vsyscall-note.o FORCE
 	$(call if_changed,syscall)
+
+CLEAN_FILES += $(obj)/vsyscall-trapa.so $(obj)/vsyscall.lds
