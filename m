From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 28 Dec 2012 11:32:54 +0000
Subject: [PATCH v2] ARM: sh7372: fix cache clean / invalidate order
Message-Id: <Pine.LNX.4.64.1212281227070.29263@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <20120919134658.GA2111@linaro.org>
 <20120920102514.GD4588@e102568-lin.cambridge.arm.com>
 <20120920110439.GB2117@linaro.org>
 <Pine.LNX.4.64.1212111655050.29758@axis700.grange>
 <20121211163313.GG16759@mudshark.cambridge.arm.com>
 <20121211163843.GH16759@mudshark.cambridge.arm.com>
 <50C7C16B.7050106@codeaurora.org>
 <20121212103338.GB23022@e102568-lin.cambridge.arm.com>
 <20121212133650.GJ6195@mudshark.cambridge.arm.com>
 <Pine.LNX.4.64.1212130909190.18586@axis700.grange>
 <20121213105109.GB26540@mudshark.cambridge.arm.com>
 <Pine.LNX.4.64.1212131522430.18586@axis700.grange> <50C9E8BD.1020501@ti.com>
In-Reply-To: <50C9E8BD.1020501@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

According to the Cortex A8 TRM the L2 cache should be first cleaned and 
then disabled. Fix the swapped order on sh7372.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---

v2: addressed improvement suggestions by Santosh, thanks

diff --git a/arch/arm/mach-shmobile/sleep-sh7372.S b/arch/arm/mach-shmobile/sleep-sh7372.S
index 1d56467..a9df53b 100644
--- a/arch/arm/mach-shmobile/sleep-sh7372.S
+++ b/arch/arm/mach-shmobile/sleep-sh7372.S
@@ -59,17 +59,19 @@ sh7372_do_idle_sysc:
 	mcr	p15, 0, r0, c1, c0, 0
 	isb
 
+	/*
+	 * Clean and invalidate data cache again.
+	 */
+	ldr	r1, kernel_flush
+	blx	r1
+
 	/* disable L2 cache in the aux control register */
 	mrc     p15, 0, r10, c1, c0, 1
 	bic     r10, r10, #2
 	mcr     p15, 0, r10, c1, c0, 1
+	isb
 
 	/*
-	 * Invalidate data cache again.
-	 */
-	ldr	r1, kernel_flush
-	blx	r1
-	/*
 	 * The kernel doesn't interwork: v7_flush_dcache_all in particluar will
 	 * always return in Thumb state when CONFIG_THUMB2_KERNEL is enabled.
 	 * This sequence switches back to ARM.  Note that .align may insert a
