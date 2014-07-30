From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 30 Jul 2014 22:27:14 +0000
Subject: [PATCH 01/02] ARM: shmobile: Lager SYS-DMAC and SCIF RX prototype
Message-Id: <20140730222714.4799.81166.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Enable RX DMA for r8a7790 / Lager SCIF devices.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 arch/arm/mach-shmobile/board-lager-reference.c |   28 ++++++++----------------
 1 file changed, 10 insertions(+), 18 deletions(-)

--- 0021/arch/arm/mach-shmobile/board-lager-reference.c
+++ work/arch/arm/mach-shmobile/board-lager-reference.c	2014-07-31 07:09:30.000000000 +0900
@@ -144,29 +144,21 @@ enum {
 	.mid_rid	= r,					\
 }
 
-#define SYS_DMAC_SLAVE_TX(_id, _bit, _addr, toffset, roffset, t, r)	\
-{								\
-	.slave_id	= SYS_DMAC_SLAVE_## _id ##_TX,		\
-	.addr		= _addr + toffset,			\
-	.chcr		= CHCR_TX(XMIT_SZ_## _bit ##BIT),	\
-	.mid_rid	= t,					\
-}
-
 static const struct sh_dmae_slave_config r8a7790_sys_dmac_slaves[] = {
 	SYS_DMAC_SLAVE(MMCIF0, 32, 0xee200000, 0x34, 0x34, 0xd1, 0xd2),
 	SYS_DMAC_SLAVE(MMCIF1, 32, 0xee220000, 0x34, 0x34, 0xe1, 0xe2),
 	SYS_DMAC_SLAVE(SDHI0, 16, 0xee100000, 0x60, 0x2060, 0xcd, 0xce),
 	SYS_DMAC_SLAVE(SDHI2, 16, 0xee140000, 0x30, 0x2030, 0xc1, 0xc2),
-	SYS_DMAC_SLAVE_TX(SCIF0, 8, 0xe6e60000, 0xc, 0x14, 0x29, 0x2a),
-	SYS_DMAC_SLAVE_TX(SCIF1, 8, 0xe6e68000, 0xc, 0x14, 0x2d, 0x2e),
-	SYS_DMAC_SLAVE_TX(SCIFA0, 8, 0xe6c40000, 0x20, 0x24, 0x21, 0x22),
-	SYS_DMAC_SLAVE_TX(SCIFA1, 8, 0xe6c50000, 0x20, 0x24, 0x25, 0x26),
-	SYS_DMAC_SLAVE_TX(SCIFA2, 8, 0xe6c60000, 0x20, 0x24, 0x27, 0x28),
-	SYS_DMAC_SLAVE_TX(SCIFB0, 8, 0xe6c20000, 0x40, 0x60, 0x3d, 0x3e),
-	SYS_DMAC_SLAVE_TX(SCIFB1, 8, 0xe6c30000, 0x40, 0x60, 0x19, 0x1a),
-	SYS_DMAC_SLAVE_TX(SCIFB2, 8, 0xe6ce0000, 0x40, 0x60, 0x1d, 0x1e),
-	SYS_DMAC_SLAVE_TX(HSCIF0, 8, 0xe62c0000, 0xc, 0x14, 0x39, 0x3a),
-	SYS_DMAC_SLAVE_TX(HSCIF1, 8, 0xe62c8000, 0xc, 0x14, 0x4d, 0x4e),
+	SYS_DMAC_SLAVE(SCIF0, 8, 0xe6e60000, 0xc, 0x14, 0x29, 0x2a),
+	SYS_DMAC_SLAVE(SCIF1, 8, 0xe6e68000, 0xc, 0x14, 0x2d, 0x2e),
+	SYS_DMAC_SLAVE(SCIFA0, 8, 0xe6c40000, 0x20, 0x24, 0x21, 0x22),
+	SYS_DMAC_SLAVE(SCIFA1, 8, 0xe6c50000, 0x20, 0x24, 0x25, 0x26),
+	SYS_DMAC_SLAVE(SCIFA2, 8, 0xe6c60000, 0x20, 0x24, 0x27, 0x28),
+	SYS_DMAC_SLAVE(SCIFB0, 8, 0xe6c20000, 0x40, 0x60, 0x3d, 0x3e),
+	SYS_DMAC_SLAVE(SCIFB1, 8, 0xe6c30000, 0x40, 0x60, 0x19, 0x1a),
+	SYS_DMAC_SLAVE(SCIFB2, 8, 0xe6ce0000, 0x40, 0x60, 0x1d, 0x1e),
+	SYS_DMAC_SLAVE(HSCIF0, 8, 0xe62c0000, 0xc, 0x14, 0x39, 0x3a),
+	SYS_DMAC_SLAVE(HSCIF1, 8, 0xe62c8000, 0xc, 0x14, 0x4d, 0x4e),
 	SYS_DMAC_SLAVE(MSIOF0, 32, 0xe7e20000, 0x50, 0x60, 0x51, 0x52),
 	SYS_DMAC_SLAVE(MSIOF1, 32, 0xe7e10000, 0x50, 0x60, 0x55, 0x56),
 	SYS_DMAC_SLAVE(MSIOF2, 32, 0xe7e00000, 0x50, 0x60, 0x41, 0x42),
