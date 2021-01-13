Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE2CC43381
	for <linux-sh@archiver.kernel.org>; Wed, 13 Jan 2021 08:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03A9F23381
	for <linux-sh@archiver.kernel.org>; Wed, 13 Jan 2021 08:22:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbhAMIWF (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 13 Jan 2021 03:22:05 -0500
Received: from mail-oi1-f169.google.com ([209.85.167.169]:43745 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726921AbhAMIWE (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 13 Jan 2021 03:22:04 -0500
Received: by mail-oi1-f169.google.com with SMTP id q25so1235430oij.10;
        Wed, 13 Jan 2021 00:21:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ALKzS1zqUziBFoEG3hQOmy1+PfVqRE4pA7mKb1ctmGA=;
        b=jCh9UO83am14njMk8Zi/y+BGwS1RQFIfWyTI0FnYjEqmDFNToDTZzUcpwzV8wvKLKO
         yNISws1ISwochAJI3gwAZ3oezIk857sR91PfBcul4i6Q4ryT/RdeI/p0gpZ0FdcqaY25
         RcYzFNIsl7M0QcoB3kn2kXVTz33JsI3Lk2g+1ygQfKshNZHJrImfLFrOAqPQJVdSjA2j
         QEt8DAQE6oDWjlvJpkWG13FDoYJ0U+VdeHklPI5gOe9bMBOhFjLCyQMcFxiyqib6n7h1
         ZGznO8dwg2KxODTaC369jbh7gtDsKDl7MQlMfsANNutWLoaKvrKH6DtlXiF3Q24vjFlF
         IQyg==
X-Gm-Message-State: AOAM533trsSnYHinjnIsBcWI5qijdcsG1z+vhLN3BJr7dWlXglpljxQl
        ckR6cR/OkZdxwzNiEjwJvMcbVRR8CV1TUK2l5GEeGBzn
X-Google-Smtp-Source: ABdhPJyRX+4namPERjEdlnCAH4leUHIBxj0SFewD7BSelMI7Pc+tgIaD4qWQrFB6gXrTphwmN2Qmf2TQe+Q+MZw7w4w=
X-Received: by 2002:aca:ec09:: with SMTP id k9mr516037oih.153.1610526083096;
 Wed, 13 Jan 2021 00:21:23 -0800 (PST)
MIME-Version: 1.0
References: <ef1dc21f-694b-2433-e1c6-aa121320173e@physik.fu-berlin.de>
 <f48bcf43-9dcc-e48b-d29d-f75f3814398b@gmx.net> <cb5a2e11-d423-96ec-3d43-3568a109e37f@physik.fu-berlin.de>
 <CACRpkda4E2NwNw29J7x5gehtqn_m3M_Z2dHpc7xRgvb0b-p22A@mail.gmail.com> <b8eb1c83-d2f8-1c72-ca67-4160b90b3845@landley.net>
In-Reply-To: <b8eb1c83-d2f8-1c72-ca67-4160b90b3845@landley.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 13 Jan 2021 09:21:10 +0100
Message-ID: <CAMuHMdUNe1A0RpkYdyRy9OJ+RDfUe_3KcAVnsCK+pP0jzJwtVA@mail.gmail.com>
Subject: Re: Old platforms: bring out your dead
To:     Rob Landley <rob@landley.net>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Gerhard Pircher <gerhard_pircher@gmx.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Sparc kernel list <sparclinux@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Rob,

On Wed, Jan 13, 2021 at 8:58 AM Rob Landley <rob@landley.net> wrote:
> On 1/12/21 4:46 PM, Linus Walleij wrote:
> > On Tue, Jan 12, 2021 at 3:45 PM John Paul Adrian Glaubitz
> > <glaubitz@physik.fu-berlin.de> wrote:
> >> Yeah, I have the same impression that's the strong commercial interest pushes
> >> hobbyist use of the Linux kernel a bit down. A lot of these changes feel like
> >> they're motivated by corporate decisions.
> >>
> >> There has to be a healthy balance between hobbyist and commercial use. I understand
> >> that from a commercial point of view, it doesn't make much sense to run Linux
> >> on a 30-year-old computer. But it's a hobbyist project for many people and hacking
> >> Linux stuff for these old machines has a very entertaining and educational factor.
> >
> > This is actually one of the most interesting things written in this discussion.
> >
> > I have both revamped and deleted subarchitectures in the ARM tree. We
> > never deleted anyone's pet project *unless* they were clearly unwilling to
> > work on it (such as simply testning new patches) and agreed that it will
> > not go on.
>
> Another fun aspect of old hardware is it serves as prior art for patents. The
> j-core hardware implementation schedule has in part been driven by specific
> patents expiring, as in "we can't do $FEATURE until $DATE".

Indeed, so that's why the release of j4 is postponed to 2016...
/me runs date (again).

> When I did an sh4 porting contract in 2018 I got that board updated to a
> current-ish kernel (3 versions back from then-current it hit some intermittent
> nor flash filesystem corruption that only occurred intermittently under
> sustained load; had to ship so I backed off one version and never tracked it
> down). But these days I'm not always on the same continent as my two actual sh4
> hardware boards, have never gotten my physical sh2 board to boot, and $DAYJOB is
> all j-core stuff not sh4.

Which is not upstream, investing in the future?

> Testing that a basic superh system still builds and boots under qemu and j-core
> I can commit to doing regularly. Testing specific hardware devices on boards I
> don't regularly use is a lot harder.

I have the sh7751-based landisk in my board farm, so it's receiving
regular boot testing.  That's one of the simpler SH-based platforms,
though.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
