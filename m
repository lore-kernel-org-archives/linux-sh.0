From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 11 May 2009 08:49:45 +0000
Subject: [PATCH] sh: clean vsyscall files
Message-Id: <20090511084945.32420.29345.sendpatchset@rx1.opensource.se>
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

 arch/sh/Makefile                 |    1 +
 arch/sh/kernel/vsyscall/Makefile |    2 ++
 2 files changed, 3 insertions(+)

--- 0001/arch/sh/Makefile
+++ work/arch/sh/Makefile	2009-05-11 13:58:05.000000000 +0900
@@ -204,6 +204,7 @@ archprepare: maketools
 
 archclean:
 	$(Q)$(MAKE) $(clean)=$(boot)
+	$(Q)$(MAKE) $(clean)=arch/sh/kernel/vsyscall
 
 define archhelp
 	@echo '* zImage 	           - Compressed kernel image'
--- 0001/arch/sh/kernel/vsyscall/Makefile
+++ work/arch/sh/kernel/vsyscall/Makefile	2009-05-11 13:59:04.000000000 +0900
@@ -34,3 +34,5 @@ SYSCFLAGS_vsyscall-syms.o = -r
 $(obj)/vsyscall-syms.o: $(src)/vsyscall.lds \
 			$(obj)/vsyscall-trapa.o $(obj)/vsyscall-note.o FORCE
 	$(call if_changed,syscall)
+
+MRPROPER_FILES += $(obj)/vsyscall-trapa.so $(obj)/vsyscall.lds
