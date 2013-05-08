From: Bastian Hecht <hechtb@gmail.com>
Date: Wed, 08 May 2013 13:20:04 +0000
Subject: [PATCH] irqchip: Add irqchip_init dummy function
Message-Id: <1368019204-24448-1-git-send-email-hechtb+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

We add an empty irqchip_init dummy function for cases in which
CONFIG_IRQCHIP is not used. In these cases irqchip.c is not compiled,
but a funtion call may still be present in architecture code, that in
runtime doesn't get hit.

E.g. this is needed in the arch/arm/mach-shmobile/intc-r8a7740.c
interrupt setup code where OF use and non OF us is both handled in one
file.

Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
---
 include/linux/irqchip.h |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/irqchip.h b/include/linux/irqchip.h
index e0006f1..78527ba 100644
--- a/include/linux/irqchip.h
+++ b/include/linux/irqchip.h
@@ -11,6 +11,10 @@
 #ifndef _LINUX_IRQCHIP_H
 #define _LINUX_IRQCHIP_H
 
+#ifdef CONFIG_IRQCHIP
 void irqchip_init(void);
+#else
+void irqchip_init(void) {};
+#endif
 
 #endif
-- 
1.7.9.5

