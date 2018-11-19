From: Takashi Iwai <tiwai@suse.de>
Date: Mon, 19 Nov 2018 11:59:10 +0000
Subject: [PATCH] sh: Always enable CONFIG_GENERIC_PCI_IOMAP
Message-Id: <20181119115910.19390-1-tiwai@suse.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

CONFIG_GENERIC_PCI_IOMAP is supposed to be set no matter whether
CONFIG_PCI is present or not.  Otherwise the generic header
(asm-generic/pci_iomap.h) won't create dummy functions, and the code
using pci_iomap() and pci_iounmap() will fail due to the lack of the
function definitions / declarations.

Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 arch/sh/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index f82a4da7adf3..3d5220ad9e46 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -36,6 +36,8 @@ config SUPERH
 	select RTC_LIB
 	select GENERIC_ATOMIC64
 	select GENERIC_IRQ_SHOW
+	select GENERIC_PCI_IOMAP
+	select NO_GENERIC_PCI_IOPORT_MAP
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_IDLE_POLL_SETUP
 	select GENERIC_CLOCKEVENTS
@@ -859,8 +861,6 @@ config PCI
 	bool "PCI support"
 	depends on SYS_SUPPORTS_PCI
 	select PCI_DOMAINS
-	select GENERIC_PCI_IOMAP
-	select NO_GENERIC_PCI_IOPORT_MAP
 	help
 	  Find out whether you have a PCI motherboard. PCI is the name of a
 	  bus system, i.e. the way the CPU talks to the other stuff inside
-- 
2.19.1
