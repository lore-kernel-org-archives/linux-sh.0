Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A81C4CA5512
	for <linux-sh@archiver.kernel.org>; Wed, 13 Sep 2023 09:24:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239269AbjIMJYO (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 13 Sep 2023 05:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239271AbjIMJYL (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 13 Sep 2023 05:24:11 -0400
Received: from hsmtpd-def.xspmail.jp (hsmtpd-def.xspmail.jp [202.238.198.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 994CE199D
        for <linux-sh@vger.kernel.org>; Wed, 13 Sep 2023 02:24:06 -0700 (PDT)
X-Country-Code: JP
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp [153.127.30.23])
        by hsmtpd-out-2.asahinet.cluster.xspmail.jp (Halon) with ESMTPA
        id 5ed89b69-2ca2-4843-99d4-afa9ea18af14;
        Wed, 13 Sep 2023 18:24:06 +0900 (JST)
Received: from SIOS1075.ysato.name (al128006.dynamic.ppp.asahi-net.or.jp [111.234.128.6])
        by sakura.ysato.name (Postfix) with ESMTPSA id AD7B01C0198;
        Wed, 13 Sep 2023 18:24:05 +0900 (JST)
From:   Yoshinori Sato <ysato@users.sourceforge.jp>
To:     linux-sh@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        glaubitz@physik.fu-berlin.de
Subject: [RFC PATCH v2 19/30] drivers/tty: sh-sci fix SH4 OF support.
Date:   Wed, 13 Sep 2023 18:23:44 +0900
Message-Id: <cef5926b1fbf18d2a3aec93dca8f1a9fb579e643.1694596125.git.ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1694596125.git.ysato@users.sourceforge.jp>
References: <cover.1694596125.git.ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

- fix earlycon name.
- fix earlyprintk hung (NULL pointer reference).
- clocks property support.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 drivers/tty/serial/sh-sci.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index a560b729fa3b..7ff1733d3368 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2720,7 +2720,7 @@ static int sci_remap_port(struct uart_port *port)
 	if (port->membase)
 		return 0;
 
-	if (port->dev->of_node || (port->flags & UPF_IOREMAP)) {
+	if ((port->dev && port->dev->of_node) || (port->flags & UPF_IOREMAP)) {
 		port->membase = ioremap(port->mapbase, sport->reg_size);
 		if (unlikely(!port->membase)) {
 			dev_err(port->dev, "can't remap port#%d\n", port->line);
@@ -2842,6 +2842,8 @@ static int sci_init_clocks(struct sci_port *sci_port, struct device *dev)
 			 * global "peripheral_clk" clock.
 			 */
 			clk = devm_clk_get(dev, "peripheral_clk");
+			if (IS_ERR(clk))
+				clk = devm_clk_get(dev, NULL);
 			if (IS_ERR(clk))
 				return dev_err_probe(dev, PTR_ERR(clk),
 						     "failed to get %s\n",
@@ -3555,8 +3557,8 @@ static int __init hscif_early_console_setup(struct earlycon_device *device,
 
 OF_EARLYCON_DECLARE(sci, "renesas,sci", sci_early_console_setup);
 OF_EARLYCON_DECLARE(scif, "renesas,scif", scif_early_console_setup);
-OF_EARLYCON_DECLARE(scif, "renesas,scif-r7s9210", rzscifa_early_console_setup);
-OF_EARLYCON_DECLARE(scif, "renesas,scif-r9a07g044", rzscifa_early_console_setup);
+OF_EARLYCON_DECLARE(rzscif, "renesas,scif-r7s9210", rzscifa_early_console_setup);
+OF_EARLYCON_DECLARE(rzscif, "renesas,scif-r9a07g044", rzscifa_early_console_setup);
 OF_EARLYCON_DECLARE(scifa, "renesas,scifa", scifa_early_console_setup);
 OF_EARLYCON_DECLARE(scifb, "renesas,scifb", scifb_early_console_setup);
 OF_EARLYCON_DECLARE(hscif, "renesas,hscif", hscif_early_console_setup);
-- 
2.39.2

