Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92AD6C43334
	for <linux-sh@archiver.kernel.org>; Wed,  8 Jun 2022 01:11:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbiFHBLh (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 7 Jun 2022 21:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1587877AbiFGXxr (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 7 Jun 2022 19:53:47 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9410D2F018
        for <linux-sh@vger.kernel.org>; Tue,  7 Jun 2022 15:50:43 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id q184so8926950oia.1
        for <linux-sh@vger.kernel.org>; Tue, 07 Jun 2022 15:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=e8ENrtIbjY7+ujNuh6Tj/bUga0MuFUeslU3izMPi9Q4=;
        b=5GhBg18NLPAgGo65m7wpJuE5gTzXpD4A+/+sktUFqmKGmrsnDqi5Ps9yBpdY8/7mfr
         WjlhWg4IGhf7pkmXuYjSU76/RzUbQdjfswBA8anoHeFzL+5EAcDV+8KusQxfT8bTmGe0
         OB3aXs7QSVDpQHWWahTgaGObb9eoDeY1tPORQ9M7j0b+XG5DZjxETgxJP8cLm15bCChg
         VxFWHxBhF9mjh+nfYPU4+Bp99/iSKDz9h3xQzveDxBLROCfSSSqH37SVH27JYvnA5x8o
         2trDNzCgr2VeAkpCmoXu1g1d96kCcxFgN+CfxjKF+YFuhROIiMlIYkpLov0yhhtqwilo
         Buww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=e8ENrtIbjY7+ujNuh6Tj/bUga0MuFUeslU3izMPi9Q4=;
        b=hxHxwQTH28NE50OKxc7dZn+nNAO6W2atmr2L6Ej7wHuyWd3jSE9xBRStcO15GBcb7o
         m1WU+1abOky7+fsJjh9v7kkKpVIYZJFNYifFADzFXweU5cnNTNFcUaxu5b2TE40X3f/N
         P8oKBxzUot2xWQveiVX/E5lV8xYwlR0kf+nHOIYMk0m4e/SrIbsbqQuRW3SPFRSk2g04
         sY/T+JMTAbuSz2Ol20N6UzRwmgfQuiDdeHL8+E6FCXRSSTy8EocqTPxEw3WN3KqPUYyu
         KX5xo2yo3zamglRHI1mHlEjiK7yyRU/VHHF0DVi39niKMz+r5m3vPbVj81lBWQCIPeyQ
         YPNg==
X-Gm-Message-State: AOAM531GID9LnEzFutrmuwatrs8+7Mm2A51gHSNHSFcWwDdAgIL5bT57
        Mou3+JGqq6yuDixNr/ookXId9zn3McnbIg==
X-Google-Smtp-Source: ABdhPJyWEQTQO2zLzeUayJqxgrXyNOD6LJaalYRS/nAOx1ID2klaXccVepGxDif8A/xuMdNbwO+j7A==
X-Received: by 2002:a05:6808:308e:b0:32b:1f24:34c4 with SMTP id bl14-20020a056808308e00b0032b1f2434c4mr734588oib.147.1654642242919;
        Tue, 07 Jun 2022 15:50:42 -0700 (PDT)
Received: from [192.168.86.195] ([136.62.38.22])
        by smtp.gmail.com with ESMTPSA id k6-20020a9d7dc6000000b0060bfb08741esm3409804otn.12.2022.06.07.15.50.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jun 2022 15:50:41 -0700 (PDT)
Message-ID: <c24579a3-74e4-1dbb-6237-d9e1a01e6e09@landley.net>
Date:   Tue, 7 Jun 2022 17:56:22 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] sh: cast away __iomem to remove sparse warning
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>, ysato@users.sourceforge.jp,
        dalias@libc.org
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
References: <20220507013411.74277-1-bhe@redhat.com>
 <YpS0C8tVG2E5jGSV@MiWiFi-R3L-srv>
From:   Rob Landley <rob@landley.net>
In-Reply-To: <YpS0C8tVG2E5jGSV@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org



On 5/30/22 07:09, Baoquan He wrote:
> Hi,
> 
> On 05/07/22 at 09:34am, Baoquan He wrote:
>> LKP reported a sparse warning in arch/sh/kernel/crash_dump.c during
>> a kdump patchset reviewing:
>> https://lore.kernel.org/all/202204082128.JKXXDGpa-lkp@intel.com/T/#u
>> 
>> ../arch/sh/kernel/crash_dump.c:23:36: sparse: warning: incorrect type in argument 1 (different address spaces)
>> ../arch/sh/kernel/crash_dump.c:23:36: sparse:    expected void const *addr
>> ../arch/sh/kernel/crash_dump.c:23:36: sparse:    got void [noderef] __iomem *
>> 
>> This warning happened when __iomem pointer is passed into fucntion
>> which doesn't expect it. Casting away the __iomem can fix it.
> 
> This warning was reported by lkp during one patchset posted and
> reviewing. Since it's not related to the patchset, I just sent it
> separately so that later code change on arch/sh/kernel/crash_dump.c
> won't trigger the lkp warning again.
> 
> [PATCH v5 RESEND 0/3] Convert vmcore to use an iov_iter
> https://lore.kernel.org/all/20220408090636.560886-2-bhe@redhat.com/T/#u
> 
> Now the above patchset has been merged into linus's tree, please
> consider taking this patch.
> 
> Thanks
> Baoquan
> 
>> 
>> Reported-by: kernel test robot <lkp@intel.com>
>> Signed-off-by: Baoquan He <bhe@redhat.com>

Tested-by: Rob Landley <rob@landley.net>

Rob
