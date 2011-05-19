From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 19 May 2011 05:10:13 +0000
Subject: [PATCH] ARM: mach-shmobile: headsmp.S build fix
Message-Id: <20110519051013.9061.94877.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Git commit f4117ac9e237b74afdf5e001d5ea26a4d15e9847
introduced PLAT_PHYS_OFFSET, but headsmp.S was left
unchanged which results in a compile error:

  AS      arch/arm/mach-shmobile/headsmp.o
arch/arm/mach-shmobile/headsmp.S: Assembler messages:
arch/arm/mach-shmobile/headsmp.S:27: Error: undefined symbol `secondary_startup' in operation
arch/arm/mach-shmobile/headsmp.S:27: Error: undefined symbol `PHYS_OFFSET' in operation
make[1]: *** [arch/arm/mach-shmobile/headsmp.o] Error 1
make[1]: *** Waiting for unfinished jobs....

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/headsmp.S |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 0001/arch/arm/mach-shmobile/headsmp.S
+++ work/arch/arm/mach-shmobile/headsmp.S	2011-05-03 10:33:20.000000000 +0900
@@ -24,4 +24,4 @@
 	.align  12
 ENTRY(shmobile_secondary_vector)
 	ldr     pc, 1f
-1:	.long   secondary_startup - PAGE_OFFSET + PHYS_OFFSET
+1:	.long   secondary_startup - PAGE_OFFSET + PLAT_PHYS_OFFSET
