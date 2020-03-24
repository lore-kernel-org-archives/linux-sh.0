From: Christoph Hellwig <hch@lst.de>
Date: Tue, 24 Mar 2020 16:26:29 +0000
Subject: [PATCH 06/10] sh: don't include <asm/io_trapped.h> in <asm/io.h>
Message-Id: <20200324162633.754714-7-hch@lst.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20200324162633.754714-1-hch@lst.de>
In-Reply-To: <20200324162633.754714-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

No need to expose the details of trapped I/O to drivers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/sh/include/asm/io.h | 1 -
 arch/sh/kernel/ioport.c  | 1 +
 arch/sh/mm/ioremap.c     | 1 +
 3 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/sh/include/asm/io.h b/arch/sh/include/asm/io.h
index 282ec476c06e..6beb55cadc21 100644
--- a/arch/sh/include/asm/io.h
+++ b/arch/sh/include/asm/io.h
@@ -22,7 +22,6 @@
 
 #define __IO_PREFIX     generic
 #include <asm/io_generic.h>
-#include <asm/io_trapped.h>
 #include <asm-generic/pci_iomap.h>
 #include <mach/mangle-port.h>
 
diff --git a/arch/sh/kernel/ioport.c b/arch/sh/kernel/ioport.c
index 34f8cdbbcf0b..f39446a658bd 100644
--- a/arch/sh/kernel/ioport.c
+++ b/arch/sh/kernel/ioport.c
@@ -7,6 +7,7 @@
  */
 #include <linux/module.h>
 #include <linux/io.h>
+#include <asm/io_trapped.h>
 
 unsigned long sh_io_port_base __read_mostly = -1;
 EXPORT_SYMBOL(sh_io_port_base);
diff --git a/arch/sh/mm/ioremap.c b/arch/sh/mm/ioremap.c
index a8170fa07bc1..3a13c1d3aa54 100644
--- a/arch/sh/mm/ioremap.c
+++ b/arch/sh/mm/ioremap.c
@@ -18,6 +18,7 @@
 #include <linux/mm.h>
 #include <linux/pci.h>
 #include <linux/io.h>
+#include <asm/io_trapped.h>
 #include <asm/page.h>
 #include <asm/pgalloc.h>
 #include <asm/addrspace.h>
-- 
2.25.1
