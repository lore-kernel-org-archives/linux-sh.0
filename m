Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 672C8C433FE
	for <linux-sh@archiver.kernel.org>; Wed, 19 Jan 2022 06:43:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351852AbiASGnr (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 19 Jan 2022 01:43:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351197AbiASGnq (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 19 Jan 2022 01:43:46 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C48C061574
        for <linux-sh@vger.kernel.org>; Tue, 18 Jan 2022 22:43:46 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id s9so2651438oib.11
        for <linux-sh@vger.kernel.org>; Tue, 18 Jan 2022 22:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nlADXUPmf1p29hxfuQFR/41tOJcuPHQGrqfut/EWDCE=;
        b=iD3cE3TUoZKiv6Lpwe/PHpT6IT6k13YZlvQ5PnaRX8ro6cTZ876TkP7cBfungccMCH
         j2sHA+X8YbJOPst4lMVd1Bd5tZKMiTK8uE7uyA5oBuje5zVB7wDr2RnSdNrsRwfZ2kws
         1wYNNVob3Nc6TIeTch9AtVd+xkddlZidqYFhCGCVLC4rMJ/o7aD6mIMHO2ql9GNIBKYy
         40/7IFPQeu+OzFltefAKgYeHLyMDD0LfHSC0yjoceklvd6Sb0Sv3AjCYsJafLia+9Lb3
         zYsFPioU0BmateqYQeaD98s9g8nvgkX9ZtjyzvWwsr7LxuOhVwQL+Dtja0YtRPC3ukrf
         oiFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nlADXUPmf1p29hxfuQFR/41tOJcuPHQGrqfut/EWDCE=;
        b=gxpCvWTcqGf6VvkkEe5+Pd+qyi2gsXg34mxyejaybsVZHIxsXGcMqohqQrIxp5E8mJ
         BUjlySl2HdkhWILnBgWn3N2vnIBLbETNXUQrSK3eHBzMvhSBhZtQOm9uhHl1PEViDydT
         ZL4lvlfL5+e11XqOLtGdO0AnyoWVHKajfAFNolchEoBO6q6Q00/OqpZj2fkwmP/x0/cN
         hOb2XkerM6/BjKndtDRJqAWYasKhuYVk8ukP1nVVeeYq9Np0hlLEAsTe8cf0Szfk07u6
         /lk1bD9yNyp9GlcAttF6957JuSZ257Dz3rHRAdNMpMPjThH422C2j0erDNWs71J0wZPm
         +rKA==
X-Gm-Message-State: AOAM5328VsC1rKvFb7GW6e5G2lIbdjWCr42EjDSVPKBx8OXwFnNgl939
        tSN3xFdLtMOP0LAhkmWWMOMxsQ==
X-Google-Smtp-Source: ABdhPJw097En5iDrv7lSMF6MERaDRXcEesMocXtMahw4oQjfm0CJ9T4FjCY7ThsfSX/ojCN9CurxQQ==
X-Received: by 2002:aca:ad15:: with SMTP id w21mr1832090oie.132.1642574614576;
        Tue, 18 Jan 2022 22:43:34 -0800 (PST)
Received: from ?IPv6:2607:fb90:c22a:dc8d:282f:5bff:fe84:bdfc? ([2607:fb90:c22a:dc8d:282f:5bff:fe84:bdfc])
        by smtp.gmail.com with ESMTPSA id t11sm7000585oiw.46.2022.01.18.22.43.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jan 2022 22:43:33 -0800 (PST)
Subject: Re: Fwd: Debian on Linux-SH4
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        =?UTF-8?Q?Robert_=c5=9awi=c4=99cki?= <robert@swiecki.net>
Cc:     linux-sh@vger.kernel.org, debian-superh@lists.debian.org
References: <CAP145pjk471P9pUzhf-rpZiQvjd499i-VpL8iRECDWkSKM_cyA@mail.gmail.com>
 <CAP145pjjyXs40Disg3QhFkkEp8CFXeBCHjn_8Hu=s1cxEjCUQg@mail.gmail.com>
 <c947a46b-7c5e-6ca3-fabe-ce648d9c182c@physik.fu-berlin.de>
 <CAP145pjQJkgHx0AhGvDp9Rg0x0KfN1utxMaehrqp8sWNSR4x0g@mail.gmail.com>
 <985011f6-c0b8-947f-7ebf-6d27c59ba219@physik.fu-berlin.de>
 <CAP145piu0gURojU7TvU7XeDybVczQZDVYqT8th_1f4EcknDF1Q@mail.gmail.com>
 <fa9bdc51-42ee-5eb9-75a3-f46706bcf1a9@physik.fu-berlin.de>
From:   Rob Landley <rob@landley.net>
Message-ID: <f9a1a035-2c19-477b-43e9-234508374864@landley.net>
Date:   Wed, 19 Jan 2022 00:45:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <fa9bdc51-42ee-5eb9-75a3-f46706bcf1a9@physik.fu-berlin.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On 1/11/22 8:55 AM, John Paul Adrian Glaubitz wrote:
>> In the end I had to compile it myself with one of those
>> https://toolchains.bootlin.com/releases_sh-sh4.html and use it with
>> istaller's initrd.
> 
> OK, that is very interesting. We need to figure out what the problem with
> Debian's compiler is what causes the kernel to be non-bootable.
> 
> I have already had a discussion with QEMU upstream and we hadn't come up
> with a solution yet, so your successful boot with QEMU is a very useful
> result.

Using the https://landley.net/toybox/faq.html#cross2 toolchains
and the https://landley.net/toybox/faq.html#mkroot build (which even has sh4 as
its example command line), I got a kernel to boot under qemu-system-sh4 and
another one on my j-core board fairly recently. (Most recent release kernel I
think?)

That's not the full debian kernel config either, though...

Rob
