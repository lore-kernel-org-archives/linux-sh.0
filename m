Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48090C25B6B
	for <linux-sh@archiver.kernel.org>; Thu, 26 Oct 2023 07:20:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjJZHU4 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-sh@archiver.kernel.org>);
        Thu, 26 Oct 2023 03:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjJZHUz (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Thu, 26 Oct 2023 03:20:55 -0400
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD3ED6
        for <linux-sh@vger.kernel.org>; Thu, 26 Oct 2023 00:20:54 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-59e88a28b98so4943997b3.1
        for <linux-sh@vger.kernel.org>; Thu, 26 Oct 2023 00:20:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698304853; x=1698909653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4m+HtyK2cOIo2GWXMAw9U7E2CfRCrcsFJaCrSIGMxuA=;
        b=oXy2C8+G7JcRFoIhSuzgHzJIsnL93/uISzICXgXDJ9PV1cooxjJE1ATLlGVR+bUVBJ
         5EWgHo2c8dgJbAKpnUqqJG8JoLLGo5355Tbjj7BhQqRB6CZOf3jW2uR932Jsfm2GToC3
         TY+jMeIhTIdkFUu7DDV8RFWnPphLggrT45XFYay68+ffqVYNy9vpafAVoFNOAVbJJSny
         QgcJCHdQRSdli6utzNWM6wxzDoGDNYuzvtP3ritITah7wQ5WCmZiBgwjYaQ/ZyNNUT2N
         ooKpElnQdl3PryTA8U8Ae0Y9wBeOifYtFxr+GLjHAlKl2KO6yatjZc+pz2TPufc1Jty+
         2New==
X-Gm-Message-State: AOJu0YwN9qeLg7qD73RyxCdCm/HNRTYB3/a8eL/wnd+g3RVBXeSnV61Y
        jHCX3UxT1xvtoslpknB9tx8wOlW2hupjZg==
X-Google-Smtp-Source: AGHT+IGeoftPIVYiHe4fTBvI1dEbluUfYzRBCc0NqrGa8fO8dZLRpvaLLaeYc6KSA/eBkSuV5ZFYrg==
X-Received: by 2002:a81:7850:0:b0:5a7:fcaf:c1c0 with SMTP id t77-20020a817850000000b005a7fcafc1c0mr3267023ywc.8.1698304853032;
        Thu, 26 Oct 2023 00:20:53 -0700 (PDT)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id gz11-20020a05690c470b00b0055a07e36659sm2545444ywb.145.2023.10.26.00.20.52
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Oct 2023 00:20:52 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-5a877e0f0d8so14942277b3.1
        for <linux-sh@vger.kernel.org>; Thu, 26 Oct 2023 00:20:52 -0700 (PDT)
X-Received: by 2002:a25:9709:0:b0:da0:3a37:61d5 with SMTP id
 d9-20020a259709000000b00da03a3761d5mr3598181ybo.4.1698304852645; Thu, 26 Oct
 2023 00:20:52 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1697199949.git.ysato@users.sourceforge.jp>
 <7b864c7ded52ace326c42b132708a6dc8ad9a606.1697199949.git.ysato@users.sourceforge.jp>
 <CAMuHMdXQUm9CpNGXoXJvyDrhe_3J11MTTvV4_J0zKK9U6AUcqQ@mail.gmail.com> <87il6u6oge.wl-ysato@users.sourceforge.jp>
In-Reply-To: <87il6u6oge.wl-ysato@users.sourceforge.jp>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 26 Oct 2023 09:20:40 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWcqBKWPhZAAu_7i81f8Qgu98Y-xj078qiEQkRqCM5Hdw@mail.gmail.com>
Message-ID: <CAMuHMdWcqBKWPhZAAu_7i81f8Qgu98Y-xj078qiEQkRqCM5Hdw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 06/35] arch/sh/boards/of-generic.c: some cleanup.
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     linux-sh@vger.kernel.org, glaubitz@physik.fu-berlin.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Sato-san,

On Thu, Oct 26, 2023 at 5:40 AM Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
> On Thu, 19 Oct 2023 03:37:57 +0900,
> Geert Uytterhoeven wrote:
> > On Sat, Oct 14, 2023 at 4:54 PM Yoshinori Sato
> > <ysato@users.sourceforge.jp> wrote:
> > > Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> >
> > Thanks for your patch!
> >
> > > --- a/arch/sh/boards/of-generic.c
> > > +++ b/arch/sh/boards/of-generic.c
> > > @@ -140,25 +132,13 @@ static void __init sh_of_init_irq(void)
> > >         irqchip_init();
> > >  }
> > >
> > > -static int __init sh_of_clk_init(void)
> > > -{
> > > -#ifdef CONFIG_COMMON_CLK
> > > -       /* Disabled pending move to COMMON_CLK framework. */
> > > -       pr_info("SH generic board support: scanning for clk providers\n");
> > > -       of_clk_init(NULL);
> > > -#endif
> > > -       return 0;
> > > -}
> > > -
> >
> > Removing this breaks J2 for sure? I guess this should be merged with
> > "[RFC PATCH v3 07/35] arch/sh/kernel/time.c: support COMMON_CLK."
> > to avoid a bisection regression?
>
> J2 timer (jcore-pit) used TIMER_OF_DECLARE
> This is the correct OF implementation, so it is initialized with timer_probe.
> I would like to eliminate as many SH-specific methods as possible.

Oh right, I missed that (a) there still is a call to timer_init()
in SH's time_init(), and (b) more importantly, J-core does not have
any other clock drivers, so it does not need of_clk_init().

Still, I think it would make sense to merge the two patches.
And the call to timer_init() should be removed from the non-DT
variant of time_init(), as timer_init() handles only DT and ACPI.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
