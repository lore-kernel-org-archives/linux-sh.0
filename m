From: Yoshinori Sato <ysato@users.sourceforge.jp>
Date: Wed, 29 Jun 2016 13:41:03 +0000
Subject: [PATCH v4 18/22] sh: Add separate DTB build rule
Message-Id: <1467207667-15768-19-git-send-email-ysato@users.sourceforge.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <1467207667-15768-1-git-send-email-ysato@users.sourceforge.jp>
In-Reply-To: <1467207667-15768-1-git-send-email-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>

Changes v4
none

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 arch/sh/Makefile          | 7 +++++++
 arch/sh/boot/dts/Makefile | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/arch/sh/Makefile b/arch/sh/Makefile
index 8adffa8..a44e630 100644
--- a/arch/sh/Makefile
+++ b/arch/sh/Makefile
@@ -189,6 +189,13 @@ drivers-$(CONFIG_OPROFILE)	+= arch/sh/oprofile/
 
 boot := arch/sh/boot
 
+%.dtb %.dtb.S %.dtb.o: | scripts
+	$(Q)$(MAKE) $(build)=arch/sh/boot/dts arch/sh/boot/dts/$@
+
+PHONY += dtbs
+dtbs: scripts
+	$(Q)$(MAKE) $(build)=arch/sh/boot/dts
+
 cflags-y	+= $(foreach d, $(cpuincdir-y), -Iarch/sh/include/$(d)) \
 		   $(foreach d, $(machdir-y), -Iarch/sh/include/$(d))
 
diff --git a/arch/sh/boot/dts/Makefile b/arch/sh/boot/dts/Makefile
index e5ce3a0..38fdc38 100644
--- a/arch/sh/boot/dts/Makefile
+++ b/arch/sh/boot/dts/Makefile
@@ -1,3 +1,5 @@
 obj-$(CONFIG_USE_BUILTIN_DTB) += $(patsubst "%",%,$(CONFIG_BUILTIN_DTB_SOURCE)).dtb.o
 
+dtstree		:= $(srctree)/$(src)
 clean-files := *.dtb.S
+always	    := $(dtb-y)
-- 
2.7.0

