From: Yoshinori Sato <ysato@users.sourceforge.jp>
Date: Sun, 12 Jun 2016 06:54:26 +0000
Subject: [PATCH v2 08/17] sh: Disable board specific code on device tree mode
Message-Id: <1465714475-24111-9-git-send-email-ysato@users.sourceforge.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <1465714475-24111-1-git-send-email-ysato@users.sourceforge.jp>
In-Reply-To: <1465714475-24111-1-git-send-email-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 arch/sh/Makefile                | 2 ++
 arch/sh/kernel/cpu/sh4/Makefile | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/sh/Makefile b/arch/sh/Makefile
index 3b2c8b4..8adffa8 100644
--- a/arch/sh/Makefile
+++ b/arch/sh/Makefile
@@ -132,6 +132,7 @@ core-$(CONFIG_SH_FPU_EMU)	+= arch/sh/math-emu/
 
 core-$(CONFIG_USE_BUILTIN_DTB)	+= arch/sh/boot/dts/
 
+ifneq ($(CONFIG_SH_DEVICE_TREE),y)
 # Mach groups
 machdir-$(CONFIG_SOLUTION_ENGINE)		+= mach-se
 machdir-$(CONFIG_SH_HP6XX)			+= mach-hp6xx
@@ -152,6 +153,7 @@ machdir-$(CONFIG_SH_LANDISK)			+= mach-landisk
 machdir-$(CONFIG_SH_LBOX_RE2)			+= mach-lboxre2
 machdir-$(CONFIG_SH_CAYMAN)			+= mach-cayman
 machdir-$(CONFIG_SH_RSK)			+= mach-rsk
+endif
 
 ifneq ($(machdir-y),)
 core-y	+= $(addprefix arch/sh/boards/, \
diff --git a/arch/sh/kernel/cpu/sh4/Makefile b/arch/sh/kernel/cpu/sh4/Makefile
index 3a1dbc7..b822c0c 100644
--- a/arch/sh/kernel/cpu/sh4/Makefile
+++ b/arch/sh/kernel/cpu/sh4/Makefile
@@ -14,6 +14,7 @@ perf-$(CONFIG_CPU_SUBTYPE_SH7750)	:= perf_event.o
 perf-$(CONFIG_CPU_SUBTYPE_SH7750S)	:= perf_event.o
 perf-$(CONFIG_CPU_SUBTYPE_SH7091)	:= perf_event.o
 
+ifndef CONFIG_OF
 # CPU subtype setup
 obj-$(CONFIG_CPU_SUBTYPE_SH7750)	+= setup-sh7750.o
 obj-$(CONFIG_CPU_SUBTYPE_SH7750R)	+= setup-sh7750.o
@@ -31,6 +32,7 @@ endif
 
 # Additional clocks by subtype
 clock-$(CONFIG_CPU_SUBTYPE_SH4_202)	+= clock-sh4-202.o
+endif
 
 obj-y					+= $(clock-y)
 obj-$(CONFIG_PERF_EVENTS)		+= $(perf-y)
-- 
2.7.0

