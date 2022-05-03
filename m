Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C804C433F5
	for <linux-sh@archiver.kernel.org>; Tue,  3 May 2022 20:42:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242189AbiECUqL (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 3 May 2022 16:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241919AbiECUqD (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 3 May 2022 16:46:03 -0400
Received: from mxout01.lancloud.ru (mxout01.lancloud.ru [45.84.86.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3904732EF8;
        Tue,  3 May 2022 13:42:22 -0700 (PDT)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout01.lancloud.ru EDDEA20E410A
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH v4] sh: avoid using IRQ0 on SH3/4
To:     Rich Felker <dalias@libc.org>, <linux-sh@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Organization: Open Mobile Platform
Message-ID: <b2bccbca-6acf-7129-0099-7ad21bf13430@omp.ru>
Date:   Tue, 3 May 2022 23:42:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Using IRQ0 by the platform devices is going to be disallowed soon (see [1])
and even now, when IRQ0 is about to be returned by platfrom_get_irq(), you
see a big warning.  The code supporting SH3/4 SoCs maps the IRQ #s starting
at 0 -- modify that code to start the IRQ #s from 16 instead.

The patch should mostly affect the AP-SH4A-3A/AP-SH4AD-0A boards as they
indeed use IRQ0 for the SMSC911x compatible Ethernet chip...

[1] https://lore.kernel.org/all/025679e1-1f0a-ae4b-4369-01164f691511@omp.ru/

Fixes: a85a6c86c25b ("driver core: platform: Clarify that IRQ 0 is invalid")
Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

---
The patch is against Linus Torvalds' 'linux.git' repo.

Changes in version 4:
- fixed up the off-chip base IRQ #s for the Dreamcast/Highlander/R2D/SE7724
  boards.

Changes in version 3:
- added an appropriate Fixes: tag and added a passage about it to the patch
  description;
- added actual cases of the boards using IRQ0 to the patch description;
- added Geert Uytterhoeven's and John Paul Adrian Glaubitz's tags;
- updated the link to point to the version 2 of the patch.

Changes in version 2:
- changed cmp/ge to cmp/hs in the assembly code.

 arch/sh/include/mach-common/mach/highlander.h |    2 +-
 arch/sh/include/mach-common/mach/r2d.h        |    2 +-
 arch/sh/include/mach-dreamcast/mach/sysasic.h |    2 +-
 arch/sh/include/mach-se/mach/se7724.h         |    2 +-
 arch/sh/kernel/cpu/sh3/entry.S                |    4 ++--
 include/linux/sh_intc.h                       |    6 +++---
 6 files changed, 9 insertions(+), 9 deletions(-)

Index: linux/arch/sh/include/mach-common/mach/highlander.h
===================================================================
--- linux.orig/arch/sh/include/mach-common/mach/highlander.h
+++ linux/arch/sh/include/mach-common/mach/highlander.h
@@ -176,7 +176,7 @@
 #define IVDR_CK_ON	4		/* iVDR Clock ON */
 #endif
 
-#define HL_FPGA_IRQ_BASE	200
+#define HL_FPGA_IRQ_BASE	(200 + 16)
 #define HL_NR_IRL		15
 
 #define IRQ_AX88796		(HL_FPGA_IRQ_BASE + 0)
Index: linux/arch/sh/include/mach-common/mach/r2d.h
===================================================================
--- linux.orig/arch/sh/include/mach-common/mach/r2d.h
+++ linux/arch/sh/include/mach-common/mach/r2d.h
@@ -47,7 +47,7 @@
 
 #define IRLCNTR1	(PA_BCR + 0)	/* Interrupt Control Register1 */
 
-#define R2D_FPGA_IRQ_BASE	100
+#define R2D_FPGA_IRQ_BASE	(100 + 16)
 
 #define IRQ_VOYAGER		(R2D_FPGA_IRQ_BASE + 0)
 #define IRQ_EXT			(R2D_FPGA_IRQ_BASE + 1)
Index: linux/arch/sh/include/mach-dreamcast/mach/sysasic.h
===================================================================
--- linux.orig/arch/sh/include/mach-dreamcast/mach/sysasic.h
+++ linux/arch/sh/include/mach-dreamcast/mach/sysasic.h
@@ -22,7 +22,7 @@
    takes.
 */
 
-#define HW_EVENT_IRQ_BASE  48
+#define HW_EVENT_IRQ_BASE  (48 + 16)
 
 /* IRQ 13 */
 #define HW_EVENT_VSYNC     (HW_EVENT_IRQ_BASE +  5) /* VSync */
Index: linux/arch/sh/include/mach-se/mach/se7724.h
===================================================================
--- linux.orig/arch/sh/include/mach-se/mach/se7724.h
+++ linux/arch/sh/include/mach-se/mach/se7724.h
@@ -37,7 +37,7 @@
 #define IRQ2_IRQ        evt2irq(0x640)
 
 /* Bits in IRQ012 registers */
-#define SE7724_FPGA_IRQ_BASE	220
+#define SE7724_FPGA_IRQ_BASE	(220 + 16)
 
 /* IRQ0 */
 #define IRQ0_BASE	SE7724_FPGA_IRQ_BASE
Index: linux/arch/sh/kernel/cpu/sh3/entry.S
===================================================================
--- linux.orig/arch/sh/kernel/cpu/sh3/entry.S
+++ linux/arch/sh/kernel/cpu/sh3/entry.S
@@ -470,9 +470,9 @@ ENTRY(handle_interrupt)
 	mov	r4, r0		! save vector->jmp table offset for later
 
 	shlr2	r4		! vector to IRQ# conversion
-	add	#-0x10, r4
 
-	cmp/pz	r4		! is it a valid IRQ?
+	mov	#0x10, r5
+	cmp/hs	r5, r4		! is it a valid IRQ?
 	bt	10f
 
 	/*
Index: linux/include/linux/sh_intc.h
===================================================================
--- linux.orig/include/linux/sh_intc.h
+++ linux/include/linux/sh_intc.h
@@ -13,9 +13,9 @@
 /*
  * Convert back and forth between INTEVT and IRQ values.
  */
-#ifdef CONFIG_CPU_HAS_INTEVT
-#define evt2irq(evt)		(((evt) >> 5) - 16)
-#define irq2evt(irq)		(((irq) + 16) << 5)
+#ifdef CONFIG_CPU_HAS_INTEVT	/* Avoid IRQ0 (invalid for platform devices) */
+#define evt2irq(evt)		((evt) >> 5)
+#define irq2evt(irq)		((irq) << 5)
 #else
 #define evt2irq(evt)		(evt)
 #define irq2evt(irq)		(irq)
