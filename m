Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABAC4EB64DC
	for <linux-sh@archiver.kernel.org>; Sun,  9 Jul 2023 12:14:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjGIMOC (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Sun, 9 Jul 2023 08:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjGIMOB (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Sun, 9 Jul 2023 08:14:01 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20002D2;
        Sun,  9 Jul 2023 05:13:50 -0700 (PDT)
X-GND-Sasl: contact@artur-rojek.eu
X-GND-Sasl: contact@artur-rojek.eu
X-GND-Sasl: contact@artur-rojek.eu
X-GND-Sasl: contact@artur-rojek.eu
X-GND-Sasl: contact@artur-rojek.eu
X-GND-Sasl: contact@artur-rojek.eu
X-GND-Sasl: contact@artur-rojek.eu
Received: by mail.gandi.net (Postfix) with ESMTPSA id 32BDF1BF205;
        Sun,  9 Jul 2023 12:13:47 +0000 (UTC)
From:   Artur Rojek <contact@artur-rojek.eu>
To:     Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        Artur Rojek <contact@artur-rojek.eu>
Subject: [PATCH] sh: hd64461: fix virq offsets
Date:   Sun,  9 Jul 2023 14:13:11 +0200
Message-ID: <20230709121311.211720-1-contact@artur-rojek.eu>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

A recent change to start counting SuperH IRQ #s from 16 breaks support
for the Hitachi HD64461 companion chip.

Move the offchip IRQ base and HD64461 IRQ # by 16 in order to
accommodate for the new virq numbering rules.

Fixes: a8ac2961148e ("sh: Avoid using IRQ0 on SH3 and SH4")
Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
---
 arch/sh/cchips/Kconfig        | 4 ++--
 arch/sh/include/asm/hd64461.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/sh/cchips/Kconfig b/arch/sh/cchips/Kconfig
index efde2edb5627..9659a0bc58de 100644
--- a/arch/sh/cchips/Kconfig
+++ b/arch/sh/cchips/Kconfig
@@ -29,9 +29,9 @@ endchoice
 config HD64461_IRQ
 	int "HD64461 IRQ"
 	depends on HD64461
-	default "36"
+	default "52"
 	help
-	  The default setting of the HD64461 IRQ is 36.
+	  The default setting of the HD64461 IRQ is 52.
 
 	  Do not change this unless you know what you are doing.
 
diff --git a/arch/sh/include/asm/hd64461.h b/arch/sh/include/asm/hd64461.h
index afb24cb034b1..6d85db6cf54b 100644
--- a/arch/sh/include/asm/hd64461.h
+++ b/arch/sh/include/asm/hd64461.h
@@ -229,7 +229,7 @@
 #define	HD64461_NIMR		HD64461_IO_OFFSET(0x5002)
 
 #define	HD64461_IRQBASE		OFFCHIP_IRQ_BASE
-#define	OFFCHIP_IRQ_BASE	64
+#define	OFFCHIP_IRQ_BASE	80
 #define	HD64461_IRQ_NUM		16
 
 #define	HD64461_IRQ_UART	(HD64461_IRQBASE+5)
-- 
2.41.0

