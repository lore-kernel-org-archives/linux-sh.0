From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 20 Jun 2014 10:17:25 +0000
Subject: [PATCH/POC 1/2] ARM: shmobile: r8a7791: Add MSIOF DMA support
Message-Id: <1403259446-13696-2-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/mach-shmobile/include/mach/r8a7791.h | 6 ++++++
 arch/arm/mach-shmobile/setup-r8a7791.c        | 5 ++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/include/mach/r8a7791.h b/arch/arm/mach-shmobile/include/mach/r8a7791.h
index c4582df76139..cfde0f61580e 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7791.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7791.h
@@ -4,6 +4,12 @@
 /* DMA slave IDs */
 enum {
 	RCAR_DMA_SLAVE_INVALID,
+	SYS_DMAC_SLAVE_MSIOF0_TX,
+	SYS_DMAC_SLAVE_MSIOF0_RX,
+	SYS_DMAC_SLAVE_MSIOF1_TX,
+	SYS_DMAC_SLAVE_MSIOF1_RX,
+	SYS_DMAC_SLAVE_MSIOF2_TX,
+	SYS_DMAC_SLAVE_MSIOF2_RX,
 	SYS_DMAC_SLAVE_QSPI_TX,
 	SYS_DMAC_SLAVE_QSPI_RX,
 };
diff --git a/arch/arm/mach-shmobile/setup-r8a7791.c b/arch/arm/mach-shmobile/setup-r8a7791.c
index 0b7252902e1d..a3efc1f85ec4 100644
--- a/arch/arm/mach-shmobile/setup-r8a7791.c
+++ b/arch/arm/mach-shmobile/setup-r8a7791.c
@@ -57,7 +57,10 @@
 }
 
 static const struct sh_dmae_slave_config r8a7791_sys_dmac_slaves[] = {
-	SYS_DMAC_SLAVE(QSPI,   8, 0xe6b10000, 0x04, 0x04,   0x17, 0x18),
+	SYS_DMAC_SLAVE(MSIOF0, 32, 0xe7e20000, 0x50, 0x60, 0x51, 0x52),
+	SYS_DMAC_SLAVE(MSIOF1, 32, 0xe7e10000, 0x50, 0x60, 0x55, 0x56),
+	SYS_DMAC_SLAVE(MSIOF2, 32, 0xe7e00000, 0x50, 0x60, 0x41, 0x42),
+	SYS_DMAC_SLAVE(QSPI,    8, 0xe6b10000, 0x04, 0x04, 0x17, 0x18),
 };
 
 static const struct sh_dmae_channel r8a7791_sys_dmac_channels[] = {
-- 
1.9.1

