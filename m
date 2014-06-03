From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 03 Jun 2014 22:33:14 +0000
Subject: [PATCH 02/03] ARM: shmobile: r8a7790: SYS-DMAC and MMCIF prototype
Message-Id: <20140603223314.2193.24640.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Add r8a7790 MMCIF entries to the SYS-DMAC prototype
code to allow board specific use of DMA with MMCIF.

Not for upstream merge.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Written on top of renesas-devel-v3.15-rc7-20140530 and
 [PATCH 01/03] ARM: shmobile: r8a7790: SYS-DMAC prototype

 arch/arm/mach-shmobile/include/mach/r8a7790.h |    4 ++++
 arch/arm/mach-shmobile/setup-r8a7790.c        |    2 ++
 2 files changed, 6 insertions(+)

--- 0001/arch/arm/mach-shmobile/include/mach/r8a7790.h
+++ work/arch/arm/mach-shmobile/include/mach/r8a7790.h	2014-06-03 21:54:19.000000000 +0900
@@ -26,6 +26,10 @@ enum {
 	AUDIO_DMAC_SLAVE_SSI8_RX,
 	AUDIO_DMAC_SLAVE_SSI9_TX,
 	AUDIO_DMAC_SLAVE_SSI9_RX,
+	SYS_DMAC_SLAVE_MMCIF0_TX,
+	SYS_DMAC_SLAVE_MMCIF0_RX,
+	SYS_DMAC_SLAVE_MMCIF1_TX,
+	SYS_DMAC_SLAVE_MMCIF1_RX,
 };
 
 void r8a7790_add_standard_devices(void);
--- 0002/arch/arm/mach-shmobile/setup-r8a7790.c
+++ work/arch/arm/mach-shmobile/setup-r8a7790.c	2014-06-03 21:53:31.000000000 +0900
@@ -55,6 +55,8 @@
 }
 
 static const struct sh_dmae_slave_config r8a7790_sys_dmac_slaves[] = {
+	SYS_DMAC_SLAVE(MMCIF0, 32, 0xee200000, 0x34, 0x34, 0xd1, 0xd2),
+	SYS_DMAC_SLAVE(MMCIF1, 32, 0xee220000, 0x34, 0x34, 0xe1, 0xe2),
 };
 
 static const struct sh_dmae_channel r8a7790_sys_dmac_channels[] = {
