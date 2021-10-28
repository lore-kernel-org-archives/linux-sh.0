Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39555C433F5
	for <linux-sh@archiver.kernel.org>; Thu, 28 Oct 2021 08:34:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E428610CF
	for <linux-sh@archiver.kernel.org>; Thu, 28 Oct 2021 08:34:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbhJ1Igd (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Thu, 28 Oct 2021 04:36:33 -0400
Received: from mail-ua1-f47.google.com ([209.85.222.47]:43872 "EHLO
        mail-ua1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbhJ1Igd (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Thu, 28 Oct 2021 04:36:33 -0400
Received: by mail-ua1-f47.google.com with SMTP id v3so10001403uam.10;
        Thu, 28 Oct 2021 01:34:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BYbaXCUYNWuEm6VFzPPAR1kV9z1lrK0IXCwkfP1SadA=;
        b=CYzzkop7dRZE4eMMbeQXAov/bGioCy9Vt2iQQo7NEMYOSjzlawqGYZNUpHzifso/Pz
         YtPcDnzLNbF+fGVNtgtxu4jpFTetyfANZUcPoxRu85e4rRErbykvUhy3EEOtNS9rpl0T
         wYD5kVjXrj5o1NaZkD/LOegZfA2K6hxGShWnxB5g9ttRbyJmw6nq9LtloR/vabXDqsGV
         aR4WdRpu6VdbYVzqR3j/97XYCPuflf0KLDv2A0TlpJKOlxgxdVPOjSmXHZPPtUkX86bA
         cN1cjrQn558HOalE/sxjnZcM7WY/ZrWDb6l+tbJxGwTI6Ze2FnuPUhGUnKWtUB02QQAJ
         +5tA==
X-Gm-Message-State: AOAM530ClTACY7IG5IfUGh0klMmlKDceIZimSQpNOqi/eOvSz90gSGSt
        1R4DYOKYWlTWR+V163USJYj4seAeSYds/Q==
X-Google-Smtp-Source: ABdhPJy7dwNsDkMlFGm70cwUIGaZe5jNg5oeikWbOuZRRL7EdVAVPjQ4CqAAPliqbdh8uGEXtdU6nQ==
X-Received: by 2002:a9f:3881:: with SMTP id t1mr2733578uaf.127.1635410046224;
        Thu, 28 Oct 2021 01:34:06 -0700 (PDT)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com. [209.85.222.46])
        by smtp.gmail.com with ESMTPSA id q24sm253216vkn.20.2021.10.28.01.34.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Oct 2021 01:34:06 -0700 (PDT)
Received: by mail-ua1-f46.google.com with SMTP id s4so10174581uaq.0;
        Thu, 28 Oct 2021 01:34:06 -0700 (PDT)
X-Received: by 2002:ab0:2bd2:: with SMTP id s18mr2843638uar.78.1635410045974;
 Thu, 28 Oct 2021 01:34:05 -0700 (PDT)
MIME-Version: 1.0
References: <20211005001914.28574-1-rdunlap@infradead.org> <20211005001914.28574-3-rdunlap@infradead.org>
 <20211027205431.GX7074@brightrain.aerifal.cx>
In-Reply-To: <20211027205431.GX7074@brightrain.aerifal.cx>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 28 Oct 2021 10:33:54 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWUQkhYxXfrG4MG-Ghi62P_XVxkCMb_6qijP-MMgn-JWg@mail.gmail.com>
Message-ID: <CAMuHMdWUQkhYxXfrG4MG-Ghi62P_XVxkCMb_6qijP-MMgn-JWg@mail.gmail.com>
Subject: Re: [PATCH 2/5 v3] sh: add git tree to MAINTAINERS
To:     Rich Felker <dalias@libc.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Rich,

On Wed, Oct 27, 2021 at 10:54 PM Rich Felker <dalias@libc.org> wrote:
> On Mon, Oct 04, 2021 at 05:19:11PM -0700, Randy Dunlap wrote:
> > Add the git tree location for linux-sh.
> >
> > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

> > --- linux-next-20211001.orig/MAINTAINERS
> > +++ linux-next-20211001/MAINTAINERS
> > @@ -18047,6 +18047,7 @@ M:    Yoshinori Sato <ysato@users.sourcefor
> >  M:   Rich Felker <dalias@libc.org>
> >  L:   linux-sh@vger.kernel.org
> >  S:   Maintained
> > +T:   git git://git.libc.org/linux-sh
> >  Q:   http://patchwork.kernel.org/project/linux-sh/list/
> >  F:   Documentation/sh/
> >  F:   arch/sh/
>
> I'm omitting this for now since (as noted on the cgit description)
> this server is not provisioned adequately for cloning from scratch,
> and should only be used for fetch into an already-populated mainline
> repo clone. If that's a problem I can see about getting it moved
> somewhere more appropriate.

Perhaps you can move it to kernel.org?

> The rest of this series should appear in next shortly.

Thanks a lot!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
