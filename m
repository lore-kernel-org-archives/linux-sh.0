From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 28 Jul 2008 11:57:35 +0000
Subject: kill include symlinks for sh?
Message-Id: <20080728115735.GA32089@uranus.ravnborg.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@linux-sh.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kbuild <linux-kbuild@vger.kernel.org>

Hi Paul.

Now that kbuild has proper support for
include/$ARCH/* maybe this is a good time
to kill the use of symlinks for sh?

The idea is to do the following:
1) move all cpu specific directories to:
   arch/sh/include/$CPU/cpu

   then we can continue to use "#include <cpu/foo.h>" if
   we just tell gcc to pick up include
   files in the correct directory.

2) move all mach specific directories to:
   arch/sh/$ARCH/mach

   then we can continue to use "#include <mach/foo.h>
   But this does NOT address the mach's that relied on
   the mach symlink that pointed one level below.
   I do not know how big his issue is.

3) move remaining header files to
   arch/sh/include/asm

4) adjust arch/sh/Makefile

   Test and enjoy....

I do not have sh toolchina on this box so I have
not tried to do a full patch myself. And the mach stuff
obviously worries me with the link to the parent directory.

But apart form this is is simple. See below for my take on it.
You can put an
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
or
Acked-by: Sam Ravnborg <sam@ravnborg.org>

as you like on the final patch.

Questions / comments are welcome.

PS. sparc is the first to use arch/$ARCH/include and will
hit -linus soon,
	Sam

To complete step 1) to 3) the following script can
be used:
# CPU dirs
mkdir -p arch/sh/include/cpu-sh2/cpu
mkdir -p arch/sh/include/cpu-sh2a/cpu
mkdir -p arch/sh/include/cpu-sh3/cpu
mkdir -p arch/sh/include/cpu-sh4/cpu
mkdir -p arch/sh/include/cpu-sh5/cpu

git mv include/asm-sh/cpu-sh2 arch/sh/include/cpu-sh2/cpu
git mv include/asm-sh/cpu-sh2a arch/sh/include/cpu-sh2a/cpu
git mv include/asm-sh/cpu-sh3 arch/sh/include/cpu-sh3/cpu
git mv include/asm-sh/cpu-sh4 arch/sh/include/cpu-sh4/cpu
git mv include/asm-sh/cpu-sh5 arch/sh/include/cpu-sh5/cpu

# mach dirs
mkdir -p arch/sh/include/dreamcast/mach
mkdir -p arch/sh/include/landisk/mach
mkdir -p arch/sh/include/hd64465/mach
mkdir -p arch/sh/include/sh03/mach

git mv include/asm-sh/dreamcast arch/sh/include/dreamcast/mach
git mv include/asm-sh/landisk arch/sh/include/landisk/mach
git mv include/asm-sh/hd64465 arch/sh/include/hd64465/mach
git mv include/asm-sh/sh03 arch/sh/include/sh03/mach

# asm-sh header files
mkdir -p arch/sh/include/asm
git mv include/asm-sh arch/sh/include/asm

Step 4) is the following patch:
diff --git a/arch/sh/Makefile b/arch/sh/Makefile
index fb7b1b1..7a514a6 100644
--- a/arch/sh/Makefile
+++ b/arch/sh/Makefile
@@ -156,52 +156,8 @@ drivers-$(CONFIG_OPROFILE)	+= arch/sh/oprofile/
 
 boot := arch/sh/boot
 
-ifneq ($(KBUILD_SRC),)
-incdir-prefix	:= $(srctree)/include/asm-sh/
-else
-incdir-prefix	:-endif
-
-#	Update machine arch and proc symlinks if something which affects
-#	them changed.  We use .arch and .mach to indicate when they were
-#	updated last, otherwise make uses the target directory mtime.
-
-include/asm-sh/.cpu: $(wildcard include/config/cpu/*.h) \
-		     include/config/auto.conf FORCE
-	@echo '  SYMLINK include/asm-sh/cpu -> include/asm-sh/$(cpuincdir-y)'
-	$(Q)if [ ! -d include/asm-sh ]; then mkdir -p include/asm-sh; fi
-	$(Q)ln -fsn $(incdir-prefix)$(cpuincdir-y) include/asm-sh/cpu
-	@touch $@
-
-#	Most boards have their own mach directories.  For the ones that
-#	don't, just reference the parent directory so the semantics are
-#	kept roughly the same.
-#
-#	When multiple boards are compiled in at the same time, preference
-#	for the mach link is given to whichever has a directory for its
-#	headers. However, this is only a workaround until platforms that
-#	can live in the same kernel image back away from relying on the
-#	mach link.
-
-include/asm-sh/.mach: $(wildcard include/config/sh/*.h) \
-		      include/config/auto.conf FORCE
-	$(Q)if [ ! -d include/asm-sh ]; then mkdir -p include/asm-sh; fi
-	$(Q)rm -f include/asm-sh/mach
-	$(Q)for i in $(incdir-y); do \
-	if [ -d $(srctree)/include/asm-sh/$$i ]; then \
-		echo -n '  SYMLINK include/asm-sh/mach -> '; \
-		echo -e "include/asm-sh/$$i"; \
-		ln -fsn $(incdir-prefix)$$i \
-			include/asm-sh/mach; \
-	else \
-		if [ ! -d include/asm-sh/mach ]; then \
-			echo -n '  SYMLINK include/asm-sh/mach -> '; \
-			echo -e 'include/asm-sh'; \
-			ln -fsn $(incdir-prefix)../asm-sh include/asm-sh/mach; \
-		fi; \
-	fi; \
-	done
-	@touch $@
+KBUILD_CFLAGS += -Iarch/sh/include/$(cpuincdir-y)
+KBUILD_CFLAGS += $(foreach d, $(incdir-y), -Iarch/sh/include/$(d))
 
 PHONY += maketools FORCE
 
@@ -215,8 +171,7 @@ zImage uImage uImage.srec vmlinux.srec: vmlinux
 
 compressed: zImage
 
-archprepare: include/asm-sh/.cpu include/asm-sh/.mach maketools \
-	     arch/sh/lib64/syscalltab.h
+archprepare: maketools arch/sh/lib64/syscalltab.h
 
 archclean:
 	$(Q)$(MAKE) $(clean)=$(boot)
