Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40865C77B75
	for <linux-sh@archiver.kernel.org>; Wed,  3 May 2023 08:14:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbjECIOb convert rfc822-to-8bit (ORCPT
        <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 3 May 2023 04:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjECIOa (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 3 May 2023 04:14:30 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB68133
        for <linux-sh@vger.kernel.org>; Wed,  3 May 2023 01:14:28 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1pu7d4-000jsx-Q7; Wed, 03 May 2023 10:14:26 +0200
Received: from p5b13ada3.dip0.t-ipconnect.de ([91.19.173.163] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1pu7d4-003Edo-JM; Wed, 03 May 2023 10:14:26 +0200
Message-ID: <eed749a0ec500edf4f70a50578eaa50803fdaf3c.camel@physik.fu-berlin.de>
Subject: Fixing "int-to-pointer-cast" warning in J2 code
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     linux-sh <linux-sh@vger.kernel.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>
Date:   Wed, 03 May 2023 10:14:25 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.1 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.173.163
X-ZEDAT-Hint: PO
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi!

When building j2_defconfig, the following warning is issued:

arch/sh/kernel/cpu/sh2/probe.c: In function 'scan_cache':
arch/sh/kernel/cpu/sh2/probe.c:24:16: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
   24 |  j2_ccr_base = (u32 __iomem *)of_flat_dt_translate_address(node);
      |

Reading the code and look how other users of of_flat_dt_translate_address()
used the return code, I came up with the following patch which fixes the issue:

diff --git a/arch/sh/kernel/cpu/sh2/probe.c b/arch/sh/kernel/cpu/sh2/probe.c
index d342ea08843f..a0dc3675fc68 100644
--- a/arch/sh/kernel/cpu/sh2/probe.c
+++ b/arch/sh/kernel/cpu/sh2/probe.c
@@ -14,14 +14,14 @@
 #include <asm/cache.h>
 
 #if defined(CONFIG_CPU_J2)
-extern u32 __iomem *j2_ccr_base;
+extern phys_addr_t j2_ccr_base;
 static int __init scan_cache(unsigned long node, const char *uname,
                             int depth, void *data)
 {
        if (!of_flat_dt_is_compatible(node, "jcore,cache"))
                return 0;
 
-       j2_ccr_base = (u32 __iomem *)of_flat_dt_translate_address(node);
+       j2_ccr_base = of_flat_dt_translate_address(node);
 
        return 1;
 }
diff --git a/arch/sh/mm/cache-j2.c b/arch/sh/mm/cache-j2.c
index f277862a11f5..2bc6d38d6f7c 100644
--- a/arch/sh/mm/cache-j2.c
+++ b/arch/sh/mm/cache-j2.c
@@ -22,7 +22,7 @@
 #define DCACHE_FLUSH   0x200
 #define CACHE_FLUSH    (ICACHE_FLUSH | DCACHE_FLUSH)
 
-u32 __iomem *j2_ccr_base;
+phys_addr_t j2_ccr_base;
 
 static void j2_flush_icache(void *args)
 {

Does that look reasonable?

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
