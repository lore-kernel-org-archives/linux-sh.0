Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 203A3C49EA6
	for <linux-sh@archiver.kernel.org>; Sat, 26 Jun 2021 22:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6E1B61C48
	for <linux-sh@archiver.kernel.org>; Sat, 26 Jun 2021 22:19:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbhFZWV0 (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Sat, 26 Jun 2021 18:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbhFZWV0 (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Sat, 26 Jun 2021 18:21:26 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8480C061574
        for <linux-sh@vger.kernel.org>; Sat, 26 Jun 2021 15:19:03 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id d21-20020a9d72d50000b02904604cda7e66so11999560otk.7
        for <linux-sh@vger.kernel.org>; Sat, 26 Jun 2021 15:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hL4UYM2SGkybwhGKeNVxRc3RhwhOjX0QboFkuvBmxSI=;
        b=gPLAQUkBSs4K1Iyg7nlLQ/Di9cZnlIsOhjJYah1/ndHUfP+UuOwlG+gejgqQJCKSV1
         MUw36uxralpQUiWvIyF0aqn3Yrj73aWwwLBtQTaPhjxUki4ky3Il2oC1Azt3hbGAfjyC
         bbdlT7fo6N/nTsbmiLeblzvTYK/WmzP1YQi9Xwd0XeAGcwUlirB4hYCLSMUsGgOX82dB
         mnNIW3xg9C9tlzbeCtnLTyeM/IoNls8iuZ386wT9zOpk11vgT67UcihHwg0kDXapUqJy
         uVYPnIFONm9jX+XVBIg6X99gH/SXHNi5frxyks1cnl1ShzPP8OdWW8J0twuu5FKIS5gX
         RCZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hL4UYM2SGkybwhGKeNVxRc3RhwhOjX0QboFkuvBmxSI=;
        b=Cex52XFyw9UtUBIMDQLqBZbErvx04Z8wjB5WkBh47u+MIz5fCl+q2b9m+kzLIvLWCw
         YEwmt7Thgf89Smiz4DDFRL/VaXxOsppo6Lpda/8CXeFGqw00OvClVYMz0zqak/msHFSZ
         7iKAsBKpYCTonTgRc34SXHlGbsivSMGEr1dRnHe9IBFvOeoqtT9yFx3qrvFOjIz0U7kt
         3MjPOja0jNhealNwg3ua3HW2XaaLUFyVQi3FYGs1MqgcrCKRuYRAEghigxPzzRh6AjFG
         x9o/ECMFePDn46IBvsqIUjkY6r5oX8yuwa//XwBofnVn+Y75OvgnASa1Nj8RDw2NBNX0
         fsyA==
X-Gm-Message-State: AOAM533RmVanfzgpgo0JrUfAHahrhThd0CFbskk8IpyX7Vs5bV5umcGt
        g4qtp5mNDNBQZ+8FVxLZOFOCaLXqo2cNIDIl
X-Google-Smtp-Source: ABdhPJzIBYiDwN+vs4Juiju+SrRswUfU+7eER9WObXr+x/xzu9mdFDLFiX/Zu9aD6NeZSS/2M7F/iw==
X-Received: by 2002:a9d:80a:: with SMTP id 10mr12880537oty.192.1624745942815;
        Sat, 26 Jun 2021 15:19:02 -0700 (PDT)
Received: from [192.168.86.166] ([136.62.4.88])
        by smtp.gmail.com with ESMTPSA id 35sm2389066oth.49.2021.06.26.15.19.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Jun 2021 15:19:01 -0700 (PDT)
Subject: Re: dma_declare_coherent_memory and SuperH
To:     Christoph Hellwig <hch@lst.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210623133205.GA28589@lst.de>
From:   Rob Landley <rob@landley.net>
Message-ID: <1a55cf69-8fe1-dca0-68c7-f978567f9ca0@landley.net>
Date:   Sat, 26 Jun 2021 17:36:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210623133205.GA28589@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On 6/23/21 8:32 AM, Christoph Hellwig wrote:
> Hi SuperH maintainers,
> 
> I have a vague recollection that you were planning on dropping support
> for non-devicetree platforms, is that still the case?

We'd like to convert them, but have to rustle up test hardware for what _is_
still available. (There was some motion towards this a year or so back, but it
petered out because pandemic and everyone got distracted halfway through.)

(We should definitely START by converting the r2d board qemu emulates. :)

> The reason I'm asking is because all but one users of
> dma_declare_coherent_memory are in the sh platform setup code, and
> I'd really like to move towards killing this function off.

Understood. Is there an easy "convert to this" I could do to those callers?

Rob
