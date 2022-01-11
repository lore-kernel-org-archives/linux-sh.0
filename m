Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCDABC433EF
	for <linux-sh@archiver.kernel.org>; Tue, 11 Jan 2022 11:42:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238807AbiAKLmH (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 11 Jan 2022 06:42:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238505AbiAKLmG (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 11 Jan 2022 06:42:06 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87594C06173F
        for <linux-sh@vger.kernel.org>; Tue, 11 Jan 2022 03:42:06 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id g205so618689oif.5
        for <linux-sh@vger.kernel.org>; Tue, 11 Jan 2022 03:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=swiecki.net; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cybT3faDLGbWMNulzXgeOrQ8n2c3udPfBoCG7EfCfgw=;
        b=IMvAD7F2VNMP/wbov0OeiABgvIk/ZpBDhmeVec1V8tJwjDnk5l4+KF4e+vmMuR89/Q
         /yitlstfHPyJC1ykjliF/add65U4Aujrn5fy/sLjIINWmamlW9IUV9N5ev9xZCV5POID
         9qrSEwFf0KJOFmvuyv57rbExObTTmGrTKtQ0w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cybT3faDLGbWMNulzXgeOrQ8n2c3udPfBoCG7EfCfgw=;
        b=S1QoVgp9pwo7YocFPbnLGI1nt1XZ5L9+rkr+sFeQtfTKnn1GmVkKedR2ZUBuGOaSLP
         CEnNqWJvxrDe4PgyFamKNd5ZLpa5fHeeL0JKy/AsvNMfouxroaiuZzb8I6uF94UyI407
         eKmFZ6DBG59humdLaaqu9Tp9AuqVMFZs6bu5w97yAo2sqUn62SbCeTTRsapWCCTXJIhI
         7ClgttBD0FzpMzwVn/iA2K7DzB5iGLK3I8aDRmQnBU5S+jpeLNUV/tfIw5SzREPptXlx
         uD/k9mqqyUGsowZfxZiuRaLydK09MYYI+Q8GvdtNXAPA7+zdT0GjC7fNXET8SuczcWVs
         05uw==
X-Gm-Message-State: AOAM533gC1Ml6gAX98VMWj5ag/mxRJlZCdYS9ISqfVCdMoQTrOykZd3b
        JJAeLS0tziqohw+lMqbYIY9ofq/52yIQnLEpoW5p+pRhLAlM1A==
X-Google-Smtp-Source: ABdhPJxkAUGqfQo4OLiZ72qMYV6NZ6Cuu9ezh/0BAFJ6icLrGiIDu4xnkzvaAFtMa04yHXYaQD4+jQdXGkDwej41NzY=
X-Received: by 2002:a54:4502:: with SMTP id l2mr1460991oil.167.1641901325948;
 Tue, 11 Jan 2022 03:42:05 -0800 (PST)
MIME-Version: 1.0
References: <CAP145pjk471P9pUzhf-rpZiQvjd499i-VpL8iRECDWkSKM_cyA@mail.gmail.com>
 <CAP145pjjyXs40Disg3QhFkkEp8CFXeBCHjn_8Hu=s1cxEjCUQg@mail.gmail.com> <c947a46b-7c5e-6ca3-fabe-ce648d9c182c@physik.fu-berlin.de>
In-Reply-To: <c947a46b-7c5e-6ca3-fabe-ce648d9c182c@physik.fu-berlin.de>
From:   =?UTF-8?B?Um9iZXJ0IMWad2nEmWNraQ==?= <robert@swiecki.net>
Date:   Tue, 11 Jan 2022 12:41:54 +0100
Message-ID: <CAP145pjQJkgHx0AhGvDp9Rg0x0KfN1utxMaehrqp8sWNSR4x0g@mail.gmail.com>
Subject: Re: Fwd: Debian on Linux-SH4
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     linux-sh@vger.kernel.org, debian-superh@lists.debian.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

> On 1/11/22 12:23, Robert =C5=9Awi=C4=99cki wrote:
> > Recently I tried to create a working modern disk image for Linux-SH4.
> > There were many problems, but I finally managed to pull it off.
> >
> > If anyone needs a working Debian (unstable/experimental) + kernel
> > 5.15.0 - here're the images/kernels/scripts
>
> You could also create a Debian unstable environment for the sh4 architect=
ure
> using debootstrap:
>
> suse-laptop:/tmp # debootstrap --no-check-gpg --arch=3Dsh4 --foreign unst=
able debian-sh4-root http://ftp.ports.debian.org/debian-ports
> I: Retrieving InRelease
> I: Retrieving Packages
> I: Validating Packages
> I: Resolving dependencies of required packages...
> (...)
> I: Extracting login...
> I: Extracting logsave...
> I: Extracting mawk...
> I: Extracting mount...
> I: Extracting ncurses-bin...
> I: Extracting passwd...
> I: Extracting perl-base...
> I: Extracting sed...
> I: Extracting sysvinit-utils...
> I: Extracting tar...
> I: Extracting util-linux...
> I: Extracting zlib1g...
> suse-laptop:/tmp #
>
> Then run "./debootstrap/debootstrap --second-stage" on the target system.
>
> If your qemu-user is properly set up to use binfmt (which is currently no=
t the case on my
> system), you can omit the "--foreign" option and get a ready-to-boot chro=
ot for Debian sh4.

Thanks, I guess I did it the hard way then (through the debian-installer) :=
)

BTW: some problems I noticed during installation:

- debian-installer for sh4 (probably one of the most recent ones) has
tools compiled with glibc-2.33 but the version of glibc inside (initrd
image) is glibc-2.32, so some tools like mount and part*something
refuse to run with sth like "missing symbol GLIBC_2.33"
- debian-installer comes with kernel version 5.13 or so, and the
pool-sh4 has only 5.15.*-di kernels - I used custom kernel with custom
kernel version (so it matches the -di kernel version)
- older debian-installers for sh4 won't run on r2d with 64MB RAM due
to OOOms. I added some ninja swap images to bypass that. I think newer
installers have low-RAM mode, and it works better.

PS: Many years ago I was solving a CTF (Capture The Flag) challenge -
https://blog.dragonsector.pl/2014/12/seccon-2014-japanese-super-micro.html
- which was using SH4 for Linux compiled in big-endian mode. I guess
someone went through troubles to compile Linux kernel in big-endian,
and then compiled some userland to big-endian too. Dunno.
