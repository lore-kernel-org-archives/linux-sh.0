From: Pranith Kumar <bobby.prani@gmail.com>
Date: Tue, 05 Aug 2014 19:25:08 +0000
Subject: [PATCH 1/1] sh: Fix build error by adding generic ioport_{map/unmap}()
Message-Id: <1407266709-9296-1-git-send-email-bobby.prani@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "GitAuthor: Pranith Kumar" <bobby.prani@gmail.com>, "open list:SUPERH" <linux-sh@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

Fix build error as reported by Geert Uytterhoeven here:
http://kisskb.ellerman.id.au/kisskb/buildresult/11607865/

The error happens when CONFIG_HAS_IOPORT_MAP=n because of which there are
missing definitions of ioport_map/unmap(). Fix this build error by adding these
prototypes.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
---
 arch/sh/include/asm/io_noioport.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/sh/include/asm/io_noioport.h b/arch/sh/include/asm/io_noioport.h
index 4d48f14..c727e6d 100644
--- a/arch/sh/include/asm/io_noioport.h
+++ b/arch/sh/include/asm/io_noioport.h
@@ -34,6 +34,17 @@ static inline void outl(unsigned int x, unsigned long port)
 	BUG();
 }
 
+static inline void __iomem *ioport_map(unsigned long port, unsigned int size)
+{
+	BUG();
+	return NULL;
+}
+
+static inline void ioport_unmap(void __iomem *addr)
+{
+	BUG();
+}
+
 #define inb_p(addr)	inb(addr)
 #define inw_p(addr)	inw(addr)
 #define inl_p(addr)	inl(addr)
-- 
1.9.1

