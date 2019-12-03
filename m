From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 03 Dec 2019 16:26:42 +0000
Subject: [PATCH 4/7] sh: sh2007: Modernize printing of kernel messages
Message-Id: <20191203162645.19950-5-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <20191203162645.19950-1-geert+renesas@glider.be>
In-Reply-To: <20191203162645.19950-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Guenter Roeck <linux@roeck-us.net>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

  - Convert from printk() to pr_*(),
  - Add missing continuation.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Compile-tested only.
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
