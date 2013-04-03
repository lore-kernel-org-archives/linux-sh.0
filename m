From: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Wed, 03 Apr 2013 14:23:09 +0000
Subject: [PATCH-mmotm] sh4: make the bios early console support depend on EARLY_PRINTK
Message-Id: <1364998989-27357-1-git-send-email-paul.gortmaker@windriver.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>, Thomas Gleixner <tglx@linutronix.de>, Paul Mundt <lethal@linux-sh.org>

The commit "early_printk: consolidate random copies of identical code"
introduces a build failure for the lboxre2_defconfig because arch/sh
unconditionally assumes that there will be an early_console struct
present that it can populate with bios routines to drive the
early printk support.

Making this whole block conditional on EARLY_PRINTK solves the
problem and gets rid of unused runtime code for when the feature
is disabled at the same time.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Paul Mundt <lethal@linux-sh.org>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---

Related mmotm patches:
   * early_printk-consolidate-random-copies-of-identical-code.patch
   * early_printk-consolidate-random-copies-of-identical-code-v3.patch
   * early_printk-consolidate-random-copies-of-identical-code-v3-fix.patch
   * include-linux-printkh-include-stdargh.patch
   
 arch/sh/kernel/sh_bios.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/sh/kernel/sh_bios.c b/arch/sh/kernel/sh_bios.c
index a5b51b9..fe584e5 100644
--- a/arch/sh/kernel/sh_bios.c
+++ b/arch/sh/kernel/sh_bios.c
@@ -104,6 +104,7 @@ void sh_bios_vbr_reload(void)
 		);
 }
 
+#ifdef CONFIG_EARLY_PRINTK
 /*
  *	Print a string through the BIOS
  */
@@ -168,3 +169,4 @@ static int __init setup_early_printk(char *buf)
 	return 0;
 }
 early_param("earlyprintk", setup_early_printk);
+#endif
-- 
1.8.1.2

