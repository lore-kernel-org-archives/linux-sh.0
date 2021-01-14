Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07472C433DB
	for <linux-sh@archiver.kernel.org>; Thu, 14 Jan 2021 09:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE99F23A21
	for <linux-sh@archiver.kernel.org>; Thu, 14 Jan 2021 09:42:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728252AbhANJmK (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Thu, 14 Jan 2021 04:42:10 -0500
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:53371 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728045AbhANJmJ (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Thu, 14 Jan 2021 04:42:09 -0500
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1kzz8J-000FJ7-1k; Thu, 14 Jan 2021 10:41:34 +0100
Received: from ipservice-092-214-205-060.092.214.pools.vodafone-ip.de ([92.214.205.60] helo=[192.168.178.45])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1kzz8I-0026qL-8j; Thu, 14 Jan 2021 10:41:34 +0100
Subject: Re: Old platforms: bring out your dead
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Gerhard Pircher <gerhard_pircher@gmx.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Sparc kernel list <sparclinux@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>
References: <ef1dc21f-694b-2433-e1c6-aa121320173e@physik.fu-berlin.de>
 <f48bcf43-9dcc-e48b-d29d-f75f3814398b@gmx.net>
 <cb5a2e11-d423-96ec-3d43-3568a109e37f@physik.fu-berlin.de>
 <CACRpkda4E2NwNw29J7x5gehtqn_m3M_Z2dHpc7xRgvb0b-p22A@mail.gmail.com>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <1be37673-db0e-f09d-68c8-f929be4019ab@physik.fu-berlin.de>
Date:   Thu, 14 Jan 2021 10:41:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CACRpkda4E2NwNw29J7x5gehtqn_m3M_Z2dHpc7xRgvb0b-p22A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 92.214.205.60
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hello Linus!

On 1/12/21 11:46 PM, Linus Walleij wrote:
> On Tue, Jan 12, 2021 at 3:45 PM John Paul Adrian Glaubitz
> <glaubitz@physik.fu-berlin.de> wrote:
> 
>> Yeah, I have the same impression that's the strong commercial interest pushes
>> hobbyist use of the Linux kernel a bit down. A lot of these changes feel like
>> they're motivated by corporate decisions.
>>
>> There has to be a healthy balance between hobbyist and commercial use. I understand
>> that from a commercial point of view, it doesn't make much sense to run Linux
>> on a 30-year-old computer. But it's a hobbyist project for many people and hacking
>> Linux stuff for these old machines has a very entertaining and educational factor.
> 
> This is actually one of the most interesting things written in this discussion.
> 
> I have both revamped and deleted subarchitectures in the ARM tree. We
> never deleted anyone's pet project *unless* they were clearly unwilling to
> work on it (such as simply testning new patches) and agreed that it will
> not go on.

I'm not arguing this. This was more about killing (sub-)architectures because they
haven't seen git activity for a long time which I think is poor metric to determine
whether a port is dead or not. And reading through the other answers in this thread,
it seems I'm not alone with this stance.

> At multiple occasions I actually found it easier to fix stuff than
> delete it, both because it is a nicer thing to do and because it
> simply creates less social problems, often to the point that the time
> (man hours) spent trying to solve the resulting social problems from
> deleting a platform would be longer than the time spent actually acquiring
> the physical platform and fixing it.

Good to hear.

> Corporate entities can be a bit deletionist (using Wikipedia terminology)
> and as in this thread there is always a strong inclusionist stance pushing
> back to that.

It's an obvious conflict.

> The explanation is in my mind very simply that running Linux
> on a 35-yo or so Amiga, Atari or Apollo Workstation is pretty impressive and
> fun. And I think that fits Mr. Torvalds own sociological-or-something
> explanation in the autobiographical "Just for fun" as to why to write it
> in the first place. And we are very protective of that quality of the
> kernel. (At least I am.)

I'm happy to hear that. For me personally, it also has a very educational value
as the non-mainstream platforms such as m68k offer more places of code to hack
on for adding features such as SECCOMP which are still missing there.

There are usually enough people working on architectures such as x86 and ARM,
so there is not much room for hobbyist activities. Also, you risk making much
more people upset if you break something.

> That said there are a three things that people should really be doing if they
> want to keep their pet archs/subarchs around as good community
> members, and they are in essence to:
> 
> 1. Test and review/ack patches that others make

I am already doing that as much as I can for various architectures such as ia64,
m68k, SH and POWER, SPARC although I need to ramp up my activity a bit more. I have
also now added myself for the linux-alpha mailing list to test and ack patches for
the Alpha architecture as well.

I have to admit I have quite a number of pet architectures but that's because I'm
co-maintaining these architectures in Debian Ports with regular releases of Debian
installation images for these targets:

> https://cdimage.debian.org/cdimage/ports/snapshots/

> 2. Migrate existing drivers to newly appeared and
>     appropriate subsystems (I think there are some hacky heartbeat LED
>     drivers down in arch/* for example) there is also the feature matrix
>     core maintainers like and which appears if you type
>     Documentation/features/list-arch.sh <archname>
>     would be nice if you work on them if you can support them!
>     Or at least take a look.

Thanks for the pointer. I'm not so much active in kernel development itself yet, but
I'm also trying to be more active. Although the kernel is not the only project that
sometimes needs attention for these pet architectures. We're also confronted with
deprecation problem in problems such as GCC although we recently saved the m68k
(and VAX) backends in GCC with the help of a Bountysource campaign. The AVR backend
is also backed by such a campaign and currently being worked on.

We are even getting an m68k backend for LLVM hopefully soonish, so we will even be able
to build the Linux kernel for m68k with clang :-).

> 3. Migrate old systems to use the
>    contemporary hardware descriptions (such as device tree or ACPI)
>    because it makes things so much easier to maintain. Some
>    upfront work, but a great win for everyone. Especially for
>    subsystem maintainers.

There is such a patch set for arch/sh to add device tree support, but so far it has not
been merged yet, unfortunately. Apparently, it causes some regression on LANDISK devices
according to Rich Felker.

Maybe we can finally get it merged this year:

> https://lore.kernel.org/patchwork/cover/693910/

Since Geert also has a LANDISK SH device now for testing, he might be able to help.

Oh, and if anyone else is interested in helping with the SH port, I'm happy to send
them a free LANDISK or NextVoD SuperH device - the latter has a 450 MHz ST-40
CPU and 256 MB RAM.

> And if your arch uses highmem then please get rid of highmem. I'm
> trying to do this a bit right now for ARM let's see how it goes.

Is there a list of architectures which still need highmem?

> I understand that for some maintainers time is a factor and this list
> feels stressful. I'd say relax, but it'd be nice if you have a TODO that
> you cross items off of.

Thanks for the kind words. I appreciate the input.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

