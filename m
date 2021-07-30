Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF2EC4338F
	for <linux-sh@archiver.kernel.org>; Fri, 30 Jul 2021 00:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CD84603E7
	for <linux-sh@archiver.kernel.org>; Fri, 30 Jul 2021 00:01:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235199AbhG3ABY (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Thu, 29 Jul 2021 20:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235179AbhG3ABY (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Thu, 29 Jul 2021 20:01:24 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66253C061765
        for <linux-sh@vger.kernel.org>; Thu, 29 Jul 2021 17:01:19 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id c16so8883347plh.7
        for <linux-sh@vger.kernel.org>; Thu, 29 Jul 2021 17:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jmfaji+9M/QC/wTT+8FBRce+Fu/vs2mWCLqtmeZ4Wrs=;
        b=T1fohr2z3qw+DajeU7gQdW2GaaZVIWM11rbVQKZTG6iRDv1IsC7tSk4Bj6VJvxo+fB
         zKSFMxpbNiKIhcAywviTiuwVucnKPMQy72HVwESKK3QM/5PlE4ZpTxLuCByJcmU2J3w4
         85KCG17EaPOjnjcmulVyYqQJ7OZgc9Cf6E1IS9MPpBnQNgQsTfCLRZd0lzxUf1qdGorV
         70l8FtFM+rFRqnL83MmKFPFxRPxmTOsAwrO/mxow3oE2JvyIvGI5KwT4qOZTE8vP8BdQ
         B5CgD4t2yipeFTX79+fTb5Notzlo02/fJxaPTKyNwu0xOelkHGGN1A/oBISgkYyFb0kl
         O2sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jmfaji+9M/QC/wTT+8FBRce+Fu/vs2mWCLqtmeZ4Wrs=;
        b=RktMtIPjWg+YhAIGkk0PUxxEifC3jxvN6MG/qX76WRUW90VQ3CrBjM9iGNn7m+eiRJ
         dVfQMg/gGof4mmVy9YMJNiKcOxJY/XPuZvVmeIWyJdupplGEcUh1R4Dg3hTCOfjc7hQC
         idKLB033Fw9SUaS1tlqiBcMglix1XveiE80KOSTg3QdMnmR3NUTmV8WWYPqbVnp8MfpK
         Y+VoSI4j6P9mN8MUGH3Vn7zs98jSZX+9j1qdFpChjnt3HbF+RKR/32yW2795WxC1VKYJ
         KktqYf2ZofVUvYA51sKa+mzM87HvGsYACDAf6q6HVg754O31azXDy/+A9/urS4+qUhSy
         LKQw==
X-Gm-Message-State: AOAM532k4JDeOUrKJRudlBeNDarqI3G3y82s8qnIvBEwYWzdNkzCjJ95
        cjIw6d/T01g13bvIHeXTZecxhTIjKWyVKA==
X-Google-Smtp-Source: ABdhPJwyqPqyYEh2SmlifUi7S3yQPUra5Yhe6ehxK8XCdihQ23k83OMJot3HyVh4dsDP98vIy/NTZg==
X-Received: by 2002:a17:90a:d18d:: with SMTP id fu13mr7268pjb.206.1627603278888;
        Thu, 29 Jul 2021 17:01:18 -0700 (PDT)
Received: from ?IPv6:2603:800c:3202:ffa7:c4c7:6719:c57e:8ffe? (2603-800c-3202-ffa7-c4c7-6719-c57e-8ffe.res6.spectrum.com. [2603:800c:3202:ffa7:c4c7:6719:c57e:8ffe])
        by smtp.gmail.com with ESMTPSA id x26sm4828346pfj.71.2021.07.29.17.01.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jul 2021 17:01:18 -0700 (PDT)
Subject: Re: [PATCH for-6.2 12/43] target/sh4: Implement do_unaligned_access
 for user-only
To:     Peter Maydell <peter.maydell@linaro.org>
Cc:     QEMU Developers <qemu-devel@nongnu.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Linux-sh list <linux-sh@vger.kernel.org>
References: <20210729004647.282017-1-richard.henderson@linaro.org>
 <20210729004647.282017-13-richard.henderson@linaro.org>
 <CAFEAcA9yrj7OZPkeZ2jUqAV4+ULVYm4++y6kXeK2_MC8gR3-bg@mail.gmail.com>
From:   Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3318f1ba-0963-155d-4fe7-3de9bf7ee0f6@linaro.org>
Date:   Thu, 29 Jul 2021 14:01:15 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9yrj7OZPkeZ2jUqAV4+ULVYm4++y6kXeK2_MC8gR3-bg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On 7/29/21 3:52 AM, Peter Maydell wrote:
> sh4 kernel default for unaligned accesses seems to be "warn and fixup",
> not SIGBUS, unless the user changes that by writing to /proc/cpu/alignment
> or the process changes it via prctl().

We will still need this for load-locked/store-conditional (MOVLI/MOVCO).

It appears that the sh4 kernel fails to decode these properly, and will do something ugly, 
like interpreting MOVLI as a multiple-store instead of a load.

There are also other instructions that the kernel does not attempt to handle, such as MAC. 
  I suppose we could begin with turning off TARGET_ALIGNED_ONLY for sh4-linux-user, then 
re-enabling MO_ALIGN for the atomics (at least).


r~
