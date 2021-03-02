Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 775EEC433E0
	for <linux-sh@archiver.kernel.org>; Wed,  3 Mar 2021 03:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 315C564E74
	for <linux-sh@archiver.kernel.org>; Wed,  3 Mar 2021 03:36:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352228AbhCCD3F (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 2 Mar 2021 22:29:05 -0500
Received: from mail-yb1-f169.google.com ([209.85.219.169]:46712 "EHLO
        mail-yb1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351448AbhCBPsk (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 2 Mar 2021 10:48:40 -0500
Received: by mail-yb1-f169.google.com with SMTP id h82so7361020ybc.13
        for <linux-sh@vger.kernel.org>; Tue, 02 Mar 2021 07:47:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HDdtGyn77Du57SsvPhYLRJ6/ttTCZkENrTmhSHW7aFc=;
        b=flwWdyTb7oep69y5W6kZIlDBNIaz358f7Bc9t4DqFmoQtG7qe52OfUxJWLZuyRo3ds
         AUOeRJ6WrQJ1N5e1p1zypavnZxkRoc4VLKwFt6Pb8js2UjKR8lk92XOSoaT1t0H0IDlW
         tHGqJXJPRujuM6lbcZ1OfkzM5ZDmE+WwWt2ls8d1xjZ4ueMuq29McZn5Txq011OdycBi
         g4wb9MBP0UZmI2C/G0j5/C7U7KMuAHx4THzu/cY7kFOy54sL7YXINUIAw1XMRp6YSKxm
         081d3F6XZfGCBvyKtUOFoJ+UIGbXsEH8UyHxQiQERZ9U7KfBAyFAf7zsd346l6AaDxAQ
         IK7A==
X-Gm-Message-State: AOAM533OkRcxzGyf+dVL/Nz0HS+DiQun7+00mtUbtPdDcfCvBkL1h010
        dd1btRH8pKhm8uF4VVoBLmPSldWSBFPSSBzBMT6wqMIzDjs=
X-Google-Smtp-Source: ABdhPJwhKR9cPSMniWRwIKs0oExcycLWXPwBYEZuPCZzqbS9pExQPej7qGthEl9MCCIvfpqnUIYj6zquAwqCGegA3SA=
X-Received: by 2002:a9f:35a1:: with SMTP id t30mr11762813uad.106.1614695650074;
 Tue, 02 Mar 2021 06:34:10 -0800 (PST)
MIME-Version: 1.0
References: <31ba6e66-71f3-381c-076b-c9d9b0c5d264@physik.fu-berlin.de>
 <20210223005608.GB6965@brightrain.aerifal.cx> <f9de2ff4-dc47-4f4f-397a-00c84ac1e81d@physik.fu-berlin.de>
 <20210302140308.GJ32655@brightrain.aerifal.cx> <CAMuHMdXEbD13AG9m1PJVyVpg3=QUDMHG_LQuEyYc2bwrLHU-xQ@mail.gmail.com>
 <CAK8P3a1oCxj411vPQ9HiZpXBRQt3evP0o9RiFv6DPd9Ru2UHWQ@mail.gmail.com>
In-Reply-To: <CAK8P3a1oCxj411vPQ9HiZpXBRQt3evP0o9RiFv6DPd9Ru2UHWQ@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 2 Mar 2021 15:33:58 +0100
Message-ID: <CAMuHMdU4t1Dek6me6crjFYqnNUUTwOwrXxwScPLc6mB35XxGbg@mail.gmail.com>
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

Hi Arnd,

On Tue, Mar 2, 2021 at 3:27 PM Arnd Bergmann <arnd@arndb.de> wrote:
> On Tue, Mar 2, 2021 at 3:17 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Tue, Mar 2, 2021 at 3:03 PM Rich Felker <dalias@libc.org> wrote:
> > > On Tue, Mar 02, 2021 at 09:51:23AM +0100, John Paul Adrian Glaubitz wrote:
> > > > On 2/23/21 1:56 AM, Rich Felker wrote:
> > > > > Thanks! The last one seems to be upstream already and the rest LGTM.
> > > > > I've applied them and will do some smoke checks now and then prepare
> > > > > for -next.
> > > >
> > > > Any timeline for when the PR is sent to Linus?
> > >
> > > They're in next but I got a warning from the bot on one (7ec713058f21)
> > > and haven't checked it in detail yet. In case you have a quick idea:
> > >
> > > [linux-next:master 11837/12788] arch/sh/boot/compressed/../../lib/ashldi3.c:6:11: warning: no previous prototype for '__ashldi3'
> > >
> > > Maybe it's just a duplicate of a warning that was already there and
> > > that should be dealt with too.
> >
> > I think that can be ignored safely: similar functions like __ashrdi3()
> > also lack forward declarations on SH.
> >
> > Looks like only microblaze and powerpc do have forward declarations
> > for the gcc helpers:
> > arch/microblaze/lib/libgcc.h
> > arch/powerpc/include/asm/asm-prototypes.h
> >
> > One day we may move them to asm-generic, and start using them
> > everywhere...
>
> I thought these were fundamentally architecture specific. Is it even
> possible to declare them properly?

AFAIK their asm implementation, and if the compiler generates calls
to them, is architecture-specific.  The C versions are identical.

In fact we do have shared C implementations in lib/.
And at least __ashldi3() and __ashrdi3() are identical for SH and lib/,
so the latter should be used.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
