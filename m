Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA6EEC433EF
	for <linux-sh@archiver.kernel.org>; Tue,  5 Oct 2021 07:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC8B4613B5
	for <linux-sh@archiver.kernel.org>; Tue,  5 Oct 2021 07:26:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231816AbhJEH2M (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 5 Oct 2021 03:28:12 -0400
Received: from mail-ua1-f49.google.com ([209.85.222.49]:35684 "EHLO
        mail-ua1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232365AbhJEH2L (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 5 Oct 2021 03:28:11 -0400
Received: by mail-ua1-f49.google.com with SMTP id q13so2150336uaq.2;
        Tue, 05 Oct 2021 00:26:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5B8guYb5WtEG1DfSQkNHuh8hV3bBqGM6XN/MlDSJq6g=;
        b=Wo3h2a1j3ucRsdu8bnoUcvVumzVyNDaqP2LqUhAWgRFHap/ZmpkRVvY2ceXyVvENBC
         eYVCgfV33oT4TTjWKXPw4LYpdNxxXCMEwIbrzprXNOOsoNvVdjZzCFO2ZBOkJmtigv3R
         cYpBUH+2NRURvNDvM4+NjWIn5YYFmO3vWvnS1elIf6upl/mrSfARtmx5ONTwuqKXhsnu
         1dM+qBL6qbda1wEplISZFQHjXkpLBP0XS1Rg3UPORrzPJVBQLIapKsaxd/O+Lyx1STi1
         +fRNXBAHu+OvVdfir6tBPcQR71wCqKGaMKje+gMbj3B8K//lGtXKA6434rEnS0JvqGKT
         S82g==
X-Gm-Message-State: AOAM530ELi83pr4qRWlA3sx4kUD0vvSicHbccMXlFhoNhmOSHJ0svlfy
        ghH8vyvp9HzdZWqIr8AguCiLNjl+405iCSoJfUE=
X-Google-Smtp-Source: ABdhPJwitoHm5NqIklNf3C/vTIwhdJEaTtzOd1JmOOF/GJsBSk+HnFu5BWxGe3wzWFhlUDtnlcmU/pjMaReCJlRtJqI=
X-Received: by 2002:ab0:540d:: with SMTP id n13mr10811903uaa.78.1633418777896;
 Tue, 05 Oct 2021 00:26:17 -0700 (PDT)
MIME-Version: 1.0
References: <20211005001914.28574-1-rdunlap@infradead.org> <20211005001914.28574-4-rdunlap@infradead.org>
In-Reply-To: <20211005001914.28574-4-rdunlap@infradead.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 5 Oct 2021 09:26:06 +0200
Message-ID: <CAMuHMdUwkOwLgbxjSwO0QCq+=jBL+e1z8X6NZHrrx0bv_zFq1A@mail.gmail.com>
Subject: Re: [PATCH 3/5 v3] sh: math-emu: drop unused functions
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

Hi Randy,

Thanks for your patch!

On Tue, Oct 5, 2021 at 2:19 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> Delete ieee_fpe_handler() since it is not used. After that is done,
> delete denormal_to_double() since it is not used:
>
> ../arch/sh/math-emu/math.c:505:12: error: 'ieee_fpe_handler' defined but not used [-Werror=unused-function]
>   505 | static int ieee_fpe_handler(struct pt_regs *regs)
>
> ../arch/sh/math-emu/math.c:477:13: error: 'denormal_to_double' defined but not used [-Werror=unused-function]
>   477 | static void denormal_to_double(struct sh_fpu_soft_struct *fpu, int n)
>
> Fixes: 4b565680d163 ("sh: math-emu support")

Shouldn't that be
Fixes: 7caf62de25554da3 ("sh: remove unused do_fpu_error")
?

> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
