Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A176FC77B7F
	for <linux-sh@archiver.kernel.org>; Sat,  6 May 2023 14:17:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232791AbjEFORt (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Sat, 6 May 2023 10:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbjEFORs (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Sat, 6 May 2023 10:17:48 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184291992E;
        Sat,  6 May 2023 07:17:37 -0700 (PDT)
Received: (Authenticated sender: contact@artur-rojek.eu)
        by mail.gandi.net (Postfix) with ESMTPSA id BAD5E20007;
        Sat,  6 May 2023 14:17:34 +0000 (UTC)
From:   Artur Rojek <contact@artur-rojek.eu>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Rafael Ignacio Zurita <rafaelignacio.zurita@gmail.com>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        Artur Rojek <contact@artur-rojek.eu>
Subject: [PATCH 0/2] SH7709 DMA fixes
Date:   Sat,  6 May 2023 16:17:01 +0200
Message-Id: <20230506141703.65605-1-contact@artur-rojek.eu>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi, 

this series provides fixes to the SH7709 DMA controller, allowing the HP
Jornada 680 palmtop to boot Linux again. To my knowledge, this is the
first time in ~14 years someone tests upstream Linux on this device. And
with the included patches applied, I'm happy to announce that it still
works like a charm.

PS. What might be of interest to the sh-linux community, there's further
work towards this platform in my pipeline. E.g. I've added support for
the HD6446x PCMCIA controller, allowing Jornada 680 to use Ethernet and
Wi-Fi cards. However, what prevents proper upstream of such a driver is
the crude and antiquated code of the underlying platform base. For
example, the HD6446x bridge (`cchips/hd6446x/hd64461.c`) lacks the
concept of clocks, preventing the PCMCIA driver from hardware agnostic
clock gating. So what I'm looking into next is the cleanup of existing
platform code base, bringing it up-to-date with modern kernel APIs.
Hopefully it's not trying to bite more than I can chew, but eventually
ending up with Device Tree support would be really nice :)

Artur Rojek (2):
  sh: dma: fix `dmaor_read_reg`/`dmaor_write_reg` macros
  sh: dma: Correct the number of DMA channels in SH7709

 arch/sh/drivers/dma/Kconfig  | 10 ++++++----
 arch/sh/drivers/dma/dma-sh.c |  7 +++++--
 2 files changed, 11 insertions(+), 6 deletions(-)

-- 
2.40.1

