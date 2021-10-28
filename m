Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7280C433F5
	for <linux-sh@archiver.kernel.org>; Thu, 28 Oct 2021 13:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A83960527
	for <linux-sh@archiver.kernel.org>; Thu, 28 Oct 2021 13:38:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbhJ1Nk1 (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Thu, 28 Oct 2021 09:40:27 -0400
Received: from mail-vk1-f176.google.com ([209.85.221.176]:45689 "EHLO
        mail-vk1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbhJ1Nk1 (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Thu, 28 Oct 2021 09:40:27 -0400
Received: by mail-vk1-f176.google.com with SMTP id n201so2984906vkn.12;
        Thu, 28 Oct 2021 06:38:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z3bhZg2q8rGPgVnYFAWcAuG3eiVVloGlaqKG4qPQIPg=;
        b=cQ0jUHIhTDi9oTpqgXG441S+hJ0iuyMx9DrFDxaTOskrPR6T1yzQ4n2OFM1x7O/DPI
         aaV+r/C6K0uk3RL5oIRZ+WsaQpjVD67dgrthWoj6h4WlVBMWikm1JhCLUlzfSDUSHtnX
         +ywK3cwJS/3CDIfEe9v1YRIpTuACtD9t7cySZATyjqBwz19QzIciNSuLiLHzMY8So9f5
         LMN15c6XDIQA0PeszzpzLkADFGai8YhMfBsWwFKvOlmrgSE09k4IOjmyU20yaabJBQJw
         KLetR+xB5v3NRzI9gMp3rXmwCEKM/x+CLDr4i4+PDI3RIcM+ueHEHuicT8u+QwLWCt8k
         DgJQ==
X-Gm-Message-State: AOAM532CqOfJmCYfD9tDqQst3AIWrdEr8lsY1q6YnQv6rEGenRuTf4Lp
        W0Y9mBw61cExNH4jEt44Z7VnS9zVhPKG/w==
X-Google-Smtp-Source: ABdhPJxpX8F1cR0UMjl51bxRqKkOkIwObcf/VwwxmvJZqyciAksEmxMnAKNmOuf406JKcyYXM1Sntg==
X-Received: by 2002:a05:6122:881:: with SMTP id 1mr4353111vkf.19.1635428279527;
        Thu, 28 Oct 2021 06:37:59 -0700 (PDT)
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com. [209.85.221.176])
        by smtp.gmail.com with ESMTPSA id a8sm452549vko.51.2021.10.28.06.37.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Oct 2021 06:37:59 -0700 (PDT)
Received: by mail-vk1-f176.google.com with SMTP id s201so2990064vke.6;
        Thu, 28 Oct 2021 06:37:58 -0700 (PDT)
X-Received: by 2002:a05:6122:a12:: with SMTP id 18mr4280175vkn.15.1635428278667;
 Thu, 28 Oct 2021 06:37:58 -0700 (PDT)
MIME-Version: 1.0
References: <20211005001914.28574-1-rdunlap@infradead.org> <20211005001914.28574-3-rdunlap@infradead.org>
 <20211027205431.GX7074@brightrain.aerifal.cx> <CAMuHMdWUQkhYxXfrG4MG-Ghi62P_XVxkCMb_6qijP-MMgn-JWg@mail.gmail.com>
 <20211028133049.GY7074@brightrain.aerifal.cx>
In-Reply-To: <20211028133049.GY7074@brightrain.aerifal.cx>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 28 Oct 2021 15:37:47 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUw=6RMF4gEhROMBwQALNmmKJgiKQLYymV4m75EZV+DJQ@mail.gmail.com>
Message-ID: <CAMuHMdUw=6RMF4gEhROMBwQALNmmKJgiKQLYymV4m75EZV+DJQ@mail.gmail.com>
Subject: Re: [PATCH 2/5 v3] sh: add git tree to MAINTAINERS
To:     Rich Felker <dalias@libc.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Rich,

CC Konstantin

On Thu, Oct 28, 2021 at 3:30 PM Rich Felker <dalias@libc.org> wrote:
> On Thu, Oct 28, 2021 at 10:33:54AM +0200, Geert Uytterhoeven wrote:
> > On Wed, Oct 27, 2021 at 10:54 PM Rich Felker <dalias@libc.org> wrote:
> > > On Mon, Oct 04, 2021 at 05:19:11PM -0700, Randy Dunlap wrote:
> > > > Add the git tree location for linux-sh.
> > > >
> > > > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> >
> > > > --- linux-next-20211001.orig/MAINTAINERS
> > > > +++ linux-next-20211001/MAINTAINERS
> > > > @@ -18047,6 +18047,7 @@ M:    Yoshinori Sato <ysato@users.sourcefor
> > > >  M:   Rich Felker <dalias@libc.org>
> > > >  L:   linux-sh@vger.kernel.org
> > > >  S:   Maintained
> > > > +T:   git git://git.libc.org/linux-sh
> > > >  Q:   http://patchwork.kernel.org/project/linux-sh/list/
> > > >  F:   Documentation/sh/
> > > >  F:   arch/sh/
> > >
> > > I'm omitting this for now since (as noted on the cgit description)
> > > this server is not provisioned adequately for cloning from scratch,
> > > and should only be used for fetch into an already-populated mainline
> > > repo clone. If that's a problem I can see about getting it moved
> > > somewhere more appropriate.
> >
> > Perhaps you can move it to kernel.org?
>
> I would love to. This was my hope years ago, but I got bogged down in
> the GPG key signing requirements and folks not following through with
> signing my key. Has any of that been streamlined since?

I'll let Konstantin respond...

> > > The rest of this series should appear in next shortly.
> >
> > Thanks a lot!
>
> Looks like it's been pulled by next now with no reports of anything
> going wrong. I know it's late in the release cycle but should I

Good!

> probably go ahead and send a PR?

Actually you're right on time ;-)
Your tree is based on v5.15-rc1, and the merge window for v5.16 is
expected to open on Monday. So you can send the PR right away.

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
