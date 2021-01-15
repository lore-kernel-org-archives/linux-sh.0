Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA5BC433E6
	for <linux-sh@archiver.kernel.org>; Fri, 15 Jan 2021 08:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E88A22C7D
	for <linux-sh@archiver.kernel.org>; Fri, 15 Jan 2021 08:32:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729822AbhAOIcw (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Fri, 15 Jan 2021 03:32:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:57128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726439AbhAOIcw (ORCPT <rfc822;linux-sh@vger.kernel.org>);
        Fri, 15 Jan 2021 03:32:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A1A3E22C7D;
        Fri, 15 Jan 2021 08:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610699530;
        bh=l+vS3UHXXMrTJUBoLO6zBmJwtTma5Au1XHnUzyN4zW4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mTMCN0X3oCQgUbwZMAHO0vL3f6cxtUsRT65kSyGPT+GXs3QkYrfXawcTRCWViqOZO
         1LdEl4aYVgSnElv5L+bIM1numvEjmB34RIgsXX5XpGlM6TvImsWwkRn3GVRcuLSkpH
         /2ds2Ev+bEJPiooSiogiv7dTfiVla3XwoXFDgdqcmB3zcdKkRJE0SPK1CXkkA7YbDw
         P9lfMRsGOuF7A5J0sfUWSVEj/qZXg9zM1WPb6lvqM8BOYNQ62vEUpXpInb7aLdCyth
         9g4wDW7hUH8X2JZ5earEN2Q9UsTEuo2IdJSeJ9Te8t7xm4uI/7uz5WGNC1LuLsr06F
         teb1dmHfxHYRQ==
Received: by mail-ot1-f46.google.com with SMTP id o11so7845944ote.4;
        Fri, 15 Jan 2021 00:32:10 -0800 (PST)
X-Gm-Message-State: AOAM53394MTcbjWV5CuCGt2Byh40TZMxFgoLBluQio0McZ4jy43Q3Y0B
        vsyD0mDl81J5j/7K9QxQL+4dQ8Lp9CiLCvYcVNU=
X-Google-Smtp-Source: ABdhPJyAZ9w6n+VSogM+tjnZEM6qr0MpVtvpDIkaBLigf9jGDThlrmNDUxXZPg7dZ6Yqzz7x4XxQ8NocTkgvdDdGixg=
X-Received: by 2002:a9d:7a4b:: with SMTP id z11mr7509680otm.305.1610699529936;
 Fri, 15 Jan 2021 00:32:09 -0800 (PST)
MIME-Version: 1.0
References: <ef1dc21f-694b-2433-e1c6-aa121320173e@physik.fu-berlin.de>
 <f48bcf43-9dcc-e48b-d29d-f75f3814398b@gmx.net> <cb5a2e11-d423-96ec-3d43-3568a109e37f@physik.fu-berlin.de>
 <CACRpkda4E2NwNw29J7x5gehtqn_m3M_Z2dHpc7xRgvb0b-p22A@mail.gmail.com>
 <1be37673-db0e-f09d-68c8-f929be4019ab@physik.fu-berlin.de>
 <CAK8P3a1+SdAW8VKnvMdXNVcpR-ykNdPoqLqb59uxzB+jNFJRtg@mail.gmail.com> <CAMo8Bf+geJqaaTkwaRyMUZPJgGC1ELXTdnYGq92UNnaaz2CFVg@mail.gmail.com>
In-Reply-To: <CAMo8Bf+geJqaaTkwaRyMUZPJgGC1ELXTdnYGq92UNnaaz2CFVg@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 15 Jan 2021 09:31:53 +0100
X-Gmail-Original-Message-ID: <CAK8P3a16dta82GOVZCcMgFokB4Mo6y6Vje=+5gUH-t-1ATQYUw@mail.gmail.com>
Message-ID: <CAK8P3a16dta82GOVZCcMgFokB4Mo6y6Vje=+5gUH-t-1ATQYUw@mail.gmail.com>
Subject: Re: Old platforms: bring out your dead
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Gerhard Pircher <gerhard_pircher@gmx.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Sparc kernel list <sparclinux@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Fri, Jan 15, 2021 at 12:09 AM Max Filippov <jcmvbkbc@gmail.com> wrote:
> On Thu, Jan 14, 2021 at 1:25 PM Arnd Bergmann <arnd@kernel.org> wrote:
> > | arch/mips/Kconfig:config HIGHMEM
> > | arch/xtensa/Kconfig:config HIGHMEM
> >
> > AFAICT On MIPS (prior to MIPS32r3) and xtensa, you have at
> > most 512MB in the linear map, so the VMSPLIT_2G or VMSPLIT_4G_4G
> > tricks won't work.
>
> Regarding xtensa this was done to minimize difference between
> MMUv2 and MMUv3 virtual memory layouts. MMUv2 has been
> obsoleted more than 10 years ago, and MMUv3 is much more
> flexible and can do e.g. 4GB linear map. The only piece of xtensa
> MMUv2 hardware that I have has 96MB of DRAM which fits into
> its linear mapping. So maybe it's time to do a cleanup and
> rearrange virtual memory layout to eliminate the need of highmem.

Yes, I think that sounds like a useful preparation for the future.

> > I have no idea who uses xtensa systems with lots of memory on
> > modern kernels.
>
> We definitely use it for development internally at Cadence/Tensilica,
> mainly on simulators, but also on FPGA boards (e.g. on KC705 we
> can use all of the 1GB onboard DRAM).
> In the last few years we've had a few support requests for linux on
> xtensa cores with MMU, but AFAICT none of them had to deal with
> more than 512MB of onboard memory.

If 1GB of RAM is a useful upper bound on MMUv3, the easiest way is
probably to hardcode the CONFIG_VMSPLIT_3G_OPT behavior
from x86 and ARM, using 2.75GB of user addresses (TASK_SIZE),
and 1.25 GB that gets split between linear map and vmalloc space,
but no uncached linear map and ioremap() pointing into vmalloc
instead. If you want to be prepared for machines with 2GB of linear
lowmem, you could do the same with VMSPLIT_2G_OPT
(TASK_SIZE == 0x70000000).

      Arnd
