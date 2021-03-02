Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BAE9C43603
	for <linux-sh@archiver.kernel.org>; Wed,  3 Mar 2021 03:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F5BE64E6B
	for <linux-sh@archiver.kernel.org>; Wed,  3 Mar 2021 03:36:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343649AbhCCD2Q (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 2 Mar 2021 22:28:16 -0500
Received: from mail-vs1-f53.google.com ([209.85.217.53]:40356 "EHLO
        mail-vs1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1578251AbhCBPfQ (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 2 Mar 2021 10:35:16 -0500
Received: by mail-vs1-f53.google.com with SMTP id a15so2832551vsi.7
        for <linux-sh@vger.kernel.org>; Tue, 02 Mar 2021 07:34:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oUTbPlGVETPfzp/PNzesd6cn5QHgOyHXk+8RNLSuaHE=;
        b=sI4xcu5QEJV0ijztD6ojz3iQwmhu9CXU+fNTk2Qrp80aOQ4jwZABeNFj4bJuZnqbNe
         NmW1xGFbJLqwDzKv8Msk70JO1ClsiTr3vXyVS9EIjUjATK5zl/JIv2H2u6vlGbB5zy7a
         /Isl5UWvz2Tm7eqapwbQeZy9mw2w0pkdNl5Dso94lc9t3seknRCPOkmCAgHZGdZ4Cfb/
         hkbYLp5m/wC8OTQIsWQ9KAf7NQ9CDPoHeUZLUrcbXlEYfd8nzoLHwXVjqH4Nj6nCB46y
         DqzbXDJRlJK9st8VWkSTs3dSIEjWX9k7corbwpxXV1sOkLFOpifP96h1JNQM2CzQHGGs
         L2qQ==
X-Gm-Message-State: AOAM531OhTvFw4v8ZXAxjQcPqgk+gXyO7eEePgHESkH8f2A9dRSRmnKh
        aIe5piMG1t1bM3GR3cFHU5vbBj01DcipU0zXcQ4tbUmt
X-Google-Smtp-Source: ABdhPJxwNg8QkLf1aQ8tDUcYYADnedYPtSueHuLk23l5XbOtvOf8bcg+I9vuIRvkN5PvqqiuIja5pX+4o400TvdZSNE=
X-Received: by 2002:a05:6102:2403:: with SMTP id j3mr2300797vsi.40.1614697401491;
 Tue, 02 Mar 2021 07:03:21 -0800 (PST)
MIME-Version: 1.0
References: <31ba6e66-71f3-381c-076b-c9d9b0c5d264@physik.fu-berlin.de>
 <20210223005608.GB6965@brightrain.aerifal.cx> <f9de2ff4-dc47-4f4f-397a-00c84ac1e81d@physik.fu-berlin.de>
 <20210302140308.GJ32655@brightrain.aerifal.cx> <CAMuHMdXEbD13AG9m1PJVyVpg3=QUDMHG_LQuEyYc2bwrLHU-xQ@mail.gmail.com>
 <CAK8P3a1oCxj411vPQ9HiZpXBRQt3evP0o9RiFv6DPd9Ru2UHWQ@mail.gmail.com>
 <CAMuHMdU4t1Dek6me6crjFYqnNUUTwOwrXxwScPLc6mB35XxGbg@mail.gmail.com> <20210302144803.GK32655@brightrain.aerifal.cx>
In-Reply-To: <20210302144803.GK32655@brightrain.aerifal.cx>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 2 Mar 2021 16:03:10 +0100
Message-ID: <CAMuHMdVyLJGVLH2Y7gmaKaQtzB8d8i_3SRMiFXki-2cSjzOwhg@mail.gmail.com>
Subject: Re: SH patches for 5.12
To:     Rich Felker <dalias@libc.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Rob Landley <rob@landley.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Rich,

On Tue, Mar 2, 2021 at 3:48 PM Rich Felker <dalias@libc.org> wrote:
> On Tue, Mar 02, 2021 at 03:33:58PM +0100, Geert Uytterhoeven wrote:
> > On Tue, Mar 2, 2021 at 3:27 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Tue, Mar 2, 2021 at 3:17 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > On Tue, Mar 2, 2021 at 3:03 PM Rich Felker <dalias@libc.org> wrote:
> > > > > On Tue, Mar 02, 2021 at 09:51:23AM +0100, John Paul Adrian Glaubitz wrote:
> > > > > > On 2/23/21 1:56 AM, Rich Felker wrote:
> > > > > > > Thanks! The last one seems to be upstream already and the rest LGTM.
> > > > > > > I've applied them and will do some smoke checks now and then prepare
> > > > > > > for -next.
> > > > > >
> > > > > > Any timeline for when the PR is sent to Linus?
> > > > >
> > > > > They're in next but I got a warning from the bot on one (7ec713058f21)
> > > > > and haven't checked it in detail yet. In case you have a quick idea:
> > > > >
> > > > > [linux-next:master 11837/12788] arch/sh/boot/compressed/../../lib/ashldi3.c:6:11: warning: no previous prototype for '__ashldi3'
> > > > >
> > > > > Maybe it's just a duplicate of a warning that was already there and
> > > > > that should be dealt with too.
> > > >
> > > > I think that can be ignored safely: similar functions like __ashrdi3()
> > > > also lack forward declarations on SH.
> > > >
> > > > Looks like only microblaze and powerpc do have forward declarations
> > > > for the gcc helpers:
> > > > arch/microblaze/lib/libgcc.h
> > > > arch/powerpc/include/asm/asm-prototypes.h
> > > >
> > > > One day we may move them to asm-generic, and start using them
> > > > everywhere...
> > >
> > > I thought these were fundamentally architecture specific. Is it even
> > > possible to declare them properly?
> >
> > AFAIK their asm implementation, and if the compiler generates calls
> > to them, is architecture-specific.  The C versions are identical.
> >
> > In fact we do have shared C implementations in lib/.
> > And at least __ashldi3() and __ashrdi3() are identical for SH and lib/,
> > so the latter should be used.
>
> I haven't looked at the code, but are you sure this is okay? C
> implementations of variable bitshift seem subject to the compiler
> auto-replacing them with <<n and >>n, which would then create a
> recursive definition on archs (pre-sh3 only) that don't have a barrel
> shift instruction and need the library calls.

The SH version is a C implementation, too.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
