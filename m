Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA0A9C4708F
	for <linux-sh@archiver.kernel.org>; Fri,  4 Jun 2021 07:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1BF261418
	for <linux-sh@archiver.kernel.org>; Fri,  4 Jun 2021 07:24:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbhFDH0Y (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Fri, 4 Jun 2021 03:26:24 -0400
Received: from mail-ua1-f45.google.com ([209.85.222.45]:37636 "EHLO
        mail-ua1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbhFDH0Y (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Fri, 4 Jun 2021 03:26:24 -0400
Received: by mail-ua1-f45.google.com with SMTP id w28so4769499uae.4;
        Fri, 04 Jun 2021 00:24:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xdK3jErAEdVTUgbukZxCb16WCBIXuXcCaEIpQC1wYjM=;
        b=bH4y8z9n2NgdP3G/3Xs5wokjPLGc+RB/BGXEfa4IUklIArsCPPhOzIqJqYuku+9BSk
         JshPVvn3VpfkbB2V0bBfSLEBJAdnxFui7OZchJEW5rXKNshupMLBWVWV7ENcsU7VZg0C
         5x6e3ySC7ELHkX1Y9vlSO2OOB8e1XtIYCXMzt3AfZs25WX5BFajGnkHbg9UiPwTmyV99
         ReffoT/2CtXJJ9DncV1n7rRH5MK8OaOZ8TcBbcEaQh++y1k3/EAtH156NB7a7vtafXq5
         EJxxxKLGsfhnvFYTRkRY++XboVbSLSuSWJhu06jHG9pe0RIXzZr43AvjcSeKMt483o/c
         pzlg==
X-Gm-Message-State: AOAM533bYge7OtzUW+AmFtcoy5DuN4t1xKYbyoz7Hiue8ybebY+T13oN
        7/INzLRRyUFPH5wPdXp8JxO95R0ORMRZDXGRFfq6tHu4bjOlHg==
X-Google-Smtp-Source: ABdhPJyr7w2RlhMD4aWY30qs/G0+K2Azu7QiaeOfo1q/OOiwa11AeSXDBIj20pRPh1Vf8spFrTi7/OtZetxEa5/kCrw=
X-Received: by 2002:ab0:7515:: with SMTP id m21mr2259375uap.2.1622791474528;
 Fri, 04 Jun 2021 00:24:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210602231443.4670-1-rdunlap@infradead.org> <20210602231443.4670-3-rdunlap@infradead.org>
 <CAMuHMdX1aCJPASd0vvuo+=sjnS8dv24eB_xY8Fn0L2TkJ8NWiQ@mail.gmail.com> <cde0b1fc-eec3-2267-3872-1099840f5670@infradead.org>
In-Reply-To: <cde0b1fc-eec3-2267-3872-1099840f5670@infradead.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 4 Jun 2021 09:24:23 +0200
Message-ID: <CAMuHMdVUp2+C7QbLQvDqXCZ6FK-dEoz90aNk7Tu84YTRb3B_ww@mail.gmail.com>
Subject: Re: [RFC PATCH 3/4] sh: define __BIG_ENDIAN for math-emu
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Randy,

On Fri, Jun 4, 2021 at 1:19 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> On 6/3/21 12:54 AM, Geert Uytterhoeven wrote:
> > On Thu, Jun 3, 2021 at 1:17 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> >> The headers in include/math-emu/ test for __BYTE_ORDER == __BIG_ENDIAN
> >> without checking to see if these macros are defined, so add
> >> a define for __BIG_ENDIAN before pulling in these headers.
> >>
> >> This placates these build warnings:
> >>
> >> In file included from ../arch/sh/math-emu/math.c:23:
> >> ../include/math-emu/single.h:50:21: warning: "__BIG_ENDIAN" is not defined, evaluates to 0 [-Wundef]
> >>    50 | #if __BYTE_ORDER == __BIG_ENDIAN
> >> In file included from ../arch/sh/math-emu/math.c:24:
> >> ../include/math-emu/double.h:59:21: warning: "__BIG_ENDIAN" is not defined, evaluates to 0 [-Wundef]
> >>    59 | #if __BYTE_ORDER == __BIG_ENDIAN
> >>
> >> Fixes: 4b565680d163 ("sh: math-emu support")
> >> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> >
> > Thanks for your patch!
> >
> >> --- linux-next-20210528.orig/arch/sh/math-emu/sfp-util.h
> >> +++ linux-next-20210528/arch/sh/math-emu/sfp-util.h
> >> @@ -70,4 +70,4 @@
> >>
> >>  #define __BYTE_ORDER __LITTLE_ENDIAN
> >>
> >> -
> >> +#define __BIG_ENDIAN 0
> >
> > I don't think this is the right fix.
> >
> > I think the right values should be picked up from:
> >
> >     include/uapi/linux/byteorder/big_endian.h:#define __BIG_ENDIAN 4321
> >     include/uapi/linux/byteorder/little_endian.h:#define __LITTLE_ENDIAN 1234
> >
> > How is this picked up on other architectures using <math-emu/single.h>?
>
> There isn't very much to compare to in other arch/.
> I've made a v2 patch that is done like arch/nds32/ does.
> What do you think about this one?
>
> thanks.
> ---
> From: Randy Dunlap <rdunlap@infradead.org>
> Subject: [RFC PATCH 2/3 v2] sh: define __BIG_ENDIAN for math-emu
>
> Fix this by defining both ENDIAN macros in
> <asm/sfp-machine.h> so that they can be utilized in
> <math-emu/soft-fp.h> according to the latter's comment:
> /* Allow sfp-machine to have its own byte order definitions. */
>
> (This is what is done in arch/nds32/include/asm/sfp-machine.h.)
>
> This placates these build warnings:
>
> In file included from ../arch/sh/math-emu/math.c:23:
> ../include/math-emu/single.h:50:21: warning: "__BIG_ENDIAN" is not defined, evaluates to 0 [-Wundef]
>    50 | #if __BYTE_ORDER == __BIG_ENDIAN
> In file included from ../arch/sh/math-emu/math.c:24:
> ../include/math-emu/double.h:59:21: warning: "__BIG_ENDIAN" is not defined, evaluates to 0 [-Wundef]
>    59 | #if __BYTE_ORDER == __BIG_ENDIAN
>
> Fixes: 4b565680d163 ("sh: math-emu support")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: linux-sh@vger.kernel.org
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> ---
>  arch/sh/include/asm/sfp-machine.h |    8 ++++++++
>  1 file changed, 8 insertions(+)
>
> --- linux-next-20210528.orig/arch/sh/include/asm/sfp-machine.h
> +++ linux-next-20210528/arch/sh/include/asm/sfp-machine.h
> @@ -13,6 +13,14 @@
>  #ifndef _SFP_MACHINE_H
>  #define _SFP_MACHINE_H
>
> +#ifdef __BIG_ENDIAN__
> +#define __BYTE_ORDER __BIG_ENDIAN
> +#define __LITTLE_ENDIAN 0
> +#else
> +#define __BYTE_ORDER __LITTLE_ENDIAN
> +#define __BIG_ENDIAN 0
> +#endif
> +
>  #define _FP_W_TYPE_SIZE                32
>  #define _FP_W_TYPE             unsigned long
>  #define _FP_WS_TYPE            signed long

These checks match with what is set by my sh cross-compiler (gcc
8.1.0):

diff <(sh4-linux-gcc-8.1.0 -ml -dM -E - < /dev/null | grep -E
"(BYTE_ORDER|ENDIAN)") <(sh4-linux-gcc-8.1.0 -mb -dM -E - < /dev/null
| grep -E "(BYTE_ORDER|ENDIAN)")
--- /dev/fd/63 2021-06-04 09:15:50.689928352 +0200
+++ /dev/fd/62 2021-06-04 09:15:50.689928352 +0200
@@ -1,6 +1,6 @@
 #define __ORDER_LITTLE_ENDIAN__ 1234
-#define __FLOAT_WORD_ORDER__ __ORDER_LITTLE_ENDIAN__
+#define __BIG_ENDIAN__ 1
+#define __FLOAT_WORD_ORDER__ __ORDER_BIG_ENDIAN__
 #define __ORDER_PDP_ENDIAN__ 3412
-#define __LITTLE_ENDIAN__ 1
 #define __ORDER_BIG_ENDIAN__ 4321
-#define __BYTE_ORDER__ __ORDER_LITTLE_ENDIAN__
+#define __BYTE_ORDER__ __ORDER_BIG_ENDIAN__

So
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Note that powerpc checks on _BIG_ENDIAN, which works as my powerpc
cross-compiler (gcc 9.3.0) defines both _BIG_ENDIAN and _BIG_ENDIAN__.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
