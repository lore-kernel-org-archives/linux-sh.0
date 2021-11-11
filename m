Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C77EC433F5
	for <linux-sh@archiver.kernel.org>; Thu, 11 Nov 2021 05:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AC37611C9
	for <linux-sh@archiver.kernel.org>; Thu, 11 Nov 2021 05:18:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbhKKFVL (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Thu, 11 Nov 2021 00:21:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbhKKFVJ (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Thu, 11 Nov 2021 00:21:09 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0122C061766
        for <linux-sh@vger.kernel.org>; Wed, 10 Nov 2021 21:18:17 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id a23-20020a9d4717000000b0056c15d6d0caso197223otf.12
        for <linux-sh@vger.kernel.org>; Wed, 10 Nov 2021 21:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xMXXACNd/53KhwNZXoGonQXGN628dPKbPsydhzu3jZ8=;
        b=ry683UpT8WZ6rYCUMZ3kAH/K5I3SvyAJfAtN/k1buS828SLigI9YnaXRjp0z9ZOVpX
         yg9VqERPbMTQXOV8bFLARRZCBl1q8gBvBhlI1ET5zP/uE8kaxiAT2SAqHuRf4Tn9RLMA
         LKq6lVWo8c3tkUmUgxT6sbceIP91O5PZ7KD/K3pNhI1itDtIF4kG8rOK0ypskEpm2uVh
         Xe0IOiQAXjNes5fZu69pNd37VE4yZUwuABKK+d/36HJDf64pE4d0DftNcbo/PZGR9OS8
         Iw/NvbyUW/zSNz1qdlFdTnFA8z/8zv15rJte5MVW2jEvaZ7aojZGGIen2TqhRb0lgI8L
         wktg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xMXXACNd/53KhwNZXoGonQXGN628dPKbPsydhzu3jZ8=;
        b=d8Uyi0josSXmv6+oXYT1EJ5O8mldq2k/K7axMciZITOPYa7yFCD2/Ba74VlsqSolht
         iCl4MCVoRoqGBTvukfHfpp29WWHhEwDxN6aIMco4DyuPxbN7rT4Znc95j24JgzXpBZJi
         X+sbS6+A1CF1q2g2AGphC61DcbKvrQ35ajy8D17iw+X64hpSvkgQJZB+FI23YIxSjg5c
         xuLZgOAAUo5ph/wRhBbX63J6gNqzKxoKPxVZBsHsE4u9ACRT6YZM0nN9XbwFQbcsiBsh
         afq1FHzA1S7rU8UCmjViM+SlRh4O+GKLiVvmA82mWKtluxhmoj3RPg1xeE6SMuNLa5Vu
         OO6g==
X-Gm-Message-State: AOAM532rcYJ4i4+LJxoFPKAX875KFYRcIDrknyYxbVdWB4SqOM4FzGqh
        CLfXc2DTUvFhzKnGsLJts/WFAg==
X-Google-Smtp-Source: ABdhPJyGWx/1x+9bygIWuQ97SUlT5Ff8+w27//L4q2TNlBAswAZL9U6GN5hiFCH8DHYW/baIP1U5rQ==
X-Received: by 2002:a9d:6297:: with SMTP id x23mr3845613otk.142.1636607897049;
        Wed, 10 Nov 2021 21:18:17 -0800 (PST)
Received: from ?IPv6:2607:fb90:c2fd:ae84:6680:99ff:fe6f:cb54? ([2607:fb90:c2fd:ae84:6680:99ff:fe6f:cb54])
        by smtp.gmail.com with ESMTPSA id bi20sm636312oib.29.2021.11.10.21.18.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Nov 2021 21:18:16 -0800 (PST)
Subject: Re: [PATCH] Fix the j-core SOC build.
To:     Dennis Zhou <dennis@kernel.org>, Rich Felker <dalias@libc.org>
Cc:     Linux-sh list <linux-sh@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
References: <7d559bd1-1f9c-124f-ad4d-c805c049971a@landley.net>
 <20211003021851.GA2559@brightrain.aerifal.cx>
 <20211110213345.GK7074@brightrain.aerifal.cx>
 <20211111005312.GM7074@brightrain.aerifal.cx> <YYx5ZuWFSNOu/wah@fedora>
From:   Rob Landley <rob@landley.net>
Message-ID: <7d97a4d2-f7db-9d8d-21c2-ab80be03e364@landley.net>
Date:   Wed, 10 Nov 2021 23:39:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YYx5ZuWFSNOu/wah@fedora>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On 11/10/21 8:01 PM, Dennis Zhou wrote:
> I'm surprised I haven't heard any reports of this until now. Thanks for
> ccing me. Fwiw, it's generally good to cc the author / subsystem
> maintainer when there is an issue.
> 
> I would need to think about it a little bit more, but I think
> percpu-km.c was written more in the mindset of !MMU == !SMP. It sounds
> like for superh that's not true.
> 
> Given that, if sh has no MMU,

sh1 and sh2 are nommu. sh3 and sh4 have mmu. J2 is an SMP sh2 compatible (with
some backported sh3 instructions plus a cmpxchg variant to make the SMP work).
It is, as far as I know, the only nommu SMP in the tree, but it worked for us
until recently.

Rob
