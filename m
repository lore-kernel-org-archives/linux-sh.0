Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89576C433E6
	for <linux-sh@archiver.kernel.org>; Tue, 12 Jan 2021 14:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55C582312E
	for <linux-sh@archiver.kernel.org>; Tue, 12 Jan 2021 14:38:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728429AbhALOiR (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 12 Jan 2021 09:38:17 -0500
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:38941 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726329AbhALOiR (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 12 Jan 2021 09:38:17 -0500
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1kzKne-000o6B-Ed; Tue, 12 Jan 2021 15:37:34 +0100
Received: from p5b13a61e.dip0.t-ipconnect.de ([91.19.166.30] helo=[192.168.178.139])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1kzKnd-001CLC-9K; Tue, 12 Jan 2021 15:37:33 +0100
Subject: Re: Old platforms: bring out your dead
To:     chase rayfield <cusbrar1@gmail.com>
Cc:     Sam Ravnborg <sam@ravnborg.org>, Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Sparc kernel list <sparclinux@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>
References: <CAK8P3a2VW8T+yYUG1pn1yR-5eU4jJXe1+M_ot6DAvfr2KyXCzQ@mail.gmail.com>
 <ef1dc21f-694b-2433-e1c6-aa121320173e@physik.fu-berlin.de>
 <20210110214653.GA1693373@ravnborg.org>
 <df42946e-5b1f-c433-fc6b-a2950f3d8dab@physik.fu-berlin.de>
 <CACwypyNS+fVoPVspSr36v8YjFbkrnYb+amcYRqVmA2kD2uD1Wg@mail.gmail.com>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <4c42f2ce-7702-55cd-a2c0-558d3dd208f2@physik.fu-berlin.de>
Date:   Tue, 12 Jan 2021 15:37:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CACwypyNS+fVoPVspSr36v8YjFbkrnYb+amcYRqVmA2kD2uD1Wg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.166.30
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hello!

On 1/11/21 3:55 PM, chase rayfield wrote:
> My take is that there *would* be more interest in Sparc sun4m / Sun4d
> from enthusiasts at the very least if it was possible to actually boot
> the bloat hog that is Linux these days in a fully usable configuration
> that probably means some modifications to SILO and Linux required.

The Linux kernel is configurable. If you want a small kernel, then just
configure one. No one expects you to boot a fully-fledged distribution
kernel on these machines.

> The problem is as I understand it, SILO only sets up a 16Mb mapping
> (either due to having to assume 4MB minimum dram stick size or due to
> mapping limitations not sure, most of these machines have at least
> 16MB in slot one...these days though that wasn't the case for sun4c),
> loads Linux into it and says good Luck. This isn't enough for a modern
> kernel with any  hardware support built in. So you might for instance
> get a kernel to fit but only if you dropped all of networking support
> etc...

That makes no sense. It worked in the past, why shouldn't it work nowadays?

As I said, you disable everything you don't need. I'm booting my SH-7785LCR
SuperH board with a kernel that is less than 4 MB in size and which includes
everything I need.

> I'm guessing the fix for this would be to modify silo to map a
> larger amount in a way that Linux expects so it can remap it as it
> likes, or just have SILO map the full memory as Linux would. Anyway
> that is THE main demotivation for these architectures.... otherwise
> they have plenty of ram and performance to do basic router/server
> tasks sans SSL.

Or just configure a smaller kernel.

> This has been the status quo for since the last of the 2.6 series of
> kernels which it was still possible to just barely squeeze a usable
> kernel out of... If someone wanted to take a few hours and fix this
> issue, and keep these architectures around I'd be happy to "buy them a
> round of pizza", though I recognize that many people that work on this
> already have nice jobs, and just don't have time.

I haven't gotten around to setup my SPARCstation 5 yet, but I will certainly
going to do that later this year to give it a try.

> Also Sparc would probably be a good project for someone to extend/test
> Andi Keen's Linux LTO patch set so we could reduce the kernel binary
> size that way also even if sun4 architectures are dropped, it would
> still be useful for embedded sparc. Also there is a port of Temlib to
> the Mister hardware now, 3 cores roughly equivalent to a mid 90s
> machine, at least 128MB ram is possible ( more if a way to map the ARM
> system memory also 1GB is available there, it would have higher
> latency though).
> 
> It is perfectly viable to build Sparc v7 or v8 32bit binaries in a
> chroot on a fast machine also, and I would recommend this if you wish
> to retain sanity rather than attempting cross compiler voodoo, unless
> that is your thing.

We build anything SPARC on a SPARC T5 that we have for Debian, no need
for cross-compilation and that machine is actually quite fast.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

