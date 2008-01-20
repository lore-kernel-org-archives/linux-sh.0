From: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Date: Sun, 20 Jan 2008 18:18:29 +0000
Subject: [PATCH] SG - fix SH Kconfig
Message-Id: <1200853109.6331.2.camel@localhost.localdomain>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@users.sourceforge.net>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-sh <linux-sh@vger.kernel.org>

From: Adrian McMenamin <adrian@mcmen.demon.co.uk>


Remove reference to board deleted in commit 758e06ded4c48024835ef0a14627afcde2e25929

Submitted-by: Adrian McMenamin <adrian@mcmen.demon.co.uk>
---

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 85bd9ac..e94430b 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -518,7 +518,6 @@ config SH_CAYMAN
 
 endmenu
 
-source "arch/sh/boards/renesas/hs7751rvoip/Kconfig"
 source "arch/sh/boards/renesas/rts7751r2d/Kconfig"
 source "arch/sh/boards/renesas/r7780rp/Kconfig"
 source "arch/sh/boards/magicpanelr2/Kconfig"

