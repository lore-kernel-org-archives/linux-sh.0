Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 426BEC433E0
	for <linux-sh@archiver.kernel.org>; Wed, 13 Jan 2021 11:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECE30233F8
	for <linux-sh@archiver.kernel.org>; Wed, 13 Jan 2021 11:49:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbhAMLsv (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 13 Jan 2021 06:48:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726733AbhAMLsu (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 13 Jan 2021 06:48:50 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BEF9C061786;
        Wed, 13 Jan 2021 03:48:10 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id h10so1056712pfo.9;
        Wed, 13 Jan 2021 03:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ghOdi+UAykLWD4vvRom8GW+W7X9kkjSm+M80at4v8cs=;
        b=E5C1M14oZgTKM2epjMHwhjKy+MHxWijtl5C986W/OvklnLgQladKjF2HzoEanl1JcJ
         tj79m3FRoXJJKIER62qytSoQMmT4Rv90kesljEram0gRlS3bUwAoMzghZawp7Y2jyVN+
         Q/6YhoF+b76l50McygrRdLCXb3ei5VVlBhaWgwHQY9JJtqzGyJEVJfiXNkB4NokstuwL
         KlNAl4RGSU5+zYgacKW3ACLhLDuzIONmsTQOMg1o/7Hc7HUmAuLB3/7s2PnOs8DQVjdl
         XH1sW2x/lrBQ16QcgynRxXa/YTFcLeWwNAIQ6mJZGjR6c779t5f2E6XN01op6Idn2nvv
         IFGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ghOdi+UAykLWD4vvRom8GW+W7X9kkjSm+M80at4v8cs=;
        b=LvQdObpDWVMVMa9SerYLHPg1Z1FyBuJV0zoIeKULb+d5Zfy1+xBvFoZbtviR8I4b/I
         TjO075ypSfAQNhbkUAccj1I3iM+ZMvG2Knn/Ydi/GrLiI6nYwzDIT0sr4RZWFToBkTBc
         bYkVoeSYibGh/HLnOOtOHDaNDtQMx1usrjj/JefxCbO4pkKC738lXuZl0tH2z0axeEkq
         3srdqT4HssWdMC99kulOoPwVuxOlEPMtJqvk3esaUOaLzl3kL53E6xbECpLFgqUWEC4I
         q9k/sX6i4i0fLkcjsTq1PPSkMoWrt1rXzZWWfCAmdImneWHd0aq11ahdI6hAZbhtPcU7
         DIYg==
X-Gm-Message-State: AOAM5326SQ8c6LQynlyB8LVSFBphlHIDLEhh69ZDk1zQkU3+tLPomGaj
        a5oIs14YrDfA/NfnEEOcsPxeIbNnKDuw3Ab77zQ=
X-Google-Smtp-Source: ABdhPJxxqm2y6TITyZX2Mnvkyi437G/FIp77NR+L/x6XWFbshuVsNnhIbDyhhIDjngyombexLukFSkP6fKTWlYoztx8=
X-Received: by 2002:a62:19cc:0:b029:19e:321b:a22e with SMTP id
 195-20020a6219cc0000b029019e321ba22emr1781064pfz.73.1610538489892; Wed, 13
 Jan 2021 03:48:09 -0800 (PST)
MIME-Version: 1.0
References: <ef1dc21f-694b-2433-e1c6-aa121320173e@physik.fu-berlin.de>
 <f48bcf43-9dcc-e48b-d29d-f75f3814398b@gmx.net> <cb5a2e11-d423-96ec-3d43-3568a109e37f@physik.fu-berlin.de>
In-Reply-To: <cb5a2e11-d423-96ec-3d43-3568a109e37f@physik.fu-berlin.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 13 Jan 2021 13:47:53 +0200
Message-ID: <CAHp75VdVmCWUeAp1FWCedGGzjzBi7b9GMeeO0Vw8HXT21Bj0eQ@mail.gmail.com>
Subject: Re: Old platforms: bring out your dead
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Gerhard Pircher <gerhard_pircher@gmx.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Sparc kernel list <sparclinux@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Tue, Jan 12, 2021 at 4:47 PM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> On 1/11/21 4:04 PM, Gerhard Pircher wrote:

> There has to be a healthy balance between hobbyist and commercial use. I understand
> that from a commercial point of view, it doesn't make much sense to run Linux
> on a 30-year-old computer.

I have another impression (depending on what you put under "commercial use").
Industrial requirements are to support for 15+ (in some cases 30+)
years for hardware. I'm quite sure they don't want to have completely
outdated software there either.

-- 
With Best Regards,
Andy Shevchenko
