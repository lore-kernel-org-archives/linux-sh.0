Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF74EB64DD
	for <linux-sh@archiver.kernel.org>; Sun,  9 Jul 2023 11:15:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjGILP5 (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Sun, 9 Jul 2023 07:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjGILP5 (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Sun, 9 Jul 2023 07:15:57 -0400
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72DBE131
        for <linux-sh@vger.kernel.org>; Sun,  9 Jul 2023 04:15:55 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:5bb:109a:ec27:6093])
        by xavier.telenet-ops.be with bizsmtp
        id JzFr2A0081ycx4f01zFrvK; Sun, 09 Jul 2023 13:15:52 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qISOH-000x9R-SV;
        Sun, 09 Jul 2023 13:15:51 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qISON-003NUk-5d;
        Sun, 09 Jul 2023 13:15:51 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Guenter Roeck <linux@roeck-us.net>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] [RFT] sh: mach-r2d: Handle virq offset in cascaded IRL demux
Date:   Sun,  9 Jul 2023 13:15:49 +0200
Message-Id: <2c99d5df41c40691f6c407b7b6a040d406bc81ac.1688901306.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

When booting rts7751r2dplus_defconfig on QEMU, the system hangs due to
an interrupt storm on IRQ 20.  IRQ 20 aka event 0x280 is a cascaded IRL
interrupt, which maps to IRQ_VOYAGER, the interrupt used by the Silicon
Motion SM501 multimedia companion chip.  As rts7751r2d_irq_demux() does
not take into account the new virq offset, the interrupt is no longer
translated, leading to an unhandled interrupt.

Fix this by taking into account the virq offset when translating
cascaded IRL interrupts.

Fixes: a8ac2961148e8c72 ("sh: Avoid using IRQ0 on SH3 and SH4")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Closes: https://lore.kernel.org/r/fbfea3ad-d327-4ad5-ac9c-648c7ca3fe1f@roeck-us.net
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Highlander and Dreamcast probably have the same issue.
I'll send patches for these later...
---
 arch/sh/boards/mach-r2d/irq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sh/boards/mach-r2d/irq.c b/arch/sh/boards/mach-r2d/irq.c
index e34f81e9ae813b8d..c37b40398c5bc83e 100644
--- a/arch/sh/boards/mach-r2d/irq.c
+++ b/arch/sh/boards/mach-r2d/irq.c
@@ -117,10 +117,10 @@ static unsigned char irl2irq[R2D_NR_IRL];
 
 int rts7751r2d_irq_demux(int irq)
 {
-	if (irq >= R2D_NR_IRL || irq < 0 || !irl2irq[irq])
+	if (irq >= 16 + R2D_NR_IRL || irq < 16 || !irl2irq[irq - 16])
 		return irq;
 
-	return irl2irq[irq];
+	return irl2irq[irq - 16];
 }
 
 /*
-- 
2.34.1

