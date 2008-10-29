From: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
Date: Wed, 29 Oct 2008 04:31:58 +0000
Subject: [PATCH] sh: Add '-up' to ISA flag if enable SH3
Message-Id: <4907E73E.9050905@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

By commit of b2d86a3fd9855380598c0c039e712a20086e119f, compilation of SH3 fails.
In current binutils, "pref" opcode is not support SH3. However, it is supported.
Please validate this flag till fix binutils.

Signed-off-by: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
---
 arch/sh/Makefile |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/sh/Makefile b/arch/sh/Makefile
index 3a74ed6..b2d46a6 100644
--- a/arch/sh/Makefile
+++ b/arch/sh/Makefile
@@ -20,6 +20,10 @@ isa-$(CONFIG_CPU_SH4AL_DSP)		:= sh4al
 isa-$(CONFIG_CPU_SH5)			:= shmedia
 isa-$(CONFIG_SH_DSP)			:= $(isa-y)-dsp

+ifdef CONFIG_CPU_SH3
+isa-y	:= $(isa-y)-up
+endif
+
 cflags-$(CONFIG_CPU_SH2)		:= $(call cc-option,-m2,)
 cflags-$(CONFIG_CPU_SH2A)		+= $(call cc-option,-m2a,) \
 					   $(call cc-option,-m2a-nofpu,)
-- 
1.5.6.5
