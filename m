Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E77CC433DB
	for <linux-sh@archiver.kernel.org>; Fri,  1 Jan 2021 18:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F34C3221E9
	for <linux-sh@archiver.kernel.org>; Fri,  1 Jan 2021 18:23:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbhAASXU (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Fri, 1 Jan 2021 13:23:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727093AbhAASXU (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Fri, 1 Jan 2021 13:23:20 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E634FC061573
        for <linux-sh@vger.kernel.org>; Fri,  1 Jan 2021 10:22:39 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id c132so3504554pga.3
        for <linux-sh@vger.kernel.org>; Fri, 01 Jan 2021 10:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Nsh4X9W5WN1CD8l2eYKSzJRtwEbLMHELC9+VQB482fI=;
        b=Jm1So86/onCTYb3cOPfBA4TLCvhhXR0nrDycDwuV7JeEVwj4Rwjdbf2IfkbINyNKR2
         G4FWUrqyRkbo7fs3RB8m3KC/uBNqGOAp4yKadCdubCoMlaDKQdv50mZkeUr9W55rfNg7
         2Bxni5OBghlF/kjn8491LU0U+j9mg/vQ8xiLwM5qaFEj8hpN4qzLVdI9F6iR4c4oZa+9
         wpidpwjSWSaBp+jtEJ8gv48bXZHV/MwKtZNgC4JSo0TDfSVwRNdp4VKXkR3egDxvIa7O
         3oD89POdA9zx0DZmqw1r01+6h8us8zgrVSo3GW3HScueQ/TzkvIyXG+ROK1OX8YJhB/z
         REwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Nsh4X9W5WN1CD8l2eYKSzJRtwEbLMHELC9+VQB482fI=;
        b=rlcd3EQtvxHTIVWToDSge9RlJe7AmfsAMkmrmX9NsorvPg4c3sO3EAGJODCRfEz4Zs
         YQV2u9lXXXG1DIXDmWGzM3rDnTR9cyfCSVVxRYXLDKgPzQxwvJ+YtBUfirawMDHUbjmP
         sQZLKJPZ9K00pdomm35EXNUz5Kq2DNH8GWzE2zhGRLCTGzSgRXc68+4lgitgroXg/eS6
         EAxhF1BhOKm6I+8JaAXFXwFSvtwLdFovHDvhVX7oArpcu16GbI8+/t5aC5W4sDCAHld1
         D8V6DicHtZLfXCj35soaU/P4SqHTEW2+QnDb73HSnK7iMMbtQZ7mpLR6bQ68ogs9C2uN
         /1Ig==
X-Gm-Message-State: AOAM530U0/wb2mdpK2e9g7p1pPPAKB0avX46xqLW4XJDP+iUCjykVDkN
        jTYjPkOURdRrYvhP5AzG0I+5+w==
X-Google-Smtp-Source: ABdhPJyTtawIs8JAiCFsqTxiiYyYjp3MsIXycwEqge0vMptTJJRNzukowkbDkXuEoCvC4I8pQV01yQ==
X-Received: by 2002:a63:1f1d:: with SMTP id f29mr2528341pgf.47.1609525359124;
        Fri, 01 Jan 2021 10:22:39 -0800 (PST)
Received: from ?IPv6:2603:8001:2900:d1ce:5830:72d7:a38c:58e8? (2603-8001-2900-d1ce-5830-72d7-a38c-58e8.res6.spectrum.com. [2603:8001:2900:d1ce:5830:72d7:a38c:58e8])
        by smtp.gmail.com with ESMTPSA id h18sm49138671pfo.172.2021.01.01.10.22.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Jan 2021 10:22:38 -0800 (PST)
Subject: Re: [PATCH] sh: add support for TIF_NOTIFY_SIGNAL
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     linux-sh@vger.kernel.org,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>
References: <5fcc82b4-89ae-3bca-10ab-6ad933565cee@kernel.dk>
 <ae29ab73-ee7a-2bb7-3fd8-3037f40c1cbd@kernel.dk>
 <5611bde9-67e7-6ff6-defc-9b02ea830fac@physik.fu-berlin.de>
 <9ea14eb3-d698-5499-ba4c-c6a3c35cd8d4@kernel.dk>
 <47f79645-53b7-b11c-167a-f5721b53df02@physik.fu-berlin.de>
 <9d9acec6-1e8c-2d68-5dfa-d58c11cf5cc4@kernel.dk>
 <070780c4-445e-6373-c8f4-1c72d0f3b4e0@physik.fu-berlin.de>
 <1047f3e5-4599-c34f-3176-9f41d2e1246b@kernel.dk>
 <31b34cfc-8d6e-d3b4-e29f-1ec485f5b368@physik.fu-berlin.de>
 <23bf4423-0987-c445-d5cd-1922e1e40820@kernel.dk>
 <f95539e9-506b-c4d9-2861-f288e2d021df@physik.fu-berlin.de>
 <10752e73-ca2a-9ea7-4aa6-35e366e36fb0@kernel.dk>
 <b16ed393-e2bf-deca-d0d9-614d24ee6406@physik.fu-berlin.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4acdfb5b-842f-aba4-0f6c-20b4795ded35@kernel.dk>
Date:   Fri, 1 Jan 2021 11:22:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <b16ed393-e2bf-deca-d0d9-614d24ee6406@physik.fu-berlin.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On 1/1/21 11:16 AM, John Paul Adrian Glaubitz wrote:
> On 1/1/21 4:35 PM, Jens Axboe wrote:> It's supposed to finish very quickly:
>>
>> axboe@p1 ~> time ./socket-rw                                                             0.000s
>>
>> ________________________________________________________
>> Executed in    1.10 millis    fish           external 
>>    usr time  888.00 micros  278.00 micros  610.00 micros 
>>    sys time   35.00 micros   35.00 micros    0.00 micros 
>>
>> If it doesn't, can you try:
>>
>> # echo 1 > /sys/kernel/debug/tracing/events/io_uring/enable
>>
>> Then run the socket-rw app, and then do:
>>
>> # cat /sys/kernel/debug/tracing/trace
>>
>> and send that output? Might also be useful to include the strace
>> of the socket-rw just in case, so maybe run it ala
>>
>> strace -o foo ./socket-rw
>>
>> and include foo in the reply as well.
> 
> Odd, I just ran it through strace and it exited immediately:

That looks correct, it sets up a ring, issues and waits for two
requests. Both of those requests require TWA_SIGNAL processing.

-- 
Jens Axboe

