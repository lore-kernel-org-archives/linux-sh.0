From: "Robert P. J. Day" <rpjday@crashcourse.ca>
Date: Sat, 27 Feb 2010 18:35:08 +0000
Subject: [PATCH] SH: No need to explicitly include <linux/rwlock.h>.
Message-Id: <alpine.LFD.2.00.1002271333240.22885@localhost>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Since <linux/spinlock.h> already includes <linux/rwlock.h>, and the
latter file will warn about not having included the former file
anyway, there is no value in including rwlock.h explicitly.

Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

diff --git a/arch/sh/mm/pmb.c b/arch/sh/mm/pmb.c
index 198bcff..35b364f 100644
--- a/arch/sh/mm/pmb.c
+++ b/arch/sh/mm/pmb.c
@@ -23,7 +23,6 @@
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/spinlock.h>
-#include <linux/rwlock.h>
 #include <asm/sizes.h>
 #include <asm/system.h>
 #include <asm/uaccess.h>

====================================
Robert P. J. Day                               Waterloo, Ontario, CANADA

            Linux Consulting, Training and Kernel Pedantry.

Web page:                                          http://crashcourse.ca
Twitter:                                       http://twitter.com/rpjday
====================================
