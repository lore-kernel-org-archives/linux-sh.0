Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25FAAC49EA5
	for <linux-sh@archiver.kernel.org>; Sat, 26 Jun 2021 22:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE59161434
	for <linux-sh@archiver.kernel.org>; Sat, 26 Jun 2021 22:21:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbhFZWYD (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Sat, 26 Jun 2021 18:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbhFZWYC (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Sat, 26 Jun 2021 18:24:02 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C414AC061574
        for <linux-sh@vger.kernel.org>; Sat, 26 Jun 2021 15:21:39 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id d1-20020a4ad3410000b029024c4d2ea72aso1377783oos.4
        for <linux-sh@vger.kernel.org>; Sat, 26 Jun 2021 15:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EQeMaNA1sVIhvvCwAtXf5WDd9aEzcx0UGJ2b2e8S1WI=;
        b=x7gRX9kYEdxgO3H3q7FVjpP56A/eSYVNMePBCWwBZ5p2LYZbEvvY4oi+2rZSKhBe9o
         UP7Ciuj358RrD0g/+NmOapc/0YL/TX0uZ5LfJ4sxIpuMLK8gLxt3QgZHT9YBerY6y3V2
         /wpwuqsQ3xmXOzQE9v1J1SnnlAHMKlCVDnl/xRA/SiVkpwILXxWNxvKbQLUOIcbEw4wa
         mpb/FuHNeklum6jmgTDdX1L5KpGUKcpxJPDyyNewzqnLV9mbXOuky7+PVx/VjSf2Hj8s
         PGdDN93OqTqzprNHRqnWmJJLG5gF0Mv9ViKuUi5moGrnmGu43gG4OVbxNGmB7u46C2jP
         7PSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EQeMaNA1sVIhvvCwAtXf5WDd9aEzcx0UGJ2b2e8S1WI=;
        b=iz93P1DJs5F7cO8oUihCXcaeV32LddWrKw3K2ODOZ26m5UArRN6LW5ORNnJwBLlYco
         mxEPjYlWxp7MrbTEvV24TG9uO8lyPGw0myiYpb30ecE/qqcwHDAGznVqI3f2aeogTTfQ
         TRPGQAcZVz8Tx1rY3lNxNi1howBJ/5bzRFLgbmUTCY+Gb+GBi2aa73fiaPBChK/gnOUK
         81WOWqiHWuaHjtkyt6xT6EloX2a5buUGHYl6+FRpM7tCjyX1P8y/ArGBg31CGzS/VWQu
         1KDhUMXBMTorAU93N1Jdqp4n0Rdm+EE/XtJG4HmbBt60VsIw/wkjjVrnNWNVFvdR5zbO
         G3ng==
X-Gm-Message-State: AOAM5301XyY+ZPpKmMIhCMLBAzIzpcIZQtP40fEhuAVek6r7c/2ZdJlx
        16jo3hp/mSqd1kJZAymi6h8y4z93RAZu9o1K
X-Google-Smtp-Source: ABdhPJz/nrFvpOMBVeo9EF/HEEqqHNrn+wy26MGzkHh5cFroID99bjbKbRCrkFdgV4g71y6zd175xA==
X-Received: by 2002:a4a:ba01:: with SMTP id b1mr1058673oop.0.1624746098708;
        Sat, 26 Jun 2021 15:21:38 -0700 (PDT)
Received: from [192.168.86.166] ([136.62.4.88])
        by smtp.gmail.com with ESMTPSA id d10sm2081542oop.3.2021.06.26.15.21.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Jun 2021 15:21:38 -0700 (PDT)
Subject: Re: dma_declare_coherent_memory and SuperH
From:   Rob Landley <rob@landley.net>
To:     Christoph Hellwig <hch@lst.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     linux-sh@vger.kernel.org
References: <20210623133205.GA28589@lst.de>
 <1a55cf69-8fe1-dca0-68c7-f978567f9ca0@landley.net>
Message-ID: <f81cf0d9-c7c1-fa08-8839-dd12b9b9ae92@landley.net>
Date:   Sat, 26 Jun 2021 17:38:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1a55cf69-8fe1-dca0-68c7-f978567f9ca0@landley.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Pulling in the debian sh maintainer, who was one of the participants in the
earlier discussion...

On 6/26/21 5:36 PM, Rob Landley wrote:
> On 6/23/21 8:32 AM, Christoph Hellwig wrote:
>> Hi SuperH maintainers,
>> 
>> I have a vague recollection that you were planning on dropping support
>> for non-devicetree platforms, is that still the case?
> 
> We'd like to convert them, but have to rustle up test hardware for what _is_
> still available. (There was some motion towards this a year or so back, but it
> petered out because pandemic and everyone got distracted halfway through.)
> 
> (We should definitely START by converting the r2d board qemu emulates. :)
> 
>> The reason I'm asking is because all but one users of
>> dma_declare_coherent_memory are in the sh platform setup code, and
>> I'd really like to move towards killing this function off.
> 
> Understood. Is there an easy "convert to this" I could do to those callers?
> 
> Rob
> 
