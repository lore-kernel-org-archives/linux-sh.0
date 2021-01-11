Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6380FC433DB
	for <linux-sh@archiver.kernel.org>; Mon, 11 Jan 2021 16:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A2212250F
	for <linux-sh@archiver.kernel.org>; Mon, 11 Jan 2021 16:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389089AbhAKQvA (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 11 Jan 2021 11:51:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389067AbhAKQvA (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Mon, 11 Jan 2021 11:51:00 -0500
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E28A8C061794
        for <linux-sh@vger.kernel.org>; Mon, 11 Jan 2021 08:50:19 -0800 (PST)
Received: from ramsan.of.borg ([84.195.186.194])
        by laurent.telenet-ops.be with bizsmtp
        id FUqG2400a4C55Sk01UqGfo; Mon, 11 Jan 2021 17:50:16 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1kz0OV-002uj5-R1; Mon, 11 Jan 2021 17:50:15 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1kz0OU-0025HE-Uh; Mon, 11 Jan 2021 17:50:14 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-renesas-soc@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2] pinctrl: renesas: checker: Restrict checks to Renesas platforms
Date:   Mon, 11 Jan 2021 17:50:13 +0100
Message-Id: <20210111165013.496897-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

When DEBUG is defined (e.g. if CONFIG_DEBUG_PINCTRL=y), the Renesas pin
control driver runs sanity checks against the pin control tables.  This
may cause lots of output on the console, and can be annoying in ARM
multi-platform kernels.  Fix this by only running the checks when
running on SuperH, or on a DT platform supported by the Renesas pin
controller driver.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
---
To be queued in renesas-pinctrl-for-v5.12.

v2:
  - Add Reviewed-by,
  - Use IS_ENABLED().
---
 drivers/pinctrl/renesas/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pinctrl/renesas/core.c b/drivers/pinctrl/renesas/core.c
index b16759a321ae9c94..2bfd3006f6fda445 100644
--- a/drivers/pinctrl/renesas/core.c
+++ b/drivers/pinctrl/renesas/core.c
@@ -1066,6 +1066,10 @@ static void __init sh_pfc_check_driver(const struct platform_driver *pdrv)
 {
 	unsigned int i;
 
+	if (!IS_ENABLED(CONFIG_SUPERH) &&
+	    !of_find_matching_node(NULL, pdrv->driver.of_match_table))
+		return;
+
 	sh_pfc_regs = kcalloc(SH_PFC_MAX_REGS, sizeof(*sh_pfc_regs),
 			      GFP_KERNEL);
 	if (!sh_pfc_regs)
-- 
2.25.1

