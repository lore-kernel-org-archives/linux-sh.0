Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 105E4C11F64
	for <linux-sh@archiver.kernel.org>; Mon, 28 Jun 2021 19:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E54AC61C74
	for <linux-sh@archiver.kernel.org>; Mon, 28 Jun 2021 19:30:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236526AbhF1Tce (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 28 Jun 2021 15:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234094AbhF1Tcd (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Mon, 28 Jun 2021 15:32:33 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7765C061574
        for <linux-sh@vger.kernel.org>; Mon, 28 Jun 2021 12:30:06 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id n99-20020a9d206c0000b029045d4f996e62so20036705ota.4
        for <linux-sh@vger.kernel.org>; Mon, 28 Jun 2021 12:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VFJY8505wyLq/TqpNtGxx/X4mufdytmO16W0L0dHIgg=;
        b=om4/U1E+hj6T7UkgHhPtAr+MURu4APHxmHXxUJG1zNOw+zEl+i9NmsNx3QnEYmmNCp
         t5rlS5d/Weh7HtAbUzHIz3gebtjOexW6hV5er/4UNfgesAv55oB0eNOqwh5ZbTOJK/g5
         mmELdGLy/6PiyMJtTefdbQ9vqO+4dpJxQb8bhb2sD26EtqVaM4l+VBwLu8z+oLgnGrJA
         7JRvkVcgqJbA8TVSkSmHJyxT5B3B42fPTHenlSLt9m4gER/SRYB5BU3YJlnvVC3d/nAV
         /4/i8jJd4gUGylUuI7MzMh6daNP+Kz6t7IWsXvW6dw6k1KHRxIMnL8Oq2oE4S1HsyORb
         8DoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VFJY8505wyLq/TqpNtGxx/X4mufdytmO16W0L0dHIgg=;
        b=S6gAd75TSVt6BUnFQd+kaXZthCgI2MurQb5u3fL4OEmn6Z1/HNAm87e5fCxPQeW7wv
         b5vm+yAO+fKYNpq1t/cJxXL4S9qWeezP5DXLev7soEH+Dgm+aw2yL+/DtSoSSpqUxY4w
         hUgrAv4RUcMYKBVUpZPoxC68slVTbKmpOCdeh3QPWO0NQyT9PPtxGzujMXWcOwuo88EW
         5zrmkbaE3WBNzIkpvxm6XQZuqsUQCCWPT/mGSk/Ep3vRwxkBCAcbuPAro6sBxWU40ngX
         Wa/KrUYyO9FqheswzHd/m2PlIqC5GtE6LwsgzOwCadg4CtMK14nqQoLhRmHhoGpTIH/i
         jIlQ==
X-Gm-Message-State: AOAM530zcvFzpWaTEsSAdwIjTlg4Q1hLxT3XyGJt5CaCJdrL9IkZ0bdf
        7i2FbyqBwFu8naC5aXPCR8RjFw==
X-Google-Smtp-Source: ABdhPJyQF1m0BxNSgT0anmTMLiJYKDNJJnKXUgkXT4+p9bUZ460gWnijh9Yo+M4Apn9fU8Cn89ZRYw==
X-Received: by 2002:a9d:62cf:: with SMTP id z15mr1002438otk.306.1624908606386;
        Mon, 28 Jun 2021 12:30:06 -0700 (PDT)
Received: from [192.168.86.166] ([136.62.4.88])
        by smtp.gmail.com with ESMTPSA id p190sm259011oop.2.2021.06.28.12.30.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jun 2021 12:30:05 -0700 (PDT)
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
 <1141b20f-7cdf-1477-ef51-876226db7a37@landley.net>
 <20210628163312.GA29659@lst.de>
From:   Rob Landley <rob@landley.net>
Message-ID: <4415e2cf-5a6a-8e83-a6d8-391c25e1f041@landley.net>
Date:   Mon, 28 Jun 2021 14:47:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210628163312.GA29659@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On 6/28/21 11:33 AM, Christoph Hellwig wrote:
> On Mon, Jun 28, 2021 at 09:29:59AM -0500, Rob Landley wrote:
> >> Your plan is to eliminate the ability for non-device-tree boards to do DMA?
>
>> > No.
>
>> Which part of this exchange have I misunderstood?
> 
> The part that there is no easy way out without the device tree
> conversion.

Interesting use of the word "No".

I didn't ask for easy, I asked what needed to be done. What is the patch you
want to apply to kernel/dma so I can see what infrastructure needs to be moved
into arch/sh so it's our problem and not yours.

If a wrapper function has to fake up a temporary device tree snippet to lie to
new DMA infrastructure that refuses to export non-systemd APIs to handle this,
fine. It's still less intrusive than converting EVERY device to a new API on
boards I can't easily regression test. (And hey, if you squint that would be a
little like a partial incremental device tree conversion.)

Rob
