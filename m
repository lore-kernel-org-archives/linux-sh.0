Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ECB0C433F5
	for <linux-sh@archiver.kernel.org>; Tue, 11 Jan 2022 12:45:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239422AbiAKMpB (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 11 Jan 2022 07:45:01 -0500
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:54503 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236359AbiAKMpB (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 11 Jan 2022 07:45:01 -0500
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1n7GWK-004AV5-C7; Tue, 11 Jan 2022 13:45:00 +0100
Received: from suse-laptop.physik.fu-berlin.de ([160.45.32.140])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1n7GWK-001D1s-70; Tue, 11 Jan 2022 13:45:00 +0100
Message-ID: <985011f6-c0b8-947f-7ebf-6d27c59ba219@physik.fu-berlin.de>
Date:   Tue, 11 Jan 2022 13:45:00 +0100
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
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
In-Reply-To: <CAP145pjQJkgHx0AhGvDp9Rg0x0KfN1utxMaehrqp8sWNSR4x0g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 160.45.32.140
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Robert!

On 1/11/22 12:41, Robert Święcki wrote:
> Thanks, I guess I did it the hard way then (through the debian-installer) :)
> 
> BTW: some problems I noticed during installation:
> 
> - debian-installer for sh4 (probably one of the most recent ones) has
> tools compiled with glibc-2.33 but the version of glibc inside (initrd
> image) is glibc-2.32, so some tools like mount and part*something
> refuse to run with sth like "missing symbol GLIBC_2.33"

I will build updated debian-installer images within the next days which should
fix the problem.

> - debian-installer comes with kernel version 5.13 or so, and the
> pool-sh4 has only 5.15.*-di kernels - I used custom kernel with custom
> kernel version (so it matches the -di kernel version)

That will be fixed by an updated image build as well.

> - older debian-installers for sh4 won't run on r2d with 64MB RAM due
> to OOOms. I added some ninja swap images to bypass that. I think newer
> installers have low-RAM mode, and it works better.

I never managed to get debian-installer to boot on qemu-sh4-system, did you?

If yes, I would be very interested to learn how you managed to get the kernel
to boot in qemu-sh4.

> PS: Many years ago I was solving a CTF (Capture The Flag) challenge -
> https://blog.dragonsector.pl/2014/12/seccon-2014-japanese-super-micro.html
> - which was using SH4 for Linux compiled in big-endian mode. I guess
> someone went through troubles to compile Linux kernel in big-endian,
> and then compiled some userland to big-endian too. Dunno.

Fun. I will have a read tonight.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

