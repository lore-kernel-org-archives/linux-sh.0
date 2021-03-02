Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 748BAC433E9
	for <linux-sh@archiver.kernel.org>; Wed,  3 Mar 2021 03:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A8DB64E6F
	for <linux-sh@archiver.kernel.org>; Wed,  3 Mar 2021 03:35:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234990AbhCCD0B (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 2 Mar 2021 22:26:01 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:40069 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384484AbhCBPFU (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 2 Mar 2021 10:05:20 -0500
Received: from mail-ot1-f44.google.com ([209.85.210.44]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MV6Bs-1lODGF0mdq-00S3Tq for <linux-sh@vger.kernel.org>; Tue, 02 Mar 2021
 15:27:33 +0100
Received: by mail-ot1-f44.google.com with SMTP id w3so368147oti.8
        for <linux-sh@vger.kernel.org>; Tue, 02 Mar 2021 06:27:32 -0800 (PST)
X-Gm-Message-State: AOAM5335N5iQ3RNRlnO32XawYx7/WiSE03gQdhCVcOAR2Qs/tm6B9f8J
        ZLAErtM6holI8NrNzVGNhSZvQ+hh5FktZUF3TKs=
X-Google-Smtp-Source: ABdhPJyejjDPCDQtcMN9RqrSezjuZL2iR4FDcSK6/fB0iECjJgNdP4eO5op5lQ79rFPTVsoKRy3US3m0s26pVZ/KJjY=
X-Received: by 2002:a9d:7f11:: with SMTP id j17mr18751458otq.251.1614695251910;
 Tue, 02 Mar 2021 06:27:31 -0800 (PST)
MIME-Version: 1.0
References: <31ba6e66-71f3-381c-076b-c9d9b0c5d264@physik.fu-berlin.de>
 <20210223005608.GB6965@brightrain.aerifal.cx> <f9de2ff4-dc47-4f4f-397a-00c84ac1e81d@physik.fu-berlin.de>
 <20210302140308.GJ32655@brightrain.aerifal.cx> <CAMuHMdXEbD13AG9m1PJVyVpg3=QUDMHG_LQuEyYc2bwrLHU-xQ@mail.gmail.com>
In-Reply-To: <CAMuHMdXEbD13AG9m1PJVyVpg3=QUDMHG_LQuEyYc2bwrLHU-xQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 2 Mar 2021 15:27:15 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1oCxj411vPQ9HiZpXBRQt3evP0o9RiFv6DPd9Ru2UHWQ@mail.gmail.com>
Message-ID: <CAK8P3a1oCxj411vPQ9HiZpXBRQt3evP0o9RiFv6DPd9Ru2UHWQ@mail.gmail.com>
Subject: Re: SH patches for 5.12
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Rob Landley <rob@landley.net>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:fXNovOwwmLWZ/icNvLs5P5a/6rcrVy3YpvxaIf6X0Czy/Ugq/n+
 RjgYZcaw1/Sd3NJnKpHINpZUN9NuXDeJfE4W2xiyrOHeqLDuOFjTq7bXCafkd3581BKFQcS
 EfzeYzj4W0dfquhJ7Jknu756BUsov+TxEhK5wptfaCyC4sr7C9SzrJguOcNvjMhNzQpFcrp
 QOD3v9lq27XWL5+G/GbVw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:M9Gn+V3KyB8=:R0b+xwUowKQXrGG4yDsoC/
 2hQiFfKp9GPsQoVpo/jB5GA8XU2v04Oz+uhN01lJJrWqSQXryjD+GLwYkIjQxhcSEjutXFsSz
 Rn/0w0tOCQRRDnBFY4Sak2XeRxvrNf1EFE1K4tnI2y3bKm9e6xy+ate2LeM0SJwrJU5eC4Ni1
 4wACEn0b/ju44YNQU2SQ0wtxSHtSyCbXbBo5eWX9CxEu3oTsbMWQBZl3i5vgfy8a4JzsWrcVj
 0e+Uc73qbN6Mqu3GoV9tos3QArxSK5AWMk6tYxpM+LHFuoB+O425d//AtIX8WhDjFIDhRBa7o
 07M6u4FzK3zW7wM2Izt2az3F89u85QPECn7rxtK8Cidmc6klKP0OD2iEQGkFxQI90T2Ymw4gD
 mOQDxVn0esABUttRtyy/CbYr1nQRiq16OQcI8YuFBkZ9dxzw7ztC3/rpffhDw
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Tue, Mar 2, 2021 at 3:17 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Tue, Mar 2, 2021 at 3:03 PM Rich Felker <dalias@libc.org> wrote:
> > On Tue, Mar 02, 2021 at 09:51:23AM +0100, John Paul Adrian Glaubitz wrote:
> > > On 2/23/21 1:56 AM, Rich Felker wrote:
> > > > Thanks! The last one seems to be upstream already and the rest LGTM.
> > > > I've applied them and will do some smoke checks now and then prepare
> > > > for -next.
> > >
> > > Any timeline for when the PR is sent to Linus?
> >
> > They're in next but I got a warning from the bot on one (7ec713058f21)
> > and haven't checked it in detail yet. In case you have a quick idea:
> >
> > [linux-next:master 11837/12788] arch/sh/boot/compressed/../../lib/ashldi3.c:6:11: warning: no previous prototype for '__ashldi3'
> >
> > Maybe it's just a duplicate of a warning that was already there and
> > that should be dealt with too.
>
> I think that can be ignored safely: similar functions like __ashrdi3()
> also lack forward declarations on SH.
>
> Looks like only microblaze and powerpc do have forward declarations
> for the gcc helpers:
> arch/microblaze/lib/libgcc.h
> arch/powerpc/include/asm/asm-prototypes.h
>
> One day we may move them to asm-generic, and start using them
> everywhere...

I thought these were fundamentally architecture specific. Is it even
possible to declare them properly?

Note that the '-Wmissing-prototype' warning is currently not enabled
by default, only if you use 'make W=1', or alternatively the corresponding
sparse warning with 'make C=1'. There is however ongoing work from
Lee Jones and others to address all W=1 warnings and then enable
these by default.

       Arnd
