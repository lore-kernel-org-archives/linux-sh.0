From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 20 Oct 2011 03:01:53 +0000
Subject: [PATCH 2/5] ARM: mach-shmobile: bonito: make sure static function
Message-Id: <87ehy82wo2.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

fpga_xxx() were static functions

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-bonito.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-bonito.c b/arch/arm/mach-shmobile/board-bonito.c
index a00de29..3a91e9c 100644
--- a/arch/arm/mach-shmobile/board-bonito.c
+++ b/arch/arm/mach-shmobile/board-bonito.c
@@ -83,12 +83,12 @@
 #define LCDCR		0x10B4
 #define A1MDSR		0x10E0
 #define BVERR		0x1100
-u16 fpga_read(u32 offset)
+static u16 fpga_read(u32 offset)
 {
 	return __raw_readw(0xf0003000 + offset);
 }
 
-void fpga_write(u32 offset, u16 val, u16 mask)
+static void fpga_write(u32 offset, u16 val, u16 mask)
 {
 	u16 tmp;
 
-- 
1.7.4.1

