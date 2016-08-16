From: Jason Cooper <jason@lakedaemon.net>
Date: Tue, 16 Aug 2016 15:41:40 +0000
Subject: [PATCH] sh: Fix building j2_defconfig
Message-Id: <20160816154140.25022-1-jason@lakedaemon.net>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rich Felker <dalias@libc.org>, Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <marc.zyngier@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>

When targeting the j2, we need to retain '-m2'.  Previously, the
Makefile blew out -m2 on the next line via :=.

Fix this by s/:=/+=/ when building for the J2.

Fixes: 5a846abad07f6 ("sh: add support for J-Core J2 processor")
Signed-off-by: Jason Cooper <jason@lakedaemon.net>
---
Thanks to Richard Felker for helping me locate the problem.

 arch/sh/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/Makefile b/arch/sh/Makefile
index 00476662ac2c..336f33a419d9 100644
--- a/arch/sh/Makefile
+++ b/arch/sh/Makefile
@@ -31,7 +31,7 @@ isa-y					:= $(isa-y)-up
 endif
 
 cflags-$(CONFIG_CPU_SH2)		:= $(call cc-option,-m2,)
-cflags-$(CONFIG_CPU_J2)			:= $(call cc-option,-mj2,)
+cflags-$(CONFIG_CPU_J2)			+= $(call cc-option,-mj2,)
 cflags-$(CONFIG_CPU_SH2A)		+= $(call cc-option,-m2a,) \
 					   $(call cc-option,-m2a-nofpu,) \
 					   $(call cc-option,-m4-nofpu,)
-- 
2.9.3

