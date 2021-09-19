Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67471C433EF
	for <linux-sh@archiver.kernel.org>; Sun, 19 Sep 2021 02:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C282610A8
	for <linux-sh@archiver.kernel.org>; Sun, 19 Sep 2021 02:05:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbhISCGZ (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Sat, 18 Sep 2021 22:06:25 -0400
Received: from condef-03.nifty.com ([202.248.20.68]:35164 "EHLO
        condef-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbhISCGV (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Sat, 18 Sep 2021 22:06:21 -0400
Received: from conssluserg-05.nifty.com ([10.126.8.84])by condef-03.nifty.com with ESMTP id 18J2358c023225
        for <linux-sh@vger.kernel.org>; Sun, 19 Sep 2021 11:03:05 +0900
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 18J22fC3001853;
        Sun, 19 Sep 2021 11:02:41 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 18J22fC3001853
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1632016962;
        bh=eZ4UqEzoFbcU1gxopsAWucOOsR8Keeo3LyleujdCQ2c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Gp1X0Imnhk25xHygSuIwJ39zKa8vRJuxluKs09ZphVNtqFxqjCXHuiAVP4u/+Dibz
         t07RNv3PmHeauIY6sGZITWOCDQERx2Cgs6Rh+eqwAvVjDZf2q+xFSrP4IIEwt4zVSG
         eG1eIL9l1QUHqtu/HJBJjC4qt0D/OYKQSM1z6mLeOf6P1xKivEA3/wmojiNj2GmWY6
         DxGx+Yh7sEsDFXYroT6HntEq52ee02o4bCoW8gvEncOaAtYJOkHwwfCqfxeYExPZs3
         0Gj46GNBVAjb1YRKZ2fBFgFs6ZdMH6sZNtUlHm0tCyWJVSevqxMOP1J92tTDmtgmmT
         2oPHK+OuoXSzw==
X-Nifty-SrcIP: [209.85.216.45]
Received: by mail-pj1-f45.google.com with SMTP id me5-20020a17090b17c500b0019af76b7bb4so12055419pjb.2;
        Sat, 18 Sep 2021 19:02:41 -0700 (PDT)
X-Gm-Message-State: AOAM530O8iVnwCGqL7i1ueGA7qMOUXhwo2gu5kctyTqS0BIsxxl7SVxw
        6bNeyX2r/s5axsWhAZBgpmMweYi5pNO+juvvVEE=
X-Google-Smtp-Source: ABdhPJzEdjq35ZjkW0hHIL1UUG+LNy7qC1HsCpAIiK3J6D7N5kbSKfCC5cTPRhOBcUI7G4hghXCQ6KRSxa0DGFrJnd8=
X-Received: by 2002:a17:90b:314a:: with SMTP id ip10mr9609133pjb.77.1632016960976;
 Sat, 18 Sep 2021 19:02:40 -0700 (PDT)
MIME-Version: 1.0
References: <0771f164fcbba2fb425bf525400b8fab7079e539.1631781770.git.geert+renesas@glider.be>
In-Reply-To: <0771f164fcbba2fb425bf525400b8fab7079e539.1631781770.git.geert+renesas@glider.be>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 19 Sep 2021 11:02:04 +0900
X-Gmail-Original-Message-ID: <CAK7LNARTCU12W=nKOrjM8_5aGhkUPhiOqWBgwROsLKcZ80fy3Q@mail.gmail.com>
Message-ID: <CAK7LNARTCU12W=nKOrjM8_5aGhkUPhiOqWBgwROsLKcZ80fy3Q@mail.gmail.com>
Subject: Re: [PATCH] sh: Add missing FORCE prerequisites in Makefile
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Thu, Sep 16, 2021 at 5:43 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> make:
>
>     arch/sh/boot/Makefile:87: FORCE prerequisite is missing
>
> Add the missing FORCE prerequisites for all build targets identified by
> "make help".
>
> Fixes: e1f86d7b4b2a5213 ("kbuild: warn if FORCE is missing for if_changed(_dep,_rule) and filechk")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---


Applied to linux-kbuild. Thanks.

>  arch/sh/boot/Makefile | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/arch/sh/boot/Makefile b/arch/sh/boot/Makefile
> index dded61296c9a00da..5c123f5b2797c08a 100644
> --- a/arch/sh/boot/Makefile
> +++ b/arch/sh/boot/Makefile
> @@ -80,30 +80,30 @@ $(obj)/vmlinux.bin.xz: $(obj)/vmlinux.bin FORCE
>  $(obj)/vmlinux.bin.lzo: $(obj)/vmlinux.bin FORCE
>         $(call if_changed,lzo)
>
> -$(obj)/uImage.bz2: $(obj)/vmlinux.bin.bz2
> +$(obj)/uImage.bz2: $(obj)/vmlinux.bin.bz2 FORCE
>         $(call if_changed,uimage,bzip2)
>
> -$(obj)/uImage.gz: $(obj)/vmlinux.bin.gz
> +$(obj)/uImage.gz: $(obj)/vmlinux.bin.gz FORCE
>         $(call if_changed,uimage,gzip)
>
> -$(obj)/uImage.lzma: $(obj)/vmlinux.bin.lzma
> +$(obj)/uImage.lzma: $(obj)/vmlinux.bin.lzma FORCE
>         $(call if_changed,uimage,lzma)
>
> -$(obj)/uImage.xz: $(obj)/vmlinux.bin.xz
> +$(obj)/uImage.xz: $(obj)/vmlinux.bin.xz FORCE
>         $(call if_changed,uimage,xz)
>
> -$(obj)/uImage.lzo: $(obj)/vmlinux.bin.lzo
> +$(obj)/uImage.lzo: $(obj)/vmlinux.bin.lzo FORCE
>         $(call if_changed,uimage,lzo)
>
> -$(obj)/uImage.bin: $(obj)/vmlinux.bin
> +$(obj)/uImage.bin: $(obj)/vmlinux.bin FORCE
>         $(call if_changed,uimage,none)
>
>  OBJCOPYFLAGS_vmlinux.srec := -I binary -O srec
> -$(obj)/vmlinux.srec: $(obj)/compressed/vmlinux
> +$(obj)/vmlinux.srec: $(obj)/compressed/vmlinux FORCE
>         $(call if_changed,objcopy)
>
>  OBJCOPYFLAGS_uImage.srec := -I binary -O srec
> -$(obj)/uImage.srec: $(obj)/uImage
> +$(obj)/uImage.srec: $(obj)/uImage FORCE
>         $(call if_changed,objcopy)
>
>  $(obj)/uImage: $(obj)/uImage.$(suffix-y)
> --
> 2.25.1
>


-- 
Best Regards
Masahiro Yamada
