Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC86BC4320A
	for <linux-sh@archiver.kernel.org>; Thu, 29 Jul 2021 15:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2604601FC
	for <linux-sh@archiver.kernel.org>; Thu, 29 Jul 2021 15:53:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238020AbhG2PxV (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Thu, 29 Jul 2021 11:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238019AbhG2PxU (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Thu, 29 Jul 2021 11:53:20 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76145C0613C1
        for <linux-sh@vger.kernel.org>; Thu, 29 Jul 2021 08:53:16 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 48-20020a9d0bb30000b02904cd671b911bso6341054oth.1
        for <linux-sh@vger.kernel.org>; Thu, 29 Jul 2021 08:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZVVXzgN1GhKovnRxWqbY2snTDqoBtRSnVxP9qDPzayY=;
        b=LYZ2DYUY0AMG1eLib6jmyuBqHvkFlu30iokat8Bq3M0lew4U2wgCdmCOp28QarXcua
         c96mJGW0D2e8Q8RAd9PP1U0ZENAKkbsOaJ4NvrdEDVawjz8BpkA/lQj4xHS7toY42Xjc
         oZzog7jTFIj38Ms8c1EJ72a+cvF5qtlPsa4FYP92f8tqTdOoR+TPEXEoNppal+W+F207
         MJYkL/Oveo0KDuGSbvHFkBym1svXqPepnvWJzEpNZTef78GwZQJNBv/VFPBPs9vwzPw/
         euRWNoTLm4X+K7H6UlZYljWdcZ3ntDQwSmfUd2GhOv2mIodvydwUuvj0F22l384FVwSt
         S6TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZVVXzgN1GhKovnRxWqbY2snTDqoBtRSnVxP9qDPzayY=;
        b=Si5YnLpKhmYooAO9If6ghY5+L8nd8fIQvnN7yPoR1o3MvIdKqstQXHa08a66KfEw4B
         AitG8UmZFAYzUnp8yub/n6lFuNQOi0IanaM3Z8C68gKKz94AECPx4UaO5QLlDZHFgQDB
         ebsR1/6hmP+RXq1pXRqx2b3eurbr6AkXt72ETSFEMVW6wFh+AOxJaYGhXLgelDqrQfQu
         N3YOuoiXR9WyQkGRfl4X4LhShsIscq/Tb8K1D4UsTYKepchSR2rAe2/DuGpKufj3OZUL
         HaVnLOLpfAfjegvw9GcbcGDXP0muk8a6T9jYTkmokH//zHg9Aff6zisHAae/LpXIX5ME
         S3cw==
X-Gm-Message-State: AOAM5326ZTN/k2gvJdFJYFuCw6Zzj6o3iwUlm156TmTo1Am1TKKIdTl3
        HACYZg/DBShsrrNI8Ur7KyAwrQ==
X-Google-Smtp-Source: ABdhPJzPH4S9HeHImVN7Q4fEALbq2v7XYrZ97UmxItwSauKx0big9DMi3YZYyfvY1RU+WhNOdQwNyw==
X-Received: by 2002:a9d:8a3:: with SMTP id 32mr3973892otf.277.1627573995918;
        Thu, 29 Jul 2021 08:53:15 -0700 (PDT)
Received: from [192.168.86.153] ([136.62.4.88])
        by smtp.gmail.com with ESMTPSA id v5sm522974oor.33.2021.07.29.08.53.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jul 2021 08:53:15 -0700 (PDT)
Subject: Re: Stalled patches for the SH tree
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Rich Felker <dalias@libc.org>
Cc:     Linux-sh list <linux-sh@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
References: <3a14d8c5-45e4-84dc-32b9-0bb573ebc77a@physik.fu-berlin.de>
From:   Rob Landley <rob@landley.net>
Message-ID: <be89052d-bd6f-90e5-198a-e8919fabf7ba@landley.net>
Date:   Thu, 29 Jul 2021 11:11:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <3a14d8c5-45e4-84dc-32b9-0bb573ebc77a@physik.fu-berlin.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On 7/29/21 3:58 AM, John Paul Adrian Glaubitz wrote:
> Hi!
> 
> I was wondering whether there is anything I can do to help with the stalled
> patches for SH? There have been a number of patches with improvements that
> were sent to the list and I think we should pick these up, also not to discourage
> external contributors in helping us maintain the SuperH port.

The main thing is collect and track the patches, and then point us at the list
of ones you think we should review.

The ones I've seen go by here recently were all part of multi-architecture
series, which I assumed would go upstream as part of the series and they were
mostly checking to see if we objected? What did I miss?

Rob
