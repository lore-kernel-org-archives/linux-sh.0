Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D74CBC77B73
	for <linux-sh@archiver.kernel.org>; Fri, 28 Apr 2023 03:10:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344930AbjD1DKm (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Thu, 27 Apr 2023 23:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345277AbjD1DKL (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Thu, 27 Apr 2023 23:10:11 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 931DF5FCE
        for <linux-sh@vger.kernel.org>; Thu, 27 Apr 2023 20:09:03 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-51fcf5d1e44so9057242a12.3
        for <linux-sh@vger.kernel.org>; Thu, 27 Apr 2023 20:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20221208.gappssmtp.com; s=20221208; t=1682651343; x=1685243343;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LPZyzjx3kaqaEQxtJ8BJqv3z62eGfrmK5DxdbZeaX88=;
        b=MeJ/+AaQPQs9M0rFehld1SoxXPM5ZtD8nJ/2oyuq6LcQIQnw29uLuglWW3B182fHMm
         EoMdlfZ1rgeRuu/5Cu6cjQwC7ngMXGE/coBmw5Bit83wjcKNYlPvEFTUGHK+6o8E93gG
         HZ7P3FmRY4IKJAW92HSNhGWsB/cKvPrr0/2p1HDvv7eDrl+vKzOVEdg4zzF6hbmta/Tg
         B3R48vEV6bubRtAY/pe+hQ4p7TOG6VN5XnqspAR5wHLbV5L9IV7TcXodmVselFANhWjy
         mzOQZUQ4vPfGMfvCb75bT+EOi2BMXPEPCTzl6Hgbp3/IA5Kxl1RC9pQEN4FFZcGQlDfn
         Oaxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682651343; x=1685243343;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LPZyzjx3kaqaEQxtJ8BJqv3z62eGfrmK5DxdbZeaX88=;
        b=cFA+YEQOfFwqlrqUVPzbgPAo8FYW28IJBbEc3TjNQF9yBUOixDKbXc2kuYBi7fVouO
         AK3VKph47qv80Jgv3ZU6h58abCW99Wb840T8tz2cycrEqLgA8rs9IoeIhwYkepOstcsv
         RchohRO8cNuLZNV2vAB9zE56OSwk0dZ2guYtgI14X8kYI4N1JABYm0L+xv1hZ9SjfZZM
         uGzDb7ZoLZECTnJA6lO4vEEyUBdDkub1a8YK9PuUZARFaPXxQftIiY+1llitQ7e1q94e
         IuiaUoESwUs/zjmXDn+wu4lHBVWN7b0b+690FoBpiHJpYLc5+8W6B7M39gX0WoxaSm8y
         LZjA==
X-Gm-Message-State: AC+VfDxCMI/MCVpyg1TUiROaiY+p2gK2MxnqZcJHptBie3BPSrw54fMm
        V/f7ks64BJVo+kTS9IjzD3rpMhrSiC7SitW1ZfQIbg==
X-Google-Smtp-Source: ACHHUZ6wRKKafYcr52GWeeAWFNn8BxDWbaw9k12lBL5wlRwJgtpaKh0fJfcsWlsQ3aNBoUlKVr4Y7Q==
X-Received: by 2002:a17:903:124a:b0:1a9:bdf3:d0a6 with SMTP id u10-20020a170903124a00b001a9bdf3d0a6mr2568278plh.46.1682651342827;
        Thu, 27 Apr 2023 20:09:02 -0700 (PDT)
Received: from [192.168.33.147] (124-110-25-102.east.xps.vectant.ne.jp. [124.110.25.102])
        by smtp.gmail.com with ESMTPSA id bh8-20020a170902a98800b001a641ea111fsm12291381plb.112.2023.04.27.20.09.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Apr 2023 20:09:02 -0700 (PDT)
Message-ID: <8e62f0ee-942e-be0d-c16d-d3fe1e3a7cae@landley.net>
Date:   Thu, 27 Apr 2023 22:24:34 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] Fix J-core aic warning spam
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
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
 <CAMuHMdVoH+V4hL_D=4YuoBFq3MYm==X1if3mXyAZdWy5un+Ufw@mail.gmail.com>
From:   Rob Landley <rob@landley.net>
In-Reply-To: <CAMuHMdVoH+V4hL_D=4YuoBFq3MYm==X1if3mXyAZdWy5un+Ufw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org



On 4/19/23 06:53, Geert Uytterhoeven wrote:
> On Wed, Apr 19, 2023 at 12:25 PM John Paul Adrian Glaubitz
> <glaubitz@physik.fu-berlin.de> wrote:
>> I just wanted to perform a test build of the J2 kernel, but I'm getting lots of error messages
>> from the assembler about unknown opcodes when trying to build j2_defconfig.
> 
> Looks like upstream gcc does not support -mj2, and thus the build fails
> with "unknown opcode" due to the use of "cas.l".
> Disabling CONFIG_SMP in j2_defconfig fixes/works around that.

Sorry I fell behind, busy week, catching up...

> Just checked with Arnd on IRC, who says opcodes/sh-opc.h was last updated
> in a meaningful way back in 2005...

The gcc developers still wanted physical copyright assignment signatures on
paper when we were submitting the j2 stuff upstream, and we had trouble getting
those from multiple developers on 3 continents, so appeasing them went on the
todo heap.

The kernel should build without the -mj2? (Or at least used to? Commit
f208b87b48d5 was tested at the time?) The j2 instruction set is mostly sh2 with
a couple backported instructions from sh3 (more efficient bit shifts), and it'll
work fine with the old sh2 versions (just less efficiently).

The other new instruction is cmpxchg (ala cas.l), but I thought we'd hardwired
the literal hex bytes into the kernel build so you didn't need the toolchain to
know about the new instruction? (It was only used directly in two places.) It's
quite possible somebody went "ew, don't do that" and thus it was "improved" not
to work with generally available toolchains. (I've only tested with the j2
toolchain in forever...)

In theory a single processor j2 build won't use cmpxchg, and should run on the
hardware just fine...

Rob
