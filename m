From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Sat, 11 Aug 2012 22:17:40 +0000
Subject: [PATCH 1/2] ARM: shmobile: Move definition of shmobile_init_late() to header
Message-Id: <201208120017.40317.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


The role of the only function in the common.c file in
arch/arm/mach-shmobile, shmobile_init_late(), is to call two
initializers whose definitions depend on kernel configuration
options.  Those initializers may very well be called from a static
inline function in arm/mach-shmobile/include/mach/common.h,
though, which makes the code a bit easier to read.  Moreover,
the common.c may be dropped entirely then.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 arch/arm/mach-shmobile/Makefile              |    2 +-
 arch/arm/mach-shmobile/common.c              |   24 ------------------------
 arch/arm/mach-shmobile/include/mach/common.h |    8 ++++++--
 3 files changed, 7 insertions(+), 27 deletions(-)

Index: linux/arch/arm/mach-shmobile/common.c
=================================--- linux.orig/arch/arm/mach-shmobile/common.c
+++ /dev/null
@@ -1,24 +0,0 @@
-/*
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; version 2 of the License.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
- */
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <mach/common.h>
-
-void __init shmobile_init_late(void)
-{
-	shmobile_suspend_init();
-	shmobile_cpuidle_init();
-}
Index: linux/arch/arm/mach-shmobile/include/mach/common.h
=================================--- linux.orig/arch/arm/mach-shmobile/include/mach/common.h
+++ linux/arch/arm/mach-shmobile/include/mach/common.h
@@ -86,8 +86,6 @@ extern int r8a7779_boot_secondary(unsign
 extern void r8a7779_smp_prepare_cpus(void);
 extern void r8a7779_register_twd(void);
 
-extern void shmobile_init_late(void);
-
 #ifdef CONFIG_SUSPEND
 int shmobile_suspend_init(void);
 #else
@@ -100,4 +98,10 @@ int shmobile_cpuidle_init(void);
 static inline int shmobile_cpuidle_init(void) { return 0; }
 #endif
 
+static inline void shmobile_init_late(void)
+{
+	shmobile_suspend_init();
+	shmobile_cpuidle_init();
+}
+
 #endif /* __ARCH_MACH_COMMON_H */
Index: linux/arch/arm/mach-shmobile/Makefile
=================================--- linux.orig/arch/arm/mach-shmobile/Makefile
+++ linux/arch/arm/mach-shmobile/Makefile
@@ -3,7 +3,7 @@
 #
 
 # Common objects
-obj-y				:= timer.o console.o clock.o common.o
+obj-y				:= timer.o console.o clock.o
 
 # CPU objects
 obj-$(CONFIG_ARCH_SH7367)	+= setup-sh7367.o clock-sh7367.o intc-sh7367.o

