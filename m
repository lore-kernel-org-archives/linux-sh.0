Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A8BAC2B9F4
	for <linux-sh@archiver.kernel.org>; Mon, 28 Jun 2021 13:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E84C61C70
	for <linux-sh@archiver.kernel.org>; Mon, 28 Jun 2021 13:47:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232178AbhF1Ntk (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 28 Jun 2021 09:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232131AbhF1Ntj (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Mon, 28 Jun 2021 09:49:39 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9BCEC061574
        for <linux-sh@vger.kernel.org>; Mon, 28 Jun 2021 06:47:10 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id l26-20020a4ac61a0000b029024c94215d77so916469ooq.11
        for <linux-sh@vger.kernel.org>; Mon, 28 Jun 2021 06:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qceIscsR0qrG5qBxyFH8+s8zOb1JhNM9G4ZV0IV+llI=;
        b=Ui5tbzleCKtxQLzeaeNusdncvAYbZ0YVOaGFOd9hPcTFcKVdYk3QY7gbBOjNaFJN6v
         BTKz1fQcFColqlgOehqK1lCndPtgfQ7g5E07dU8Ga6wHXAqFg1S62r3U7snNJAGS8awD
         VE0Bv+6UzQCojhJjbb+wdf5OQpg2M6RJaulStQP6nxup6C4jaL+/ljjWn1OL10iv5ofs
         PsOum6XwhXMAILXuiX/Xl38nrmFKYNGiN5pDMRX0LYIEDwsIsiIXxwRhXJqwufJnfwSB
         nUsHJ2JeGNdd6Z9YeVWdo1+VFc+QPUboRwHfLrsLGKXIak/048eDNKCJ59FydZXXbb6Z
         WJrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qceIscsR0qrG5qBxyFH8+s8zOb1JhNM9G4ZV0IV+llI=;
        b=ReAI3vup/555cicGD5Sp/EoH3fwiu8Z8nTF6jm5rcOHDAD8wRTUOtNncGtM6JGTYz4
         v4HgeTo/BeHwyWRcgNq65Ujh1kPn5wePpdtg03D4RH3SSgCFf681vhyiTFR2aXFa0Kw2
         7kPcl/g4dbJXIVQi0XImg3SdGGcCSXJExGnEy2dvf6ns1hvrKPUVeplW1k10cx9DleT4
         dfLx6XmI+ugakSyMbY3zEWzEFcM8AuHTsCSWA9jC2epcc/S5KSH8wDyU7Uu3TQOMGqHD
         jbR93gvN3NdfCdv7vgG9d3c1pTjzW6Jsf5SVg5xz+dY5/PClaMjrDtbs9TkHYjfIgzkP
         XxEA==
X-Gm-Message-State: AOAM531c6cVRYI/kLcxRokhxFUsTXg83s1SHIlZZrt8jbXvqpY1yX3Bn
        UWzD+gCh7rPDrbSD93UQJJVHskLB3S2HmwyG
X-Google-Smtp-Source: ABdhPJzW850hkyCet8ockBb2pXWxsK9Q32fy3TmhkXzxvuk4dJrRBVxkfdylqxd+lYT1oDAev5TCSA==
X-Received: by 2002:a4a:b815:: with SMTP id g21mr19202867oop.70.1624888030261;
        Mon, 28 Jun 2021 06:47:10 -0700 (PDT)
Received: from [192.168.86.166] ([136.62.4.88])
        by smtp.gmail.com with ESMTPSA id y20sm1619791ots.23.2021.06.28.06.47.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jun 2021 06:47:09 -0700 (PDT)
Subject: Re: dma_declare_coherent_memory and SuperH
To:     Christoph Hellwig <hch@lst.de>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210623133205.GA28589@lst.de>
 <1a55cf69-8fe1-dca0-68c7-f978567f9ca0@landley.net>
 <20210628133858.GA21602@lst.de>
From:   Rob Landley <rob@landley.net>
Message-ID: <4d6b7c35-f2fa-b476-b814-598a812770e6@landley.net>
Date:   Mon, 28 Jun 2021 09:04:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210628133858.GA21602@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org



On 6/28/21 8:38 AM, Christoph Hellwig wrote:
> On Sat, Jun 26, 2021 at 05:36:08PM -0500, Rob Landley wrote:
>> On 6/23/21 8:32 AM, Christoph Hellwig wrote:
>> > Hi SuperH maintainers,
>> > 
>> > I have a vague recollection that you were planning on dropping support
>> > for non-devicetree platforms, is that still the case?
>> 
>> We'd like to convert them, but have to rustle up test hardware for what _is_
>> still available. (There was some motion towards this a year or so back, but it
>> petered out because pandemic and everyone got distracted halfway through.)
>> 
>> (We should definitely START by converting the r2d board qemu emulates. :)
>> 
>> > The reason I'm asking is because all but one users of
>> > dma_declare_coherent_memory are in the sh platform setup code, and
>> > I'd really like to move towards killing this function off.
>> 
>> Understood. Is there an easy "convert to this" I could do to those callers?
> 
> Well, the replacement is to declare the device memory carveouts in the
> Device Tree.

Your plan is to eliminate the ability for non-device-tree boards to do DMA?

Rob
