From: Christoph Hellwig <hch@lst.de>
Date: Fri, 26 Jun 2020 08:07:16 +0000
Subject: [PATCH 09/10] sh: don't allow non-coherent DMA for NOMMU
Message-Id: <20200626080717.1999041-10-hch@lst.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20200626080717.1999041-1-hch@lst.de>
In-Reply-To: <20200626080717.1999041-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

The code handling non-coherent DMA depends on being able to remap code
as non-cached.  But that can't be done without an MMU, so using this
option on NOMMU builds is broken.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/sh/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index f8027eee08edae..337eb496c45a0a 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -61,6 +61,7 @@ config SUPERH
 	select MAY_HAVE_SPARSE_IRQ
 	select MODULES_USE_ELF_RELA
 	select NEED_SG_DMA_LENGTH
+	select NO_DMA if !MMU && !DMA_COHERENT
 	select NO_GENERIC_PCI_IOPORT_MAP if PCI
 	select OLD_SIGACTION
 	select OLD_SIGSUSPEND
@@ -135,7 +136,7 @@ config DMA_COHERENT
 	bool
 
 config DMA_NONCOHERENT
-	def_bool !DMA_COHERENT
+	def_bool !NO_DMA && !DMA_COHERENT
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
 
 config PGTABLE_LEVELS
-- 
2.26.2
