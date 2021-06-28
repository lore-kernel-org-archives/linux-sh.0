Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF95DC2B9F4
	for <linux-sh@archiver.kernel.org>; Mon, 28 Jun 2021 08:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6CC36108B
	for <linux-sh@archiver.kernel.org>; Mon, 28 Jun 2021 08:46:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231683AbhF1Isr (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 28 Jun 2021 04:48:47 -0400
Received: from mail-ua1-f54.google.com ([209.85.222.54]:41776 "EHLO
        mail-ua1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbhF1Isq (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Mon, 28 Jun 2021 04:48:46 -0400
Received: by mail-ua1-f54.google.com with SMTP id k20so1064018uao.8;
        Mon, 28 Jun 2021 01:46:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=voFOBLuBCRHfRZtqFDsbwOOLuWD6cccWT5LVlSTJ9/E=;
        b=V1PSg/s9BEyq7XdFlFzsMCmc/MT8apuLVVobBRdPx+MAWuY1GY33gkzF8TYVmSSR/Q
         laFG+/YS0gR+YrIAsPKimZSGMfRpE78S9qFtj1AxLDrT00SHLCTkWkc1M14gfhGTng9/
         B1tBp6yqKTXIxz3RNpfkLN74qRp6HgDU3kyTUbd6Mi7pCmzkV6OTtD+Hau5z3cUryKdG
         d34S+tqX0Sy7TWN2omBOec3A2u/gUZGcyDLemIIXkfbQ5TKH0ewJ8sMjuJpBqpm1Av+q
         G9Ln6TBs9pgNIoQgcfSW4qQ8wvx5fcaBNB3DT9ErasTkdQyL0gHxv2BMQvuxZFlPT97N
         sYrg==
X-Gm-Message-State: AOAM532BitQnzcDiXD29z3cUjhqCopRNOFQL7BaUaGymp7MzfHu2Pxjn
        ULMu91JeasR/PIknP5If3oOVcvOf1pFfAA0NchM=
X-Google-Smtp-Source: ABdhPJwVXfTuV2raA/UpFLfgr6WGkyTil4P5EnmOS9K8wTMCPE7QgpLc6qhsa/1lAXx/CUqhVm3cgty9oQ6kiOcC1mc=
X-Received: by 2002:ab0:1e4c:: with SMTP id n12mr19387183uak.58.1624869979919;
 Mon, 28 Jun 2021 01:46:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210627220544.8757-1-rdunlap@infradead.org> <20210627220544.8757-4-rdunlap@infradead.org>
In-Reply-To: <20210627220544.8757-4-rdunlap@infradead.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 28 Jun 2021 10:46:08 +0200
Message-ID: <CAMuHMdXPRyyWaoVB=sekEprg5ReDp=rTAoSii0-BYtOu8nkM7w@mail.gmail.com>
Subject: Re: [PATCH 3/3 v2] sh: fix READ/WRITE redefinition warnings
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Takashi YOSHII <takasi-y@ops.dti.ne.jp>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Mon, Jun 28, 2021 at 12:05 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> kernel.h defines READ and WRITE, so rename the SH math-emu macros
> to MREAD and MWRITE.
>
> Fixes these warnings:
>
> ../arch/sh/math-emu/math.c:54: warning: "WRITE" redefined
>    54 | #define WRITE(d,a) ({if(put_user(d, (typeof (d) __user *)a)) return -EFAULT;})
> In file included from ../arch/sh/math-emu/math.c:10:
> ../include/linux/kernel.h:37: note: this is the location of the previous definition
>    37 | #define WRITE   1
> ../arch/sh/math-emu/math.c:55: warning: "READ" redefined
>    55 | #define READ(d,a) ({if(get_user(d, (typeof (d) __user *)a)) return -EFAULT;})
> In file included from ../arch/sh/math-emu/math.c:10:
> ../include/linux/kernel.h:36: note: this is the location of the previous definition
>    36 | #define READ   0
>
> Fixes: 4b565680d163 ("sh: math-emu support")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
