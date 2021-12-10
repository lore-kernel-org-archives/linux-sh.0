Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E166C433EF
	for <linux-sh@archiver.kernel.org>; Fri, 10 Dec 2021 20:39:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242933AbhLJUmq (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Fri, 10 Dec 2021 15:42:46 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:39064
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238944AbhLJUmp (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Fri, 10 Dec 2021 15:42:45 -0500
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 9734B40319
        for <linux-sh@vger.kernel.org>; Fri, 10 Dec 2021 20:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1639168749;
        bh=5yoGUr7pzPnZBDOdChvpH3bNEBPR4tkHUNd2RR7JJH4=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=ntew18tapMkwviBqOAHUgN7wKEru2Qs3ehxrwg6SCEaB4k+eTgdgQ85onGty/6UD9
         DAOXJVn1zWSw489ET1LfbzrwxU3OXmmZ7i49EgfsQQZyv7i51Bax8TNLjZohc55Tvw
         7KXmdH2UlO+t4jF3rauIi9itN3mgwLffrWNzKSf1zfxYh1ekCAMOrZTcjy0G8q3txT
         56dJeJZoap0IkngrM7xWIeUVGtQyM+UnFREyn7xtY6ElLZE6OA5G8UAY9yAcBZ+8GA
         BXx8k/AS1AImSeY4GRq4T/e8b9BvynsSjxstZtKehFy7alk0AoPFzkU9YwgYbDT7Rf
         DIspDNlQ1DK7g==
Received: by mail-ed1-f69.google.com with SMTP id m12-20020a056402430c00b003e9f10bbb7dso9155477edc.18
        for <linux-sh@vger.kernel.org>; Fri, 10 Dec 2021 12:39:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5yoGUr7pzPnZBDOdChvpH3bNEBPR4tkHUNd2RR7JJH4=;
        b=iKEzpMDilCWq69Byznf1eY+9jUzGrUwo/4erJgDM1RTYVbKFcifT0ic2zU+9sQhS2u
         FEdZ87Jzr1rnDqC2Xdh+tK2eNAloi6b7f7Q6SCZH8li2hfLDQPYF1NTTUkav9xmtzlwo
         XD2HUMHg3+txu37EVhSZ1zGo9mBJkbgUntjx66/tvZXTXYegRgxopT4/Oo+W1/ES7qv8
         StP4Q4jWxzK/6VPP5wTmeDtvLU/yoyE4UtAiruWuAKO+Gc6BoTl7M6mgpUlVMG7q5i8b
         zZij3tQBfkVliMCgqNA30NcwDOrd/BrfsO2mT2LJj9VnlJ6an2L3+5SoceVyvIMmJfAw
         KsuA==
X-Gm-Message-State: AOAM5305+cbnK3swF1zK0t81sskYlUznTGm55Ga9RiRQm2Rum3x/j+pD
        Bk6Qbr69rBGVPVZLyg7NgOg2U1rwheqFgjpvUDlN6P9tQ8v4vrpuFdyOcwwQsbGib+/KOL9Q1Z9
        BoYBvgUAfFGsLhouOZIVEQ2vUGBL5KOGjIGPGIgxcwN9gxnVVeNCq
X-Received: by 2002:a05:6402:274c:: with SMTP id z12mr43261393edd.294.1639168738739;
        Fri, 10 Dec 2021 12:38:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxgA236x/yjx6TWkXOleXezvnEgrIAVa1yzBQb8Ze+JaO9/0KXgBOBtxlFprZiSdLFnjBlcdw/PZl80G6UL+y4=
X-Received: by 2002:a05:6402:274c:: with SMTP id z12mr43261361edd.294.1639168738589;
 Fri, 10 Dec 2021 12:38:58 -0800 (PST)
MIME-Version: 1.0
References: <20211105154334.1841927-1-alexandre.ghiti@canonical.com> <CAK8P3a2AnLJgGNBFvjUQqXd-Az9vjgE7yJQXGDwCav5E0btSsg@mail.gmail.com>
In-Reply-To: <CAK8P3a2AnLJgGNBFvjUQqXd-Az9vjgE7yJQXGDwCav5E0btSsg@mail.gmail.com>
From:   Alexandre Ghiti <alexandre.ghiti@canonical.com>
Date:   Fri, 10 Dec 2021 21:38:47 +0100
Message-ID: <CA+zEjCtajRJhs8zSdR_oFBOO3P5FWWZJ3L6N-GK+JnUjdymTiA@mail.gmail.com>
Subject: Re: [PATCH 0/7] Cleanup after removal of configs
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Steve French <sfrench@samba.org>, Jonathan Corbet <corbet@lwn.net>,
        David Howells <dhowells@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lee Jones <lee.jones@linaro.org>,
        Jeff Layton <jlayton@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-cachefs@redhat.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        linux-power@fi.rohmeurope.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Fri, Nov 5, 2021 at 4:56 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Fri, Nov 5, 2021 at 4:43 PM Alexandre Ghiti
> <alexandre.ghiti@canonical.com> wrote:
> >
> > While bumping from 5.13 to 5.15, I found that a few deleted configs had
> > left some pieces here and there: this patchset cleans that.
> >
> > Alexandre Ghiti (7):
> >   Documentation, arch: Remove leftovers from fscache/cachefiles
> >     histograms
> >   Documentation, arch: Remove leftovers from raw device
> >   Documentation, arch: Remove leftovers from CIFS_WEAK_PW_HASH
> >   arch: Remove leftovers from mandatory file locking
> >   Documentation, arch, fs: Remove leftovers from fscache object list
> >   include: mfd: Remove leftovers from bd70528 watchdog
> >   arch: Remove leftovers from prism54 wireless driver
>
> Looks all good to me, thanks a lot for the cleanup!
>
> For arch/arm/configs:
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
>
> assuming this goes through someone else's tree. Let me know if you need me
> to pick up the patches in the asm-generic tree for cross-architecture work.

Arnd, do you mind taking the whole series except patch 6 ("include:
mfd: Remove leftovers from bd70528 watchdog") as this will be handled
separately. I can ask Jonathan for the doc patches if needed.

Thanks,

Alex

>
>          Arnd
