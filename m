From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 08 Jul 2014 21:32:24 +0000
Subject: [PATCH] sh: Also try passing -m4-nofpu for SH2A builds
Message-Id: <1404855144-24439-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Tony Breeds <tony@bakeyournoodle.com>, Alexei Starovoitov <ast@plumgrid.com>, Fengguang Wu <fengguang.wu@intel.com>, Daniel Borkmann <dborkman@redhat.com>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

When compiling a SH2A kernel (e.g. se7206_defconfig or rsk7203_defconfig)
using sh4-linux-gcc, linking fails with:

net/built-in.o: In function `__sk_run_filter':
net/core/filter.c:566: undefined reference to `__fpscr_values'
net/core/filter.c:269: undefined reference to `__fpscr_values'
net/core/filter.c:269: undefined reference to `__fpscr_values'
net/core/filter.c:269: undefined reference to `__fpscr_values'
net/core/filter.c:269: undefined reference to `__fpscr_values'
net/built-in.o:net/core/filter.c:580: more undefined references to `__fpscr_values' follow

This happens because sh4-linux-gcc doesn't support the "-m2a-nofpu", which
is thus filtered out by "$(call cc-option, ...)".

As compiling using sh4-linux-gcc is useful for compile coverage, also try
passing "-m4-nofpu" (which is presumably filtered out when using a real
sh2a-linux toolchain) to disable the generation of FPU instructions and
references to __fpscr_values[].

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/sh/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/sh/Makefile b/arch/sh/Makefile
index d4d16e4be07c..bf5b3f5f4962 100644
--- a/arch/sh/Makefile
+++ b/arch/sh/Makefile
@@ -32,7 +32,8 @@ endif
 
 cflags-$(CONFIG_CPU_SH2)		:= $(call cc-option,-m2,)
 cflags-$(CONFIG_CPU_SH2A)		+= $(call cc-option,-m2a,) \
-					   $(call cc-option,-m2a-nofpu,)
+					   $(call cc-option,-m2a-nofpu,) \
+					   $(call cc-option,-m4-nofpu,)
 cflags-$(CONFIG_CPU_SH3)		:= $(call cc-option,-m3,)
 cflags-$(CONFIG_CPU_SH4)		:= $(call cc-option,-m4,) \
 	$(call cc-option,-mno-implicit-fp,-m4-nofpu)
-- 
1.9.1

