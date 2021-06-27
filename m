Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1CC6C48BC2
	for <linux-sh@archiver.kernel.org>; Sun, 27 Jun 2021 22:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77528613E4
	for <linux-sh@archiver.kernel.org>; Sun, 27 Jun 2021 22:36:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbhF0Wiy (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Sun, 27 Jun 2021 18:38:54 -0400
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:56627 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231737AbhF0Wix (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Sun, 27 Jun 2021 18:38:53 -0400
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1lxdO7-003UK9-2K; Mon, 28 Jun 2021 00:36:27 +0200
Received: from p57bd964c.dip0.t-ipconnect.de ([87.189.150.76] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1lxdO6-000IVS-Ry; Mon, 28 Jun 2021 00:36:27 +0200
Subject: Re: [PATCH 0/3 v2] sh: fixes for various build and kconfig warnings
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
References: <20210627220544.8757-1-rdunlap@infradead.org>
 <be15fd85-1d35-0cba-5c27-8273f0647f94@physik.fu-berlin.de>
 <0c2c5638-09a7-d69b-7a0d-eb2abbe83738@infradead.org>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <87b6efe2-6562-db7e-076e-723faf9362a6@physik.fu-berlin.de>
Date:   Mon, 28 Jun 2021 00:36:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <0c2c5638-09a7-d69b-7a0d-eb2abbe83738@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 87.189.150.76
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Randy!

On 6/28/21 12:30 AM, Randy Dunlap wrote:
>>> [PATCH 1/3 v2] sh: fix kconfig unmet dependency warning for FRAME_POINTER
>>> [PATCH 2/3 v2] sh: define __BIG_ENDIAN for math-emu
>>> [PATCH 3/3 v2] sh: fix READ/WRITE redefinition warnings
>>>
>>>  arch/sh/Kconfig.debug             |    1 
>>>  arch/sh/include/asm/sfp-machine.h |    8 +++++
>>>  arch/sh/math-emu/math.c           |   44 ++++++++++++++--------------
>>>  3 files changed, 31 insertions(+), 22 deletions(-)
>>
>> I'll test these tomorrow on my SH-7785LCR board. Would it be possible to queue
>> them up for linux-next after verification?
> 
> Thanks.  Hopefully they will be queued and put into linux-next,
> but that's up to the arch/sh/ maintainers, and I haven't heard
> from them lately.  :(

Whoops, I was meant to direct the second part to Rich :-).

Rich is still around and he reviews and merges patches. Sometimes he is a bit
busy with other things, so response times can sometimes be a bit delayed.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
