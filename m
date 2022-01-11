Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE11C433EF
	for <linux-sh@archiver.kernel.org>; Tue, 11 Jan 2022 18:40:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241327AbiAKSkZ (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 11 Jan 2022 13:40:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244120AbiAKSkY (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 11 Jan 2022 13:40:24 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5F6C061751
        for <linux-sh@vger.kernel.org>; Tue, 11 Jan 2022 10:40:24 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id y14so267435oia.9
        for <linux-sh@vger.kernel.org>; Tue, 11 Jan 2022 10:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=swiecki.net; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jp2LBqCiBrhVSbcSUrEf2fcHU+CTOqmkgo5NNtq6BU8=;
        b=NGqlss0sLEjaiZPMlVaO7+wj9Ahj6X/yT8Euf7U8DBf+B9QswXQ7smnY9T+p77vEqT
         oEpGH3E98To4bMKCNCNuR094uVlKxYdUJjUzkYDimGc/wyadbN+0Naax3324vs0TG7au
         Xo7fUoTABC34x5NBR0gaaa6v3UMGffpM4BcP0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jp2LBqCiBrhVSbcSUrEf2fcHU+CTOqmkgo5NNtq6BU8=;
        b=2m13VGTa288b5CcfqfaqnaiWYtK8263NGW4safj4rNsiEO1Ex6gvMd9LxZsBPnDdGi
         OVZOblrq0yakepKPCxbcrQG6Z+cfCJeh/2uAxkTD6DPfQVpfaMOOr/2vYHfu9Y/fDDJH
         Ayl0nHMXA6f2NipvGx4ZPVgxAEWv5q2Vjjxviw1puF5alOVDo2JyeKiwgpa46s/jlKBp
         JcnevLhjwMQWRl2kjFzHKNnQbijye2oLhfxAHYyKWK4LN7+nAG0tZ2fvPyBY7K9f0DEx
         C2R379MmaqoTK/bFob+DtODTq8GGB4BjRBFv8JSUeVoT4/L8ypVNw5cKCuGV6FVN2TJ0
         x+8Q==
X-Gm-Message-State: AOAM531yWN/86ZjjHNViBVf+zazqlSDFj2lLycmX46xM+iYZ1P8jy3Ym
        tVj07KEBnt9IGDWckdh5sVn7S0TBXvphtRDgNYGaIxFee54=
X-Google-Smtp-Source: ABdhPJwDMhHQUjTAO5tzHRjQv0VeNpMOw1kHkLmwz/kBwQypmaFVfYhgFsUTOdvRRiOb2mvsL+3xsx+8jsITrA5Mg6M=
X-Received: by 2002:a54:4f81:: with SMTP id g1mr2465974oiy.172.1641926423720;
 Tue, 11 Jan 2022 10:40:23 -0800 (PST)
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
 <CAP145pjWrPSqX0g9oJoqU57+S4OziHQt8=ZDrQVq8pD5CzAyiw@mail.gmail.com> <24eae22e-2b28-c1e4-468a-f7d0ada564a8@physik.fu-berlin.de>
In-Reply-To: <24eae22e-2b28-c1e4-468a-f7d0ada564a8@physik.fu-berlin.de>
From:   =?UTF-8?B?Um9iZXJ0IMWad2nEmWNraQ==?= <robert@swiecki.net>
Date:   Tue, 11 Jan 2022 19:40:12 +0100
Message-ID: <CAP145pjFkwvMfwhrTRJpBL=uJLGHcZTegrb4rRwGtrR2Q=AK-Q@mail.gmail.com>
Subject: Re: Fwd: Debian on Linux-SH4
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     linux-sh@vger.kernel.org, debian-superh@lists.debian.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

> > I tried with both sh7785lcr and with sh7751r debian configs and no
> > luck. So it's a config problem.
> >
> > I don't know how I got to the conclusion that it's problem with
> > cross-toolchain. Now I tried with Debian's version, and it works. Must
> > have gotten confused in the process.
>
> OK, good to know.
>
> > [    0.000000] Linux version 5.15.0 (jagger@jd) (sh4-linux-gnu-gcc
> > (Debian 6.3.0-18) 6.3.0 20170516, GNU ld (GNU Binutils for Debian)
> > 2.37.50.20220106) #46 Tue Jan 11 16:19:36 CET 2022
> >
> > I'm attaching my working config. I'll see whether I can bisect it or
> > spot anything obvious.
>
> That would be awesome, thanks a lot!

Disabling

Kernel Hacking -> Tracers

makes it boot. I'll check which option is responsible exactly.
