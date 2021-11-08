Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F4FC433EF
	for <linux-sh@archiver.kernel.org>; Mon,  8 Nov 2021 14:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDAC4611C0
	for <linux-sh@archiver.kernel.org>; Mon,  8 Nov 2021 14:03:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240178AbhKHOGG (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 8 Nov 2021 09:06:06 -0500
Received: from mail-ua1-f53.google.com ([209.85.222.53]:41657 "EHLO
        mail-ua1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240177AbhKHOGF (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Mon, 8 Nov 2021 09:06:05 -0500
Received: by mail-ua1-f53.google.com with SMTP id p37so30538457uae.8;
        Mon, 08 Nov 2021 06:03:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3vEIzZ1S/bu9Zd8ER6jvDbqdstuSaVNrpeM6s9ASoIo=;
        b=C997UAu4rid2A+xQiaEfpgxtvU2YrTUyRsX9KIl0r2C47ds6lE7G0yu3BGZIq1Tvsd
         N6pBTg+gplv9cQln976Ii1P09zna0/T5tBezgmmQodZTG/m+/4bH5MVmlL8QOzbulrVq
         kL+N4YJsfdFeeGEIBhQFJlm9QvKCcCfLknbQFQUn/j8TrdpO9UKbc0H3seU1Z0Igjiq+
         HSLvTLAv/pp/Oaub50mceL1gLwXDMKkOJnSvXYjctjnoFwl7ppNiw3oV+Boq/0JbZY+w
         5tDaOsE68SAqMpvIpVJuDYgkSudtmytp/Q7TilSYIO4drfD7WxfBDyrS/BdMmmeTr+VP
         gxTg==
X-Gm-Message-State: AOAM532U/6Jvy7iChHgcp/AIBWJ4YWibH/HkekywmuVjdh8McitTFI/n
        GQqSh4WSAzcSanoqQYp+js+Fr0rYtuOQGg==
X-Google-Smtp-Source: ABdhPJzVF1rVaRZ1EVGMGVI38eDFIfajNZ/UDiP12X6F4eizXpDFjTz60oWk8bLSo6mro01EZT3KLA==
X-Received: by 2002:a67:ec8f:: with SMTP id h15mr95467403vsp.42.1636380200463;
        Mon, 08 Nov 2021 06:03:20 -0800 (PST)
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com. [209.85.221.179])
        by smtp.gmail.com with ESMTPSA id 66sm3213728vsh.34.2021.11.08.06.03.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Nov 2021 06:03:19 -0800 (PST)
Received: by mail-vk1-f179.google.com with SMTP id n201so8250608vkn.12;
        Mon, 08 Nov 2021 06:03:19 -0800 (PST)
X-Received: by 2002:a05:6122:20a7:: with SMTP id i39mr32672729vkd.15.1636380199367;
 Mon, 08 Nov 2021 06:03:19 -0800 (PST)
MIME-Version: 1.0
References: <20211108101157.15189-1-bp@alien8.de> <20211108101157.15189-36-bp@alien8.de>
 <CAMuHMdW4fv4LN6oDS6qgYodf74_NvbzMxQfRbtnS-mn_D+u7Kg@mail.gmail.com> <YYkq7WbmNXNgiqv9@zn.tnic>
In-Reply-To: <YYkq7WbmNXNgiqv9@zn.tnic>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 8 Nov 2021 15:03:08 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUULHGmsAu1f=4of1A+ABecH89PRxDqRGewqhG7bbL3-g@mail.gmail.com>
Message-ID: <CAMuHMdUULHGmsAu1f=4of1A+ABecH89PRxDqRGewqhG7bbL3-g@mail.gmail.com>
Subject: Re: [PATCH v0 35/42] sh: Check notifier registration return value
To:     Borislav Petkov <bp@alien8.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Borislav,

On Mon, Nov 8, 2021 at 2:49 PM Borislav Petkov <bp@alien8.de> wrote:
> On Mon, Nov 08, 2021 at 02:31:41PM +0100, Geert Uytterhoeven wrote:
> > Do you think these can actually fail?
>
> Hmm, maybe you missed the 0th message. Does this explain it:
>
> https://lore.kernel.org/r/20211108101924.15759-1-bp@alien8.de
>
> ?

Thanks, but that still doesn't explain why we need to add the check,
for something that IMHO cannot fail, in a caller that cannot do
anything in the very unlikely event that he call would ever start
to fail?

The clue is the addition of __must_check in "[PATCH v0 42/42] notifier:
Return an error when callback is already registered"
(https://lore.kernel.org/all/20211108101157.15189-43-bp@alien8.de/).

I'll reply to that one...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
