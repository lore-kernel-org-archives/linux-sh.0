Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87664C77B73
	for <linux-sh@archiver.kernel.org>; Sat,  6 May 2023 14:17:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232822AbjEFORu (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Sat, 6 May 2023 10:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232778AbjEFORt (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Sat, 6 May 2023 10:17:49 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 020E319D47;
        Sat,  6 May 2023 07:17:39 -0700 (PDT)
Received: (Authenticated sender: contact@artur-rojek.eu)
        by mail.gandi.net (Postfix) with ESMTPSA id 07AB420002;
        Sat,  6 May 2023 14:17:36 +0000 (UTC)
From:   Artur Rojek <contact@artur-rojek.eu>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Rafael Ignacio Zurita <rafaelignacio.zurita@gmail.com>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        Artur Rojek <contact@artur-rojek.eu>
Subject: [PATCH 1/2] sh: dma: fix `dmaor_read_reg`/`dmaor_write_reg` macros
Date:   Sat,  6 May 2023 16:17:02 +0200
Message-Id: <20230506141703.65605-2-contact@artur-rojek.eu>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230506141703.65605-1-contact@artur-rojek.eu>
References: <20230506141703.65605-1-contact@artur-rojek.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Squash two bugs introduced into said macros in 7f47c7189b3e, preventing
them from proper operation:
1) Add DMAOR register offset into the address of the hw reg access,
2) Correct a nasty typo in the DMAOR base calculation for
   `dmaor_write_reg`.

Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
---
 arch/sh/drivers/dma/dma-sh.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/sh/drivers/dma/dma-sh.c b/arch/sh/drivers/dma/dma-sh.c
index 96c626c2cd0a..14c18ebda400 100644
--- a/arch/sh/drivers/dma/dma-sh.c
+++ b/arch/sh/drivers/dma/dma-sh.c
@@ -254,8 +254,11 @@ static int sh_dmac_get_dma_residue(struct dma_channel *chan)
  * DMAOR bases are broken out amongst channel groups. DMAOR0 manages
  * channels 0 - 5, DMAOR1 6 - 11 (optional).
  */
-#define dmaor_read_reg(n)		__raw_readw(dma_find_base((n)*6))
-#define dmaor_write_reg(n, data)	__raw_writew(data, dma_find_base(n)*6)
+#define dmaor_read_reg(n)		__raw_readw(dma_find_base((n) * 6) + \
+						    DMAOR)
+#define dmaor_write_reg(n, data)	__raw_writew(data, \
+						     dma_find_base((n) * 6) + \
+						     DMAOR)
 
 static inline int dmaor_reset(int no)
 {
-- 
2.40.1

