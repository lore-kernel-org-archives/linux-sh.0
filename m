Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C0EC433F5
	for <linux-sh@archiver.kernel.org>; Tue, 11 Jan 2022 14:55:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243068AbiAKOzL (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 11 Jan 2022 09:55:11 -0500
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:57325 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243146AbiAKOzL (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 11 Jan 2022 09:55:11 -0500
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1n7IYH-000wF2-TU; Tue, 11 Jan 2022 15:55:09 +0100
Received: from suse-laptop.physik.fu-berlin.de ([160.45.32.140])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1n7IYH-001ZLl-OA; Tue, 11 Jan 2022 15:55:09 +0100
Message-ID: <fa9bdc51-42ee-5eb9-75a3-f46706bcf1a9@physik.fu-berlin.de>
Date:   Tue, 11 Jan 2022 15:55:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: Fwd: Debian on Linux-SH4
Content-Language: en-US
To:     =?UTF-8?Q?Robert_=c5=9awi=c4=99cki?= <robert@swiecki.net>
Cc:     linux-sh@vger.kernel.org, debian-superh@lists.debian.org
References: <CAP145pjk471P9pUzhf-rpZiQvjd499i-VpL8iRECDWkSKM_cyA@mail.gmail.com>
 <CAP145pjjyXs40Disg3QhFkkEp8CFXeBCHjn_8Hu=s1cxEjCUQg@mail.gmail.com>
 <c947a46b-7c5e-6ca3-fabe-ce648d9c182c@physik.fu-berlin.de>
 <CAP145pjQJkgHx0AhGvDp9Rg0x0KfN1utxMaehrqp8sWNSR4x0g@mail.gmail.com>
 <985011f6-c0b8-947f-7ebf-6d27c59ba219@physik.fu-berlin.de>
 <CAP145piu0gURojU7TvU7XeDybVczQZDVYqT8th_1f4EcknDF1Q@mail.gmail.com>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
In-Reply-To: <CAP145piu0gURojU7TvU7XeDybVczQZDVYqT8th_1f4EcknDF1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 160.45.32.140
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Robert!

On 1/11/22 15:49, Robert Święcki wrote:
> Ha.. I didn't. debian's cross-sh4-gcc (I think I tried versions 11 10
> 8 and 6) doesn't build "working" kernels. Dunno why. It compiles, but
> doesn't boot.
> 
> In the end I had to compile it myself with one of those
> https://toolchains.bootlin.com/releases_sh-sh4.html and use it with
> istaller's initrd.

OK, that is very interesting. We need to figure out what the problem with
Debian's compiler is what causes the kernel to be non-bootable.

I have already had a discussion with QEMU upstream and we hadn't come up
with a solution yet, so your successful boot with QEMU is a very useful
result.

> Fortunately it allowed me to proceed even if the
> *-di* modules couldn't be loaded. The only thing I had to do was to
> trick the installer into thinking that my custom kernel is the same
> kernel version as the *di* version in pool-sh4 via EXTRAVERSION in
> kernel's Makefile, because the "anna" thingy stops the installation
> process w/o it.

Yes, but that's a different problem and doesn't normally happen when using
the standard kernel.

> $ ./sh-sh4--glibc--stable/bin/sh4-linux-gcc --version
> sh4-linux-gcc.br_real (Buildroot 2017.05) 5.4.0
> 
> [    0.000000] Linux version 5.15.0 (jagger@jd)
> (sh4-buildroot-linux-gnu-gcc.br_real (Buildroot 2017.05) 5.4.0, GNU ld
> (GNU Binutils) 2.27) #37 Tue Jan 11 12:58:34 CET 2022

Thanks for the information.

If you can find out anything else on the kernel/GCC issue that would be much
appreciated. I have been quite stuck on this issue in the past although it
works on real hardware.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

