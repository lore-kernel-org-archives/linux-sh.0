From: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Date: Sun, 03 Feb 2008 23:34:50 +0000
Subject: [PATCH] Fix 8139too for Dreamcast
Message-Id: <1202081690.9936.11.camel@localhost.localdomain>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Adrian McMenamin

This fixes the 8139too driver for the Dreamcast to work with the recent coherency patches. All Magnus's work, I just tested it.

Suggested-by: Magnus Damm
Submitted-by: Adrian McMenamin <adrian@mcmen.demon.co.uk>

========


--- a/drivers/net/8139too.c
+++ b/drivers/net/8139too.c
@@ -168,7 +168,7 @@ static int debug = -1;
  * Warning: 64K ring has hardware issues and may lock up.
  */
 #if defined(CONFIG_SH_DREAMCAST)
-#define RX_BUF_IDX     1       /* 16K ring */
+#define RX_BUF_IDX     0       /* 8K ring */
 #else
 #define RX_BUF_IDX     2       /* 32K ring */
 #endif

