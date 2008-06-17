From: Adrian Bunk <bunk@kernel.org>
Date: Tue, 17 Jun 2008 22:30:53 +0000
Subject: [2.6 patch] move arch/sh/lib/io.o to obj-y
Message-Id: <20080617223053.GJ25911@cs181133002.pp.htv.fi>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lethal@linux-sh.org
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

EXPORT_SYMBOL's in lib-y considered harmful:

<--  snip  -->

...
  MODPOST 1837 modules
ERROR: "__raw_readsl" [drivers/ssb/ssb.ko] undefined!
ERROR: "__raw_writesl" [drivers/ssb/ssb.ko] undefined!
ERROR: "__raw_writesl" [drivers/net/smc91x.ko] undefined!
ERROR: "__raw_readsl" [drivers/net/smc91x.ko] undefined!
ERROR: "__raw_writesl" [drivers/net/3c59x.ko] undefined!
ERROR: "__raw_readsl" [drivers/net/3c59x.ko] undefined!
...
make[2]: *** [__modpost] Error 1

<--  snip  -->

Reported-by: Adrian Bunk <bunk@kernel.org>
Signed-off-by: Adrian Bunk <bunk@kernel.org>

---

b4dec4046b4e491c0ad2cb1046699f22d635fcab diff --git a/arch/sh/lib/Makefile b/arch/sh/lib/Makefile
index 3424b90..265aca0 100644
--- a/arch/sh/lib/Makefile
+++ b/arch/sh/lib/Makefile
@@ -2,9 +2,11 @@
 # Makefile for SuperH-specific library files..
 #
 
-lib-y  = delay.o io.o memset.o memmove.o memchr.o \
+lib-y  = delay.o memset.o memmove.o memchr.o \
 	 checksum.o strlen.o div64.o div64-generic.o
 
+obj-y				+= io.o
+
 memcpy-y			:= memcpy.o
 memcpy-$(CONFIG_CPU_SH4)	:= memcpy-sh4.o
 
