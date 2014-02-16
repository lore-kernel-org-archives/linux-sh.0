From: Paul Bolle <pebolle@tiscali.nl>
Date: Sun, 16 Feb 2014 19:00:03 +0000
Subject: [PATCH] sh: remove SH_ALPHA_BOARD
Message-Id: <1392577203.28866.29.camel@x220>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@linux-sh.org>
Cc: Richard Weinberger <richard@nod.at>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

The Kconfig symbol SH_ALPHA_BOARD was added in v2.6.38. It has never
been used. Setting it has no effect. There are no calls for
mach_is_sh_alpha_board(). This symbol can safely be removed.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
Tested with "git grep".

 arch/sh/boards/Kconfig   | 5 -----
 arch/sh/tools/mach-types | 1 -
 2 files changed, 6 deletions(-)

diff --git a/arch/sh/boards/Kconfig b/arch/sh/boards/Kconfig
index eb1cf84..70c4f51 100644
--- a/arch/sh/boards/Kconfig
+++ b/arch/sh/boards/Kconfig
@@ -3,9 +3,6 @@ menu "Board support"
 config SOLUTION_ENGINE
 	bool
 
-config SH_ALPHA_BOARD
-	bool
-
 config SH_SOLUTION_ENGINE
 	bool "SolutionEngine"
 	select SOLUTION_ENGINE
@@ -345,7 +342,6 @@ config SH_SH2007
 
 config SH_APSH4A3A
 	bool "AP-SH4A-3A"
-	select SH_ALPHA_BOARD
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 	depends on CPU_SUBTYPE_SH7785
 	help
@@ -353,7 +349,6 @@ config SH_APSH4A3A
 
 config SH_APSH4AD0A
 	bool "AP-SH4AD-0A"
-	select SH_ALPHA_BOARD
 	select SYS_SUPPORTS_PCI
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 	depends on CPU_SUBTYPE_SH7786
diff --git a/arch/sh/tools/mach-types b/arch/sh/tools/mach-types
index 569977e..99f524c 100644
--- a/arch/sh/tools/mach-types
+++ b/arch/sh/tools/mach-types
@@ -9,7 +9,6 @@ SE			SH_SOLUTION_ENGINE
 HIGHLANDER		SH_HIGHLANDER
 RTS7751R2D		SH_RTS7751R2D
 RSK			SH_RSK
-ALPHA_BOARD		SH_ALPHA_BOARD
 
 #
 # List of companion chips / MFDs.
-- 
1.8.5.3

