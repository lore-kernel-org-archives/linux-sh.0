From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 17 Jun 2020 14:36:37 +0000
Subject: [PATCH v2 7/9] sh: sh2007: Modernize printing of kernel messages
Message-Id: <20200617143639.18315-8-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <20200617143639.18315-1-geert+renesas@glider.be>
In-Reply-To: <20200617143639.18315-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@linux.ibm.com>, Dmitry Safonov <0x7f454c46@gmail.com>, Guenter Roeck <linux@roeck-us.net>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

  - Convert from printk() to pr_*(),
  - Add missing continuation.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Guenter Roeck <linux@roeck-us.net>
---
v2:
  - Add Tested-by.
---
 arch/sh/boards/board-sh2007.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sh/boards/board-sh2007.c b/arch/sh/boards/board-sh2007.c
index ef9c87deeb08828c..6ea85e4808512f94 100644
--- a/arch/sh/boards/board-sh2007.c
+++ b/arch/sh/boards/board-sh2007.c
@@ -126,14 +126,14 @@ static void __init sh2007_init_irq(void)
  */
 static void __init sh2007_setup(char **cmdline_p)
 {
-	printk(KERN_INFO "SH-2007 Setup...");
+	pr_info("SH-2007 Setup...");
 
 	/* setup wait control registers for area 5 */
 	__raw_writel(CS5BCR_D, CS5BCR);
 	__raw_writel(CS5WCR_D, CS5WCR);
 	__raw_writel(CS5PCR_D, CS5PCR);
 
-	printk(KERN_INFO " done.\n");
+	pr_cont(" done.\n");
 }
 
 /*
-- 
2.17.1
