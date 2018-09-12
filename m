From: Mark Brown <broonie@kernel.org>
Date: Wed, 12 Sep 2018 12:12:07 +0000
Subject: [PATCH] sh: Provide prototypes for PCI I/O mapping in asm/io.h
Message-Id: <20180912121207.16772-1-broonie@kernel.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Most architectures provide prototypes for the PCI I/O mapping operations
when asm/io.h is included but SH doesn't currently do that, leading to
for example warnings in sound/pci/hda/patch_ca0132.c when pci_iomap() is
used on current -next.  Make SH more consistent with other architectures
by including asm-generic/pci_iomap.h in asm/io.h.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/sh/include/asm/io.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sh/include/asm/io.h b/arch/sh/include/asm/io.h
index 98cb8c802b1a..4f7f235f15f8 100644
--- a/arch/sh/include/asm/io.h
+++ b/arch/sh/include/asm/io.h
@@ -24,6 +24,7 @@
 #define __IO_PREFIX     generic
 #include <asm/io_generic.h>
 #include <asm/io_trapped.h>
+#include <asm-generic/pci_iomap.h>
 #include <mach/mangle-port.h>
 
 #define __raw_writeb(v,a)	(__chk_io_ptr(a), *(volatile u8  __force *)(a) = (v))
-- 
2.19.0.rc2
