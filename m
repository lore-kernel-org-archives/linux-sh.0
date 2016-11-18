From: Geliang Tang <geliangtang@gmail.com>
Date: Fri, 18 Nov 2016 14:21:15 +0000
Subject: [PATCH] sh: dreamcast: drop duplicate header irq.h
Message-Id: <89d9c583f107b9fe81967c9016d9a792a4f61dec.1479459047.git.geliangtang@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <319a5803aac795e175306d4978134f0247cf87bc.1479457751.git.geliangtang@gmail.com>
In-Reply-To: <319a5803aac795e175306d4978134f0247cf87bc.1479457751.git.geliangtang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Cc: Geliang Tang <geliangtang@gmail.com>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Drop duplicate header irq.h from irq.c.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 arch/sh/boards/mach-dreamcast/irq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/sh/boards/mach-dreamcast/irq.c b/arch/sh/boards/mach-dreamcast/irq.c
index 2789647..69fa91c 100644
--- a/arch/sh/boards/mach-dreamcast/irq.c
+++ b/arch/sh/boards/mach-dreamcast/irq.c
@@ -10,7 +10,6 @@
  */
 #include <linux/irq.h>
 #include <linux/io.h>
-#include <linux/irq.h>
 #include <linux/export.h>
 #include <linux/err.h>
 #include <mach/sysasic.h>
-- 
2.9.3

