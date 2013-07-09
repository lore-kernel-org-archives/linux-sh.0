From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 09 Jul 2013 05:44:09 +0000
Subject: [PATCH 04/04] ARM: shmobile: Allow ARCH_SHMOBILE_MULTI timer configuration
Message-Id: <20130709054409.14007.23571.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
References: <20130709054331.14007.66068.sendpatchset@w520>
In-Reply-To: <20130709054331.14007.66068.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Move the timer configuration bits to allow use in
case of ARCH_SHMOBILE or ARCH_SHMOBILE_MULTI.

The timers all make use of the regular driver model
so they are safe to enable for ARCH_MULTIPLATFORM.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/Kconfig |   16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

--- 0005/arch/arm/mach-shmobile/Kconfig
+++ work/arch/arm/mach-shmobile/Kconfig	2013-07-09 12:07:23.000000000 +0900
@@ -30,6 +30,8 @@ config MACH_KZM9D_REFERENCE
 	   of not supporting a number of devices.
 
 	   This is intended to aid developers
+
+comment "SH-Mobile System Configuration"
 endif
 
 if ARCH_SHMOBILE
@@ -243,6 +245,15 @@ config CPU_HAS_INTEVT
         bool
 	default y
 
+config SH_CLK_CPG
+	bool
+
+source "drivers/sh/Kconfig"
+
+endif
+
+if ARCH_SHMOBILE || ARCH_SHMOBILE_MULTI
+
 menu "Timer and clock configuration"
 
 config SHMOBILE_TIMER_HZ
@@ -277,9 +288,4 @@ config EM_TIMER_STI
 
 endmenu
 
-config SH_CLK_CPG
-	bool
-
-source "drivers/sh/Kconfig"
-
 endif
