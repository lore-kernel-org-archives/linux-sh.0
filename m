From: Rob Landley <rob@landley.net>
Date: Thu, 09 Apr 2020 08:09:03 +0000
Subject: [PATCH] Fix verbose arch/sh panic messages.
Message-Id: <1da19521-b70c-272c-51bb-9416ece62772@landley.net>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Rob Landley <rob@landley.net>

These days printk() adds a newline, so 8 lines of memory dump becomes 80.

Signed-off-by: Rob Landley <rob@landley.net>
---

 arch/sh/kernel/dumpstack.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/sh/kernel/dumpstack.c b/arch/sh/kernel/dumpstack.c
index 9f1c9c11d62d..bfbae0d79dde 100644
--- a/arch/sh/kernel/dumpstack.c
+++ b/arch/sh/kernel/dumpstack.c
@@ -19,12 +19,14 @@
 void dump_mem(const char *str, unsigned long bottom, unsigned long top)
 {
 	unsigned long p;
+	char buf[128], *s;
 	int i;

 	printk("%s(0x%08lx to 0x%08lx)\n", str, bottom, top);

 	for (p = bottom & ~31; p < top; ) {
-		printk("%04lx: ", p & 0xffff);
+		s = buf;
+		s += sprintf(s, "%04lx: ", p & 0xffff);

 		for (i = 0; i < 8; i++, p += 4) {
 			unsigned int val;
@@ -33,13 +35,13 @@
 				printk("         ");
 			else {
 				if (__get_user(val, (unsigned int __user *)p)) {
-					printk("\n");
+					printk("FAULT\n");
 					return;
 				}
-				printk("%08x ", val);
+				s += sprintf(s, "%08x ", val);
 			}
 		}
-		printk("\n");
+		printk("%s\n", buf);
 	}
 }
