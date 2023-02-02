Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F6EEC61DA4
	for <linux-sh@archiver.kernel.org>; Thu,  2 Feb 2023 16:22:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232727AbjBBQWI (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Thu, 2 Feb 2023 11:22:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232805AbjBBQVr (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Thu, 2 Feb 2023 11:21:47 -0500
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A377B6EAF5
        for <linux-sh@vger.kernel.org>; Thu,  2 Feb 2023 08:21:02 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed50:f3de:d156:24ca:e691])
        by baptiste.telenet-ops.be with bizsmtp
        id GGLy2900Y1R5m7k01GLy0T; Thu, 02 Feb 2023 17:20:59 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pNcKJ-0083Hc-Nx;
        Thu, 02 Feb 2023 17:20:58 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pNcKY-002C3U-I0;
        Thu, 02 Feb 2023 17:20:58 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     linux-sh@vger.kernel.org, linux-clk@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] sh: clk: Fix clk_enable() to return 0 on NULL clk
Date:   Thu,  2 Feb 2023 17:20:55 +0100
Message-Id: <b53e6b557b4240579933b3359dda335ff94ed5af.1675354849.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On SH, devm_clk_get_optional_enabled() fails with -EINVAL if the clock
is not found.  This happens because __devm_clk_get() assumes it can pass
a NULL clock pointer (as returned by clk_get_optional()) to the init()
function (clk_prepare_enable() in this case), while the SH
implementation of clk_enable() considers that an error.

Fix this by making the SH clk_enable() implementation return zero
instead, like the Common Clock Framework does.

Reported-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Exposed by commit 599566c1c3692052 ("r8169: use
devm_clk_get_optional_enabled() to simplify the code"), cfr.
https://lore.kernel.org/all/585c4b48790d71ca43b66fc24ea8d84917c4a0e1.camel@physik.fu-berlin.de

Boot-tested on qemu/rts7751r2d, which did not show the problem though.
---
 drivers/sh/clk/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/sh/clk/core.c b/drivers/sh/clk/core.c
index d996782a710642cd..7a73f5e4a1fc70cc 100644
--- a/drivers/sh/clk/core.c
+++ b/drivers/sh/clk/core.c
@@ -295,7 +295,7 @@ int clk_enable(struct clk *clk)
 	int ret;
 
 	if (!clk)
-		return -EINVAL;
+		return 0;
 
 	spin_lock_irqsave(&clock_lock, flags);
 	ret = __clk_enable(clk);
-- 
2.34.1

