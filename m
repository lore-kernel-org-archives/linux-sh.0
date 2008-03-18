From: Franck Bui-Huu <vagabon.xyz@gmail.com>
Date: Tue, 18 Mar 2008 19:04:06 +0000
Subject: Re: [PATCH] Use relative path when creating include/asm/{mach,cpu}
Message-Id: <47E01226.3050504@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <47DEC594.6010502@gmail.com>
In-Reply-To: <47DEC594.6010502@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Franck Bui-Huu wrote:
> Well it should be pretty trivial to make this patch works both cases
> although it can't be called a "clean up" patch.
> 

and here's an updated patch, which should work for both cases.

It's pretty simple and not very intrusive so it could be a temporary fix
until the massive header reorganization happen.

		Franck

---8<---

Subject: [PATCH] Use relative path when creating include/asm/{mach,cpu} symlinks when possible

From: Franck Bui-Huu <fbuihuu@gmail.com>

When building the kernel without passing the O= command line parameter
there's no point to use absolute paths for them.

Usually relative paths are preferred because they survive directory
moves, work across networked file systems and chrooted environments.

Absolute paths are still used if an output directory is given.

Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
---
 arch/sh/Makefile |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/sh/Makefile b/arch/sh/Makefile
index c510c22..cffc92b 100644
--- a/arch/sh/Makefile
+++ b/arch/sh/Makefile
@@ -154,7 +154,11 @@ drivers-$(CONFIG_OPROFILE)	+= arch/sh/oprofile/
 
 boot := arch/sh/boot
 
+ifneq ($(KBUILD_SRC),)
 incdir-prefix	:= $(srctree)/include/asm-sh/
+else
+incdir-prefix	:+endif
 
 #	Update machine arch and proc symlinks if something which affects
 #	them changed.  We use .arch and .mach to indicate when they were
@@ -182,7 +186,7 @@ include/asm-sh/.mach: $(wildcard include/config/sh/*.h) \
 	$(Q)if [ ! -d include/asm-sh ]; then mkdir -p include/asm-sh; fi
 	$(Q)rm -f include/asm-sh/mach
 	$(Q)for i in $(incdir-y); do \
-	if [ -d $(incdir-prefix)$$i ]; then \
+	if [ -d $(srctree)/include/asm-sh/$$i ]; then \
 		echo -n '  SYMLINK include/asm-sh/mach -> '; \
 		echo -e "include/asm-sh/$$i"; \
 		ln -fsn $(incdir-prefix)$$i \
@@ -191,7 +195,7 @@ include/asm-sh/.mach: $(wildcard include/config/sh/*.h) \
 		if [ ! -d include/asm-sh/mach ]; then \
 			echo -n '  SYMLINK include/asm-sh/mach -> '; \
 			echo -e 'include/asm-sh'; \
-			ln -fsn $(incdir-prefix) include/asm-sh/mach; \
+			ln -fsn $(incdir-prefix)../asm-sh include/asm-sh/mach; \
 		fi; \
 	fi; \
 	done
-- 
1.5.4.4.GIT

