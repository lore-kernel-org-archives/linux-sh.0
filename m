Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36FA7C2B9F4
	for <linux-sh@archiver.kernel.org>; Mon, 28 Jun 2021 10:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 210C1611B0
	for <linux-sh@archiver.kernel.org>; Mon, 28 Jun 2021 10:01:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232559AbhF1KDY (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 28 Jun 2021 06:03:24 -0400
Received: from mail-vk1-f173.google.com ([209.85.221.173]:39628 "EHLO
        mail-vk1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232488AbhF1KDY (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Mon, 28 Jun 2021 06:03:24 -0400
Received: by mail-vk1-f173.google.com with SMTP id k140so777535vkk.6;
        Mon, 28 Jun 2021 03:00:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PkXqYJgitaalH/JTJGQSczmMs8oLBdOuvLdN4mBy9qc=;
        b=Thsjcwsh+UtROidrqhDDsDi7bUHPn9Jt2czWtqzQ0OW/fpwTS8tY0Q7/f8oGwtz/y9
         mv0arZ8RDT4VDn2XgT67V6A/hgfcdb6n304fG/FJhK+6sWr7xSMsEgRmEeSGm0rKHUUv
         cZC1HiodW14KvdMiEMaEQz7F/bAL2Ul8knPpo+IbeJtpBHDmMfk3b9MMgL9hBs/Tx5mG
         mnBMIDJ4yJwSfYyGiq582ZU04Wri0a0o0zFlU7QKcf0MxTQTBQQa1ZTgbHnHgAgR2UoK
         6P39Y7bcKUB8t6jawZ5raB8OYXcX9167XX5yS+xVgegRCJ6bynT0NBY7P/HTwe/LLer5
         5HgQ==
X-Gm-Message-State: AOAM532bZ002MD0t7VDQdsgDfX1yCQKFzPxrQF7nXsfiPgURfY1wDCxF
        4EWro9WfJR3NVQ5oyoTJDqzP5slQ7U0ElOqwQBV6TkpxiESm+Q==
X-Google-Smtp-Source: ABdhPJyYa7db5x1agDV7+CIDFKfHb/aN1WkHfWiCp0mrKjb5bzdZbOu7d2PI8FfeM2tAu9a+QhGeyjM5bSwRo8IKe0o=
X-Received: by 2002:a1f:ac45:: with SMTP id v66mr15717278vke.1.1624874456985;
 Mon, 28 Jun 2021 03:00:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210623133205.GA28589@lst.de> <CAFr9PXk84aejj186UNizftwK_w5G1RXLMsSvAEVEYsXi8=yCoA@mail.gmail.com>
 <27c78c11-b230-a5b5-6648-6b93daf6afda@physik.fu-berlin.de>
 <CAMuHMdV+SmxUtvAptYfVgy04jCHeABmsEpn3mcUfFQ_RfTF7eA@mail.gmail.com> <CAFr9PXnuFWFy-3mUAo63aiP5qXmD9ULycWVn=_YG96ReohJAjg@mail.gmail.com>
In-Reply-To: <CAFr9PXnuFWFy-3mUAo63aiP5qXmD9ULycWVn=_YG96ReohJAjg@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 28 Jun 2021 12:00:45 +0200
Message-ID: <CAMuHMdU_O3-qgCF3TStdE3Jp2gD6kqhwK9kSECnBeJGB7aNVAA@mail.gmail.com>
Subject: Re: dma_declare_coherent_memory and SuperH
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Christoph Hellwig <hch@lst.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Daniel,

On Mon, Jun 28, 2021 at 11:30 AM Daniel Palmer <daniel@0x0f.com> wrote:
> On Mon, 28 Jun 2021 at 17:57, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > There is an unmerged patch set by Yoshinori Sato that adds device tree support for SH.
> >
> > But it does not include support for SH7724 yet, only for SH775[01]
> > (note to myself: still have to try it on my landisk).
>
> I have some landisks. Is there a sane u-boot for them? I think mine
> still have the hacked up lilo thing.

I believe Sato-san has one for the new landisks.
Mine is also using the hacked up lilo, with kexec to boot into a modern
kernel.  Unfortunately kexec is broken upstream (since ages), so I cannot
kexec from a modern kernel to a modern kernel.

> > Fortunately most core devices on SH7724 and Ecovec should already
> > have DT support in their drivers. The main missing pieces are
> > interrupt and clock support.
>
> This sounds like a fun project. I'm not sure if I could manage it
> without the Hitachi/Renesas debugging dongle though.

Should be doable with earlycon.

> Anyhow, it would be a shame to remove the ecovec just because it
> doesn't have DT as it pretty much fully works with a few small patches
> to fix some bit rot like ethernet and the LCD not working.

Yeah, I agree the Ecovec24 (and the SH7722-based Migo-R) should be
kept alive.

> I sent a patch a few years ago for the ethernet and never got a response. :(

You mean "[PATCH] SH: Add dma mask for sh_eth on ecovec24."[1]?
Do you still need that patch? Probably this was fixed in the core
core, after the
initial dma_mask breakage.

[1] https://lore.kernel.org/linux-sh/20181203122323.765-1-daniel@0x0f.com/

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
