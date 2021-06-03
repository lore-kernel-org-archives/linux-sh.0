Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C88C47082
	for <linux-sh@archiver.kernel.org>; Thu,  3 Jun 2021 06:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FBED613DA
	for <linux-sh@archiver.kernel.org>; Thu,  3 Jun 2021 06:51:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbhFCGx1 (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Thu, 3 Jun 2021 02:53:27 -0400
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:42479 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229702AbhFCGx0 (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Thu, 3 Jun 2021 02:53:26 -0400
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1lohCe-0014Ki-Gh; Thu, 03 Jun 2021 08:51:40 +0200
Received: from p5b13a0fe.dip0.t-ipconnect.de ([91.19.160.254] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1lohCe-002CQd-AA; Thu, 03 Jun 2021 08:51:40 +0200
Subject: Re: [PATCH 0/3] sh: fixes for various build warnings
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
References: <20210602231443.4670-1-rdunlap@infradead.org>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <789e8e24-0513-75e1-6f6c-5ff16ddf7f88@physik.fu-berlin.de>
Date:   Thu, 3 Jun 2021 08:51:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210602231443.4670-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.160.254
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Randy!

On 6/3/21 1:14 AM, Randy Dunlap wrote:
> Fix a few build warnings on SUPERH.
> 
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: linux-sh@vger.kernel.org
> 
> [PATCH 1/3] sh: convert xchg() to a statement expression
> [RFC PATCH 2/3] sh: define __BIG_ENDIAN for math-emu
> [PATCH 3/3] sh: fix READ/WRITE redefinition warnings
> 
>  arch/sh/include/asm/cmpxchg.h |    2 -
>  arch/sh/math-emu/math.c       |   44 ++++++++++++++++----------------
>  arch/sh/math-emu/sfp-util.h   |    2 -
>  3 files changed, 24 insertions(+), 24 deletions(-)

Thanks for your patches. I have been pondering to fix these warnings for a while
now glad someone else was quicker than me :-).

I will test your patches later today and see if there are any regressions.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
