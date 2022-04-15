Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2636C433EF
	for <linux-sh@archiver.kernel.org>; Fri, 15 Apr 2022 19:08:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240535AbiDOTLA (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Fri, 15 Apr 2022 15:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232623AbiDOTK7 (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Fri, 15 Apr 2022 15:10:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D975FDAFF5;
        Fri, 15 Apr 2022 12:08:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E4D061BA7;
        Fri, 15 Apr 2022 19:08:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AE88C385A4;
        Fri, 15 Apr 2022 19:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650049709;
        bh=wLptQ9KcXl6+N9MX+ZuwkhOcFMiubmc8uGIxEhPIVsw=;
        h=From:To:Cc:Subject:Date:From;
        b=kMa8vmzsEoLHqqj8o162lzFyicETqjQXbHfr5ImL1Ae9T92XhA7/J/OYE3IcbnXN4
         7ePmsefcNu2rBwzhNnaUtZBSIDPSaoyxmLo8pk+i5VdMOtmG3GkUY0lrEa73lTW/2V
         Ug7UMduqMNaG9m5kk1lDbtepjruMyB//l/sFbAUflo5h2fSiSQOtJtlTGb/ZjBrZDX
         w/IKNd1N+X/c6BltEErY9wMWJZ965YEp++XzySEwiQDwnEYl3OyhGebrjR9Ll6lBhN
         Pw1g6o9wyrUeuiUPT7mgq7WrcLLHXyKlny2f9f7eZFXgVeaocS+n1eFAK11luqBP6s
         uuqYoPhSC5y/g==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Chas Williams <3chas3@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
        linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 0/7] Remove unused SLOW_DOWN_IO
Date:   Fri, 15 Apr 2022 14:08:10 -0500
Message-Id: <20220415190817.842864-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Only alpha, ia64, powerpc, and sh define SLOW_DOWN_IO, and there are no
actual uses of it.  The few references to it are in situations that are
themselves unused.  Remove them all.

It should be safe to apply these independently and in any order.  The only
place SLOW_DOWN_IO is used at all is the lmc_var.h definition of DELAY,
which is itself never used.

Bjorn Helgaas (7):
  net: wan: atp: remove unused eeprom_delay()
  net: wan: lmc: remove unused DELAY()
  net: remove comments that mention obsolete __SLOW_DOWN_IO
  sh: remove unused SLOW_DOWN_IO
  powerpc: Remove unused SLOW_DOWN_IO definition
  ia64: remove unused __SLOW_DOWN_IO and SLOW_DOWN_IO definitions
  alpha: remove unused __SLOW_DOWN_IO and SLOW_DOWN_IO definitions

 arch/alpha/include/asm/io.h                  |  4 ----
 arch/ia64/include/asm/io.h                   |  4 ----
 arch/powerpc/include/asm/io.h                |  2 --
 arch/sh/include/asm/io.h                     | 17 ++---------------
 drivers/atm/nicstarmac.c                     |  5 -----
 drivers/net/ethernet/dec/tulip/winbond-840.c |  2 --
 drivers/net/ethernet/natsemi/natsemi.c       |  2 --
 drivers/net/ethernet/realtek/atp.h           |  4 ----
 drivers/net/wan/lmc/lmc_main.c               |  8 --------
 drivers/net/wan/lmc/lmc_var.h                |  8 --------
 10 files changed, 2 insertions(+), 54 deletions(-)

-- 
2.25.1

