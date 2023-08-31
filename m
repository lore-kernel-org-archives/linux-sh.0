Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0090BC83F1B
	for <linux-sh@archiver.kernel.org>; Thu, 31 Aug 2023 01:12:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjHaBMP (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 30 Aug 2023 21:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344985AbjHaBMN (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 30 Aug 2023 21:12:13 -0400
Received: from hsmtpd-def.xspmail.jp (hsmtpd-def.xspmail.jp [202.238.198.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4EFCE0
        for <linux-sh@vger.kernel.org>; Wed, 30 Aug 2023 18:12:08 -0700 (PDT)
X-Country-Code: JP
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp [153.127.30.23])
        by hsmtpd-out-1.asahinet.cluster.xspmail.jp (Halon) with ESMTPA
        id c45f0d71-a94a-432f-acdd-cc978bab6f45;
        Thu, 31 Aug 2023 10:12:07 +0900 (JST)
Received: from SIOS1075.flets-east.jp (al128006.dynamic.ppp.asahi-net.or.jp [111.234.128.6])
        by sakura.ysato.name (Postfix) with ESMTPSA id CC4311C0431;
        Thu, 31 Aug 2023 10:12:06 +0900 (JST)
From:   Yoshinori Sato <ysato@users.sourceforge.jp>
To:     linux-sh@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        glaubitz@physik.fu-berlin.de
Subject: [RESEND RFC PATCH 10/12] serial/sh-sci: Fix earlyprintk / earlycon.
Date:   Thu, 31 Aug 2023 10:11:57 +0900
Message-Id: <8f12d3b4b5fdeae4e465fc8fbf843e2878f17b55.1693444193.git.ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1693444193.git.ysato@users.sourceforge.jp>
References: <cover.1693444193.git.ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

- earlyprintk having fault.
- fix shortname conflict.
- fix SCI regshift in SH4.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 drivers/tty/serial/sh-sci.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 7c9457962a3d..541466b23b45 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2721,7 +2721,7 @@ static int sci_remap_port(struct uart_port *port)
 	if (port->membase)
 		return 0;
 
-	if (port->dev->of_node || (port->flags & UPF_IOREMAP)) {
+	if ((port->dev && port->dev->of_node) || (port->flags & UPF_IOREMAP)) {
 		port->membase = ioremap(port->mapbase, sport->reg_size);
 		if (unlikely(!port->membase)) {
 			dev_err(port->dev, "can't remap port#%d\n", port->line);
@@ -3507,6 +3507,10 @@ static int __init early_console_setup(struct earlycon_device *device,
 	if (!device->port.membase)
 		return -ENODEV;
 
+	if (type == PORT_SCI &&
+	    (IS_ENABLED(CONFIG_CPU_SH3) || IS_ENABLED(CONFIG_CPU_SH4))) {
+		device->port.regshift = 2;
+	}
 	device->port.serial_in = sci_serial_in;
 	device->port.serial_out	= sci_serial_out;
 	device->port.type = type;
@@ -3556,8 +3560,8 @@ static int __init hscif_early_console_setup(struct earlycon_device *device,
 
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

