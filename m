Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 172F5C43381
	for <linux-sh@archiver.kernel.org>; Wed,  3 Mar 2021 03:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDB3A64E6B
	for <linux-sh@archiver.kernel.org>; Wed,  3 Mar 2021 03:36:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352252AbhCCDaK (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 2 Mar 2021 22:30:10 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:60931 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449234AbhCBQQy (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 2 Mar 2021 11:16:54 -0500
Received: from mail-oi1-f180.google.com ([209.85.167.180]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1M2Plu-1lDEon1NBG-003t4f for <linux-sh@vger.kernel.org>; Tue, 02 Mar 2021
 15:38:27 +0100
Received: by mail-oi1-f180.google.com with SMTP id i21so19871898oii.2
        for <linux-sh@vger.kernel.org>; Tue, 02 Mar 2021 06:38:27 -0800 (PST)
X-Gm-Message-State: AOAM530ctLEpj9qcfJhE5w9kpemKS4pB0Im9Tb5Dev+hRC/j5cGv+Bos
        ox7ka9Vcoz4+8tt0ZtnzOz2CYqHt9tXc0BI50zI=
X-Google-Smtp-Source: ABdhPJzoPYrGk8bBnJqjD82kuoC5O68yK9AIcfX+sWUw5qJtguiDhjNwmJbQD86O91PPoYXBEKUo/wDCTOIaYRLUn6Y=
X-Received: by 2002:aca:c381:: with SMTP id t123mr3440327oif.4.1614695906100;
 Tue, 02 Mar 2021 06:38:26 -0800 (PST)
MIME-Version: 1.0
References: <31ba6e66-71f3-381c-076b-c9d9b0c5d264@physik.fu-berlin.de>
 <20210223005608.GB6965@brightrain.aerifal.cx> <f9de2ff4-dc47-4f4f-397a-00c84ac1e81d@physik.fu-berlin.de>
 <20210302140308.GJ32655@brightrain.aerifal.cx> <CAMuHMdXEbD13AG9m1PJVyVpg3=QUDMHG_LQuEyYc2bwrLHU-xQ@mail.gmail.com>
 <CAK8P3a1oCxj411vPQ9HiZpXBRQt3evP0o9RiFv6DPd9Ru2UHWQ@mail.gmail.com> <CAMuHMdU4t1Dek6me6crjFYqnNUUTwOwrXxwScPLc6mB35XxGbg@mail.gmail.com>
In-Reply-To: <CAMuHMdU4t1Dek6me6crjFYqnNUUTwOwrXxwScPLc6mB35XxGbg@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 2 Mar 2021 15:38:09 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0hGKkD9YSjT9UOZdWAUrOB8wM9uMMdEzrW3-1nD7r29g@mail.gmail.com>
Message-ID: <CAK8P3a0hGKkD9YSjT9UOZdWAUrOB8wM9uMMdEzrW3-1nD7r29g@mail.gmail.com>
Subject: Re: SH patches for 5.12
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Rob Landley <rob@landley.net>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:fa9qdAMRj+uMQbksmiACDvNB5jMjvMqZkjmcgTOQKaQHqC1ibua
 9OxSNI31xf3lSy62QhRKfa1T1n3t87uHdWlnHfCDrx5XU8u0Dx6etw+5urCqDWinnLHrEVU
 UeUBsrAVIN/rzLU/WqagluXpVTZ2Hh7VeX9KmE5efyYu+eaKzVPum77Rxxkg9Nl34o6BUIP
 E6alpqBS4hn3KdhxZY6vA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5gVTZLXmtI0=:6jCPPjej+UAL3m2tD7kRHd
 fFV7R2Ip4n5fD12PnIz6krKxMc6NI28Zur5BM34esN3bHo0g3blcSWFbKy2gOCeM1cDMwRm06
 KY2iZvhNKM7TuvM9/u7gEUkoLAeRbuCTeEml2v9E68+/rYk8DSqqsfJtpVn0Ry3X/haAj4n5J
 YfSnHcTYVusgtCY/8exeXxIvKtSn/cRgPic1SwH1Mzvhhe5ZR30XIEKpMRbeTjtFavTrnFDjr
 Lm8d//3AUapVJHMWdvnargM4U5QzV8gFypfqcsdhi9drMn4mm113Z0EaTooo/r50ynJw33Ooz
 ylp1/kiFue0lfn/z9zk0H3gheJJTFIq9FeASFDI2T+FxeCRedlVgr1Hb1fMmx30kLs2beq2jj
 et3YXQmD0UKNJND9Y+1QpN/OX9r1p4hS3NyqyFw/T9oJPXZrF9tvoYCeWr/E+hNjSjRQzHVmW
 5MspZYToBPk9T4aVumtZtr2cPHil7d9FjaZCNiug1HnM8J/lT9GhDXLxm4S3f5RycPREstAeR
 7fJrd4Yk/oYX5dFtvwqhOTxzBOeJeVgRK3r0T2fZWrcgyzqeYEXAY7W0uA+PIWc2Q==
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

Ah, makes sense. Anything that has an implementation in lib/ is
probably generic anyway. I got a little confused because on ARM
there are separate names for these based on the ABI (oabi/eabi),
with the default version using non-generic names.

        Arnd
