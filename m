Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB30C77B7E
	for <linux-sh@archiver.kernel.org>; Sun, 30 Apr 2023 03:30:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjD3DaE (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Sat, 29 Apr 2023 23:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjD3DaD (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Sat, 29 Apr 2023 23:30:03 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83360E7F
        for <linux-sh@vger.kernel.org>; Sat, 29 Apr 2023 20:30:01 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id 98e67ed59e1d1-24ded4b33d7so224253a91.3
        for <linux-sh@vger.kernel.org>; Sat, 29 Apr 2023 20:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20221208.gappssmtp.com; s=20221208; t=1682825401; x=1685417401;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UxgYFNuWxok/Z3tDsv9Nz+mxTrJ6nINNaU7kHtdSROo=;
        b=NAc4wADAMGVo7Gm7S54fwH1KsQm4Mid7+Aq/oc1Oup73QWkwUtfOCnCcM2Shfls0mQ
         xcUiEWVa2VlsTF4MZ8gtjd7rNVe2Zz+iyBH7DECKVPTvqVWtrYs/PoQxgOe+4VcrcxFo
         W4atQOCbEdHx7bsGDZXJrukssERcYM0KK/Dr/yRycNUoOhC6KMWorzwPaD3pbYBlHn1C
         jIGFUbfLhr82pvFbvfuhAyxTwMDYemNrc2hWlmQ8R/n+J+5V1dbINVeB6BCbQVK1/zWo
         GMp8a2a5Wk+8v4gZ6hDQ1m5tHvdrnUm8XqxEvrbjOocCgnPqSwi92CiDvWIVPBWOvajQ
         uHlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682825401; x=1685417401;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UxgYFNuWxok/Z3tDsv9Nz+mxTrJ6nINNaU7kHtdSROo=;
        b=kwsnixA2sofjrKpDtz8f4z1RF/769kLuvrSQfeNoCr7CL/tv+kLF8i5/KIEEbCOyhe
         dAUl3BTb/qoKhq6lyRAIJaeg2rdYPt6NHYfqLkEQfeC/iEFXJVhs9bbmC1VLHE/djwXW
         OPFds3yXDaFQX8eI9CD8srYnjedpI+qVuHX1jbeeF+wsYPmgUdove9PnxUk/FjyEogod
         bx3Uv7mYibZdyNSyGZkJctfpKwjmB/is0ZbMDtSJx3fnYcSTjP6ilI26Bb3+fdB5ULUm
         6w/iaaqqDTYm/RoH+KklcR6BLCSl4WDdoqOP/w2PfAr0fT5see4yPhAWdJJ7vNZon13v
         o1qg==
X-Gm-Message-State: AC+VfDyFDod2oDVZMQYbR+2SjgP4xQjeGGaYT8q+ztro3P2cEmLNIG17
        BkAqyuUyr16ONp9eoDjc9Eu+6BJdtWrqxdj3sNJv4xVu
X-Google-Smtp-Source: ACHHUZ6gBLfWQ3wPMvIqbsCm0G/wlN4citNdiLsLWaYmGHqgXZhYnrwKcQtEIpM0KnzBq/qFX8tWBQ==
X-Received: by 2002:a17:90a:c406:b0:23d:1b50:1ebe with SMTP id i6-20020a17090ac40600b0023d1b501ebemr10667228pjt.27.1682825400977;
        Sat, 29 Apr 2023 20:30:00 -0700 (PDT)
Received: from [192.168.33.147] (124-110-25-102.east.xps.vectant.ne.jp. [124.110.25.102])
        by smtp.gmail.com with ESMTPSA id n4-20020a17090a928400b0024c1ac09394sm3754671pjo.19.2023.04.29.20.29.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Apr 2023 20:30:00 -0700 (PDT)
Message-ID: <6c36f97c-e64d-ba50-fd15-48003acdba66@landley.net>
Date:   Sat, 29 Apr 2023 22:45:34 -0500
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
From:   Rob Landley <rob@landley.net>
In-Reply-To: <c72b94655a26cf69ad0ed4ec586cdb062c24ac93.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On 4/29/23 15:07, John Paul Adrian Glaubitz wrote:
> Hi Rob!
> 
> On Wed, 2023-04-19 at 20:24 -0500, Rob Landley wrote:
>> J-core binary toolchain tarball:
>> 
>> https://landley.net/toybox/downloads/binaries/toolchains/latest/sh2eb-linux-muslfdpic-cross.tar.xz
> 
> OK, I can actually build a J2 kernel with that. Are there instructions somewhere which explain
> how to boot such a kernel on a Turtle board? Then I can give it a try on my personal one.

Just copy the vmlinux file to "vmlinux" on the sd card. (It needs an initramfs,
or in theory a built-in kernel command line from kconfig doing the root= thing,
but either way you should get serial output on the usb with something like "sudo
busybox microcom -s 115200 /dev/ttyACM0".)

I built 6.3 with toybox's mkroot.sh and booted it on the board, although that
was with a 10 patch stack in my tree. Only four of which are j-core related: one
is the boot warning spam, of them adds the ugly ethernet driver, one makes uio
work on nommu, and one adds support for a variable clock base because we plugged
in some peripheral hardware that wasn't clocked in base 10 back in
https://landley.net/notes-2020.html#04-11-2020 and... here, lemme just fling it
all up github:

  https://github.com/landley/linux/commits/turtle-v6.3

That's my current stack forwarded ported on top of 6.3. You probably don't need
most of that, but I booted it on the board a few days ago. (Yes, the ethernet
driver is terrible.)

> And do you have a root filesystem available for J2 that I can use?

I mostly use a toybox mkroot build. The easy way to build it yourself is:

  git clone https://github.com/landley/toybox
  cd toybox
  mkroot/mkroot.sh CROSS_COMPILE=/path/to/sh2eb-linux-muslfdpic-
  ls -l root/sh2eb

That bash script is only ~350 lines and reasonably self contained, probably 15
minutes to read through if you're curious. (I keep meaning to put an explainer
video on youtube...)

I can send a cpio.gz if you like, or dig up a busybox one if you'd prefer that?

>> The interesting bits for your purposes are probably:
>> 
>> https://github.com/richfelker/musl-cross-make/blob/master/patches/gcc-9.4.0/0007-j2.diff
>> 
>> https://github.com/richfelker/musl-cross-make/blob/master/patches/binutils-2.33.1/0001-j2.diff
> 
> Do you know who authored these patches?

I think some came from Sato-san and the rest from Rich, but I'm not 100% sure?
Rich has been the one maintaining them, and Jeff before that.

https://github.com/richfelker/musl-cross-make/commits/master/patches/gcc-5.3.0/0004-j2.diff
implies that the patch came from Patrick Oppenlander, who sounds familiar?
https://github.com/pattop

> We should get these merged upstream which should be
> easier these days since the FSF has lowered the barriers regarding the copyright assignment.

I'm all for it. Jeff had some more pending todo fixes for the toolchain that he
might want to sweep up into such a push.

Me, I want to switch over to llvm but Jeff thinks its optimizer is still
terrible for embedded systems. But then I've heard it had some pretty bad
regressions 12.0 to, so...

I'm still using 9.4 because when I tried to build 11.2 back in February it went:

sh2eb-linux-muslfdpic/src_gcc/libstdc++-v3/../libgcc/unwind-pe.h:270:25: error:
'_Unwind_gnu_Find_got' was not declared in this scope
  270 |               result += _Unwind_gnu_Find_got ((_Unwind_Ptr) u);

And I haven't circled around to try to dig up why yet. (I want to bisect the gcc
repo to see what commit broke it, but that involves getting the horrific
autoconf dependency stack working which went REALLY WEIRD since the last time I
looked at it, possibly version skew with debian oldstable package versions. The
tarball versions ship cooked ./configure scripts that don't need the full
gnu/aaaaaaaaah environment install with automake and everything...)

Rob
