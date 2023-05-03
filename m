Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1867FC77B75
	for <linux-sh@archiver.kernel.org>; Wed,  3 May 2023 08:32:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjECIcZ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 3 May 2023 04:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjECIcY (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 3 May 2023 04:32:24 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B16426A0
        for <linux-sh@vger.kernel.org>; Wed,  3 May 2023 01:32:19 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1pu7uI-000uM8-Rt; Wed, 03 May 2023 10:32:14 +0200
Received: from p5b13ada3.dip0.t-ipconnect.de ([91.19.173.163] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1pu7uI-003Jsv-Kw; Wed, 03 May 2023 10:32:14 +0200
Message-ID: <937ea351579dcf9f54b053e1272a11bbfbe6b6d4.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] Fix J-core aic warning spam
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Rob Landley <rob@landley.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        "D. Jeff Dionne" <jeff@coresemi.io>
Date:   Wed, 03 May 2023 10:32:13 +0200
In-Reply-To: <6c36f97c-e64d-ba50-fd15-48003acdba66@landley.net>
References: <ec905cf9-09de-a5d1-b8ee-0d874db4c301@landley.net>
         <45c6426d762dbbe27830182ce751aa3d8210602a.camel@physik.fu-berlin.de>
         <CAMuHMdVxTtoV5_+tEeoTT6hSEBkK8ZsHtu8t6jumvUK6u5effQ@mail.gmail.com>
         <e4f89e6f-b7fb-6cfc-c90c-03ecdefe602a@landley.net>
         <08823dbc7d6abb99958993bc35e315a3eb0e63bb.camel@physik.fu-berlin.de>
         <f321805d-346b-36d5-247f-3c092aa7bea1@landley.net>
         <CAMuHMdXX7+-KF7eEoqY4NH90e9g=ykapfma7V050NaKW1Qb-vQ@mail.gmail.com>
         <33f74e06-6b62-3f13-ed09-8efb4f05ac5c@landley.net>
         <b6ba777419f0d94c5f39cfc4698e2dd4f7319e16.camel@physik.fu-berlin.de>
         <b42c6496ffb531459eb7995fd4b5e828f599b4fe.camel@physik.fu-berlin.de>
         <b2415afc-5df9-cd95-9dd5-b31a3f9db6fc@landley.net>
         <c72b94655a26cf69ad0ed4ec586cdb062c24ac93.camel@physik.fu-berlin.de>
         <6c36f97c-e64d-ba50-fd15-48003acdba66@landley.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.1 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.173.163
X-ZEDAT-Hint: PO
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Rob!

On Sat, 2023-04-29 at 22:45 -0500, Rob Landley wrote:
> On 4/29/23 15:07, John Paul Adrian Glaubitz wrote:
> > Hi Rob!
> > 
> > On Wed, 2023-04-19 at 20:24 -0500, Rob Landley wrote:
> > > J-core binary toolchain tarball:
> > > 
> > > https://landley.net/toybox/downloads/binaries/toolchains/latest/sh2eb-linux-muslfdpic-cross.tar.xz
> > 
> > OK, I can actually build a J2 kernel with that. Are there instructions somewhere which explain
> > how to boot such a kernel on a Turtle board? Then I can give it a try on my personal one.
> 
> Just copy the vmlinux file to "vmlinux" on the sd card. (It needs an initramfs,
> or in theory a built-in kernel command line from kconfig doing the root= thing,
> but either way you should get serial output on the usb with something like "sudo
> busybox microcom -s 115200 /dev/ttyACM0".)

Thanks. I found my J2 board in the meantime.

> I built 6.3 with toybox's mkroot.sh and booted it on the board, although that
> was with a 10 patch stack in my tree. Only four of which are j-core related: one
> is the boot warning spam, of them adds the ugly ethernet driver, one makes uio
> work on nommu, and one adds support for a variable clock base because we plugged
> in some peripheral hardware that wasn't clocked in base 10 back in
> https://landley.net/notes-2020.html#04-11-2020 and... here, lemme just fling it
> all up github:
> 
>   https://github.com/landley/linux/commits/turtle-v6.3

We should get as many of these patches upstreamed as possible.

I will also continue reviewing old patches from the mailing list, I already
assembled a list of older patches many of which have not been applied.

If possible, the original author of the various J2 patches should post them
for review.

> That's my current stack forwarded ported on top of 6.3. You probably don't need
> most of that, but I booted it on the board a few days ago. (Yes, the ethernet
> driver is terrible.)
> 
> > And do you have a root filesystem available for J2 that I can use?
> 
> I mostly use a toybox mkroot build. The easy way to build it yourself is:
> 
>   git clone https://github.com/landley/toybox
>   cd toybox
>   mkroot/mkroot.sh CROSS_COMPILE=/path/to/sh2eb-linux-muslfdpic-
>   ls -l root/sh2eb

Thanks. That should be enough.

> > Do you know who authored these patches?
> 
> I think some came from Sato-san and the rest from Rich, but I'm not 100% sure?
> Rich has been the one maintaining them, and Jeff before that.
> 
> https://github.com/richfelker/musl-cross-make/commits/master/patches/gcc-5.3.0/0004-j2.diff
> implies that the patch came from Patrick Oppenlander, who sounds familiar?
> https://github.com/pattop

Doesn't ring a bell at the moment.

> > We should get these merged upstream which should be
> > easier these days since the FSF has lowered the barriers regarding the copyright assignment.
> 
> I'm all for it. Jeff had some more pending todo fixes for the toolchain that he
> might want to sweep up into such a push.

Jeff, your turn, please ;-).

> Me, I want to switch over to llvm but Jeff thinks its optimizer is still
> terrible for embedded systems. But then I've heard it had some pretty bad
> regressions 12.0 to, so...

While SuperH/J2 is not an official LLVM target, there is actually an LLVM toolchain
for J2, see:

> https://github.com/francisvm/j2-llvm

> I'm still using 9.4 because when I tried to build 11.2 back in February it went:
> 
> sh2eb-linux-muslfdpic/src_gcc/libstdc++-v3/../libgcc/unwind-pe.h:270:25: error:
> '_Unwind_gnu_Find_got' was not declared in this scope
>   270 |               result += _Unwind_gnu_Find_got ((_Unwind_Ptr) u);
> 
> And I haven't circled around to try to dig up why yet. (I want to bisect the gcc
> repo to see what commit broke it, but that involves getting the horrific
> autoconf dependency stack working which went REALLY WEIRD since the last time I
> looked at it, possibly version skew with debian oldstable package versions. The
> tarball versions ship cooked ./configure scripts that don't need the full
> gnu/aaaaaaaaah environment install with automake and everything...)

GCC for SH itself works fine for me, so I assume an issue with your build environment.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
