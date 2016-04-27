From: Yoshinori Sato <ysato@users.sourceforge.jp>
Date: Wed, 27 Apr 2016 15:49:13 +0000
Subject: [PATCH] sh-sci: SysRq support on EARLYCON
Message-Id: <1461772153-6785-1-git-send-email-ysato@users.sourceforge.jp>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>

Add missing flag condition.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 drivers/tty/serial/sh-sci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 0130feb..5a73620 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -18,7 +18,9 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  */
-#if defined(CONFIG_SERIAL_SH_SCI_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
+#if (defined(CONFIG_SERIAL_SH_SCI_CONSOLE) || \
+     defined(CONFIG_SERIAL_SH_SCI_EARLYCON)) && \
+	defined(CONFIG_MAGIC_SYSRQ)
 #define SUPPORT_SYSRQ
 #endif
 
-- 
2.7.0

