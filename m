From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 24 May 2011 11:19:35 +0000
Subject: [PATCH] ARM: mach-shmobile: sh73a0: mark DMA slave ID 0 as invalid
Message-Id: <20110524111935.17651.24907.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

This makes it possible to leave DMA slave IDs in the platform data
at default 0 value without hitting DMA channel allocation error paths.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Has a build time dependency on the patch:
 "[PATCH] ARM: mach-shmobile: sh73a0 DMA Engine support for SY-DMAC"

 Can be merged separately but wants to be used together with:
 "[PATCH 3/3] mmc: SDHI: DMA slave ID 0 is invalid"

 arch/arm/mach-shmobile/include/mach/sh73a0.h |    1 +
 1 file changed, 1 insertion(+)

--- 0013/arch/arm/mach-shmobile/include/mach/sh73a0.h
+++ work/arch/arm/mach-shmobile/include/mach/sh73a0.h	2011-05-24 20:14:27.000000000 +0900
@@ -465,6 +465,7 @@ enum {
 };
 /* DMA slave IDs */
 enum {
+	SHDMA_SLAVE_INVALID,
 	SHDMA_SLAVE_SCIF0_TX,
 	SHDMA_SLAVE_SCIF0_RX,
 	SHDMA_SLAVE_SCIF1_TX,
