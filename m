Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 676DCC433DB
	for <linux-sh@archiver.kernel.org>; Sun, 21 Feb 2021 19:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 323F764DD3
	for <linux-sh@archiver.kernel.org>; Sun, 21 Feb 2021 19:31:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbhBUTbg (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Sun, 21 Feb 2021 14:31:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbhBUTba (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Sun, 21 Feb 2021 14:31:30 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 864B0C061786
        for <linux-sh@vger.kernel.org>; Sun, 21 Feb 2021 11:30:50 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id h22so1789964otr.6
        for <linux-sh@vger.kernel.org>; Sun, 21 Feb 2021 11:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=g5UTIa9InNIBkuT94ogtQK2y5EXdGrdRe0gMG++D8V4=;
        b=ninjvy1lz0nYYZnjrEBeevjo/jojfAC0+K8ySY81KtjgquGq+J4LFZIpJob7E2yA2U
         6TDrv+idGCmSjhyQosG9n0weK99OZquYTShuxymUgaowIj9+Sn45aWl48bCjQilapnsV
         nlHXSfo+J4mXh09Er/KJZAMwhgF5tHl3yOTaQQXE4nmtjEpPh5ajLluxVLb6lOyLckIj
         R6qBn0VVwN32MAJKHiB6Q3xSsa1Yd3pSJH0EMHwL5HBovbdi+iZNtUlzyKmjl8L4OCCj
         YjhRa4U+mBU/tBzQYFYtifVlt0Eolbhcm3U18jldYJE1C+1OayD/5FR3mUbx4SDnL23z
         Z+pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=g5UTIa9InNIBkuT94ogtQK2y5EXdGrdRe0gMG++D8V4=;
        b=gLmd4pzF2fVG8fQNW9zRrxje/o6mV8Vqd5y0JCaVeB2H1FG0kQV0iGiUH3CSovUwS0
         yxCSJ9fAQRDLbgJxoPZbQziuzOISGfCbX8jdkvRMpp0RT3eN//wDK+LnYKt2Fg46o1Et
         jeiBFaV2r3t+10RrCEElxgNvpnl1cbkBtNy8h/89d1Yn8HeckSAfNz3F+3zMIhQz6BeO
         W3mS1yxQZjJZxCCkj6FhAPpR58xUcxj9EFRnjW5BJxk4lqDfJRR7k097pNborT0fQv59
         iHL2vwvm3Y0Ahl9/WhYdeD0h/wrXEiqgCGen896aQ5PzknRFhXz1MHcLk2amIIHIfFhz
         1Mmw==
X-Gm-Message-State: AOAM532n3cFWJqUKeYDn7bbMT3yQPF+60dyckaCfL2jNvsL9OmCrG2lw
        ePA4yAijw7ub26nxYSsVhsBXDUK5j7i8265T
X-Google-Smtp-Source: ABdhPJwUurRnazr2GoxU1jsk06X+SOGDh4S697uO1eA9QM4S7U42s8T6LYmETs74PNH5Yp5fsdJLjA==
X-Received: by 2002:a05:6830:2106:: with SMTP id i6mr14286657otc.260.1613935849983;
        Sun, 21 Feb 2021 11:30:49 -0800 (PST)
Received: from [192.168.86.73] ([136.62.4.88])
        by smtp.gmail.com with ESMTPSA id 4sm3185905otp.4.2021.02.21.11.30.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Feb 2021 11:30:49 -0800 (PST)
Subject: Re: SH patches for 5.12
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Linux-sh list <linux-sh@vger.kernel.org>
Cc:     Rich Felker <dalias@libc.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
References: <31ba6e66-71f3-381c-076b-c9d9b0c5d264@physik.fu-berlin.de>
From:   Rob Landley <rob@landley.net>
Message-ID: <d13218aa-dbc6-4d44-d2f7-b6020f6b902d@landley.net>
Date:   Sun, 21 Feb 2021 13:44:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <31ba6e66-71f3-381c-076b-c9d9b0c5d264@physik.fu-berlin.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On 2/21/21 3:42 AM, John Paul Adrian Glaubitz wrote:
> Hi!
> 
> Could we get the following patches picked up for 5.12?

I still have your previous email on this open in a window on my desktop, but the
weather in Austin's been a bit distracting recently. :)

>> - [PATCH] [sh] fix trivial misannotations
>> - https://marc.info/?l=linux-kernel&m=160945707001399&w=2

That is an _impressively_ broken archive. Even the 'raw' links screw up the
From: lines with despamming crap, and it corrupts them on top of that:

  $ wget  https://marc.info/?l=linux-kernel&m=160945707001399&q=mbox -O 1.patch
  $ git am ../sh/1.patch
  Applying: fix trivial misannotations
  error: corrupt patch at line 110

That's why I hadn't dealt with this faster, I have to track them down elsewhere
to get copies I can actually apply and test...

Rob
