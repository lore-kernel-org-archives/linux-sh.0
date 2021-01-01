Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF04C433DB
	for <linux-sh@archiver.kernel.org>; Fri,  1 Jan 2021 15:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86ED7207E2
	for <linux-sh@archiver.kernel.org>; Fri,  1 Jan 2021 15:36:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbhAAPgc (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Fri, 1 Jan 2021 10:36:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727057AbhAAPgb (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Fri, 1 Jan 2021 10:36:31 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE80AC061573
        for <linux-sh@vger.kernel.org>; Fri,  1 Jan 2021 07:35:42 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id 15so14645380pgx.7
        for <linux-sh@vger.kernel.org>; Fri, 01 Jan 2021 07:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CcsZuzVfxkAP0mqzHap2bNdmS8Q8Atx/IsL0b+4dRoY=;
        b=rY0tZnrKe8zuz46cag2ZfMvwI86vROMIK6MmrfYU0EdgAo1WoH7dLGnTzjJ9HKVGc4
         KKIa9wSlPgCKpd8I6LDyd5ThVpfSxlZKFZ9sivqe6Qk0F6oaIdUo8wUbKOi3GDLUneZ3
         egwQzj5Y2s0dPMaqMtPv+hKoopvSiUeOGjs2yiSD+wl+HXfqZESUxFlxwe//lyTPfcV+
         2fa3rp/PmZLzUZfpyrpli8kVtvYR7uDlXy9uMLTPzWVZf7l1k/UBv8mdrGUw7musPoQl
         lc8ilfEf1bhB/M2y+mYIg50tx6Tgh53rnH7961JNtFmitWElAKFZE0xFqG1Qhp3cI6zx
         d9fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CcsZuzVfxkAP0mqzHap2bNdmS8Q8Atx/IsL0b+4dRoY=;
        b=sv/JWtYr3a5Rj3D90sJhidd8X+zkpzAliJMcln6/cscU+XsU7Bbu4gjwngEsSc+pWZ
         wZHqhZAB66yHa3/MsFwC4gsx309G121D9zrXLydZwnmC5qUrZ303BRuad2bGKE/VU/SR
         Wh+x6htJcQCS1scTCt6oOvNdkf97/hMRec5ZjEJzlLusnGr7f7seVtzesmbKLQQcHyU6
         8TwE+zU7npue43IWaT0nbkaOorQYjhJtAWl+zZ+fFbop3pXHS4gANTBjNFD0VkDJ1rEU
         mQYe0rJOTe3+eIfAgInpxm8Vt8M8gMvPes8h0+rA0ldC3HCYFATMbIXiz1CAoogMZBbo
         S17g==
X-Gm-Message-State: AOAM533ABsSlB09Kdtyrry+hAxqQG3LrOr+3QGT60RWxoS5RvVcauQpd
        OrQ7jN248VZZrIRESYGxnxXt/A==
X-Google-Smtp-Source: ABdhPJyvTvh6j8RXXl0Ox5OBb0c0bnzFDFGIG+ugPxm2kaC+XdbMOvP35iXntDDvtjFGrghDgroHug==
X-Received: by 2002:a62:543:0:b029:19e:5627:1c4d with SMTP id 64-20020a6205430000b029019e56271c4dmr34721445pff.31.1609515341972;
        Fri, 01 Jan 2021 07:35:41 -0800 (PST)
Received: from ?IPv6:2603:8001:2900:d1ce:7a2f:4758:8d40:5fe5? (2603-8001-2900-d1ce-7a2f-4758-8d40-5fe5.res6.spectrum.com. [2603:8001:2900:d1ce:7a2f:4758:8d40:5fe5])
        by smtp.gmail.com with ESMTPSA id 14sm46088284pfi.131.2021.01.01.07.35.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Jan 2021 07:35:41 -0800 (PST)
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
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <10752e73-ca2a-9ea7-4aa6-35e366e36fb0@kernel.dk>
Date:   Fri, 1 Jan 2021 08:35:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <f95539e9-506b-c4d9-2861-f288e2d021df@physik.fu-berlin.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On 1/1/21 8:30 AM, John Paul Adrian Glaubitz wrote:
> Hi Jens!
> 
> On 1/1/21 4:08 PM, Jens Axboe wrote:
>> On 1/1/21 7:06 AM, John Paul Adrian Glaubitz wrote:
>>> Is there away to test the change itself?
>>
>> The only user of TWA_SIGNAL, which uses TIF_NOTIFY_SIGNAL, so far is io_uring.
>> You need something that triggers deferred task_work processing, which is
>> basically anything that ends up being poll driven for data/space readiness.
>> Here's a small test app from the liburing test suite, that'll trigger it.
>>
>> If you install liburing, compile with:
>>
>> gcc -Wall -O2 -o socket-rw socket-rw.c -luring
>>
>> and run it without any arguments.
> 
> How long is this test supposed to run? It's already been running for some minutes
> on my 600 MHz machine.

It's supposed to finish very quickly:

axboe@p1 ~> time ./socket-rw                                                             0.000s

________________________________________________________
Executed in    1.10 millis    fish           external 
   usr time  888.00 micros  278.00 micros  610.00 micros 
   sys time   35.00 micros   35.00 micros    0.00 micros 

If it doesn't, can you try:

# echo 1 > /sys/kernel/debug/tracing/events/io_uring/enable

Then run the socket-rw app, and then do:

# cat /sys/kernel/debug/tracing/trace

and send that output? Might also be useful to include the strace
of the socket-rw just in case, so maybe run it ala

strace -o foo ./socket-rw

and include foo in the reply as well.

-- 
Jens Axboe

