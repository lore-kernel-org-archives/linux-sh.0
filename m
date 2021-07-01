Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E1B9C11F64
	for <linux-sh@archiver.kernel.org>; Thu,  1 Jul 2021 11:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 130D36145C
	for <linux-sh@archiver.kernel.org>; Thu,  1 Jul 2021 11:57:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236289AbhGAMAC (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Thu, 1 Jul 2021 08:00:02 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:50803 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236192AbhGAMAC (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Thu, 1 Jul 2021 08:00:02 -0400
Received: from mail-wm1-f41.google.com ([209.85.128.41]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1N6LIF-1l9xK70isr-016drC; Thu, 01 Jul 2021 13:57:30 +0200
Received: by mail-wm1-f41.google.com with SMTP id k16-20020a05600c1c90b02901f4ed0fcfe7so2752769wms.5;
        Thu, 01 Jul 2021 04:57:30 -0700 (PDT)
X-Gm-Message-State: AOAM532P/UpOGH3iFWYYVS2Qk65MBhtBBRFTWFp+YJ66RwFne45LW1X9
        NiUMpQbB677/MOmrSbTn50azu3pn8Vke6qsokqg=
X-Google-Smtp-Source: ABdhPJzWT35cqnukRuNYYgOAlRhludxMkk99HC2u0D8DVZ1pVN2Q6rEUR/Gmsb0iqMGT0+k/n6HCXXoYPln3aEiovrM=
X-Received: by 2002:a7b:c143:: with SMTP id z3mr10327778wmi.84.1625140649682;
 Thu, 01 Jul 2021 04:57:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210627220544.8757-1-rdunlap@infradead.org> <20210627220544.8757-4-rdunlap@infradead.org>
 <6af41806-e715-4084-418f-4a8924d26c07@physik.fu-berlin.de>
 <8efd6e1d-9949-9598-9e6b-41d9b2f4ea7a@infradead.org> <d1e925b1-b0ef-2e00-ea79-b5ff2be3cf4c@physik.fu-berlin.de>
 <CAMuHMdUjT3GnZTUurHmjctxaa==VYU9-rNuQun=f=RyWi2M5Tw@mail.gmail.com>
In-Reply-To: <CAMuHMdUjT3GnZTUurHmjctxaa==VYU9-rNuQun=f=RyWi2M5Tw@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 1 Jul 2021 13:57:13 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2GdZ0FXUeo_3-fKOViZrhfGt-KELw+knaGAMKQTuVonw@mail.gmail.com>
Message-ID: <CAK8P3a2GdZ0FXUeo_3-fKOViZrhfGt-KELw+knaGAMKQTuVonw@mail.gmail.com>
Subject: Re: [PATCH 3/3 v2] sh: fix READ/WRITE redefinition warnings
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Takashi YOSHII <takasi-y@ops.dti.ne.jp>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:k+Ak7gOxp88frdOf7LjRXmUtxW/d8LO2w64JikIhB3Z9DP0fpI0
 W+1wsCnVNtUXzBLoKgSKvEk5tux8IhXlLaj03WIE/qTASi3wOX8mNuuTW+dZgb87n5+gBL1
 59ljM2pG/DGTCQBp2ujIUoDMHEvwcZotbhvJqLnDUSfy0l/8BaoDSFq8xuyA2ue4rSW5nvp
 /JAub3jtmR1IZ8gvTwliA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0iC6+P7QudE=:nmVWoyXlQ/GjKGRSpAVNBK
 cG3TxL9kS46VGghnFNRYzP0uB1MigUBA3PUbaAJKsCibDzmW+KLr37bu95MD+4bxUTYLhwwFh
 7qoLdXA3KmwFk0kE/qilYdY/1Z+J89MMatRYVXDpKZd+q6rDQVl8awODXhKuHVBFUD33E3U0e
 AB5EIF1D+XcechFapAtFETLfley037InCbmhrgD4fJ+OtNM2fyNzb+FV/sTcLpry/y28UtkPR
 7eEA8ygLA7dTj0hhS41QIGkwCiEAGVL9r+7EAcmE7B6sDXXq7MSD9s+WBuCfjH5jG/+fYRSuv
 VD0CkUFYliEYBW1k+uspjJHCLZefEosGEM4oelxGBPMLK05H6vR+MMrzMSUgAHp2AvIiQAgGZ
 J4ZQsAVvyyl0P4Rl9yIs5n0E4Z9Fwmrn/1/qMEAxU368z+O5FFMn3V1wW0j9MccgSBOaFq6Yv
 qFRKQShv4bLbB6a+hNRX2/EwKHQneguN8NsIllRsRx10LuwNZ0d/Mj4DKhhz15nVuvrWcnHoQ
 6rRPaJDwtDvxdCFu9MGtN4gwDuKcKIzl2RiD5epK7qOFHj4MvKCqT+DRgq4Ojg/pM+cZ4IK/t
 sj2B+Rx9LaT8aRr521P/2/5eJFwEnWxD5HuBDhzXIHbE+HILIPpM2kTm8R0U+hMKwiAfILAOm
 skY4A+QofpWRQIHFat63CLkcdxnssqHOpwHpqqnuZb8RLycnUeomIFxdZnk8nCAvtF9Nq3Q6n
 zxR25G+LxaPbFCKwFISF+v79u5Kd5MMnir78UBO01+4eZ5+8PKFHpgU9BqvH6z65nab10XxH6
 Yfgk/n/i9zGmjYKIPX5XESK2Ii2a/NfaS1OItEHx6PUetkLOM+nka2SoXtGR2kdA9NSzopn38
 uM2Iad2R+R5+PK/wjpuugrwVnaE/UJC7ViDsd7qTzXebgR3KAVCdZD6LK5PRJ0OrJErXDBOp9
 pZLS8sU7W2vk36HRTrG3JZhN+oLXw8XQ2bUGCI6xjEdbEnsncSdIy
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Thu, Jul 1, 2021 at 10:41 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Wed, Jun 30, 2021 at 9:36 PM John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de> wrote:
> > On 6/30/21 9:33 PM, Randy Dunlap wrote:
> > > On 6/30/21 2:36 AM, John Paul Adrian Glaubitz wrote:
>
> > FWIW, there are some warnings when building the SH-7785LCR configuration:
> >
> > In file included from ./arch/sh/include/asm/hw_irq.h:6,
> >                  from ./include/linux/irq.h:591,
> >                  from ./include/asm-generic/hardirq.h:17,
> >                  from ./arch/sh/include/asm/hardirq.h:9,
> >                  from ./include/linux/hardirq.h:11,
> >                  from ./include/linux/interrupt.h:11,
> >                  from ./include/linux/serial_core.h:13,
> >                  from ./include/linux/serial_sci.h:6,
> >                  from arch/sh/kernel/cpu/sh4a/setup-sh7785.c:10:
> > ./include/linux/sh_intc.h:100:63: warning: division 'sizeof (void *) / sizeof (void)' does not compute the number of array elements [-Wsizeof-pointer-div]
> >   100 | #define _INTC_ARRAY(a) a, __same_type(a, NULL) ? 0 : sizeof(a)/sizeof(*a)
> >       |                                                               ^
> > ./include/linux/sh_intc.h:107:9: note: in expansion of macro '_INTC_ARRAY'
> >   107 |         _INTC_ARRAY(sense_regs), _INTC_ARRAY(ack_regs), \
> >       |         ^~~~~~~~~~~
> > ./include/linux/sh_intc.h:124:15: note: in expansion of macro 'INTC_HW_DESC'
> >   124 |         .hw = INTC_HW_DESC(vectors, groups, mask_regs,                  \
> >       |               ^~~~~~~~~~~~
> > arch/sh/kernel/cpu/sh4a/setup-sh7785.c:478:8: note: in expansion of macro 'DECLARE_INTC_DESC'
> >   478 | static DECLARE_INTC_DESC(intc_desc, "sh7785", vectors, groups,
> >       |        ^~~~~~~~~~~~~~~~~
>
> A while ago, I had a look into fixing them, but it was non-trivial.
> The issue is that the macros are sometimes used with NULL pointer arrays.
> The __same_type() check in
>
>     #define _INTC_ARRAY(a) a, __same_type(a, NULL) ? 0 : sizeof(a)/sizeof(*a)
>
> is supposed to catch that, but modern compilers seem to evaluate the
> non-taken branch, too, leading to the warning.
>
> Anyone with a suggestion? (CCing the multi-compiler guru)

I think I looked at this (or maybe a related sh driver) in the past
and also gave up.

The best idea I have would be to manually expand the DECLARE_INTC_DESC()
macros. It would be possible to add further variations of them for each
combination of NULL/non-NULL arguments, but IMHO they don't actually
add any readability over the expanded version in the first place.

Another option would be to change the definition from array/size to
zero-terminated
arrays and get rid of the sizeof hack.

      Arnd
