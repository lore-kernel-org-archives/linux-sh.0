Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D551C5519F
	for <linux-sh@archiver.kernel.org>; Sun, 22 Nov 2020 14:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A9AE20771
	for <linux-sh@archiver.kernel.org>; Sun, 22 Nov 2020 14:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=landley-net.20150623.gappssmtp.com header.i=@landley-net.20150623.gappssmtp.com header.b="w8hh9Rym"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbgKVO7B (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Sun, 22 Nov 2020 09:59:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727817AbgKVO7B (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Sun, 22 Nov 2020 09:59:01 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A79C0613CF
        for <linux-sh@vger.kernel.org>; Sun, 22 Nov 2020 06:58:59 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id v21so11841301pgi.2
        for <linux-sh@vger.kernel.org>; Sun, 22 Nov 2020 06:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=kCKnqpS4v1c6yYr/H2VANlA8vsESB1rYjGCx5rncfR8=;
        b=w8hh9RymH64lFx8F+tAB4aflaL4SmPk/GuLgv1/nOaiudatFgp80F/HoWWlRhuUWhV
         qjJ1MXsNqa1qLzD/IriZjzZnexh1u85hDqjAJzXbK8ELq3B2C9A6qCNnYNJdiIsKTcSc
         5i4tuMeRAp+11uL4H/UVbzsJQmZLxurhvSXdRzj12gC3BGrbpW22V6FlMe32pNsuWEhI
         vZ+wrsQuVJzhSwNDfKFvf9PkJES4xkHxoOrrRP/Xr+ixTq3dwCV7YrelZ7huAorzMwZA
         iIP6ZQc/FR/ZSKd8/IoW+5P3GeYG2iMTg8PABIH8VVa5P5DPdDABM/2RyiFxQ0Wx6szD
         Mc0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kCKnqpS4v1c6yYr/H2VANlA8vsESB1rYjGCx5rncfR8=;
        b=pqfB5QagaVc2qrSPg/NcHSJIYv8G3x+aX1WJDKQ6loDgBI38SQnDC0xK1viQTh8Kw8
         laIYcTJ9p3C7LP2HmpcYw/xZOEKBUCS8KqaA1ItN0Lc2qSy6eMeA1Nc06gN4M4KJWXFy
         KWJprWuAhXUU2LQGtzonSrm//fzLfVlK0nouUzqunodcXzOoexF40jcsHXcHQSoOpDN/
         RwydloDo/mi8gl7mNsWSb0Rankirrnp8OpSRJ8U0Cr9gklvn+BQgQkCgTzThBw2eaRJH
         bR2jCXA5ykQa158gSk/N5two22AjTS86La5IBLh9NAOMOdBrskAog9eSeVjLemXNh1KT
         kIzQ==
X-Gm-Message-State: AOAM530vObG+QvuxIbl3yKveqKyyBlCIIt2lv7nlDymLVAMPGnVQPaeO
        Oe2L1rK2cWyZGxmUlXyYOW2eQjJqTD8taLcz
X-Google-Smtp-Source: ABdhPJx2n7B13ERxrk/xtKZ0MVfwmUxUGGdkN9ZtNwtQY+xN/FpLU7ZZvjPQD5xn15RMh8CCEXcTCg==
X-Received: by 2002:a63:4956:: with SMTP id y22mr24451135pgk.266.1606057138984;
        Sun, 22 Nov 2020 06:58:58 -0800 (PST)
Received: from [192.168.11.16] (softbank126112255110.biz.bbtec.net. [126.112.255.110])
        by smtp.gmail.com with ESMTPSA id e8sm9366427pfj.157.2020.11.22.06.58.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Nov 2020 06:58:57 -0800 (PST)
Subject: Re: message ids
From:   Rob Landley <rob@landley.net>
To:     Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>
References: <401c48c1-ccf1-8177-d45b-eb632ba799df@landley.net>
Message-ID: <e43e6569-99bb-4e24-e9c5-45f9c3244d86@landley.net>
Date:   Sun, 22 Nov 2020 09:10:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <401c48c1-ccf1-8177-d45b-eb632ba799df@landley.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On 11/12/20 1:47 AM, Rob Landley wrote:
> Message-Id: <20200917154547.139019-1-fazilyildiran@gmail.com>
> Message-ID: <93d98bab-01dd-5530-9fdb-76faf8dcdd41@infradead.org>
> Message-ID: <20200919025206.17729-1-miaoqinglang@huawei.com>
> Message-Id: <20200924043139.522028-1-hch@lst.de> # does not apply with git am???
> Message-Id: <1602474624-3225-1-git-send-email-hejinyang@loongson.cn>
> Message-Id: <20201012154050.68039-1-andriy.shevchenko@linux.intel.com>
> Message-Id: <1604889952-30841-1-git-send-email-wangqing@vivo.com>
> Message-Id: <1604889303-26722-1-git-send-email-wangqing@vivo.com>
> Message-ID: <66582445-4ec9-86d0-e286-8e21590f608a@kernel.dk>
> Message-Id: <20201110154939.3285928-1-geert+renesas@glider.be>
> Message-Id: <20201110155029.3286090-1-geert+renesas@glider.be>
> 
> I have no idea why the hch@lst.de one applies with "patch -p1" but not with
> "git am", that's where I ran out of brain. But they all apply as patches and the
> result boots.

FYI here are the patches from this list I forwarded to Rich right after -rc3
came out. They built in my local tree, the result booted, and I didn't spot
obvious regressions.

If anybody else wants to try them, I can put them in a -git tree or attach them
to an email?

Rob
