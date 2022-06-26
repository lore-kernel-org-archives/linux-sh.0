Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19FF2C433EF
	for <linux-sh@archiver.kernel.org>; Sun, 26 Jun 2022 13:21:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234573AbiFZNVw (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Sun, 26 Jun 2022 09:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234278AbiFZNVw (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Sun, 26 Jun 2022 09:21:52 -0400
Received: from smtp.smtpout.orange.fr (smtp09.smtpout.orange.fr [80.12.242.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC695BE25
        for <linux-sh@vger.kernel.org>; Sun, 26 Jun 2022 06:21:50 -0700 (PDT)
Received: from [192.168.1.18] ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id 5SCxoQN5sdl7z5SCxo2FOA; Sun, 26 Jun 2022 15:21:49 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 26 Jun 2022 15:21:49 +0200
X-ME-IP: 90.11.190.129
Message-ID: <03e4fa27-b30a-7824-7485-3f79df6fb5bd@wanadoo.fr>
Date:   Sun, 26 Jun 2022 15:21:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] sh: sq: Use the bitmap API when applicable
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Linux-sh list <linux-sh@vger.kernel.org>
References: <521788e22ad8f7a5058c154f068b061525321841.1656142814.git.christophe.jaillet@wanadoo.fr>
 <CAMuHMdU1zN4Eo52T+AhJtJqBM0woW8vvTgysniMd_nv207NjgA@mail.gmail.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <CAMuHMdU1zN4Eo52T+AhJtJqBM0woW8vvTgysniMd_nv207NjgA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Le 26/06/2022 à 12:01, Geert Uytterhoeven a écrit :
> Hi Christophe,
> 
> On Sat, Jun 25, 2022 at 9:45 AM Christophe JAILLET
> <christophe.jaillet@wanadoo.fr> wrote:
>> Using the bitmap API is less verbose than hand writing them.
>> It also improves the semantic.
> 
> Thanks for your patch!
> 
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>> I don't cross compile, so this patch is NOT compile-tested.
> 
> Why not?

The main reason is:

df
/dev/sdc3    ... 	98% /


> Cross-compiling is so easy nowadays?
> Many distros even provide cross-compilers ("apt install gcc-sh4-linux-gnu").
> Else try https://mirrors.edge.kernel.org/pub/tools/crosstool/.
> 
>> --- a/arch/sh/kernel/cpu/sh4/sq.c
>> +++ b/arch/sh/kernel/cpu/sh4/sq.c
> 
>> @@ -382,7 +381,7 @@ static int __init sq_api_init(void)
>>          if (unlikely(!sq_cache))
>>                  return ret;
>>
>> -       sq_bitmap = kzalloc(size, GFP_KERNEL);
>> +       sq_bitmap = bitmap_zalloc(nr_pages, GFP_KERNEL);
> 
> Perhaps you need #include <linux/bitmap.h>?

or not. See [1].

> 
> I don't know, I also didn't bother to cross-compile. Why would I? ;-)

I'll refrain from posting things that I can't compile-test myself in the 
future.

Sorry for the noise, please just ignore the patch, it was just a 
clean-up anyway.

CJ


[1]: 
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/sh/kernel/cpu/sh4/sq.c#n12

> 
> Gr{oetje,eeting}s,
> 
>                          Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                  -- Linus Torvalds
> 

