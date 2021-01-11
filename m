Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CAEBC4332D
	for <linux-sh@archiver.kernel.org>; Mon, 11 Jan 2021 14:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61DE2225AB
	for <linux-sh@archiver.kernel.org>; Mon, 11 Jan 2021 14:57:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388994AbhAKO4u (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 11 Jan 2021 09:56:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388991AbhAKO4u (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Mon, 11 Jan 2021 09:56:50 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40176C061381;
        Mon, 11 Jan 2021 06:55:26 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id lt17so28227ejb.3;
        Mon, 11 Jan 2021 06:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fkb+6kHcBYmIX1rA4Q3FeNq39va9LRsa50OKmyScf2g=;
        b=StzTmugQK+QsKVdCg08VrJTu0InftAnNTeBn1dPFsxCkTHuZnBMqpjVl1j2zpHwIKA
         kh07HCvlA24asTJhfCOBi+zXMkN/j//P+jqlAF3G9XlwOOklB8kfWHqPXmB4NcCW3qvp
         8c+EXmRLkhgt20qosv11KJAZ6tQjoomPnpJmUqQrGTWhpqzQuLJJLtPkwPqGsbykFZEN
         56LWdCUy5mExsK2nG0/GGikEooSR70bJpFhBlwl+4hXNBcn+Xl732u9omU7GYbMNZ+od
         lHAlEnbtMiZOkj06Reg/2m1GX4cGuXUBTKman8nyXquRKYyUEQbZKzMQWERthfTjkqzM
         jGzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fkb+6kHcBYmIX1rA4Q3FeNq39va9LRsa50OKmyScf2g=;
        b=PUdMEwHNpXy7xKZ1sBUqc9y6twkdtrEUNXMj3UkBhXGA0TSbLlUvfvGFpREmC9it0q
         KtTrm8wP9RNDcMOudyTpi8KPUU1/d3FsLf+IcXMB0tMK6kfTN0lR/Dwuta4sT3daw7jo
         zfbxriUpsXtWmLox/3dL2cjCyI0cBShWhAn7VnZKoLN0HgHJfkV5I/IUDglSAnzFX4qM
         vcMB/R+jcI8vSPgnpqXXwH6xgrcCJtqxQTwLO3ayeYlXacgjRoYXdhQziWo9oqFP7Ezt
         zHWEE3oNxJvAs3kM34fXHQIpupN8jm/3S/DItyPvnDzclPMtPwyMA5ctvEtTHapSmf3Q
         trrg==
X-Gm-Message-State: AOAM5338mnAMwH14zE/KZ86UZXZvBSagdGgRiv5u0SkTCIQvqrl9co0e
        EdPuevbZV7T9GJafQ7n0VDuc+mW12IpJLOojLYM=
X-Google-Smtp-Source: ABdhPJw918GbC6QuBafyHDaYJK5elbD1hwsTi1Ed+fYRWxX2QIhf0EjPIimbPBiw3xpG7FeRFh2zgSqqXVAx08t21DY=
X-Received: by 2002:a17:906:7c49:: with SMTP id g9mr11454375ejp.185.1610376924969;
 Mon, 11 Jan 2021 06:55:24 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a2VW8T+yYUG1pn1yR-5eU4jJXe1+M_ot6DAvfr2KyXCzQ@mail.gmail.com>
 <ef1dc21f-694b-2433-e1c6-aa121320173e@physik.fu-berlin.de>
 <20210110214653.GA1693373@ravnborg.org> <df42946e-5b1f-c433-fc6b-a2950f3d8dab@physik.fu-berlin.de>
In-Reply-To: <df42946e-5b1f-c433-fc6b-a2950f3d8dab@physik.fu-berlin.de>
From:   chase rayfield <cusbrar1@gmail.com>
Date:   Mon, 11 Jan 2021 09:55:13 -0500
Message-ID: <CACwypyNS+fVoPVspSr36v8YjFbkrnYb+amcYRqVmA2kD2uD1Wg@mail.gmail.com>
Subject: Re: Old platforms: bring out your dead
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Sam Ravnborg <sam@ravnborg.org>, Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Sparc kernel list <sparclinux@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Mon, Jan 11, 2021 at 3:09 AM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:

>
> I'm not sure I understand the reasoning for doing this. The SPARC architecture
> isn't going to see any new hardware developments in the future after Oracle
> let go of most of the SPARC developers. So it's not that we need to make room
> for new hardware.
>
My take is that there *would* be more interest in Sparc sun4m / Sun4d
from enthusiasts at the very least if it was possible to actually boot
the bloat hog that is Linux these days in a fully usable configuration
that probably means some modifications to SILO and Linux required.

The problem is as I understand it, SILO only sets up a 16Mb mapping
(either due to having to assume 4MB minimum dram stick size or due to
mapping limitations not sure, most of these machines have at least
16MB in slot one...these days though that wasn't the case for sun4c),
loads Linux into it and says good Luck. This isn't enough for a modern
kernel with any  hardware support built in. So you might for instance
get a kernel to fit but only if you dropped all of networking support
etc... I'm guessing the fix for this would be to modify silo to map a
larger amount in a way that Linux expects so it can remap it as it
likes, or just have SILO map the full memory as Linux would. Anyway
that is THE main demotivation for these architectures.... otherwise
they have plenty of ram and performance to do basic router/server
tasks sans SSL.

This has been the status quo for since the last of the 2.6 series of
kernels which it was still possible to just barely squeeze a usable
kernel out of... If someone wanted to take a few hours and fix this
issue, and keep these architectures around I'd be happy to "buy them a
round of pizza", though I recognize that many people that work on this
already have nice jobs, and just don't have time.

Also Sparc would probably be a good project for someone to extend/test
Andi Keen's Linux LTO patch set so we could reduce the kernel binary
size that way also even if sun4 architectures are dropped, it would
still be useful for embedded sparc. Also there is a port of Temlib to
the Mister hardware now, 3 cores roughly equivalent to a mid 90s
machine, at least 128MB ram is possible ( more if a way to map the ARM
system memory also 1GB is available there, it would have higher
latency though).

It is perfectly viable to build Sparc v7 or v8 32bit binaries in a
chroot on a fast machine also, and I would recommend this if you wish
to retain sanity rather than attempting cross compiler voodoo, unless
that is your thing.

Anyways it could be that people that want this get around to fixing
SILO eventually and just sit on this last kernel version... *shrugs*

Chase
