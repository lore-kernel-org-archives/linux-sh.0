From: Christoph Hellwig <hch@lst.de>
Date: Fri, 26 Jun 2020 08:07:15 +0000
Subject: [PATCH 08/10] dma-mapping: consolidate the NO_DMA definition in kernel/dma/Kconfig
Message-Id: <20200626080717.1999041-9-hch@lst.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20200626080717.1999041-1-hch@lst.de>
In-Reply-To: <20200626080717.1999041-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Have a single definition that architetures can select.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/m68k/Kconfig         | 4 +---
 arch/m68k/Kconfig.machine | 1 +
 arch/um/Kconfig           | 4 +---
 kernel/dma/Kconfig        | 3 +++
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index 6ad6cdac74b3dc..8e488369a7e55a 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -17,6 +17,7 @@ config M68K
 	select HAVE_COPY_THREAD_TLS
 	select GENERIC_IRQ_SHOW
 	select GENERIC_ATOMIC64
+	select NO_DMA if !MMU && !COLDFIRE
 	select HAVE_UID16
 	select VIRT_TO_BUS
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG if RMW_INSNS
@@ -60,9 +61,6 @@ config TIME_LOW_RES
 config NO_IOPORT_MAP
 	def_bool y
 
-config NO_DMA
-	def_bool (MMU && SUN3) || (!MMU && !COLDFIRE)
-
 config ZONE_DMA
 	bool
 	default y
diff --git a/arch/m68k/Kconfig.machine b/arch/m68k/Kconfig.machine
index a82651d58af483..17e8c3a292d770 100644
--- a/arch/m68k/Kconfig.machine
+++ b/arch/m68k/Kconfig.machine
@@ -126,6 +126,7 @@ config SUN3
 	depends on MMU
 	depends on !MMU_MOTOROLA
 	select MMU_SUN3 if MMU
+	select NO_DMA
 	select M68020
 	help
 	  This option enables support for the Sun 3 series of workstations
diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 9318dc6d1a0cee..32c1d1945033ec 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -15,6 +15,7 @@ config UML
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_DEBUG_BUGVERBOSE
 	select HAVE_COPY_THREAD_TLS
+	select NO_DMA
 	select GENERIC_IRQ_SHOW
 	select GENERIC_CPU_DEVICES
 	select GENERIC_CLOCKEVENTS
@@ -168,9 +169,6 @@ config MMAPPER
 	  This driver allows a host file to be used as emulated IO memory inside
 	  UML.
 
-config NO_DMA
-	def_bool y
-
 config PGTABLE_LEVELS
 	int
 	default 3 if 3_LEVEL_PGTABLES
diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index a0ce3c1494fdd2..cb05247804d9f3 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -1,5 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
+config NO_DMA
+	bool
+
 config HAS_DMA
 	bool
 	depends on !NO_DMA
-- 
2.26.2
