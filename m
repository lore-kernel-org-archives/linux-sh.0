Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2802C43381
	for <linux-sh@archiver.kernel.org>; Fri, 12 Mar 2021 09:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9EAA64FD9
	for <linux-sh@archiver.kernel.org>; Fri, 12 Mar 2021 09:16:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232623AbhCLJPV (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Fri, 12 Mar 2021 04:15:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232375AbhCLJPD (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Fri, 12 Mar 2021 04:15:03 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA562C061761
        for <linux-sh@vger.kernel.org>; Fri, 12 Mar 2021 01:15:02 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id j3so6923106edp.11
        for <linux-sh@vger.kernel.org>; Fri, 12 Mar 2021 01:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Vr0Lv80xX3Xl1L8m7N3BWIS/MyIzX8iL/K8kW4thpIU=;
        b=CqF/Vmp9d1IQSuSoyVR1p1PonzxnRC7YVWCuT73D3c7/UoVTQwfy4d3lTqaj04mPUQ
         w6sDy8AQC/jxvaSTTu0yKndZ7nBoRAi41EFLCvhlDfC8iVzFOPC/8fvKvRQIeAiQgh5V
         KRZ+w8tWAPqNUkdW2da/uoIpNh1yN0K7orKRo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Vr0Lv80xX3Xl1L8m7N3BWIS/MyIzX8iL/K8kW4thpIU=;
        b=Zj0gMLawUfNx9kjiGqsgJ+BCg98MEanD9ekOWj8NVotkeuYg29v7TPUEo5GcI/R/zV
         /mO4w1cZf+BO/8fI24NpbwwoDgGJROSJACdb4ANZgjC84OXN7qY0n5HoNLOktbw4URIQ
         wxsx8U2yMmiRsUmTcMg5NqpiZ79NTZYGto2QicU2CXP/cfcpFqUayjTIfK7h/7s0zM1y
         A48xPLoKZxpJNLteCT/TzK56KR9JzHX9Zear+t+9vxm+1zbS1CCWvSTQPiEWQEAfAWoV
         xc/VzLagoVBr/R2Q8bJAQdyJYG5S6qYNHHEXzRwIlyU0m21hT5hpJ7xY6X7uRD8UKGz2
         WG6g==
X-Gm-Message-State: AOAM5329vt6kMA0NH2ZR0c4ciNFl4fpRQyLrTlJX8eF4wYQiu/OpQNkH
        h0i6g0VCxPBEQxznThcvtN6fYg==
X-Google-Smtp-Source: ABdhPJzojpw5MISuvwhn5uCj+GlJAixi2DNi1NCX+H/oDGcpqgnrVUfFvP7Bn2/KE8Wd2h5/no6lTw==
X-Received: by 2002:a05:6402:57:: with SMTP id f23mr12757182edu.323.1615540501369;
        Fri, 12 Mar 2021 01:15:01 -0800 (PST)
Received: from [192.168.1.149] ([80.208.71.248])
        by smtp.gmail.com with ESMTPSA id rs24sm2493668ejb.75.2021.03.12.01.15.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Mar 2021 01:15:01 -0800 (PST)
Subject: Re: [PATCH 14/14] MAINTAINERS: Add entry for the bitmap API
To:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-arch@vger.kernel.org, linux-sh@vger.kernel.org,
        Alexey Klimov <aklimov@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, David Sterba <dsterba@suse.com>,
        Dennis Zhou <dennis@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jianpeng Ma <jianpeng.ma@intel.com>,
        Joe Perches <joe@perches.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Rich Felker <dalias@libc.org>,
        Stefano Brivio <sbrivio@redhat.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
References: <20210218040512.709186-1-yury.norov@gmail.com>
 <20210218040512.709186-15-yury.norov@gmail.com>
 <YC6HoF2lhSlrYs3j@smile.fi.intel.com> <20210218153424.GA701246@yury-ThinkPad>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <d677abac-ad3e-7483-b808-4b826d3afd66@rasmusvillemoes.dk>
Date:   Fri, 12 Mar 2021 10:15:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210218153424.GA701246@yury-ThinkPad>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On 18/02/2021 16.34, Yury Norov wrote:
> On Thu, Feb 18, 2021 at 05:28:32PM +0200, Andy Shevchenko wrote:
>> On Wed, Feb 17, 2021 at 08:05:12PM -0800, Yury Norov wrote:
>>> Add myself as maintainer for bitmap API.
>>>
>>> I'm an author of current implementation of lib/find_bit and an
>>> active contributor to lib/bitmap. It was spotted that there's no
>>> maintainer for bitmap API. I'm willing to maintain it.
>>
>> Perhaps reviewers as well, like Rasmus, if he is okay with that, of course?
> 
> I'll be happy if you and Rasmus join the team. :) Guys, just let me
> know and I'll update the patch.
>  
>> Otherwise, why not?
>> Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Sure, you can add my name/email as an R: line (or whatever means
reviewer), and consider this patch (with or without that addition) acked.

Rasmus
