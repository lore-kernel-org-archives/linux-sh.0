From: Ralf Baechle <ralf@linux-mips.org>
Date: Thu, 23 Jun 2011 11:45:37 +0000
Subject: [PATCH] STAGING: Comedi: Build only on arches providing
Message-Id: <20110623114536.GA14011@linux-mips.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Greg Kroah-Hartman <gregkh@suse.de>, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, linux-m32r@ml.linux-m32r.org, linux-m32r-ja@ml.linux
Cc: linux-arch@vger.kernel.org

On architectures that don't define PAGE_KERNEL_NOCACHE, the Comedi driver turns
into tragedy:

  CC [M]  drivers/staging/comedi/drivers.o
drivers/staging/comedi/drivers.c: In function ‘comedi_buf_alloc’:
drivers/staging/comedi/drivers.c:505:41: error: ‘PAGE_KERNEL_NOCACHE’ undeclared (first use in this function)
drivers/staging/comedi/drivers.c:505:41: note: each undeclared identifier is rep orted only once for each function it appears in
make[3]: *** [drivers/staging/comedi/drivers.o] Error 1

Restrict the driver to only those architectures that define PAGE_KERNEL_NOCACHE.

PAGE_KERNEL_NOCACHE is a kludge - some system architectures such as SGI IP27
are even uable to offer uncached operation - at least in the way an unwitting
driver might assume.  I haven't looked in details how the driver is using
the area vmaped with PAGE_KERNEL_NOCACHE but maybe doing it XFS-style using
cached memory and the flush_kernel_vmap_range / invalidate_kernel_vmap_range
APIs in conjunction with the DMA API is a practical alternative.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

 drivers/staging/comedi/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/comedi/Kconfig b/drivers/staging/comedi/Kconfig
index 1502d80..bccdc12 100644
--- a/drivers/staging/comedi/Kconfig
+++ b/drivers/staging/comedi/Kconfig
@@ -2,6 +2,7 @@ config COMEDI
 	tristate "Data acquisition support (comedi)"
 	default N
 	depends on m
+	depends on BROKEN || FRV || M32R || MN10300 || SUPERH || TILE || X86
 	---help---
 	  Enable support a wide range of data acquisition devices
 	  for Linux.
