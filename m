From: Franck Bui-Huu <vagabon.xyz@gmail.com>
Date: Mon, 17 Mar 2008 19:25:08 +0000
Subject: [PATCH] Use relative path when creating include/asm/{mach,cpu} symlinks
Message-Id: <47DEC594.6010502@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Franck Bui-Huu <fbuihuu@gmail.com>

Usually relative paths are preferred because they survive directory
moves, work across networked file systems/chrooted environments.

And in this case, there's no point to use absolute paths.

Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
---
 arch/sh/Makefile |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/sh/Makefile b/arch/sh/Makefile
index c510c22..14b39b1 100644
--- a/arch/sh/Makefile
+++ b/arch/sh/Makefile
@@ -164,7 +164,7 @@ include/asm-sh/.cpu: $(wildcard include/config/cpu/*.h) \
 		     include/config/auto.conf FORCE
 	@echo '  SYMLINK include/asm-sh/cpu -> include/asm-sh/$(cpuincdir-y)'
 	$(Q)if [ ! -d include/asm-sh ]; then mkdir -p include/asm-sh; fi
-	$(Q)ln -fsn $(incdir-prefix)$(cpuincdir-y) include/asm-sh/cpu
+	$(Q)ln -fsn $(cpuincdir-y) include/asm-sh/cpu
 	@touch $@
 
 #	Most boards have their own mach directories.  For the ones that
@@ -185,13 +185,12 @@ include/asm-sh/.mach: $(wildcard include/config/sh/*.h) \
 	if [ -d $(incdir-prefix)$$i ]; then \
 		echo -n '  SYMLINK include/asm-sh/mach -> '; \
 		echo -e "include/asm-sh/$$i"; \
-		ln -fsn $(incdir-prefix)$$i \
-			include/asm-sh/mach; \
+		ln -fsn $$i include/asm-sh/mach; \
 	else \
 		if [ ! -d include/asm-sh/mach ]; then \
 			echo -n '  SYMLINK include/asm-sh/mach -> '; \
 			echo -e 'include/asm-sh'; \
-			ln -fsn $(incdir-prefix) include/asm-sh/mach; \
+			ln -fsn ../asm-sh include/asm-sh/mach; \
 		fi; \
 	fi; \
 	done
-- 
1.5.4.4.GIT

