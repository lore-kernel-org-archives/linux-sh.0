Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4651EC433F5
	for <linux-sh@archiver.kernel.org>; Wed,  6 Oct 2021 01:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 141DE604E9
	for <linux-sh@archiver.kernel.org>; Wed,  6 Oct 2021 01:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbhJFBIY (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 5 Oct 2021 21:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbhJFBIY (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 5 Oct 2021 21:08:24 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966A5C061749;
        Tue,  5 Oct 2021 18:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=+vWBHl1EvmMiSu6+JjZhRe8Jw+YmxOZ94aEmbzilIbI=; b=Da/e5LMYCYkiyu2IOmDMfH/+Ne
        2hpxm9k3+mI0LypXmrAhfXHwzMLhvWkWaY+mkyHIZXwp1OUDtwx8eH3vCiqgHTMInuvfGLppQ5GNz
        UhIPLuRTQj0hsokf8xzmhtwtkKODfaErYFd45bZps78IszlkLSUKMIvTsVedDRHbckgrXTTLOdaA9
        0K/DrYcroRklJ2+m0XnU3FN8cRmgtp9nhhfOK+hZ2MdBBS3Xuup6cDHWszadlcWrjJFyQSH0bUm+m
        qZaKz4IQ9HLnF9LnGAAb3PWsWfHoL89W/VtAAtnWJ7fTtf25d5KZO691sakA96RN0ZcxCBMkvPgHs
        q67bNanQ==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mXvO3-00CUaB-3C; Wed, 06 Oct 2021 01:06:23 +0000
Subject: Re: [PATCH 3/5 v3] sh: math-emu: drop unused functions
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Takashi YOSHII <takasi-y@ops.dti.ne.jp>
References: <20211005001914.28574-1-rdunlap@infradead.org>
 <20211005001914.28574-4-rdunlap@infradead.org>
 <CAMuHMdUwkOwLgbxjSwO0QCq+=jBL+e1z8X6NZHrrx0bv_zFq1A@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <d5f5735a-ab8b-0da6-c530-06426dbb2457@infradead.org>
Date:   Tue, 5 Oct 2021 18:06:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdUwkOwLgbxjSwO0QCq+=jBL+e1z8X6NZHrrx0bv_zFq1A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On 10/5/21 12:26 AM, Geert Uytterhoeven wrote:
> Hi Randy,
> 
> Thanks for your patch!
> 
> On Tue, Oct 5, 2021 at 2:19 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>> Delete ieee_fpe_handler() since it is not used. After that is done,
>> delete denormal_to_double() since it is not used:
>>
>> ../arch/sh/math-emu/math.c:505:12: error: 'ieee_fpe_handler' defined but not used [-Werror=unused-function]
>>    505 | static int ieee_fpe_handler(struct pt_regs *regs)
>>
>> ../arch/sh/math-emu/math.c:477:13: error: 'denormal_to_double' defined but not used [-Werror=unused-function]
>>    477 | static void denormal_to_double(struct sh_fpu_soft_struct *fpu, int n)
>>
>> Fixes: 4b565680d163 ("sh: math-emu support")
> 
> Shouldn't that be
> Fixes: 7caf62de25554da3 ("sh: remove unused do_fpu_error")
> ?

oh, ah, um. Yes, it should. Thanks!

> 
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> Gr{oetje,eeting}s,
> 
>                          Geert
> 


-- 
~Randy
