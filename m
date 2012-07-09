From: minyard@acm.org
Date: Mon, 09 Jul 2012 20:35:20 +0000
Subject: [PATCH] SH: Convert out[bwl] macros to inline functions
Message-Id: <1341866120-18640-1-git-send-email-minyard@acm.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, lethal@linux-sh.org, linux-sh@vger.kernel.org
Cc: Corey Minyard <cminyard@mvista.com>

From: Corey Minyard <cminyard@mvista.com>

The macros just called BUG(), but that results in unused variable
warnings all over the place, like in the IPMI driver.  The build
regression emails were annoying me, so here's the fix.  I have
not even compile tested this, but it's rather obvious.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 arch/sh/include/asm/io_noioport.h |   17 ++++++++++++++---
 1 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/arch/sh/include/asm/io_noioport.h b/arch/sh/include/asm/io_noioport.h
index e136d28..8cf7084 100644
--- a/arch/sh/include/asm/io_noioport.h
+++ b/arch/sh/include/asm/io_noioport.h
@@ -19,9 +19,20 @@ static inline u32 inl(unsigned long addr)
 	return -1;
 }
 
-#define outb(x, y)	BUG()
-#define outw(x, y)	BUG()
-#define outl(x, y)	BUG()
+static inline void outb(unsigned char x, unsigned int port)
+{
+	BUG();
+}
+
+static inline void outw(unsigned short x, unsigned int port)
+{
+	BUG();
+}
+
+static inline void outl(unsigned int x, unsigned int port)
+{
+	BUG();
+}
 
 #define inb_p(addr)	inb(addr)
 #define inw_p(addr)	inw(addr)
-- 
1.7.4.1

