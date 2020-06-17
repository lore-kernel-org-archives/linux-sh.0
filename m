From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 17 Jun 2020 14:36:39 +0000
Subject: [PATCH v2 9/9] sh: machvec: Modernize printing of kernel messages
Message-Id: <20200617143639.18315-10-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <20200617143639.18315-1-geert+renesas@glider.be>
In-Reply-To: <20200617143639.18315-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@linux.ibm.com>, Dmitry Safonov <0x7f454c46@gmail.com>, Guenter Roeck <linux@roeck-us.net>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

  - Convert from printk() to pr_*(),
  - Add missing continuations.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Guenter Roeck <linux@roeck-us.net>
---
v2:
  - Add Tested-by.
---
 arch/sh/kernel/machvec.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/sh/kernel/machvec.c b/arch/sh/kernel/machvec.c
index beadbbdb44867759..0e9fa33a9b6ab38c 100644
--- a/arch/sh/kernel/machvec.c
+++ b/arch/sh/kernel/machvec.c
@@ -64,10 +64,10 @@ static int __init early_parse_mv(char *from)
 
 	mvp = get_mv_byname(mv_name);
 	if (unlikely(!mvp)) {
-		printk("Available vectors:\n\n\t'%s', ", sh_mv.mv_name);
+		pr_info("Available vectors:\n\n\t'%s', ", sh_mv.mv_name);
 		for_each_mv(mvp)
-			printk("'%s', ", mvp->mv_name);
-		printk("\n\n");
+			pr_cont("'%s', ", mvp->mv_name);
+		pr_cont("\n\n");
 		panic("Failed to select machvec '%s' -- halting.\n",
 		      mv_name);
 	} else
@@ -104,7 +104,7 @@ void __init sh_mv_setup(void)
 			sh_mv = *(struct sh_machine_vector *)&__machvec_start;
 	}
 
-	printk(KERN_NOTICE "Booting machvec: %s\n", get_system_type());
+	pr_notice("Booting machvec: %s\n", get_system_type());
 
 	/*
 	 * Manually walk the vec, fill in anything that the board hasn't yet
-- 
2.17.1
