From: Yoshinori Sato <ysato@users.sourceforge.jp>
Date: Mon, 07 Mar 2016 13:50:02 +0000
Subject: [PATCH] sh: Disable trace for kernel uncompressing.
Message-Id: <1457358603-9579-1-git-send-email-ysato@users.sourceforge.jp>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 arch/sh/boot/compressed/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/boot/compressed/Makefile b/arch/sh/boot/compressed/Makefile
index 23bc849..6df826e 100644
--- a/arch/sh/boot/compressed/Makefile
+++ b/arch/sh/boot/compressed/Makefile
@@ -48,7 +48,7 @@ ifeq ($(BITS),64)
 	lib1funcs-dir 	:= $(addsuffix $(BITS), $(lib1funcs-dir))
 endif
 
-KBUILD_CFLAGS += -I$(lib1funcs-dir)
+KBUILD_CFLAGS += -I$(lib1funcs-dir) -DDISABLE_BRANCH_PROFILING
 
 $(addprefix $(obj)/,$(lib1funcs-y)): $(obj)/%: $(lib1funcs-dir)/% FORCE
 	$(call cmd,shipped)
-- 
2.7.0

