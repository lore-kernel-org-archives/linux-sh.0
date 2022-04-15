Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D050DC433EF
	for <linux-sh@archiver.kernel.org>; Fri, 15 Apr 2022 19:17:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347400AbiDOTTw (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Fri, 15 Apr 2022 15:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232645AbiDOTTw (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Fri, 15 Apr 2022 15:19:52 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA4949CB7
        for <linux-sh@vger.kernel.org>; Fri, 15 Apr 2022 12:17:23 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id c11-20020a9d684b000000b00603307cef05so2275606oto.3
        for <linux-sh@vger.kernel.org>; Fri, 15 Apr 2022 12:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=PdIDFGQW4UYiVf0M69peoSmdiojSEaqNuqBV2NqZc8U=;
        b=0BVtvbGjVzsjRc+2SRZo6FtQuKRHY0bMFiXstc0wjsPiOk9WCBEGmJBfKuqAeGof45
         gpVDYqx32IFNfcTzBnn5cmZHoNgFQXCjq3eUHdjkvnIh/1xTI6r8WMhPytEUjT6uLYLJ
         cExJu5uJ0tdB6kjwdbK4Um6lTlZtKF62leIkSvASocAuXi20DEQFaqFdYwqHmzgeTSJL
         EekXUfNNzLHhW3+ARTGLRbGhQAG4qLidXgubjdDELCqmJYGfghXaLulX3paNl4nmI/M1
         YLOnsZLjHZYAAh0zt5EGwOZ7QQEUW0b1rfibLnT9dMZleNB+b9Hby1YoCoXi5gI5i+UY
         Jukg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PdIDFGQW4UYiVf0M69peoSmdiojSEaqNuqBV2NqZc8U=;
        b=ZI6SIYpzEl/RkwDiHcGj8CrIWBfZUFI0cQGotyG2zI7/9Fl3/8TKsjYMhL6EkfyGiR
         reLowfyfhdTNzOL6JwCsT8qMrPXlNZKgbaENR1cLY9q4pa71N8QiOoxXXZUhSCw8st9I
         SPH/1+d6iYLtU/Js6LGY+DgnvxCeBuYTYsEggkkXBm0d411sJ+3vwvNEWv5vV0Nmopg1
         Fu321DT7RI0Hm3ic65WSYWrgkBM84bENKmbJ3mHDVnlCPF4F2WoKRAiH5mytN1jFt3Rm
         S4TR77St9wNIUNaVIGl+bDw53bO54qeunsYKCyoHtty//IqM8rFo5Yq0MB68T7vVac8w
         br3w==
X-Gm-Message-State: AOAM533v6ckljPIh3dixPYmdyGd1VssO2XqpHn8hZW8pWr2Wj/tONifu
        ciBpaElkAYuRbX8AnyZPtxHvhw==
X-Google-Smtp-Source: ABdhPJwufc9Dw5netOvXCeF2GG9ESvEIF+T2ecye6tMC450yb9o/WVAtW1iX7f2vcwiYoZEUnqk7kg==
X-Received: by 2002:a9d:6503:0:b0:5e6:d8b6:f684 with SMTP id i3-20020a9d6503000000b005e6d8b6f684mr198853otl.289.1650050241494;
        Fri, 15 Apr 2022 12:17:21 -0700 (PDT)
Received: from [192.168.86.188] ([136.62.4.88])
        by smtp.gmail.com with ESMTPSA id eq37-20020a056870a92500b000c6699dad62sm1949141oab.41.2022.04.15.12.17.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Apr 2022 12:17:20 -0700 (PDT)
Message-ID: <76a7b33d-6f8b-e660-c64d-027b1bc8e308@landley.net>
Date:   Fri, 15 Apr 2022 14:21:30 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] sh: make !MMU iounmap an inline function
Content-Language: en-US
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc:     kernel@axis.com, hch@lst.de, kernel test robot <lkp@intel.com>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220414081257.1487499-1-vincent.whitchurch@axis.com>
From:   Rob Landley <rob@landley.net>
In-Reply-To: <20220414081257.1487499-1-vincent.whitchurch@axis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On 4/14/22 03:12, Vincent Whitchurch wrote:
> The current definition of sh's !MMU iounmap makes it unusable in certain
> kinds of code, such as this instance caught by 0day on a patch posted to
> the mailing lists:
> 
>  In file included from include/linux/io.h:13,
>                   from drivers/mtd/devices/phram.c:21:
>  drivers/mtd/devices/phram.c: In function 'register_device':
>  arch/sh/include/asm/io.h:274:33: error: expected expression before 'do'
>    274 | #define iounmap(addr)           do { } while (0)
>        |                                 ^~
>  drivers/mtd/devices/phram.c:150:44: note: in expansion of macro 'iounmap'
>    150 |         cached ? memunmap(new->mtd.priv) : iounmap(new->mtd.priv);
>        |                                            ^~~~~~~
> 
> Make it an inline function as it was earlier.
> 
> Link: https://lore.kernel.org/lkml/202204131446.omJ5mC54-lkp@intel.com/
> Fixes: 13f1fc870dd747131 ("sh: move the ioremap implementation out of line")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>

Tested-by: Rob Landley <rob@landley.net>

Worked For Me.

Rob
