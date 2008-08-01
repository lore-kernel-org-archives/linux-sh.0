From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 01 Aug 2008 21:53:38 +0000
Subject: Re: sh O= builds broken
Message-Id: <20080801215338.GC13448@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080801212728.GF19682@cs181140183.pp.htv.fi>
In-Reply-To: <20080801212728.GF19682@cs181140183.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian Bunk <bunk@kernel.org>
Cc: sam@ravnborg.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, Aug 02, 2008 at 12:27:28AM +0300, Adrian Bunk wrote:
> Most likely caused by the headers move:
> 
> <--  snip  -->
> 
> ...
>   CC      init/main.o
> In file included from /home/bunk/linux/kernel-2.6/git/linux-2.6/arch/sh/include/asm/irq.h:4,
>                  from /home/bunk/linux/kernel-2.6/git/linux-2.6/include/linux/irq.h:23,
>                  from /home/bunk/linux/kernel-2.6/git/linux-2.6/arch/sh/include/asm/hardirq.h:5,
>                  from /home/bunk/linux/kernel-2.6/git/linux-2.6/include/linux/hardirq.h:7,
>                  from /home/bunk/linux/kernel-2.6/git/linux-2.6/include/asm-generic/local.h:5,
>                  from /home/bunk/linux/kernel-2.6/git/linux-2.6/arch/sh/include/asm/local.h:4,
>                  from /home/bunk/linux/kernel-2.6/git/linux-2.6/include/linux/module.h:19,
>                  from /home/bunk/linux/kernel-2.6/git/linux-2.6/init/main.c:13:
> /home/bunk/linux/kernel-2.6/git/linux-2.6/arch/sh/include/asm/machvec.h:15:27: 
> error: asm/machtypes.h: No such file or directory
> make[2]: *** [init/main.o] Error 1
> 
> <--  snip  -->
> 
Ok, so this is what I get for moving the auto-generated header outside of
include/asm-sh.. it seemed like a good idea at the time.

---

diff --git a/arch/sh/Makefile b/arch/sh/Makefile
index 25659ce..7b70cfd 100644
--- a/arch/sh/Makefile
+++ b/arch/sh/Makefile
@@ -164,7 +164,7 @@ KBUILD_AFLAGS		+= $(cflags-y)
 PHONY += maketools FORCE
 
 maketools:  include/linux/version.h FORCE
-	$(Q)$(MAKE) $(build)=arch/sh/tools arch/sh/include/asm/machtypes.h
+	$(Q)$(MAKE) $(build)=arch/sh/tools include/asm-sh/machtypes.h
 
 all: $(KBUILD_IMAGE)
 
@@ -215,4 +215,4 @@ arch/sh/lib64/syscalltab.h: arch/sh/kernel/syscalls_64.S
 	$(call filechk,gen-syscalltab)
 
 CLEAN_FILES += arch/sh/lib64/syscalltab.h \
-	       arch/sh/include/asm/machtypes.h
+	       include/asm-sh/machtypes.h
diff --git a/arch/sh/tools/Makefile b/arch/sh/tools/Makefile
index b5d202b..567516b 100644
--- a/arch/sh/tools/Makefile
+++ b/arch/sh/tools/Makefile
@@ -10,7 +10,7 @@
 # Shamelessly cloned from ARM.
 #
 
-arch/sh/include/asm/machtypes.h: $(src)/gen-mach-types $(src)/mach-types
+include/asm-sh/machtypes.h: $(src)/gen-mach-types $(src)/mach-types
 	@echo '  Generating $@'
-	$(Q)if [ ! -d arch/sh/include/asm ]; then mkdir -p arch/sh/include/asm; fi
+	$(Q)if [ ! -d include/asm-sh ]; then mkdir -p include/asm-sh; fi
 	$(Q)$(AWK) -f $^ > $@ || { rm -f $@; /bin/false; }
