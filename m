Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9203C77B7F
	for <linux-sh@archiver.kernel.org>; Wed,  3 May 2023 12:24:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjECMYN (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 3 May 2023 08:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjECMYM (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 3 May 2023 08:24:12 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C00F5B8E
        for <linux-sh@vger.kernel.org>; Wed,  3 May 2023 05:24:02 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id d9443c01a7336-1a516fb6523so49540375ad.3
        for <linux-sh@vger.kernel.org>; Wed, 03 May 2023 05:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20221208.gappssmtp.com; s=20221208; t=1683116641; x=1685708641;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GAaL1ayRyTJBICjJWAygP9XRU+BcHWvjYP5qd3e8RjY=;
        b=QezpO5FpeQncfBT2NYZpOGl21Y17xi9qElkf+yPGMsMr3x6d+V7yTFGjajW95IILj+
         en99An+K1VofAfv++AQ31IcJNeAWRw9rqVIl617GmkAzARFCBusMhpKnehyqPr+bPerV
         QuVbtaku3hyfuKQlxcujeMR1Vbr7OSli7sGsmJZDdXhFBFBF5oxV3/N3BQI7Yq93+dDq
         4nejWfvNp4a3vubwkpg127Ttv9wj0/HLJIerCgDPQmsxzzWBz/mLqT62KcMIMxey04tY
         itjt8mdwr6qrYKr0FTXbD+24kuJZhlfJtKOeZ/h7yOQedQ9cHsX1BwnQGNuvB4a1IKca
         m+uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683116641; x=1685708641;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GAaL1ayRyTJBICjJWAygP9XRU+BcHWvjYP5qd3e8RjY=;
        b=UOqHr9Ci7mgoItlAjjdVSdXioO8oH/nCMjapEu9p8SMdeXpBwD58vZj32fZBRDqR4Q
         7AYpfVv3NZ6lEImH2oc90WEDRC202Vhhh71VptgepYL8dZqyyMCCr14Jj2DE25YXnstS
         azDsb0sTiF+uIHLLpe4xkTB9hxjW7n8CqT8GcOjBkeIMPF1PoUgSznvhXcd1sgShPG36
         rdZcJuj/7EuiB9FwBYdIbVcNNxe80+jq5rld0J3igQAWVop18w8U1uO/+vQllsDtt3di
         p97jACtOAhkIjc87LE6CHiNAGxisyZtOgZI18dzXK2zEOEbj0eb2BDF208TOo15HUMZR
         I8bQ==
X-Gm-Message-State: AC+VfDxt7l4F+vkS2ez3fFpERKLSK/gJaq9OuIjB0+1v+1sf9LXGxiPV
        hZAshS/L1IWBm0UA6G9zKuFIVQ==
X-Google-Smtp-Source: ACHHUZ7N61IW8RwLIrOjBwDs8prLiO0D7MdJkPeTln+BUB3UVLPBD22myXC9AY9HZoF0uXig+RzV9w==
X-Received: by 2002:a17:903:120a:b0:1a9:433e:41d5 with SMTP id l10-20020a170903120a00b001a9433e41d5mr2181694plh.56.1683116641437;
        Wed, 03 May 2023 05:24:01 -0700 (PDT)
Received: from [192.168.33.147] (124-110-25-102.east.xps.vectant.ne.jp. [124.110.25.102])
        by smtp.gmail.com with ESMTPSA id x12-20020a1709027c0c00b001a52e3e3745sm21449888pll.296.2023.05.03.05.23.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 May 2023 05:24:00 -0700 (PDT)
Message-ID: <fea62844-cb9d-a6b1-31c0-5297ddad92c8@landley.net>
Date:   Wed, 3 May 2023 07:39:40 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] Fix J-core aic warning spam
Content-Language: en-US
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        "D. Jeff Dionne" <jeff@coresemi.io>
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
 <937ea351579dcf9f54b053e1272a11bbfbe6b6d4.camel@physik.fu-berlin.de>
From:   Rob Landley <rob@landley.net>
In-Reply-To: <937ea351579dcf9f54b053e1272a11bbfbe6b6d4.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On 5/3/23 03:32, John Paul Adrian Glaubitz wrote:
> Hi Rob!
> 
> On Sat, 2023-04-29 at 22:45 -0500, Rob Landley wrote:
>> On 4/29/23 15:07, John Paul Adrian Glaubitz wrote:
>> > Hi Rob!
>> > 
>> > On Wed, 2023-04-19 at 20:24 -0500, Rob Landley wrote:
>> > > J-core binary toolchain tarball:
>> > > 
>> > > https://landley.net/toybox/downloads/binaries/toolchains/latest/sh2eb-linux-muslfdpic-cross.tar.xz
>> > 
>> > OK, I can actually build a J2 kernel with that. Are there instructions somewhere which explain
>> > how to boot such a kernel on a Turtle board? Then I can give it a try on my personal one.
>> 
>> Just copy the vmlinux file to "vmlinux" on the sd card. (It needs an initramfs,
>> or in theory a built-in kernel command line from kconfig doing the root= thing,
>> but either way you should get serial output on the usb with something like "sudo
>> busybox microcom -s 115200 /dev/ttyACM0".)
> 
> Thanks. I found my J2 board in the meantime.

Woo!

>> I built 6.3 with toybox's mkroot.sh and booted it on the board, although that
>> was with a 10 patch stack in my tree. Only four of which are j-core related: one
>> is the boot warning spam, of them adds the ugly ethernet driver, one makes uio
>> work on nommu, and one adds support for a variable clock base because we plugged
>> in some peripheral hardware that wasn't clocked in base 10 back in
>> https://landley.net/notes-2020.html#04-11-2020 and... here, lemme just fling it
>> all up github:
>> 
>>   https://github.com/landley/linux/commits/turtle-v6.3
> 
> We should get as many of these patches upstreamed as possible.

I'm all for it, and am very happy to hand patches off to people who can deal
with them, but I'm not personally very good at navigating the process of what
linux-kernel has become:

  https://landley.net/notes-2023.html#22-02-2023

I still feel guilty about not having replied to Andrew yet, but I dunno what to
_say_:

  https://landley.net/notes-2023.html#24-02-2023

Oh, that ncp cleanup patch should also remove SMB_SUPER_MAGIC which went away in
commit 939cbe5af5fb and USBDEVICE_SUPER_MAGIC which went away in commit
fb28d58b72aa. Those symbols _also_ went away more than 10 years ago. Whole lot
of dusty corners in this codebase nobody's bothered to clean them out in forever
because touching linux-kernel actively unpleasant, so people who might otherwise
speak up about the references to 2.1 and 2.2 kernel versions being maybe a bit
stale in
https://github.com/torvalds/linux/blob/v6.3/Documentation/filesystems/proc.rst#:~:text=may%20change%20slightly
don't think engaging with linux-kernel is worth it. (That whole "with enough
eyeballs all bugs are shallow" thing assumes you have participation from people
outside the core group. Which stops working when your community actively drives
them away...)

*shrug* I can respin the patch if you think it's worth trying? Last time I did
something similar I had to argue with people whose entire argument was "change
bad, accumulting cruft endlessly has no downsides":

  https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1102436.html

Which is odd because as the linux-kernel community ages and shrinks it's been
throwing multiple entire drivers overboard:

  http://www.phoronix.com/news/Linux-Disabling-RNDIS-Drivers
  https://fosstodon.org/@kernellogger/109697090093536263

But "change from outsider, bad!" and "we've driven too many developers away to
maintain the existing code" only conflict if you think that a shrinking clique
circling the wagons is a problem I guess. (I admit to bias on this one...)

> I will also continue reviewing old patches from the mailing list, I already
> assembled a list of older patches many of which have not been applied.

Cool, thanks. Some of the branches in Rich's repository have more, and I can dig
through my linux junk drawer here if your backlog runs low. :)

