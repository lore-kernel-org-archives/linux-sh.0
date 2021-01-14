Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A0AFC433E6
	for <linux-sh@archiver.kernel.org>; Thu, 14 Jan 2021 23:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1078423A5E
	for <linux-sh@archiver.kernel.org>; Thu, 14 Jan 2021 23:10:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730847AbhANXKS (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Thu, 14 Jan 2021 18:10:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730840AbhANXKS (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Thu, 14 Jan 2021 18:10:18 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F20C061757;
        Thu, 14 Jan 2021 15:09:37 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id ga15so10708240ejb.4;
        Thu, 14 Jan 2021 15:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VLCIXId9Ur9EEU+g0ZhcxPqlBXoFwGkEQByEAfvt7pM=;
        b=vcqi2AFNMuHivlPqf62balXOKuMVUeY1LDDZ4fmw8Hnj3tSgqsyBXm7JbDJF9WlPPY
         8bJIm6Ttru3yi691agA+flqNijZxjZb73DiVbR3W1rDlicn5SY0T/u1wnGLhVdhlhusq
         iUDZ9zEiHaVMoNHxfKYLw2zfMNEvElIMBgtsFc0UubmiNgcefy6G100CRGjkC/Onmh7E
         CjaXGFSpX5neYOuFEg9uZCFcuk5tlNK3ZFh7zBff8qbLnavJLnhaCot0fn+g7eT1+kDi
         OBkCWhRl94dCP59/v7lWm1x+W8Jhv/AloiQ2A0eS0Kn6dxP02VJmvd7nNTv1Jp6G4AgO
         AkuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VLCIXId9Ur9EEU+g0ZhcxPqlBXoFwGkEQByEAfvt7pM=;
        b=QdZcfff9KM2PSbbHQjbzwU43s33sINhOIBmWsG57aRdfCz2V9Fhdpthr/jIGFHv5it
         cxTOXbB19Tjgo4O+KmPxlIzuiKlnKp/gVj6HVt4q2eN0gIYTMAPSMf4GoEHbkuBVgmfe
         KulGRqKZ/NwURryRdOWECyQmlrSHs/6CUW7d6/cCMTErwYtuUWkfIwUIPDhpkgpfXQuA
         Ka8l0uAIX2NhhMKsqKHdTa3cgrAyQb5eL4DK4FROXQf0T4dVu9fSxJO6eyTBZPX9Nb9Z
         hIH57yxQlt+mzg7t+DX8JH7cXGoLVnoy5igBdncW469DV5ZUZojlRwe2/EPJKg8PwHdb
         1tPA==
X-Gm-Message-State: AOAM53293loUf7/G4wPFzZtz3F9M6nQ5S70Es/p8i9jEBndIFPzV5zdy
        RZqfEvCiW5W4VpkvM98Em9W+NE/lCwM0Osgked9k5l8IEFU=
X-Google-Smtp-Source: ABdhPJylRuPBI5F/xw1RjkvPX3agtRPjZbW8XqRSubVW2OyOOiBrBkicF/VAeeSVmuQoI3+o0JJeE48HWUCWmjOj0hM=
X-Received: by 2002:a17:906:22c7:: with SMTP id q7mr6812484eja.486.1610665776265;
 Thu, 14 Jan 2021 15:09:36 -0800 (PST)
MIME-Version: 1.0
References: <ef1dc21f-694b-2433-e1c6-aa121320173e@physik.fu-berlin.de>
 <f48bcf43-9dcc-e48b-d29d-f75f3814398b@gmx.net> <cb5a2e11-d423-96ec-3d43-3568a109e37f@physik.fu-berlin.de>
 <CACRpkda4E2NwNw29J7x5gehtqn_m3M_Z2dHpc7xRgvb0b-p22A@mail.gmail.com>
 <1be37673-db0e-f09d-68c8-f929be4019ab@physik.fu-berlin.de> <CAK8P3a1+SdAW8VKnvMdXNVcpR-ykNdPoqLqb59uxzB+jNFJRtg@mail.gmail.com>
In-Reply-To: <CAK8P3a1+SdAW8VKnvMdXNVcpR-ykNdPoqLqb59uxzB+jNFJRtg@mail.gmail.com>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Thu, 14 Jan 2021 15:09:24 -0800
Message-ID: <CAMo8Bf+geJqaaTkwaRyMUZPJgGC1ELXTdnYGq92UNnaaz2CFVg@mail.gmail.com>
Subject: Re: Old platforms: bring out your dead
To:     Arnd Bergmann <arnd@kernel.org>
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

Hi Arnd,

On Thu, Jan 14, 2021 at 1:25 PM Arnd Bergmann <arnd@kernel.org> wrote:
> | arch/mips/Kconfig:config HIGHMEM
> | arch/xtensa/Kconfig:config HIGHMEM
>
> AFAICT On MIPS (prior to MIPS32r3) and xtensa, you have at
> most 512MB in the linear map, so the VMSPLIT_2G or VMSPLIT_4G_4G
> tricks won't work.

Regarding xtensa this was done to minimize difference between
MMUv2 and MMUv3 virtual memory layouts. MMUv2 has been
obsoleted more than 10 years ago, and MMUv3 is much more
flexible and can do e.g. 4GB linear map. The only piece of xtensa
MMUv2 hardware that I have has 96MB of DRAM which fits into
its linear mapping. So maybe it's time to do a cleanup and
rearrange virtual memory layout to eliminate the need of highmem.

> I have no idea who uses xtensa systems with lots of memory on
> modern kernels.

We definitely use it for development internally at Cadence/Tensilica,
mainly on simulators, but also on FPGA boards (e.g. on KC705 we
can use all of the 1GB onboard DRAM).
In the last few years we've had a few support requests for linux on
xtensa cores with MMU, but AFAICT none of them had to deal with
more than 512MB of onboard memory.

-- 
Thanks.
-- Max
