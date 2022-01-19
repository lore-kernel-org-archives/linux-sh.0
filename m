Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C585C433F5
	for <linux-sh@archiver.kernel.org>; Wed, 19 Jan 2022 06:09:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350084AbiASGJt (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 19 Jan 2022 01:09:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234904AbiASGJt (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 19 Jan 2022 01:09:49 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A13DC061574
        for <linux-sh@vger.kernel.org>; Tue, 18 Jan 2022 22:09:49 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id a10-20020a9d260a000000b005991bd6ae3eso1689083otb.11
        for <linux-sh@vger.kernel.org>; Tue, 18 Jan 2022 22:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=43yjm3GBrfxAti0haKpvNlKdelvTPs44VxewE+IQewg=;
        b=w7CQevK1ocTKilzExf3SnKObXDSsx58lt66yfzm6fDXIjfzuCy5YjAY11nLQrZfAlp
         WlT3WL10GoythN0zpCk7uNgIlLHgiJiAgU7czJv/zj9SDQDnTFlAHoAvg1YayUgax3xg
         pVyMNpBui7AEls0FrLisDtF1Un6+qLPuggfP1vo+6LvP6NHoHH0AF1nzTB1QLI2/f5jT
         Ru7+JoLa4CL81FJIV2WQP1bz+5PlvqNfSiQRdbTdAaPLWAo8tw4OiBJCt4tOMOne+af8
         0gJ926wFOYOlfiHlj0qaArJrhhDJ9UVvR4Pw1mH0RTJfOpXoR4fUfHHiHe9VdM0J2jtz
         Pj7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=43yjm3GBrfxAti0haKpvNlKdelvTPs44VxewE+IQewg=;
        b=EHUoHamFrFZrh8L76uGefww/xaxgB1NnZTf/kZai2N/QDwxhU5PX2aLMq1xwU4551V
         hlpRQ+L7TKu8iJZPRSsv13+A/nHN/msSWJj+Fp6KWlN9d1YgXy+W1hi1v4m4eMRhzlIa
         a6DLdggkgAdnY99BjyPH6TP7SUwnUtt5gufexc9kmYERrjSXvGxg6ZlfCfrfPuf7axh9
         cT5iA4NIz/hTBDu4yaddbDjIpwz1DEGBDUWgDxC+tcINbfbRCUn+bE7qEWesSg7vkX7R
         HM8a2btsAFO3avD1KuzsIurAHr8N3119Ycywb6YBhH/sQN/mUnHszlJVt22j5VnoztTr
         TU8A==
X-Gm-Message-State: AOAM531OlmVSDW3D8kceSYx0dmWV0ZZaiaeRy1JuFbOAPZK7hDLNApR6
        6FAOhXkKM00sNDSgR/sMTsmdc1AXtoSmGvQZ
X-Google-Smtp-Source: ABdhPJwFbV74gNyHoCqPgb6yQEvcst0OtXOE+uZX2uLzQALrl5qaR4mO8F/ufnym8x7MeYNXpMvoDg==
X-Received: by 2002:a9d:2ed:: with SMTP id 100mr20164142otl.352.1642572588399;
        Tue, 18 Jan 2022 22:09:48 -0800 (PST)
Received: from ?IPv6:2607:fb90:c22a:dc8d:282f:5bff:fe84:bdfc? ([2607:fb90:c22a:dc8d:282f:5bff:fe84:bdfc])
        by smtp.gmail.com with ESMTPSA id 186sm9451106oig.28.2022.01.18.22.09.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jan 2022 22:09:47 -0800 (PST)
Subject: Re: Fwd: Debian on Linux-SH4
To:     =?UTF-8?Q?Robert_=c5=9awi=c4=99cki?= <robert@swiecki.net>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     linux-sh@vger.kernel.org, debian-superh@lists.debian.org
References: <CAP145pjk471P9pUzhf-rpZiQvjd499i-VpL8iRECDWkSKM_cyA@mail.gmail.com>
 <CAP145pjjyXs40Disg3QhFkkEp8CFXeBCHjn_8Hu=s1cxEjCUQg@mail.gmail.com>
 <c947a46b-7c5e-6ca3-fabe-ce648d9c182c@physik.fu-berlin.de>
 <CAP145pjQJkgHx0AhGvDp9Rg0x0KfN1utxMaehrqp8sWNSR4x0g@mail.gmail.com>
From:   Rob Landley <rob@landley.net>
Message-ID: <4a7eb3fc-32d8-be06-7932-1423371b7a76@landley.net>
Date:   Wed, 19 Jan 2022 00:11:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAP145pjQJkgHx0AhGvDp9Rg0x0KfN1utxMaehrqp8sWNSR4x0g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On 1/11/22 5:41 AM, Robert Święcki wrote:
>> Then run "./debootstrap/debootstrap --second-stage" on the target system.
>>
>> If your qemu-user is properly set up to use binfmt (which is currently not the case on my
>> system), you can omit the "--foreign" option and get a ready-to-boot chroot for Debian sh4.
> 
> Thanks, I guess I did it the hard way then (through the debian-installer) :)

I have a todo item to create a musl-based debian image for sh4. Do either of you
have an idea what the procedure for that might look like? :)

I've got sh4 musl cross and native compilers built from musl-cross-make, and
have built a bootable kernel and toybox-based initramfs for sh4
(https://landley.net/toybox/downloads/binaries/mkroot/latest/sh4.tgz) but don't
really know what to do about the debian parts of it. (debootstrap is all about
installing prebuilt binary packages...)

Rob
