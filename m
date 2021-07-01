Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE8BC11F64
	for <linux-sh@archiver.kernel.org>; Thu,  1 Jul 2021 08:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 901CC61468
	for <linux-sh@archiver.kernel.org>; Thu,  1 Jul 2021 08:41:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235493AbhGAIoV (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Thu, 1 Jul 2021 04:44:21 -0400
Received: from mail-vs1-f51.google.com ([209.85.217.51]:34362 "EHLO
        mail-vs1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235356AbhGAIoV (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Thu, 1 Jul 2021 04:44:21 -0400
Received: by mail-vs1-f51.google.com with SMTP id x15so1866462vsc.1;
        Thu, 01 Jul 2021 01:41:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0eTdfuWr8OkbCJwFohOfIFTQTvzIAVPdyd1BL+jSIRo=;
        b=QJ/wPyyHekz9fdienltpiAnNmAC5OnVE7DxVT1t6xZRup8cy+GbGY/vI0KpByWBQ5d
         ACxPzYHzXHX6iMF/+q7tfeD44Z9/6At7bzoTM7756I4d54MyijA6Tuq0LJavCBdUgHDc
         Tqb7ld2d3Jg2adI9kmygh9uH+R9aL7fBrTQ65TK1Sg3sIYchNUSLs7y2uAHV+aeGnBj1
         Nt9NhClBimV7/dtatpKTz2yTx12xaTXq2sSdu5S+hSVF2dWEMRwnNoYf22mvhgY4+68F
         9G1hHSxa5utgpW2wASfFrLVcZPicDRCMWj53JyVyiw7bC15nPTvUr7scUkywbj2XKf5a
         9OhQ==
X-Gm-Message-State: AOAM531Pm18cnkAFl0hEYN6Fx+9K2Nw7W3KWI0eMa2S1Wpfd8MaFM8cn
        HxUqUsOrBZhFOxoseSkWBYiXO56JFAYpMvKTcQ0=
X-Google-Smtp-Source: ABdhPJx9UJU5fXLhSk6qv2BOGGnRmlCcNfMAZHrqfF+ih7dAL+RHuKEQcEtNHRNMcn9fML8599ZHeZlOvGlWw9o1v5w=
X-Received: by 2002:a67:db05:: with SMTP id z5mr12484926vsj.18.1625128910205;
 Thu, 01 Jul 2021 01:41:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210627220544.8757-1-rdunlap@infradead.org> <20210627220544.8757-4-rdunlap@infradead.org>
 <6af41806-e715-4084-418f-4a8924d26c07@physik.fu-berlin.de>
 <8efd6e1d-9949-9598-9e6b-41d9b2f4ea7a@infradead.org> <d1e925b1-b0ef-2e00-ea79-b5ff2be3cf4c@physik.fu-berlin.de>
In-Reply-To: <d1e925b1-b0ef-2e00-ea79-b5ff2be3cf4c@physik.fu-berlin.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 1 Jul 2021 10:41:38 +0200
Message-ID: <CAMuHMdUjT3GnZTUurHmjctxaa==VYU9-rNuQun=f=RyWi2M5Tw@mail.gmail.com>
Subject: Re: [PATCH 3/3 v2] sh: fix READ/WRITE redefinition warnings
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Takashi YOSHII <takasi-y@ops.dti.ne.jp>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

) Hi Adrian,

On Wed, Jun 30, 2021 at 9:36 PM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> On 6/30/21 9:33 PM, Randy Dunlap wrote:
> > On 6/30/21 2:36 AM, John Paul Adrian Glaubitz wrote:
> >> On 6/28/21 12:05 AM, Randy Dunlap wrote:
> >>> kernel.h defines READ and WRITE, so rename the SH math-emu macros
> >>> to MREAD and MWRITE.
> >>>
> >>> Fixes these warnings:
> >>>
> >>> ../arch/sh/math-emu/math.c:54: warning: "WRITE" redefined
> >>>    54 | #define WRITE(d,a) ({if(put_user(d, (typeof (d) __user *)a)) return -EFAULT;})
> >>> In file included from ../arch/sh/math-emu/math.c:10:
> >>> ../include/linux/kernel.h:37: note: this is the location of the previous definition
> >>>    37 | #define WRITE   1
> >>> ../arch/sh/math-emu/math.c:55: warning: "READ" redefined
> >>>    55 | #define READ(d,a) ({if(get_user(d, (typeof (d) __user *)a)) return -EFAULT;})
> >>> In file included from ../arch/sh/math-emu/math.c:10:
> >>> ../include/linux/kernel.h:36: note: this is the location of the previous definition
> >>>    36 | #define READ   0
> >>>
> >>> Fixes: 4b565680d163 ("sh: math-emu support")
> >>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> >>> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> >>> Cc: Rich Felker <dalias@libc.org>
> >>> Cc: linux-sh@vger.kernel.org
> >>> Cc: Takashi YOSHII <takasi-y@ops.dti.ne.jp>
> >>> Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> >>> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> >>> ---
> >>> v2: renumber patches, otherwise no change;
> >>>
> >>>  arch/sh/math-emu/math.c |   44 +++++++++++++++++++-------------------
> >>>  1 file changed, 22 insertions(+), 22 deletions(-)

> >> This one no longer applies to Linus' tree:
> >>
> >> glaubitz@node54:/data/home/glaubitz/linux> git am ../sh-patches-2021/\[PATCH\ 3_3\ v2\]\ sh\:\ fix\ READ_WRITE\ redefinition\ warnings.eml
> >> Applying: sh: fix READ/WRITE redefinition warnings
> >> error: patch failed: arch/sh/math-emu/math.c:51
> >> error: arch/sh/math-emu/math.c: patch does not apply
> >> Patch failed at 0001 sh: fix READ/WRITE redefinition warnings
> >> hint: Use 'git am --show-current-patch=diff' to see the failed patch
> >> When you have resolved this problem, run "git am --continue".
> >> If you prefer to skip this patch, run "git am --skip" instead.
> >> To restore the original branch and stop patching, run "git am --abort".
> >> glaubitz@node54:/data/home/glaubitz/linux>
> >
> > OK. Thanks for all of the testing.
>
> I'll report back with the other patch applied that Geert mentioned from linux-next before this one.

FTR, I booted all three successfully on qemu/rts7751r2d and on physical landisk.


> FWIW, there are some warnings when building the SH-7785LCR configuration:
>
> In file included from ./arch/sh/include/asm/hw_irq.h:6,
>                  from ./include/linux/irq.h:591,
>                  from ./include/asm-generic/hardirq.h:17,
>                  from ./arch/sh/include/asm/hardirq.h:9,
>                  from ./include/linux/hardirq.h:11,
>                  from ./include/linux/interrupt.h:11,
>                  from ./include/linux/serial_core.h:13,
>                  from ./include/linux/serial_sci.h:6,
>                  from arch/sh/kernel/cpu/sh4a/setup-sh7785.c:10:
> ./include/linux/sh_intc.h:100:63: warning: division 'sizeof (void *) / sizeof (void)' does not compute the number of array elements [-Wsizeof-pointer-div]
>   100 | #define _INTC_ARRAY(a) a, __same_type(a, NULL) ? 0 : sizeof(a)/sizeof(*a)
>       |                                                               ^
> ./include/linux/sh_intc.h:107:9: note: in expansion of macro '_INTC_ARRAY'
>   107 |         _INTC_ARRAY(sense_regs), _INTC_ARRAY(ack_regs), \
>       |         ^~~~~~~~~~~
> ./include/linux/sh_intc.h:124:15: note: in expansion of macro 'INTC_HW_DESC'
>   124 |         .hw = INTC_HW_DESC(vectors, groups, mask_regs,                  \
>       |               ^~~~~~~~~~~~
> arch/sh/kernel/cpu/sh4a/setup-sh7785.c:478:8: note: in expansion of macro 'DECLARE_INTC_DESC'
>   478 | static DECLARE_INTC_DESC(intc_desc, "sh7785", vectors, groups,
>       |        ^~~~~~~~~~~~~~~~~

A while ago, I had a look into fixing them, but it was non-trivial.
The issue is that the macros are sometimes used with NULL pointer arrays.
The __same_type() check in

    #define _INTC_ARRAY(a) a, __same_type(a, NULL) ? 0 : sizeof(a)/sizeof(*a)

is supposed to catch that, but modern compilers seem to evaluate the
non-taken branch, too, leading to the warning.

Anyone with a suggestion? (CCing the multi-compiler guru)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
