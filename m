Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05DF6C77B75
	for <linux-sh@archiver.kernel.org>; Tue, 18 Apr 2023 09:03:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjDRJDO (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 18 Apr 2023 05:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbjDRJDL (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 18 Apr 2023 05:03:11 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073B34C0B
        for <linux-sh@vger.kernel.org>; Tue, 18 Apr 2023 02:03:09 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id d2e1a72fcca58-63b60366047so1463553b3a.1
        for <linux-sh@vger.kernel.org>; Tue, 18 Apr 2023 02:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20221208.gappssmtp.com; s=20221208; t=1681808589; x=1684400589;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=riEyUUcyGOoo1m6E9T12XXnAsiXXXppReCmjmHm49hw=;
        b=H7SnQr2p/f7scQtloPUNrTUr8NnJaqEnUlXeuUpk8LwhrZl0N53zwJqnPaaxcz3akc
         oIs6vepvY/FKQZeVWMY+Fy/hZt1KIhaYHkPd1xtqIG2sIC/uj8ZCbaAzfzVietL1O+2e
         69D6usOu5w6E4K176pgvDx67X7oqtivmsGJhlvyH+4mR+CayuxcTDzUysHDcVQT14Scw
         k9lcgm4XS+yzJH1VSFmyKcyoJNg0+qTejQnfQVtHHsBSGRRai2sKLVEDNynJicYSZs0q
         KX8hLkjE04ssnXgVVXYUTljBbsrNb5oQgFjGxzsGCXvcOOXfiaG43s9sT2mtdT2zP61U
         jT4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681808589; x=1684400589;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=riEyUUcyGOoo1m6E9T12XXnAsiXXXppReCmjmHm49hw=;
        b=auTaWIkbVQtr8/XxIYoZs547dGhsJHWLOFD3ZfpPpCvryD9xkeuGp66/p+2zfTzyzA
         qbraJySHeWuxvUvZcsFtnLkVoZ5Q6E79F9JG9ZLODfAzls/VyZdFi1EehN7x5tUk+GXg
         0S5UdWYRjh8tKIMqizkB4tI9hsTLnr0R8505wxiXRIxnLnb8T0xGjcwFxm8hU35/GXtD
         VFPYqsCHXHEycRM+dGSl3PRjmw3Tvd2hpG8Z2uRY9F9RP49eTa5cl9sRnDQwNRL3ldzI
         2tAf23bUMI6O/4tfBYubtfh7vafbRnUkqTJCAaHXcBVDFDGkw0QJ+ur5K2KZRoPE4RvY
         sKPA==
X-Gm-Message-State: AAQBX9e9FspWyKRJskffA7MjIaM1A/cfmbsctsBKwhAcn37C1msmK/11
        pPJQZeULxs+xbK9NsggulzN8icNYgXIObCdVe0WvOdii
X-Google-Smtp-Source: AKy350ZFztdvNtdyyYFX3bp5O/XLsyUxbyKY/fR6ry59sIHkwUl/mYYSJb7KgwiEnON421dPqYzJIg==
X-Received: by 2002:a05:6a00:1249:b0:63d:39f0:6eaa with SMTP id u9-20020a056a00124900b0063d39f06eaamr1577220pfi.4.1681808589423;
        Tue, 18 Apr 2023 02:03:09 -0700 (PDT)
Received: from [192.168.33.147] (124-110-25-102.east.xps.vectant.ne.jp. [124.110.25.102])
        by smtp.gmail.com with ESMTPSA id a10-20020aa780ca000000b005a8173829d5sm8903986pfn.66.2023.04.18.02.03.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 02:03:09 -0700 (PDT)
Message-ID: <29ac31e3-2c3a-03b3-200f-52c74adcca3f@landley.net>
Date:   Tue, 18 Apr 2023 04:18:22 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] Fix J-core aic warning spam
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>
References: <ec905cf9-09de-a5d1-b8ee-0d874db4c301@landley.net>
 <45c6426d762dbbe27830182ce751aa3d8210602a.camel@physik.fu-berlin.de>
 <CAMuHMdVxTtoV5_+tEeoTT6hSEBkK8ZsHtu8t6jumvUK6u5effQ@mail.gmail.com>
 <91f17ce6-566f-c5d0-f30c-8f8440f0cca6@omp.ru>
From:   Rob Landley <rob@landley.net>
In-Reply-To: <91f17ce6-566f-c5d0-f30c-8f8440f0cca6@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org



On 4/18/23 03:56, Sergey Shtylyov wrote:
> On 4/18/23 10:18 AM, Geert Uytterhoeven wrote:
> [...]
>>>> From: Rich Felker <dalias@libc.org>
>>>> Signed-off-by: Rob Landley <rob@landley.net>
>>>>
>>>> Silence noisy boot messages (warning and stack dump for each IRQ) when booting
>>>> on J2 SOC.
>> 
>>>> --- a/drivers/irqchip/irq-jcore-aic.c
>>>> +++ b/drivers/irqchip/irq-jcore-aic.c
> [...]
>>>> @@ -100,6 +101,11 @@ static int __init aic_irq_of_init(struct device_node *node,
>>>>       jcore_aic.irq_unmask = noop;
>>>>       jcore_aic.name = "AIC";
>>>>
>>>> +     rc = irq_alloc_descs(min_irq, min_irq, dom_sz - min_irq,
>>>> +                          of_node_to_nid(node));
>>>> +     if (rc < 0)
>>>> +             pr_info("Cannot allocate irq_descs @ IRQ%d, assuming pre-allocated\n",
>>>> +                     min_irq);
>> 
>> This is a fatal error, so please bail out, instead of continuing.
> 
>    Then shounld't we use pr_err() (or stronger), not pr_info()?

That I agree with. Happy to repost the patch with that? (Or, you could just sed
's/pr_info/pr_err/' file.patch at your end if that's easier...)

Rob
