From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 21 Dec 2010 11:20:45 +0000
Subject: [PATCH] ARM: mach-shmobile: mackerel: fixup default momory size
Message-Id: <w3p8vzjnzhu.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 285dbbd..cb33753 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -86,7 +86,7 @@ config MEMORY_SIZE
 	hex "Physical memory size"
 	default "0x08000000" if MACH_G3EVM
 	default "0x08000000" if MACH_G4EVM
-	default "0x10000000" if MACH_AP4EVB
+	default "0x10000000" if MACH_AP4EVB || MACH_MACKEREL
 	default "0x20000000" if MACH_AG5EVM
 	default "0x04000000"
 	help
-- 
1.7.1

