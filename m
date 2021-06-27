Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4AA5C48BC2
	for <linux-sh@archiver.kernel.org>; Sun, 27 Jun 2021 22:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEC9B619B6
	for <linux-sh@archiver.kernel.org>; Sun, 27 Jun 2021 22:30:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbhF0WdQ (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Sun, 27 Jun 2021 18:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231644AbhF0WdQ (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Sun, 27 Jun 2021 18:33:16 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA3A0C061574;
        Sun, 27 Jun 2021 15:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=DS/fK2zjumlbbuhQwo2wgSQ7ZgGW9I8lcpN9MSH7sgw=; b=P5lWT+Pfs2LwIFNoClHCnPqkyx
        ZQaBIhKoGynfOgA4f6u0eYbFszo6LSFGg3zzX8UvnLXvy9ZNGtB4eRXoWm8Q22IX1WLMID3+9xtt3
        zPKFoyykVphuAK4flZyZuHjV+8ukhaGtjGIGucQOMFQnsMsq9NJvKpZ4pw9EnpksZHR16dSyEd8Im
        nDtmMrmneEUSPZPLBCj6J4rIdxXt3nCuSDprKxq1Fzi9R5VUAxQZybgnKNyoGEsdOqdwWGv0DbY76
        1N79jMPFFJy9msp9L9KIB50z0NNE0iqUCw1yw262OFJu54COgfkd15SsQA7YrRQ8hCXhmdH+csebc
        PqosY/VA==;
Received: from [2601:1c0:6280:3f0::aefb]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lxdIg-006EjJ-GL; Sun, 27 Jun 2021 22:30:50 +0000
Subject: Re: [PATCH 0/3 v2] sh: fixes for various build and kconfig warnings
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        linux-kernel@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
References: <20210627220544.8757-1-rdunlap@infradead.org>
 <be15fd85-1d35-0cba-5c27-8273f0647f94@physik.fu-berlin.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <0c2c5638-09a7-d69b-7a0d-eb2abbe83738@infradead.org>
Date:   Sun, 27 Jun 2021 15:30:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <be15fd85-1d35-0cba-5c27-8273f0647f94@physik.fu-berlin.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On 6/27/21 3:26 PM, John Paul Adrian Glaubitz wrote:
> Hi Randy!
> 
> On 6/28/21 12:05 AM, Randy Dunlap wrote:
>> Fix a few build warnings and one kconfig warning on SUPERH.
>>
>> v2: add a previously-sent Kconfig patch
>>     add a few more Cc's
>>
>> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
>> Cc: Rich Felker <dalias@libc.org>
>> Cc: linux-sh@vger.kernel.org
>> Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
>> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
>>
>> [PATCH 1/3 v2] sh: fix kconfig unmet dependency warning for FRAME_POINTER
>> [PATCH 2/3 v2] sh: define __BIG_ENDIAN for math-emu
>> [PATCH 3/3 v2] sh: fix READ/WRITE redefinition warnings
>>
>>  arch/sh/Kconfig.debug             |    1 
>>  arch/sh/include/asm/sfp-machine.h |    8 +++++
>>  arch/sh/math-emu/math.c           |   44 ++++++++++++++--------------
>>  3 files changed, 31 insertions(+), 22 deletions(-)
> 
> I'll test these tomorrow on my SH-7785LCR board. Would it be possible to queue
> them up for linux-next after verification?

Thanks.  Hopefully they will be queued and put into linux-next,
but that's up to the arch/sh/ maintainers, and I haven't heard
from them lately.  :(

-- 
~Randy

