Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF3E6EB64DC
	for <linux-sh@archiver.kernel.org>; Sun,  9 Jul 2023 13:10:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjGINKx (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Sun, 9 Jul 2023 09:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbjGINKw (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Sun, 9 Jul 2023 09:10:52 -0400
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6490A194
        for <linux-sh@vger.kernel.org>; Sun,  9 Jul 2023 06:10:47 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:5bb:109a:ec27:6093])
        by laurent.telenet-ops.be with bizsmtp
        id K1Al2A0031ycx4f011AlM6; Sun, 09 Jul 2023 15:10:45 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qIUBT-000xGz-PE;
        Sun, 09 Jul 2023 15:10:45 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qIUBZ-003a2j-40;
        Sun, 09 Jul 2023 15:10:45 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] [RFC] sh: dreamcast: Handle virq offset in cascaded IRQ demux
Date:   Sun,  9 Jul 2023 15:10:43 +0200
Message-Id: <7d0cb246c9f1cd24bb1f637ec5cb67e799a4c3b8.1688908227.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Take into account the virq offset when translating cascaded interrupts.

Fixes: a8ac2961148e8c72 ("sh: Avoid using IRQ0 on SH3 and SH4")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Compile-tested only.
---
 arch/sh/boards/mach-dreamcast/irq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/sh/boards/mach-dreamcast/irq.c b/arch/sh/boards/mach-dreamcast/irq.c
index cc06e4cdb4cdf9b7..4e5fb59481a26747 100644
--- a/arch/sh/boards/mach-dreamcast/irq.c
+++ b/arch/sh/boards/mach-dreamcast/irq.c
@@ -108,13 +108,13 @@ int systemasic_irq_demux(int irq)
 	__u32 j, bit;
 
 	switch (irq) {
-	case 13:
+	case 16 + 13:
 		level = 0;
 		break;
-	case 11:
+	case 16 + 11:
 		level = 1;
 		break;
-	case  9:
+	case 16 + 9:
 		level = 2;
 		break;
 	default:
-- 
2.34.1

