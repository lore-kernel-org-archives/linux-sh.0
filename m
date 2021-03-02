Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E8C3C43331
	for <linux-sh@archiver.kernel.org>; Wed,  3 Mar 2021 03:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A93964E6F
	for <linux-sh@archiver.kernel.org>; Wed,  3 Mar 2021 03:36:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232985AbhCCD0v (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 2 Mar 2021 22:26:51 -0500
Received: from mail-pg1-f178.google.com ([209.85.215.178]:44879 "EHLO
        mail-pg1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384605AbhCBPWq (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 2 Mar 2021 10:22:46 -0500
Received: by mail-pg1-f178.google.com with SMTP id a4so13991149pgc.11
        for <linux-sh@vger.kernel.org>; Tue, 02 Mar 2021 07:20:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3+VYzwe5NnbuicHioq4B9uWsOtc3mDEwSdrnkR5Plx8=;
        b=eFe5H/tT0V1IlyTsRnSIQkN6WMLxcALcvjHpqOyTw/pYY7lyeU31VE7wKYOxkNVcGv
         9khLqpRNw4Nh4YVzGTTeyjnqGZYPzHUOjSglsdrrsOyzS6Bw1HDvBHklsuto0tiy/emg
         7Hw09zzQafec05yxnaBmfN5Rhe5CgOGay6U2S3iAoWmgr8gHCLaRwENuyG5sE9tsDaEK
         twHlM7BXc14TFOCFNfsININFU6yOa6r9lKnXyTU7iiuglYcGor2+tbxOxeK7tdzLKk4Q
         HdWlxxl3iklc5tb/JXMwWM3d1PFtYdqN/zSOy4XZdC+Jt2hT6eUxpPmsKlMf/tyvzPG+
         XYYw==
X-Gm-Message-State: AOAM531FTNKlf2+PFLfnH43CxFpqhSxQDgJ0+d5KZOk91PlgNsyo5euH
        LVsZZdLfkK28pj7aiTH+yFlAkKG9pKStvurXdX5DGi8q
X-Google-Smtp-Source: ABdhPJwKac2X4o9TjHuT2GHTbxoKALNdQ2rVyo+Ykp8cWPWPlg364YOPpZLDz1S35k3F+9W+2RnpDxbSMyL3NIFR3M0=
X-Received: by 2002:a1f:fe89:: with SMTP id l131mr2320854vki.1.1614696760772;
 Tue, 02 Mar 2021 06:52:40 -0800 (PST)
MIME-Version: 1.0
References: <31ba6e66-71f3-381c-076b-c9d9b0c5d264@physik.fu-berlin.de>
 <20210223005608.GB6965@brightrain.aerifal.cx> <f9de2ff4-dc47-4f4f-397a-00c84ac1e81d@physik.fu-berlin.de>
 <20210302140308.GJ32655@brightrain.aerifal.cx> <CAMuHMdXEbD13AG9m1PJVyVpg3=QUDMHG_LQuEyYc2bwrLHU-xQ@mail.gmail.com>
 <CAK8P3a1oCxj411vPQ9HiZpXBRQt3evP0o9RiFv6DPd9Ru2UHWQ@mail.gmail.com> <CAMuHMdU4t1Dek6me6crjFYqnNUUTwOwrXxwScPLc6mB35XxGbg@mail.gmail.com>
In-Reply-To: <CAMuHMdU4t1Dek6me6crjFYqnNUUTwOwrXxwScPLc6mB35XxGbg@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 2 Mar 2021 15:52:29 +0100
Message-ID: <CAMuHMdVb9q2Rwvr+e6w4Su=CZ7rnWY=DWfW6Yo2HYUEGBZDAMQ@mail.gmail.com>
Subject: Re: SH patches for 5.12
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Rob Landley <rob@landley.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Tue, Mar 2, 2021 at 3:33 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Tue, Mar 2, 2021 at 3:27 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > On Tue, Mar 2, 2021 at 3:17 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > On Tue, Mar 2, 2021 at 3:03 PM Rich Felker <dalias@libc.org> wrote:
> > > > On Tue, Mar 02, 2021 at 09:51:23AM +0100, John Paul Adrian Glaubitz wrote:
> > > > > On 2/23/21 1:56 AM, Rich Felker wrote:
> > > > > > Thanks! The last one seems to be upstream already and the rest LGTM.
> > > > > > I've applied them and will do some smoke checks now and then prepare
> > > > > > for -next.
> > > > >
> > > > > Any timeline for when the PR is sent to Linus?
> > > >
> > > > They're in next but I got a warning from the bot on one (7ec713058f21)
> > > > and haven't checked it in detail yet. In case you have a quick idea:
> > > >
> > > > [linux-next:master 11837/12788] arch/sh/boot/compressed/../../lib/ashldi3.c:6:11: warning: no previous prototype for '__ashldi3'
> > > >
> > > > Maybe it's just a duplicate of a warning that was already there and
> > > > that should be dealt with too.
> > >
> > > I think that can be ignored safely: similar functions like __ashrdi3()
> > > also lack forward declarations on SH.
> > >
> > > Looks like only microblaze and powerpc do have forward declarations
> > > for the gcc helpers:
> > > arch/microblaze/lib/libgcc.h
> > > arch/powerpc/include/asm/asm-prototypes.h
> > >
> > > One day we may move them to asm-generic, and start using them
> > > everywhere...
> >
> > I thought these were fundamentally architecture specific. Is it even
> > possible to declare them properly?
>
> AFAIK their asm implementation, and if the compiler generates calls
> to them, is architecture-specific.  The C versions are identical.
>
> In fact we do have shared C implementations in lib/.
> And at least __ashldi3() and __ashrdi3() are identical for SH and lib/,
> so the latter should be used.

SH might never have been converted as the files are also used for the
boot loader.  Seems to work, though, will send a patch shortly.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
