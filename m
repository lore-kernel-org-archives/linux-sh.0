From: Shea Levy <shea@shealevy.com>
Date: Sun, 25 Mar 2018 22:18:50 +0000
Subject: [PATCH v2 13/16] parisc: Use INITRAMFS_GENERIC_UNLOAD
Message-Id: <20180325221853.10839-14-shea@shealevy.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20180324174458.26423-1-shea@shealevy.com>
 <20180325221853.10839-1-shea@shealevy.com>
In-Reply-To: <20180325221853.10839-1-shea@shealevy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-c6x-dev@linux-c6x.org, uclinux-h8-devel@lists.sourceforge.jp, linux-m68k@lists.linux-m68k.org, nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Cc: Shea Levy <shea@shealevy.com>

Signed-off-by: Shea Levy <shea@shealevy.com>
---
 arch/parisc/Kconfig   | 1 +
 arch/parisc/mm/init.c | 7 -------
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
index 9792d8cf4f56..7410c2094987 100644
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -51,6 +51,7 @@ config PARISC
 	select GENERIC_CLOCKEVENTS
 	select ARCH_NO_COHERENT_DMA_MMAP
 	select CPU_NO_EFFICIENT_FFS
+	select INITRAMFS_GENERIC_UNLOAD
 
 	help
 	  The PA-RISC microprocessor is designed by Hewlett-Packard and used
diff --git a/arch/parisc/mm/init.c b/arch/parisc/mm/init.c
index cab32ee824d2..3643399230f3 100644
--- a/arch/parisc/mm/init.c
+++ b/arch/parisc/mm/init.c
@@ -932,10 +932,3 @@ void flush_tlb_all(void)
 	spin_unlock(&sid_lock);
 }
 #endif
-
-#ifdef CONFIG_BLK_DEV_INITRD
-void free_initrd_mem(unsigned long start, unsigned long end)
-{
-	free_reserved_area((void *)start, (void *)end, -1, "initrd");
-}
-#endif
-- 
2.16.2

