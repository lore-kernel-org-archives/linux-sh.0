Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E87FC433E9
	for <linux-sh@archiver.kernel.org>; Wed, 13 Jan 2021 07:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B7A823120
	for <linux-sh@archiver.kernel.org>; Wed, 13 Jan 2021 07:57:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbhAMH5X (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 13 Jan 2021 02:57:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725771AbhAMH5T (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 13 Jan 2021 02:57:19 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F1A3C061795
        for <linux-sh@vger.kernel.org>; Tue, 12 Jan 2021 23:56:39 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id d8so1101710otq.6
        for <linux-sh@vger.kernel.org>; Tue, 12 Jan 2021 23:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ec28dkZfiPR2/1UzgIn1V3mHVSsLfVvyjnzQVtQycbU=;
        b=UBsuwooO0Or2Jw4qG9UiZJgUA9AMQKLfEv7NYsNeJOBOi16eIWl0+9QvoeV1v6ENAI
         PJP1yC7CC1oLFtVy3CsQLkKDl3NWjT5hSLtj47T6iyZYo9380taDPwDLgm1+MT+gHepH
         oVcMU4mqcTLhmBpXXKcQI59zebZR+sZDyXJA1wC4uU8QF/7x1RQCRH5eBrRuLxgm7Fe1
         oMI3AjiJ6vRiS5dyPdfXHdv3QVf3MwLFttXnCnjEb9c0M6V4p+djw/NQJeAWW2CkuqPr
         RDbZbyukIzhhZjsAOei3va+MQhTMG1y+byBej6upyxf7sxZwYjxK5iQCNTxbN2b4hAza
         Yc5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ec28dkZfiPR2/1UzgIn1V3mHVSsLfVvyjnzQVtQycbU=;
        b=SfGHiXnVKPCa8+k7107VwYUSkB8R51P7wzsw3wkOWVCMhbtTY1HKF7sTtIp8SkwJV6
         vSSaRbr/hz3VTitGLQ0LVyACGATzpKgL8UAeDkeDHziqw5cCsXlfH9+lndq9awuFzJ6W
         8FBXkn6u3AMTxcXUrY9AxJS6ih1ZVhVWFwJvUCt2fCQxDgd9x0VhpXbo1m6ncDDHoziB
         Ga1DhfgCufL1RVqN1iMsg5cVHYOS18Vwrx8Dwf34wPW/hWYICPtepqJ4tfbfEJpBwfyx
         dwE/3v7ff2LQAGJ6qBQuY0sFB5Ws68/y0Zp7QKY/zKD5Sja3D22OQEBUarxvl3GDGRyr
         tKiw==
X-Gm-Message-State: AOAM533vHUegRsnrx2eEgquTJUEuZ1k/PMYbL2Omko9/jmgjt4OgvFKM
        oN6mE+h5iAhJd4R328RQqhVSJJsmZsdFSuGA
X-Google-Smtp-Source: ABdhPJwWkGelcpd7joBM389H0X2SKZrVtsqITDAljmIuoohMLUBscMYPkCGJ4UfQeOFE3CxsYHFxPg==
X-Received: by 2002:a05:6830:578:: with SMTP id f24mr441323otc.7.1610524597836;
        Tue, 12 Jan 2021 23:56:37 -0800 (PST)
Received: from [192.168.86.73] ([136.62.4.88])
        by smtp.gmail.com with ESMTPSA id v3sm280249ool.16.2021.01.12.23.56.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jan 2021 23:56:37 -0800 (PST)
Subject: Re: Old platforms: bring out your dead
To:     Linus Walleij <linus.walleij@linaro.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
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
From:   Rob Landley <rob@landley.net>
Message-ID: <b8eb1c83-d2f8-1c72-ca67-4160b90b3845@landley.net>
Date:   Wed, 13 Jan 2021 02:09:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CACRpkda4E2NwNw29J7x5gehtqn_m3M_Z2dHpc7xRgvb0b-p22A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On 1/12/21 4:46 PM, Linus Walleij wrote:
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

Another fun aspect of old hardware is it serves as prior art for patents. The
j-core hardware implementation schedule has in part been driven by specific
patents expiring, as in "we can't do $FEATURE until $DATE".

It's much easier to nip a patent suit in the bud if you can go "here is
functionally equivalent hardware from the past, dates the specifications were
published, and the specific patents on the technology which have now expired".

We're a little overscheduled and not always _prompt_ about it, but for example
the reason we couldn't do full 6-wire sd 1.0 in the first j-core SOC release
(and had to implement a painfully slow mmc bus instead) is the patents hadn't
expired yet.

> That said there are a three things that people should really be doing if they
> want to keep their pet archs/subarchs around as good community
> members, and they are in essence to:
> 
> 1. Test and review/ack patches that others make

I'm trying. :)

> 2. Migrate existing drivers to newly appeared and
>     appropriate subsystems (I think there are some hacky heartbeat LED
>     drivers down in arch/* for example) there is also the feature matrix
>     core maintainers like and which appears if you type
>     Documentation/features/list-arch.sh <archname>
>     would be nice if you work on them if you can support them!
>     Or at least take a look.

For 3 years in the 1990's SuperH was the best-selling processor in the world,
and that's left the architecture with a bunch of legacy boards that aren't
easily available to us. I regression test a current kernel build under qemu
every month or two, and have portable USB-powered boards for the j-core stuff.

When I did an sh4 porting contract in 2018 I got that board updated to a
current-ish kernel (3 versions back from then-current it hit some intermittent
nor flash filesystem corruption that only occurred intermittently under
sustained load; had to ship so I backed off one version and never tracked it
down). But these days I'm not always on the same continent as my two actual sh4
hardware boards, have never gotten my physical sh2 board to boot, and $DAYJOB is
all j-core stuff not sh4.

Testing that a basic superh system still builds and boots under qemu and j-core
I can commit to doing regularly. Testing specific hardware devices on boards I
don't regularly use is a lot harder.

> 3. Migrate old systems to use the
>    contemporary hardware descriptions (such as device tree or ACPI)
>    because it makes things so much easier to maintain. Some
>    upfront work, but a great win for everyone. Especially for
>    subsystem maintainers.

We did that one for our SOC. We haven't ported a lot of legacy boards because we
can't easily test most of them.

> And if your arch uses highmem then please get rid of highmem. I'm
> trying to do this a bit right now for ARM let's see how it goes.

I don't believe it does? (We haven't got any configs using it, anyway...)

> I understand that for some maintainers time is a factor and this list
> feels stressful. I'd say relax, but it'd be nice if you have a TODO that
> you cross items off of.

My todo list runneth over. One of our perpetual todo list items is "collate todo
lists"...

> Just my €0.01
> Linus Walleij

Rob
