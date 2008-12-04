From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 04 Dec 2008 13:45:12 +0000
Subject: [PATCH 02/03] sh: allow CONFIG_PM
Message-Id: <20081204134512.21168.95849.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Allow users to select CONFIG_PM regardless of processor type or board.
Suspend and hibernation are only allowed on supported platforms.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/Kconfig |   15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

--- 0001/arch/sh/Kconfig
+++ work/arch/sh/Kconfig	2008-12-04 21:06:33.000000000 +0900
@@ -85,10 +85,17 @@ config GENERIC_LOCKBREAK
 
 config SYS_SUPPORTS_PM
 	bool
+	depends on !SMP
+
+config ARCH_SUSPEND_POSSIBLE
+	def_bool n
+
+config ARCH_HIBERNATION_POSSIBLE
+	def_bool n
 
 config SYS_SUPPORTS_APM_EMULATION
 	bool
-	select SYS_SUPPORTS_PM
+	select ARCH_SUSPEND_POSSIBLE
 
 config SYS_SUPPORTS_SMP
 	bool
@@ -753,11 +760,7 @@ source "fs/Kconfig.binfmt"
 endmenu
 
 menu "Power management options (EXPERIMENTAL)"
-depends on EXPERIMENTAL && SYS_SUPPORTS_PM
-
-config ARCH_SUSPEND_POSSIBLE
-	def_bool y
-	depends on !SMP
+depends on EXPERIMENTAL
 
 source kernel/power/Kconfig
 
