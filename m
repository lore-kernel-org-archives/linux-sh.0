Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8195EC433F5
	for <linux-sh@archiver.kernel.org>; Tue, 11 Jan 2022 19:05:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346050AbiAKTF6 (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 11 Jan 2022 14:05:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243166AbiAKTF5 (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 11 Jan 2022 14:05:57 -0500
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64553C06173F
        for <linux-sh@vger.kernel.org>; Tue, 11 Jan 2022 11:05:57 -0800 (PST)
Received: by mail-oo1-xc29.google.com with SMTP id b20-20020a4a3414000000b002dda566aba7so392504ooa.13
        for <linux-sh@vger.kernel.org>; Tue, 11 Jan 2022 11:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=swiecki.net; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BtGElQiY4GeoWelhIV8PCh2w/M+OvxqsSwQZX/tTEIE=;
        b=XkKQkDmEh03TUqN07A4DEYI6lfVzwMe2nyAkHjSvclelLGCSlWQ/ff+bVPbWvOjJyN
         WPl3po2Y6QRaFfHukjV6IDPEdg3io/ks2V3VqOXvpYdSDzpXmnxkHRDUxBLzX42sm6Xu
         5d3MhYo0muPWTA+L6CIsYU4KoExfT6gGdy+yc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BtGElQiY4GeoWelhIV8PCh2w/M+OvxqsSwQZX/tTEIE=;
        b=t4lSDGbddiVNsBRZlhBL0bqaZCv0gJkvIOwdhBG3rBg0IOLU+F7YFinCfSX0Qn5of9
         pgYe0Ovwavatgj+le8ti1aXhvxDGyXN+3vNuZd0YMA0W3ULem4uFA1vbWL4V4LZpMglF
         JPBD+GR/b4tdQSwMLOmj0BtYU8jjV1+5zx+BlDhja9Tsej9Z5A3YLB/anaHnrBmJ3Uja
         +lhxJfJca+v04Bx8JwP2q27/V7IviainoBSeQdPq4Ap0nz8L7SrCBFZPtNpoyqW1TRFf
         TuAaeg7sonQgHsNlP/XYwGX1eBOYo6SwTCMrjrV4qEfJAQcxnLyxwL2afj8ucxR9nxnN
         N8EQ==
X-Gm-Message-State: AOAM532HXKxGQI6sFQ7ctXDKBYV1ST3SjjbON3K01vTWXYwUU0HZA8XU
        4zLoY4k4wf5AFdOOfX9FL/oXbaB3tQ59FoCjskMi8YGPE/+d+Q==
X-Google-Smtp-Source: ABdhPJwPbglqLSuIqQl+1e4zYtnl0ZnfFC0agqlgll3d+pz4uQUN1w6t0tjyCyOH4Aji3wYfiL+T0JC6H+Iu68kTrVs=
X-Received: by 2002:a4a:d344:: with SMTP id d4mr36958oos.18.1641927955491;
 Tue, 11 Jan 2022 11:05:55 -0800 (PST)
MIME-Version: 1.0
References: <CAP145pjk471P9pUzhf-rpZiQvjd499i-VpL8iRECDWkSKM_cyA@mail.gmail.com>
 <CAP145pjjyXs40Disg3QhFkkEp8CFXeBCHjn_8Hu=s1cxEjCUQg@mail.gmail.com>
 <c947a46b-7c5e-6ca3-fabe-ce648d9c182c@physik.fu-berlin.de>
 <CAP145pjQJkgHx0AhGvDp9Rg0x0KfN1utxMaehrqp8sWNSR4x0g@mail.gmail.com>
 <985011f6-c0b8-947f-7ebf-6d27c59ba219@physik.fu-berlin.de>
 <CAP145piu0gURojU7TvU7XeDybVczQZDVYqT8th_1f4EcknDF1Q@mail.gmail.com>
 <fa9bdc51-42ee-5eb9-75a3-f46706bcf1a9@physik.fu-berlin.de>
 <CAP145piHFa=MLfXACWZcU3-1BP3o+Wf_AwawDV55kbFGxQm3Xg@mail.gmail.com>
 <8a33f049-90b2-3bc2-4594-229a1a9d9dff@physik.fu-berlin.de>
 <dfcad748-fe68-c4a4-d5ec-a04f17923c21@physik.fu-berlin.de>
 <CAP145pjWrPSqX0g9oJoqU57+S4OziHQt8=ZDrQVq8pD5CzAyiw@mail.gmail.com>
 <24eae22e-2b28-c1e4-468a-f7d0ada564a8@physik.fu-berlin.de> <CAP145pjFkwvMfwhrTRJpBL=uJLGHcZTegrb4rRwGtrR2Q=AK-Q@mail.gmail.com>
In-Reply-To: <CAP145pjFkwvMfwhrTRJpBL=uJLGHcZTegrb4rRwGtrR2Q=AK-Q@mail.gmail.com>
From:   =?UTF-8?B?Um9iZXJ0IMWad2nEmWNraQ==?= <robert@swiecki.net>
Date:   Tue, 11 Jan 2022 20:05:44 +0100
Message-ID: <CAP145phP-Rmqo3cthcXsYB7O2gC8EfpXMneH+wjv7P4qVtOqNQ@mail.gmail.com>
Subject: Re: Fwd: Debian on Linux-SH4
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     linux-sh@vger.kernel.org, debian-superh@lists.debian.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

> > > [    0.000000] Linux version 5.15.0 (jagger@jd) (sh4-linux-gnu-gcc
> > > (Debian 6.3.0-18) 6.3.0 20170516, GNU ld (GNU Binutils for Debian)
> > > 2.37.50.20220106) #46 Tue Jan 11 16:19:36 CET 2022
> > >
> > > I'm attaching my working config. I'll see whether I can bisect it or
> > > spot anything obvious.
> >
> > That would be awesome, thanks a lot!
>
> Disabling
>
> Kernel Hacking -> Tracers
>
> makes it boot. I'll check which option is responsible exactly.

It seems that pretty much everything must be disabled in this menu - except

"Create a snapshot trace buffer"

in comparison to the default Debian config. All other options (enabled
by default under Debian) seem to enable "yet another options", but my
Kconfig foo is too weak to understand what's going on there.
