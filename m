Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0025C433DB
	for <linux-sh@archiver.kernel.org>; Wed, 13 Jan 2021 08:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92D372333B
	for <linux-sh@archiver.kernel.org>; Wed, 13 Jan 2021 08:17:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbhAMIQt (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 13 Jan 2021 03:16:49 -0500
Received: from mail-oo1-f46.google.com ([209.85.161.46]:46396 "EHLO
        mail-oo1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726830AbhAMIQt (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 13 Jan 2021 03:16:49 -0500
Received: by mail-oo1-f46.google.com with SMTP id n127so305069ooa.13;
        Wed, 13 Jan 2021 00:16:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gL8dlZU5CEc25kMMeeMh2Bo2TlA35T4It3X5Z9IzzG4=;
        b=qd3FR7Z0ZvrNweQFfOOkzJEIlUOBMub6LaXWr+TwnOjDkLLKttRodsw8yuNBLypHsn
         et6DK5gvquLT9ADwvcabml9FE3qJmL4J1vL7YdSLdGlVIDRbc+NyhseLvwyITCBvyjjQ
         NK3tYc/qgS1pj33CjcU0Ms0Nd+EQOdeGrOrWR3P2v89f73HkpI6Nj4d+LZkFVyD8JIGf
         przEwYEiHe54QG8u7DiEMvn9+4/z/1ZKo0thKpOO9J792/dF9Y+AhbuIXWsufmdCmrrT
         0OABb0lVew463NDvw+ZHQGgDvn17RdmSqKPEMfP/5+RqiO5zae9oaDYkoKLEYbZbMdzV
         6wPQ==
X-Gm-Message-State: AOAM530E6lDvBirmhTN8y2g4T+WpiHPrU4OXwqPtDWJTWqEATpCNY0Pk
        EDIoCb7IjwkLq9FjaOJH80Vh1xJ0BJLNty6CZWM=
X-Google-Smtp-Source: ABdhPJzsiFgzr7YIJkn2Ea9XwM8kh+zZp30nhTue66iCHJrovMKrzTiErpRCatYd9PU0PgIlAu7c1wxa8qzPJVJx+fY=
X-Received: by 2002:a4a:c191:: with SMTP id w17mr464489oop.1.1610525768621;
 Wed, 13 Jan 2021 00:16:08 -0800 (PST)
MIME-Version: 1.0
References: <ef1dc21f-694b-2433-e1c6-aa121320173e@physik.fu-berlin.de>
 <f48bcf43-9dcc-e48b-d29d-f75f3814398b@gmx.net> <cb5a2e11-d423-96ec-3d43-3568a109e37f@physik.fu-berlin.de>
 <CACRpkda4E2NwNw29J7x5gehtqn_m3M_Z2dHpc7xRgvb0b-p22A@mail.gmail.com>
In-Reply-To: <CACRpkda4E2NwNw29J7x5gehtqn_m3M_Z2dHpc7xRgvb0b-p22A@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 13 Jan 2021 09:15:56 +0100
Message-ID: <CAMuHMdU3s9hvenrRFibggT=hGDfauhh2hPcN7f3E0uG-iVG7iw@mail.gmail.com>
Subject: Re: Old platforms: bring out your dead
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
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

Hi Linus,

On Wed, Jan 13, 2021 at 4:20 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> On Tue, Jan 12, 2021 at 3:45 PM John Paul Adrian Glaubitz
> <glaubitz@physik.fu-berlin.de> wrote:
> That said there are a three things that people should really be doing if they
> want to keep their pet archs/subarchs around as good community
> members, and they are in essence to:

> 2. Migrate existing drivers to newly appeared and
>     appropriate subsystems (I think there are some hacky heartbeat LED
>     drivers down in arch/* for example) there is also the feature matrix
>     core maintainers like and which appears if you type
>     Documentation/features/list-arch.sh <archname>
>     would be nice if you work on them if you can support them!
>     Or at least take a look.

The choir is listening ;-)

For Amiga, that would require writing a real GPIO driver (modifying
gpio-mmio?) for the CIAs, and converting its users (amiflop, amijoy,
amimouse, parport_amiga, amiserial, and dmasound_paula) from direct CIA
register access to GPIO access (mctrl_gpio for amiserial)).
Note that the heartbeat LED is shared by heartbeat and audio.

An interim solution might be to just write a simple gpio driver for the
single CIA pin driving the heartbeat LED, allowing the user to set up
ledtrig-heartbeat.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
