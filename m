From: Randy Dunlap <rdunlap@infradead.org>
Date: Mon, 15 Jun 2020 02:59:07 +0000
Subject: [PATCH] Documentation: remove SH-5 index entries
Message-Id: <71e1f336-ef5c-f5e9-25cf-16bd4439b9f9@infradead.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>
Cc: Rich Felker <dalias@libc.org>, Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>, Yoshinori Sato <ysato@users.sourceforge.jp>, Geert Uytterhoeven <geert@linux-m68k.org>, Linus Torvalds <torvalds@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>

From: Randy Dunlap <rdunlap@infradead.org>

Remove SH-5 documentation index entries following the removal
of SH-5 source code.

Error: Cannot open file ../arch/sh/mm/tlb-sh5.c
Error: Cannot open file ../arch/sh/mm/tlb-sh5.c
Error: Cannot open file ../arch/sh/include/asm/tlb_64.h
Error: Cannot open file ../arch/sh/include/asm/tlb_64.h

Fixes: 3b69e8b45711 ("Merge tag 'sh-for-5.8' of git://git.libc.org/linux-sh")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Rich Felker <dalias@libc.org>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: ysato@users.sourceforge.jp
Cc: linux-sh@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
---
 Documentation/sh/index.rst |   12 ------------
 1 file changed, 12 deletions(-)

--- lnx-58-rc1.orig/Documentation/sh/index.rst
+++ lnx-58-rc1/Documentation/sh/index.rst
@@ -16,18 +16,6 @@ Store Queue API
 .. kernel-doc:: arch/sh/kernel/cpu/sh4/sq.c
    :export:
 
-SH-5
-----
-
-TLB Interfaces
-~~~~~~~~~~~~~~
-
-.. kernel-doc:: arch/sh/mm/tlb-sh5.c
-   :internal:
-
-.. kernel-doc:: arch/sh/include/asm/tlb_64.h
-   :internal:
-
 Machine Specific Interfaces
 ============= 
