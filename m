Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC5E0C2B9F4
	for <linux-sh@archiver.kernel.org>; Mon, 28 Jun 2021 14:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A94D961C75
	for <linux-sh@archiver.kernel.org>; Mon, 28 Jun 2021 14:12:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232396AbhF1OPQ (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 28 Jun 2021 10:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232376AbhF1OPQ (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Mon, 28 Jun 2021 10:15:16 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93AD0C061574
        for <linux-sh@vger.kernel.org>; Mon, 28 Jun 2021 07:12:50 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id g19-20020a9d12930000b0290457fde18ad0so18885551otg.1
        for <linux-sh@vger.kernel.org>; Mon, 28 Jun 2021 07:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rfeXX0z3uQGk3VM+2xtA2DmnGgP2rWO/RWy/3AwFX2Y=;
        b=oEx9hPhXaBPdvVIaz6BVAJzYzMGl1m/N8qbg7AEc2G1ta3UVBQUKXNySY2Fbm/zSZg
         7CNt3L0bqI/4Ex96WZP/HbqN90z4RXEOrOk9kC4kPL859tXwX34YFvjbsBEf+E1q2rqj
         4nykuDKfuw6dFHpbXiBlHRhLLw3RdF1KAVKOWeHIGiqU4ZVExCSWaIX4bqR7UMbOF08g
         qvRxi0uFH9hd3yV+KOBOTXMk8UOE3Lykv1AxSqqsucT4+HJyGb/3bue6CZ+d9OlkWDg7
         2KkzfBq9ajnol99Q6mRWLMvg5b5Kg+aMSEk81qANYVNpsKJEjFshv6OBf+osh/Wbmcs4
         /m3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rfeXX0z3uQGk3VM+2xtA2DmnGgP2rWO/RWy/3AwFX2Y=;
        b=DErUDG9IbyQMAb0gaXPXLF+m4ExKBfRVJa7V/h+nQh+VD2YW9fIOMqpcEE9ulQwI6u
         nyLy4ULULSVJOsQ8xnyVjnlueyIjcmmFPZ6wuFHYQrYLHiMkU6M2FDw4LlOncSTJx13R
         xyGqJEUnPYhCjFyq8fPiYUjOVOLeavIilG+MwrF91en8m+mXW1uvXcXtncqg+ejFlZHV
         z5FY4iOuYrfaEhtdDqflbeBHpXiAd11FNNd15XMw3RFnAQLj0kOW7DHETCFUm8yIM04C
         Kg4OxJIX5WOKUMPhdWGy3CotNRyxvsezAUzJz36+B+OYzH1DxziqCHES8A8CHTmCrGYW
         ay+Q==
X-Gm-Message-State: AOAM53020qt9GcbmqJqNW7DrSIKyNItAG2vRg4fKdyVonNrgA7ZvjIS1
        w5N7uGzk7F5A7JucIPIy5dAGyw==
X-Google-Smtp-Source: ABdhPJxwqACyHwzTBQ3ULjEyeEdUJXy8m8MXBq1w/A8ku65FixpuNCpN7u0pxb2tmcH/AD8R8Qx+7w==
X-Received: by 2002:a05:6830:1e64:: with SMTP id m4mr20972177otr.23.1624889569949;
        Mon, 28 Jun 2021 07:12:49 -0700 (PDT)
Received: from [192.168.86.166] ([136.62.4.88])
        by smtp.gmail.com with ESMTPSA id b20sm3513621otq.41.2021.06.28.07.12.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jun 2021 07:12:49 -0700 (PDT)
Subject: Re: dma_declare_coherent_memory and SuperH
To:     Christoph Hellwig <hch@lst.de>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210623133205.GA28589@lst.de>
 <1a55cf69-8fe1-dca0-68c7-f978567f9ca0@landley.net>
 <20210628133858.GA21602@lst.de>
 <4d6b7c35-f2fa-b476-b814-598a812770e6@landley.net>
 <20210628134955.GA22559@lst.de>
From:   Rob Landley <rob@landley.net>
Message-ID: <1141b20f-7cdf-1477-ef51-876226db7a37@landley.net>
Date:   Mon, 28 Jun 2021 09:29:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210628134955.GA22559@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On 6/28/21 8:49 AM, Christoph Hellwig wrote:
> On Mon, Jun 28, 2021 at 09:04:19AM -0500, Rob Landley wrote:
>> > Well, the replacement is to declare the device memory carveouts in the
>> > Device Tree.
>> 
>> Your plan is to eliminate the ability for non-device-tree boards to do DMA?
> 
> No.  My hope is to kill dma_declarare_coherent, an API for board
> support files to declare device-specific regions to be used for
> coherent DMA.

Q) If I haven't got regression test hardware to make sure I properly converted
each of these entire boards to device tree, Is there anything else I can do to
help you remove this function from common code, such as inlining some portion of
this function?

A) You can convert the board to device tree.

Which part of this exchange have I misunderstood?

Rob
