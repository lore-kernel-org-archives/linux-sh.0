Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1698DCDB489
	for <linux-sh@archiver.kernel.org>; Sat, 14 Oct 2023 14:54:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232238AbjJNOyY (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Sat, 14 Oct 2023 10:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233235AbjJNOyX (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Sat, 14 Oct 2023 10:54:23 -0400
Received: from hsmtpd-def.xspmail.jp (hsmtpd-def.xspmail.jp [202.238.198.237])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25865CA
        for <linux-sh@vger.kernel.org>; Sat, 14 Oct 2023 07:54:22 -0700 (PDT)
X-Country-Code: JP
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp [153.127.30.23])
        by hsmtpd-out-0.asahinet.cluster.xspmail.jp (Halon) with ESMTPA
        id ed52e151-53c8-4e11-9240-901c1aa969ba;
        Sat, 14 Oct 2023 23:54:20 +0900 (JST)
Received: from SIOS1075.ysato.name (ZM005235.ppp.dion.ne.jp [222.8.5.235])
        by sakura.ysato.name (Postfix) with ESMTPSA id 69A101C050D;
        Sat, 14 Oct 2023 23:54:20 +0900 (JST)
From:   Yoshinori Sato <ysato@users.sourceforge.jp>
To:     linux-sh@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        glaubitz@physik.fu-berlin.de
Subject: [RFC PATCH v3 18/35] drivers/tty/serial: sh-sci.c fix SH4 OF support.
Date:   Sat, 14 Oct 2023 23:53:53 +0900
Message-Id: <d9f9ca66b43371ce8cf80faffdfcdf593c9563ac.1697199949.git.ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697199949.git.ysato@users.sourceforge.jp>
References: <cover.1697199949.git.ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

- fix earlycon name.
- fix earlyprintk hung (NULL pointer reference).

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 drivers/tty/serial/sh-sci.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index a560b729fa3b..faaf2bb32586 100644
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
@@ -3555,8 +3555,8 @@ static int __init hscif_early_console_setup(struct earlycon_device *device,
 
 OF_EARLYCON_DECLARE(sci, "renesas,sci", sci_early_console_setup);
 OF_EARLYCON_DECLARE(scif, "renesas,scif", scif_early_console_setup);
-OF_EARLYCON_DECLARE(scif, "renesas,scif-r7s9210", rzscifa_early_console_setup);
-OF_EARLYCON_DECLARE(scif, "renesas,scif-r9a07g044", rzscifa_early_console_setup);
+OF_EARLYCON_DECLARE(rzscifa, "renesas,scif-r7s9210", rzscifa_early_console_setup);
+OF_EARLYCON_DECLARE(rzscifa, "renesas,scif-r9a07g044", rzscifa_early_console_setup);
 OF_EARLYCON_DECLARE(scifa, "renesas,scifa", scifa_early_console_setup);
 OF_EARLYCON_DECLARE(scifb, "renesas,scifb", scifb_early_console_setup);
 OF_EARLYCON_DECLARE(hscif, "renesas,hscif", hscif_early_console_setup);
-- 
2.39.2