> If possible, the original author of the various J2 patches should post them
> for review.

I believe all the j2-specific kernel patches that weren't authored by me, Rich,
or Jeff have already gone in. Kernel patches from other people in our stacks
were generally saved from this list or lkml in the first place.

In my 6.3 patch stack, 1-6 are from me, 7 was from rich, 8 was Jeff and Rich, 9
is disgusting and shouldn't go in yet (only about 1/3 of that ethernet driver is
relevant), and 10 is a one line yank of an unnecessary config constraint with
explanation (done by Rich I think, we use uio on a nommu board to talk to
bespoke USB 2.0 hardware, among other things; I dunno what the unsupported
mmap() he mentioned would try to do on nommu but assuming it doesn't panic the
kernel we're fine because only a subset of the possible mmap options are _ever_
available on nommu (you can MAP_SHARED but not MAP_PRIVATE on files, anonymous
could theoretically MA_PRIVATE with range registers but I don't think any linux
port supports them?), so mmap not working for this isn't unusual in that context.)

>> > Do you know who authored these patches?
>> 
>> I think some came from Sato-san and the rest from Rich, but I'm not 100% sure?
>> Rich has been the one maintaining them, and Jeff before that.
>> 
>> https://github.com/richfelker/musl-cross-make/commits/master/patches/gcc-5.3.0/0004-j2.diff
>> implies that the patch came from Patrick Oppenlander, who sounds familiar?
>> https://github.com/pattop
> 
> Doesn't ring a bell at the moment.

He's around. He's contributed to toybox and musl and gcc on and off for years:

http://lists.landley.net/pipermail/toybox-landley.net/2017-September/017217.html
https://git.musl-libc.org/cgit/musl/commit/?id=a0d64dccbc8d
https://gcc.gnu.org/legacy-ml/gcc-help/2011-04/msg00067.html

And here's him offering a kernel signed-off-by:

https://lore.kernel.org/all/20200717011234.295692-1-patrick.oppenlander@gmail.com/T/

>> > We should get these merged upstream which should be
>> > easier these days since the FSF has lowered the barriers regarding the copyright assignment.
>> 
>> I'm all for it. Jeff had some more pending todo fixes for the toolchain that he
>> might want to sweep up into such a push.
> 
> Jeff, your turn, please ;-).
> 
>> Me, I want to switch over to llvm but Jeff thinks its optimizer is still
>> terrible for embedded systems. But then I've heard it had some pretty bad
>> regressions 12.0 to, so...
> 
> While SuperH/J2 is not an official LLVM target, there is actually an LLVM toolchain
> for J2, see:
> 
>> https://github.com/francisvm/j2-llvm

