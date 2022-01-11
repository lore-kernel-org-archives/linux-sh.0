Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 858EEC433F5
	for <linux-sh@archiver.kernel.org>; Tue, 11 Jan 2022 14:49:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239791AbiAKOt2 (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 11 Jan 2022 09:49:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239774AbiAKOt1 (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 11 Jan 2022 09:49:27 -0500
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF00C06173F
        for <linux-sh@vger.kernel.org>; Tue, 11 Jan 2022 06:49:27 -0800 (PST)
Received: by mail-oo1-xc2f.google.com with SMTP id k15-20020a4a850f000000b002dc3cdb0256so4065029ooh.3
        for <linux-sh@vger.kernel.org>; Tue, 11 Jan 2022 06:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=swiecki.net; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZPvPQBvmGAxg9E/8WpdjWn5DthJA4/PlTA1jKHPbey0=;
        b=HPUeHeBB+wJAG5AinaPGwNOMjqZ/t3pkh+gAfTyzyszXbtHZh+UMD6iCvzyxuWxd4q
         uE1FNYM18m6hctEU1MVd01h2qNL8lCH1fR4g0k9GMBlDQp0EE5+FGQOUYYQk5v7e+Lmo
         O8ZmL+yq226TOykSxK4mr8zUyZm5g5VZk1Mf8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZPvPQBvmGAxg9E/8WpdjWn5DthJA4/PlTA1jKHPbey0=;
        b=prtROvmPdBR8rxfMx6HOVcNM793ZjEnLrmm0a8sfJbo90kRWzAP4SfaTrUU1EMEbjJ
         oAwfUb+ZgYIVMzdqUngRwixNsLnY8Px1vJi4r40nJ8GJxCYo8ETNUzkhdqChwQxW3Xs3
         oOp6iNumO86DQ3UhaoL+LrrJIBmAPsvY9BfP/BG2WXnfQDFwagRPk9Jnt/ZXYNxAs/uk
         hC4dXE3W9KksHcKcsYfsSfR6ue5WjOD9HBfJasOm/az4kJKUMhtRi2MIDp2rXmmsCcHg
         yLZu6Kt7xhp6juGE+uSurMAoBGF/oRpbcx4+TLyZb3UV+n957Utk+5yNv5UiqvOTyEBi
         zBcg==
X-Gm-Message-State: AOAM531hMxGk2bUafxPvjGsdikZwzPBw44gDFaG0Jrzze6jvW4WNUDBh
        ya8Na6qTpRGR2sV5BWgNPN6Dye8G2s5CRd3FlEfjAjD81Ld2Lw==
X-Google-Smtp-Source: ABdhPJx1ebLy3swnIDHqv0xSE9PeqGtHpF+1v+ryFTz9cy6WDKYCeoi6zkpu3MhjymHcdgJIq/2fN2caJTqlw6qgyhk=
X-Received: by 2002:a4a:e4d9:: with SMTP id w25mr3351970oov.3.1641912566406;
 Tue, 11 Jan 2022 06:49:26 -0800 (PST)
MIME-Version: 1.0
References: <CAP145pjk471P9pUzhf-rpZiQvjd499i-VpL8iRECDWkSKM_cyA@mail.gmail.com>
 <CAP145pjjyXs40Disg3QhFkkEp8CFXeBCHjn_8Hu=s1cxEjCUQg@mail.gmail.com>
 <c947a46b-7c5e-6ca3-fabe-ce648d9c182c@physik.fu-berlin.de>
 <CAP145pjQJkgHx0AhGvDp9Rg0x0KfN1utxMaehrqp8sWNSR4x0g@mail.gmail.com> <985011f6-c0b8-947f-7ebf-6d27c59ba219@physik.fu-berlin.de>
In-Reply-To: <985011f6-c0b8-947f-7ebf-6d27c59ba219@physik.fu-berlin.de>
From:   =?UTF-8?B?Um9iZXJ0IMWad2nEmWNraQ==?= <robert@swiecki.net>
Date:   Tue, 11 Jan 2022 15:49:15 +0100
Message-ID: <CAP145piu0gURojU7TvU7XeDybVczQZDVYqT8th_1f4EcknDF1Q@mail.gmail.com>
Subject: Re: Fwd: Debian on Linux-SH4
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     linux-sh@vger.kernel.org, debian-superh@lists.debian.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi,

> > Thanks, I guess I did it the hard way then (through the debian-installer) :)
> >
> > BTW: some problems I noticed during installation:
> >
> > - debian-installer for sh4 (probably one of the most recent ones) has
> > tools compiled with glibc-2.33 but the version of glibc inside (initrd
> > image) is glibc-2.32, so some tools like mount and part*something
> > refuse to run with sth like "missing symbol GLIBC_2.33"
>
> I will build updated debian-installer images within the next days which should
> fix the problem.
>
> > - debian-installer comes with kernel version 5.13 or so, and the
> > pool-sh4 has only 5.15.*-di kernels - I used custom kernel with custom
> > kernel version (so it matches the -di kernel version)
>
> That will be fixed by an updated image build as well.
>
> > - older debian-installers for sh4 won't run on r2d with 64MB RAM due
> > to OOOms. I added some ninja swap images to bypass that. I think newer
> > installers have low-RAM mode, and it works better.
>
> I never managed to get debian-installer to boot on qemu-sh4-system, did you?
>
> If yes, I would be very interested to learn how you managed to get the kernel
> to boot in qemu-sh4.

Ha.. I didn't. debian's cross-sh4-gcc (I think I tried versions 11 10
8 and 6) doesn't build "working" kernels. Dunno why. It compiles, but
doesn't boot.

In the end I had to compile it myself with one of those
https://toolchains.bootlin.com/releases_sh-sh4.html and use it with
istaller's initrd. Fortunately it allowed me to proceed even if the
*-di* modules couldn't be loaded. The only thing I had to do was to
trick the installer into thinking that my custom kernel is the same
kernel version as the *di* version in pool-sh4 via EXTRAVERSION in
kernel's Makefile, because the "anna" thingy stops the installation
process w/o it.

$ ./sh-sh4--glibc--stable/bin/sh4-linux-gcc --version
sh4-linux-gcc.br_real (Buildroot 2017.05) 5.4.0

[    0.000000] Linux version 5.15.0 (jagger@jd)
(sh4-buildroot-linux-gnu-gcc.br_real (Buildroot 2017.05) 5.4.0, GNU ld
(GNU Binutils) 2.27) #37 Tue Jan 11 12:58:34 CET 2022
