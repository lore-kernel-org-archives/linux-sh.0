From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 28 Dec 2011 07:44:06 +0000
Subject: [PATCH] ARM: mach-shmobile: Fix headsmp.S code to use CPUINIT
Message-Id: <20111228074406.14224.18428.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Convert the low level SMP assembly code for SH-Mobile ARM
from using the INIT to the CPUINIT section. This unbreaks
onlining of CPUs using the CPU hotplug interface:

echo 1 > /sys/devices/system/cpu/cpu1/online

Without this fix the reset vector code used by CPU hotplug
will be freed as init section data and CPU cores cannot
be brought online.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/headsmp.S |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 0001/arch/arm/mach-shmobile/headsmp.S
+++ work/arch/arm/mach-shmobile/headsmp.S	2011-12-28 14:16:01.000000000 +0900
@@ -14,7 +14,7 @@
 #include <linux/init.h>
 #include <asm/memory.h>
 
-	__INIT
+	__CPUINIT
 
 /*
  * Reset vector for secondary CPUs.
