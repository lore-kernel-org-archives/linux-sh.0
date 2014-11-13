From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 13 Nov 2014 01:20:27 +0000
Subject: [PATCH 2/2] ARM: shmobile: always build rcar setup for armv7
Message-Id: <e3d163329753b3b473f40c9be71561ed8eb98aea.1415841454.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1415841454.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1415841454.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>

In a combined ARMv6/v7 kernel, the setup-rcar-gen2.c cannot
currently be compiled correctly because it uses the isb
instruction that is not available on ARMv6. Adding the
-march=armv7-a flag lets the compiler know that it is safe
to build this file for ARMv7.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index e20f278..71e68ca 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -36,6 +36,7 @@ cpu-y				:= platsmp.o headsmp.o
 
 # Shared SoC family objects
 obj-$(CONFIG_ARCH_RCAR_GEN2)	+= setup-rcar-gen2.o platsmp-apmu.o $(cpu-y)
+CFLAGS_setup-rcar-gen2.o	+= -march=armv7-a
 
 # SMP objects
 smp-y				:= $(cpu-y)
-- 
2.1.1

