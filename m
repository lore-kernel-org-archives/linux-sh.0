Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 409D9C433F5
	for <linux-sh@archiver.kernel.org>; Tue, 16 Nov 2021 05:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FA9361A7C
	for <linux-sh@archiver.kernel.org>; Tue, 16 Nov 2021 05:35:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234854AbhKPFiO (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 16 Nov 2021 00:38:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234734AbhKPFiD (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 16 Nov 2021 00:38:03 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 789FCC048CB7;
        Mon, 15 Nov 2021 18:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=27a+1ERJiH1WxGa9BIP0FoUnLa4JJB0EvgPKYUvef4Y=; b=Jn6x4AZ11HbKguQC85dX6scWfY
        aiwL6LjYjOxls2bDmT+sTPu9ZwHBbhgmahL4WbLk8VrIFP3fw9Fwh9vZ2jnMNgN8wKmBS9BZiLpth
        8Oxu6SawZV44UOHxMmJ3Gg3+PiWY0hqeSZQ3Ai96gQLE+rv4YFElm+zP16V70dQpm+FWkOvdZC3Rv
        kD2ZqjnbOHv8pqHJPVK+Al/Fs2YIzmgl4svYu8UsCSikkngzYOZCgA4eIKJaxNzBAjnlpQgPSz0Tp
        /WETx4HskPe5PKUlNJkb9W8rp6+kzf9QKh/4a1G7XEDtOQZxF0TyVokq35I9Cx7YOTnsXdltiWy9T
        HE6KXlNA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mmoWW-0008B1-Ht; Tue, 16 Nov 2021 02:48:40 +0000
Subject: Re: [PATCH 1/2] sh: mcount.S: fix build error when PRINTK is not
 enabled
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Paul Mundt <lethal@linux-sh.org>
References: <20211115064128.9896-1-rdunlap@infradead.org>
 <CAMuHMdULwWi6hEUGY7vA3Nc7DhYLp_dH0o-sVdijWg6Z54GijQ@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <7d54befc-496c-2035-a817-dd7ff74e5bf8@infradead.org>
Date:   Mon, 15 Nov 2021 18:48:39 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdULwWi6hEUGY7vA3Nc7DhYLp_dH0o-sVdijWg6Z54GijQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On 11/15/21 2:10 AM, Geert Uytterhoeven wrote:
> Hi Randy,
> 
> On Mon, Nov 15, 2021 at 7:41 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>> Fix a build error in mcount.S when CONFIG_PRINTK is not enabled.
>> Fixes this build error:
>>
>> sh2-linux-ld: arch/sh/lib/mcount.o: in function `stack_panic':
>> (.text+0xec): undefined reference to `dump_stack'
>>
>> Fixes: e460ab27b6c3e ("sh: Fix up stack overflow check with ftrace disabled.")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> 
> Thanks for your patch!
> 
>> Possibly even more of this function should conditionally not be built...
> 
> What about making STACK_DEBUG depend on PRINTK instead?
> It doesn't make much sense to enable the former, if you won't print
> any output...

Hi Geert,
That works. Thanks for the suggestion.

I'll send a v2.
-- 
~Randy
