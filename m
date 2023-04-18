Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B764EC77B71
	for <linux-sh@archiver.kernel.org>; Tue, 18 Apr 2023 07:55:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbjDRHy5 (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 18 Apr 2023 03:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbjDRHyf (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 18 Apr 2023 03:54:35 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E693D10F4
        for <linux-sh@vger.kernel.org>; Tue, 18 Apr 2023 00:54:31 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id d9443c01a7336-1a6bc48aec8so5159775ad.2
        for <linux-sh@vger.kernel.org>; Tue, 18 Apr 2023 00:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20221208.gappssmtp.com; s=20221208; t=1681804471; x=1684396471;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b4m/DEqkUTLjdi2fm2fPqnxbbdW3CzUw7u4PcTYjgyY=;
        b=eB+Vb4t7KHh3fYVCMNX0AX9k0hlr9So52/z9e6Zm7Yp14c3prqF0BshxGZCqmLiUhY
         PFg8eBdVp2os7Ipc2n/2+qmuH6/cHCqxrXd9FsXDJ44WtZdGhuIHBxIk+rrPXfLpLjL0
         d6bPxl7CRSOy4EB0t6G1yMt5+MVEeY+rS2wHnIUNhnDzHyIj9YRZvQ43YhQYliliHlDx
         rli2zQmMWIKX/VM9KXHKtPjb7EG4wvIyuGdMaMvyzByY3MsvjTjWu0GXlA5hGcs5HZe/
         EnLPWrJesB25SJYqpFHLurW1m8U2jlMeF7ffbuPBcO8JbS24IYGRoJL7VB+de/uQ2Ujj
         FwrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681804471; x=1684396471;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b4m/DEqkUTLjdi2fm2fPqnxbbdW3CzUw7u4PcTYjgyY=;
        b=FPm7IXNnKddXGUx3yxRh68Gvw95/iTBVStqa6YkEPdfHNte4OomrhRWLXVkZNMyOr3
         +j9o5cPbRQDBEizXNDyy18Ijg6ikICPipa08frexcjze9dVsdhZodDqEzhkfJ7a9CozC
         6Pc5d5uFTHQeX8w0yaP5vNw3kTYz5PyCn3AYtynhW2gaif/Csn/qRsmJP1hsiQrirEjO
         12M7UEvOD4kkdkxdE1y7JFtoGoBf0BHW9gKQei9S5nYuqWmdjXpcFlW01nCrb8DSWIJU
         XuStnnpGIH8B506hEGQNeMaSq15k/U5nFI2bsIh/e20xzOJl1fs6uSkwnSRAuvvIm2pS
         N8lg==
X-Gm-Message-State: AAQBX9fOfl4i1HzNG707uo8zXe25sgeHcFZD2ocqEYBanvpBvjHOjCF3
        1NWgMxiCVzRAfVFuFHuNn0nl0Q==
X-Google-Smtp-Source: AKy350aqYr9pEwYkOtndxNuBZDpi7mC8nze6j2MF8GxFuz9cI8Y/nTwrJVQV8C7SYBHPa0SaX/xQxQ==
X-Received: by 2002:a17:902:bd83:b0:1a7:c058:a167 with SMTP id q3-20020a170902bd8300b001a7c058a167mr1621089pls.25.1681804471405;
        Tue, 18 Apr 2023 00:54:31 -0700 (PDT)
Received: from [192.168.33.147] (124-110-25-102.east.xps.vectant.ne.jp. [124.110.25.102])
        by smtp.gmail.com with ESMTPSA id o1-20020a1709026b0100b001a6c524c198sm4206820plk.52.2023.04.18.00.54.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 00:54:31 -0700 (PDT)
Message-ID: <e4f89e6f-b7fb-6cfc-c90c-03ecdefe602a@landley.net>
Date:   Tue, 18 Apr 2023 03:09:45 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] Fix J-core aic warning spam
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>
References: <ec905cf9-09de-a5d1-b8ee-0d874db4c301@landley.net>
 <45c6426d762dbbe27830182ce751aa3d8210602a.camel@physik.fu-berlin.de>
 <CAMuHMdVxTtoV5_+tEeoTT6hSEBkK8ZsHtu8t6jumvUK6u5effQ@mail.gmail.com>
From:   Rob Landley <rob@landley.net>
In-Reply-To: <CAMuHMdVxTtoV5_+tEeoTT6hSEBkK8ZsHtu8t6jumvUK6u5effQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org



On 4/18/23 02:18, Geert Uytterhoeven wrote:
> Hi Adrian, Rob,
> 
> On Tue, Apr 18, 2023 at 8:19 AM John Paul Adrian Glaubitz
> <glaubitz@physik.fu-berlin.de> wrote:
>> On Mon, 2023-04-17 at 23:23 -0500, Rob Landley wrote:
>> > From: Rich Felker <dalias@libc.org>
>> > Signed-off-by: Rob Landley <rob@landley.net>
>> >
>> > Silence noisy boot messages (warning and stack dump for each IRQ) when booting
>> > on J2 SOC.
> 
>> > --- a/drivers/irqchip/irq-jcore-aic.c
>> > +++ b/drivers/irqchip/irq-jcore-aic.c
>> > @@ -68,6 +68,7 @@ static int __init aic_irq_of_init(struct device_node *node,
>> >       unsigned min_irq = JCORE_AIC2_MIN_HWIRQ;
>> >       unsigned dom_sz = JCORE_AIC_MAX_HWIRQ+1;
>> >       struct irq_domain *domain;
>> > +     int rc;
>> >
>> >       pr_info("Initializing J-Core AIC\n");
>> >
>> > @@ -100,6 +101,11 @@ static int __init aic_irq_of_init(struct device_node *node,
>> >       jcore_aic.irq_unmask = noop;
>> >       jcore_aic.name = "AIC";
>> >
>> > +     rc = irq_alloc_descs(min_irq, min_irq, dom_sz - min_irq,
>> > +                          of_node_to_nid(node));
>> > +     if (rc < 0)
>> > +             pr_info("Cannot allocate irq_descs @ IRQ%d, assuming pre-allocated\n",
>> > +                     min_irq);
> 
> This is a fatal error, so please bail out, instead of continuing.

If it can continue, it's not a fatal error. (Some pieces of hardware might not
come up, but the board might still be usable.) If it can't continue, how does
the _type_ of failure matter?

(Not calling it at all technically worked, it was just noisy...)

Rob