Yeah, I know. Alas, work on it stopped when the developer was hired by Apple:

  https://www.linkedin.com/in/francisvm/

That's actually the _second_ superh LLVM port I'm aware of, but we couldn't
convince Renesas to release theirs and it was kinda stale by that point anyway...

There's been some version skew since, but it doesn't look _that_ hard. Just... a
can of worms we've all been to busy with the other plates we're spinning to open.

>> I'm still using 9.4 because when I tried to build 11.2 back in February it went:
>> 
>> sh2eb-linux-muslfdpic/src_gcc/libstdc++-v3/../libgcc/unwind-pe.h:270:25: error:
>> '_Unwind_gnu_Find_got' was not declared in this scope
>>   270 |               result += _Unwind_gnu_Find_got ((_Unwind_Ptr) u);
>> 
>> And I haven't circled around to try to dig up why yet. (I want to bisect the gcc
>> repo to see what commit broke it, but that involves getting the horrific
>> autoconf dependency stack working which went REALLY WEIRD since the last time I
>> looked at it, possibly version skew with debian oldstable package versions. The
>> tarball versions ship cooked ./configure scripts that don't need the full
>> gnu/aaaaaaaaah environment install with automake and everything...)
> 
> GCC for SH itself works fine for me, so I assume an issue with your build environment.

I'm guessing you didn't build libstdc++? Without which you can't build a native
compiler because gcc is now written in C++. (GCC for _sh4_ works fine, including
native compiler. The sh2eb musl config builds the first pass but not the second,
some configuration that's not lining up, probably to do with fdpic given where
it broke. I need to bisect it to find out what the change was...)

> Adrian

Thanks,

Rob
