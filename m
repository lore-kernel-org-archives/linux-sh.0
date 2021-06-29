Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1443C11F67
	for <linux-sh@archiver.kernel.org>; Tue, 29 Jun 2021 21:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EEDB613F8
	for <linux-sh@archiver.kernel.org>; Tue, 29 Jun 2021 21:49:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235473AbhF2VwT (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 29 Jun 2021 17:52:19 -0400
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:52883 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233660AbhF2VwT (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 29 Jun 2021 17:52:19 -0400
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1lyLc2-001t9P-5m; Tue, 29 Jun 2021 23:49:46 +0200
Received: from p57bd964c.dip0.t-ipconnect.de ([87.189.150.76] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1lyLc1-003Yvo-VO; Tue, 29 Jun 2021 23:49:46 +0200
Subject: Re: [PATCH 0/3 v2] sh: fixes for various build and kconfig warnings
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
References: <20210627220544.8757-1-rdunlap@infradead.org>
 <be15fd85-1d35-0cba-5c27-8273f0647f94@physik.fu-berlin.de>
Message-ID: <33d4f0ef-0d7d-c0a5-102a-7ae862b8c12a@physik.fu-berlin.de>
Date:   Tue, 29 Jun 2021 23:49:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <be15fd85-1d35-0cba-5c27-8273f0647f94@physik.fu-berlin.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 87.189.150.76
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hello!

On 6/28/21 12:26 AM, John Paul Adrian Glaubitz wrote:
>>  arch/sh/Kconfig.debug             |    1 
>>  arch/sh/include/asm/sfp-machine.h |    8 +++++
>>  arch/sh/math-emu/math.c           |   44 ++++++++++++++--------------
>>  3 files changed, 31 insertions(+), 22 deletions(-)
> 
> I'll test these tomorrow on my SH-7785LCR board. Would it be possible to queue
> them up for linux-next after verification?

Just as a heads-up: My fast EPYC server for kernel cross-compilation is currently down,
so I'll have to set up a new machine at SUSE tomorrow for that purpose. Hope to be able
to test the kernel after that.

Sorry for the delay, the other server is currently down due to an A/C failure at the university.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
