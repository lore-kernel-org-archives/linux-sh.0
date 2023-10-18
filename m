Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A84FCDB47E
	for <linux-sh@archiver.kernel.org>; Wed, 18 Oct 2023 12:40:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbjJRMkw (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 18 Oct 2023 08:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbjJRMkq (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 18 Oct 2023 08:40:46 -0400
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63D0134
        for <linux-sh@vger.kernel.org>; Wed, 18 Oct 2023 05:40:37 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:788:5cb7:d72f:3d60])
        by xavier.telenet-ops.be with bizsmtp
        id zQgZ2A00941Ju1s01QgZoX; Wed, 18 Oct 2023 14:40:34 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qt5qe-006roM-Kz;
        Wed, 18 Oct 2023 14:40:33 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qt5qi-00CHdL-V2;
        Wed, 18 Oct 2023 14:40:32 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     Guenter Roeck <linux@roeck-us.net>, qemu-devel@nongnu.org,
        linux-sh@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH RFC] hw/sh4/sh7750: Add STBCR/STBCR2 register support
Date:   Wed, 18 Oct 2023 14:40:23 +0200
Message-Id: <20231018124023.2927710-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

The new Linux SH7750 clock driver uses the registers for power-down
mode control, causing a crash:

    byte read to SH7750_STBCR_A7 (0x000000001fc00004) not supported
    Aborted (core dumped)

Fix this by adding support for the Standby Control Registers STBCR and
STBCR2.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
[RFC PATCH v3 12/35] drivers/clk/renesas: clk-sh7750.c SH7750/7751 CPG driver.
https://lore.kernel.org/all/a772e1b6de89af22057d3af31cc03dcad7964fc7.1697199949.git.ysato@users.sourceforge.jp

Accesses to CLKSTP00 and CLKSTCLK00 (0xfe0a0000/0x1e0a0000 and
0xfe0a0008/0x1e0a0008) don't seem to cause any issues, although I can't
see immediately where they are handled?

---
 hw/sh4/sh7750.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/hw/sh4/sh7750.c b/hw/sh4/sh7750.c
index ebe0fd96d94ca17b..deeb83b4540bbf2b 100644
--- a/hw/sh4/sh7750.c
+++ b/hw/sh4/sh7750.c
@@ -59,6 +59,9 @@ typedef struct SH7750State {
     uint16_t bcr3;
     uint32_t bcr4;
     uint16_t rfcr;
+    /* Power-Down Modes */
+    uint8_t stbcr;
+    uint8_t stbcr2;
     /* PCMCIA controller */
     uint16_t pcr;
     /* IO ports */
@@ -219,7 +222,13 @@ static void ignore_access(const char *kind, hwaddr addr)
 
 static uint32_t sh7750_mem_readb(void *opaque, hwaddr addr)
 {
+    SH7750State *s = opaque;
+
     switch (addr) {
+    case SH7750_STBCR_A7:
+        return s->stbcr;
+    case SH7750_STBCR2_A7:
+        return s->stbcr2;
     default:
         error_access("byte read", addr);
         abort();
@@ -318,14 +327,24 @@ static uint32_t sh7750_mem_readl(void *opaque, hwaddr addr)
 static void sh7750_mem_writeb(void *opaque, hwaddr addr,
                               uint32_t mem_value)
 {
+    SH7750State *s = opaque;
 
     if (is_in_sdrmx(addr, 2) || is_in_sdrmx(addr, 3)) {
         ignore_access("byte write", addr);
         return;
     }
 
-    error_access("byte write", addr);
-    abort();
+    switch (addr) {
+    case SH7750_STBCR_A7:
+        s->stbcr = mem_value;
+        return;
+    case SH7750_STBCR2_A7:
+        s->stbcr2 = mem_value;
+        return;
+    default:
+        error_access("byte write", addr);
+        abort();
+    }
 }
 
 static void sh7750_mem_writew(void *opaque, hwaddr addr,
-- 
2.34.1

