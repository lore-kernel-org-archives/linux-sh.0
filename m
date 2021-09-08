Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40389C433EF
	for <linux-sh@archiver.kernel.org>; Wed,  8 Sep 2021 20:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25CFC6115B
	for <linux-sh@archiver.kernel.org>; Wed,  8 Sep 2021 20:19:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243872AbhIHUUU (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 8 Sep 2021 16:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233179AbhIHUUT (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 8 Sep 2021 16:20:19 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9449C061575;
        Wed,  8 Sep 2021 13:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=ay0GP3nVBMoLCPhhz4UdcBMphEJJPEuVE1YR61IsQ1w=; b=HF12iy7J2/A6zyKuhsWINv6bR5
        FSLiRNx3FeS6vq7M4Vf39HRCBcgkWIUM+y3mhynKGImK3Mj1asSChm3PKIkEGzpQBJva4aohpamJM
        tTe4XA6MjoIioZM7Sf4VAxe5IGn4ZFfYB3b0QZwnF0ArKeMLXANsajNU2QGLZgZvsRMUyxLP5srDZ
        xt1IarJifVWMcZpY5vIkVbHGNyUMlWXXI0CxueGtOFmDXapBeSsRqoyuRVJY9FkuR1p7nOYuyVphe
        YEAD3SVklgPpg5fOaBJH0/8gCZrNbZXr546cQmhST3jQ+/LEbGYZpnCtOh9O4tc92Odj0Rss9PzQv
        L+lWgI/w==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mO42D-007YDS-Tg; Wed, 08 Sep 2021 20:19:06 +0000
Subject: Re: [PATCH 0/3 v2] sh: fixes for various build and kconfig warnings
To:     linux-kernel@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>
References: <20210627220544.8757-1-rdunlap@infradead.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <2bae95d0-0932-847c-c105-a333e9956dff@infradead.org>
Date:   Wed, 8 Sep 2021 13:19:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210627220544.8757-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On 6/27/21 3:05 PM, Randy Dunlap wrote:
> Fix a few build warnings and one kconfig warning on SUPERH.
> 
> v2: add a previously-sent Kconfig patch
>      add a few more Cc's
> 
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: linux-sh@vger.kernel.org
> Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> [PATCH 1/3 v2] sh: fix kconfig unmet dependency warning for FRAME_POINTER
> [PATCH 2/3 v2] sh: define __BIG_ENDIAN for math-emu
> [PATCH 3/3 v2] sh: fix READ/WRITE redefinition warnings
> 
>   arch/sh/Kconfig.debug             |    1
>   arch/sh/include/asm/sfp-machine.h |    8 +++++
>   arch/sh/math-emu/math.c           |   44 ++++++++++++++--------------
>   3 files changed, 31 insertions(+), 22 deletions(-)
> 

Hi Rich and Yoshinori,

What is the status of arch/sh/ in general and
of these patches in particular?

thanks.
-- 
~Randy

