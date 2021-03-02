Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91500C433E0
	for <linux-sh@archiver.kernel.org>; Wed,  3 Mar 2021 03:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3286864E6B
	for <linux-sh@archiver.kernel.org>; Wed,  3 Mar 2021 03:35:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234211AbhCCDZT (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 2 Mar 2021 22:25:19 -0500
Received: from mail-vk1-f178.google.com ([209.85.221.178]:43172 "EHLO
        mail-vk1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448194AbhCBOSm (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 2 Mar 2021 09:18:42 -0500
Received: by mail-vk1-f178.google.com with SMTP id v66so4442424vkd.10
        for <linux-sh@vger.kernel.org>; Tue, 02 Mar 2021 06:17:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YfTtIyi6vKyh3cIWCLEwCZm9DnD3dQqJgBP7oiKcusg=;
        b=PbTzmphdMaMSGOTykyNF4ttJJKe9vH/kLd+NqJLb+OAK+Gzu/e2rX1NvDYw78OemIE
         mknDP7icJjb+wWH7GP1EetXg1fvJvhnwkJYAj/XsLbqKwYwNZ//+onbQ7zCuiRvUTnb/
         LwFJWIMkiWKU52sN0Eb+hhwL1+XZ5TeFZWlAaiIg2vq2/IIzfJK0StcIjLjSGOHj/ga1
         ONOQN1UE0TJKfhnd9yiggyWg+vSIK8ZM8p83HiyHaSvTuhPNeE4MzEyH9EfqKlcxwTyw
         /IRWdqwnOZVsAZz/LLFjOC3GxNBEsIkoRHUU6e4YM/qhgppVcIQlO8uLIP0qsSRY9OCu
         K2nw==
X-Gm-Message-State: AOAM533CTc6ct2adY51ncvHkD6g7lHo/LQ+2oH065j7pidKlDKXJMPOs
        DBFY52HBvE91g5q0FY4JQWkhyyyxdhnl3JXX1+w=
X-Google-Smtp-Source: ABdhPJxvo2Ml2NwFUj1MZTDBKjY09k4EnJnmqVSvR9DQfU6A6Z1ZjYIhqUrLpd6Fl0gpql1L0Ob1K/yL0hmxGRRzdWE=
X-Received: by 2002:a1f:2502:: with SMTP id l2mr2118931vkl.5.1614694637142;
 Tue, 02 Mar 2021 06:17:17 -0800 (PST)
MIME-Version: 1.0
References: <31ba6e66-71f3-381c-076b-c9d9b0c5d264@physik.fu-berlin.de>
 <20210223005608.GB6965@brightrain.aerifal.cx> <f9de2ff4-dc47-4f4f-397a-00c84ac1e81d@physik.fu-berlin.de>
 <20210302140308.GJ32655@brightrain.aerifal.cx>
In-Reply-To: <20210302140308.GJ32655@brightrain.aerifal.cx>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 2 Mar 2021 15:17:05 +0100
Message-ID: <CAMuHMdXEbD13AG9m1PJVyVpg3=QUDMHG_LQuEyYc2bwrLHU-xQ@mail.gmail.com>
Subject: Re: SH patches for 5.12
To:     Rich Felker <dalias@libc.org>
Cc:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Rob Landley <rob@landley.net>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Rich,

On Tue, Mar 2, 2021 at 3:03 PM Rich Felker <dalias@libc.org> wrote:
> On Tue, Mar 02, 2021 at 09:51:23AM +0100, John Paul Adrian Glaubitz wrote:
> > On 2/23/21 1:56 AM, Rich Felker wrote:
> > > Thanks! The last one seems to be upstream already and the rest LGTM.
> > > I've applied them and will do some smoke checks now and then prepare
> > > for -next.
> >
> > Any timeline for when the PR is sent to Linus?
>
> They're in next but I got a warning from the bot on one (7ec713058f21)
> and haven't checked it in detail yet. In case you have a quick idea:
>
> [linux-next:master 11837/12788] arch/sh/boot/compressed/../../lib/ashldi3.c:6:11: warning: no previous prototype for '__ashldi3'
>
> Maybe it's just a duplicate of a warning that was already there and
> that should be dealt with too.

I think that can be ignored safely: similar functions like __ashrdi3()
also lack forward declarations on SH.

Looks like only microblaze and powerpc do have forward declarations
for the gcc helpers:
arch/microblaze/lib/libgcc.h
arch/powerpc/include/asm/asm-prototypes.h

One day we may move them to asm-generic, and start using them
everywhere...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
