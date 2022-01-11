Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56FE0C433F5
	for <linux-sh@archiver.kernel.org>; Tue, 11 Jan 2022 14:57:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238388AbiAKO5r (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 11 Jan 2022 09:57:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243153AbiAKO5r (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 11 Jan 2022 09:57:47 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C9BC061751
        for <linux-sh@vger.kernel.org>; Tue, 11 Jan 2022 06:57:46 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id t4-20020a05683022e400b00591aaf48277so506444otc.13
        for <linux-sh@vger.kernel.org>; Tue, 11 Jan 2022 06:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=swiecki.net; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yxb/0HAFtAIhNZ0950F61QnsBf1oimyUpF6INGZmO84=;
        b=VxynJSPUVy8+/WMxGISOaDuZ2kErU9GxeXhkZRYTQoiFuWTFszgOzDcmJ2glV1pu7U
         SFhA0RskgkeTyA/G9CrHjP9a2Bem4D4uJwRHn5L2R8mThlXuz/5lNcMxD8QDXcrwq5+w
         Z/iFgsxFPjhPceHiqyBkB/nGtYmRh2ADrm96Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yxb/0HAFtAIhNZ0950F61QnsBf1oimyUpF6INGZmO84=;
        b=M6HQMDz8VkjLgQx3xYrw/CaYTqusUgCcNJ7LKUdH2jHjb+B5nwGt8NBpWI6ov0GHjr
         lRMu1iymVugR0amk15pDNfoOzJkbVQCsX412FXrJFBnADZ2jHNqSNE+wUOTLgZ/I31Pt
         ZYOrfL+DVoLEvnQmrsWxPbXznqlhOzOKshyLTv4/3Iz3a/LcLOMwzpec5rFiWW6kjC+x
         C8deJT5aEof+le25GmxGaErNGjC1sW/UIAXVLwhgkqfPb/nfG7xyMSh+zohcRkAh3e9U
         UKJkPDAQW2JC6ojPrNo7Ybgt4l0xloF36j+v6C5TpTGpF9cp9NQ5McHg4Z8cmBvgCmOJ
         32Cg==
X-Gm-Message-State: AOAM532b6swUZ2JOjk1kqpJPA1upAhVQrVjYSQmGhV1zeSJlHFPcV6//
        1W/ijOQzbM9BMSOooAoZGx5TJfRnUX4IJ9Q5u4DgNUToBYLAgQ==
X-Google-Smtp-Source: ABdhPJwZvxMa8nowD6sxHPUiX+6E/KQAcHIXh9FG/RCM9gBXtkkYWp6pdCYzbdXHmQd8ore6NNP9txr5mOaja0nVflE=
X-Received: by 2002:a05:6830:914:: with SMTP id v20mr3508080ott.62.1641913066023;
 Tue, 11 Jan 2022 06:57:46 -0800 (PST)
MIME-Version: 1.0
References: <CAP145pjk471P9pUzhf-rpZiQvjd499i-VpL8iRECDWkSKM_cyA@mail.gmail.com>
 <CAP145pjjyXs40Disg3QhFkkEp8CFXeBCHjn_8Hu=s1cxEjCUQg@mail.gmail.com>
 <c947a46b-7c5e-6ca3-fabe-ce648d9c182c@physik.fu-berlin.de>
 <CAP145pjQJkgHx0AhGvDp9Rg0x0KfN1utxMaehrqp8sWNSR4x0g@mail.gmail.com>
 <985011f6-c0b8-947f-7ebf-6d27c59ba219@physik.fu-berlin.de>
 <CAP145piu0gURojU7TvU7XeDybVczQZDVYqT8th_1f4EcknDF1Q@mail.gmail.com> <fa9bdc51-42ee-5eb9-75a3-f46706bcf1a9@physik.fu-berlin.de>
In-Reply-To: <fa9bdc51-42ee-5eb9-75a3-f46706bcf1a9@physik.fu-berlin.de>
From:   =?UTF-8?B?Um9iZXJ0IMWad2nEmWNraQ==?= <robert@swiecki.net>
Date:   Tue, 11 Jan 2022 15:57:35 +0100
Message-ID: <CAP145piHFa=MLfXACWZcU3-1BP3o+Wf_AwawDV55kbFGxQm3Xg@mail.gmail.com>
Subject: Re: Fwd: Debian on Linux-SH4
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     linux-sh@vger.kernel.org, debian-superh@lists.debian.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

> > [    0.000000] Linux version 5.15.0 (jagger@jd)
> > (sh4-buildroot-linux-gnu-gcc.br_real (Buildroot 2017.05) 5.4.0, GNU ld
> > (GNU Binutils) 2.27) #37 Tue Jan 11 12:58:34 CET 2022
>
> Thanks for the information.
>
> If you can find out anything else on the kernel/GCC issue that would be much
> appreciated. I have been quite stuck on this issue in the past although it
> works on real hardware.

I just compiled with buildroot's newest gcc and it works as well. I'll
do some builds with debian's cross-toolchain of vmlinux and see
whether I can spot anything obvious between those two.

[    0.000000] Linux version 5.15.0 (jagger@jd)
(sh4-buildroot-linux-gnu-gcc.br_real (Buildroot
toolchains.bootlin.com-2021.11-1) 10.3.0, GNU ld (GNU Binutils)
2.36.1) #38 Tue Jan 11 15:54:50 CET 2022
