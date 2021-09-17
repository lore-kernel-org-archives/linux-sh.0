Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AAAEC433EF
	for <linux-sh@archiver.kernel.org>; Fri, 17 Sep 2021 01:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 103386120F
	for <linux-sh@archiver.kernel.org>; Fri, 17 Sep 2021 01:12:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242091AbhIQBOS (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Thu, 16 Sep 2021 21:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242082AbhIQBOR (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Thu, 16 Sep 2021 21:14:17 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D21D0C061756
        for <linux-sh@vger.kernel.org>; Thu, 16 Sep 2021 18:12:56 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id g9so10173858ioq.11
        for <linux-sh@vger.kernel.org>; Thu, 16 Sep 2021 18:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=COgu+Smzr2YqzR6tkm3PXZN/dACB/9XYE3hlM4YA6dw=;
        b=cV4WEVACT1XlzzF99FIFhp8x5uYBhSgMe7jqweUbWVmc1Ry9Tr/CEjKSNdLYNE3aqG
         AgovWF3HfeOjv/aLlDvNZe2sMbZaUhQCbPK7KKdNi3Pkp2jiJWLlg/QrBiyLBU1yWKCl
         we25+Dwpx+oGwkkPGprDKrERAXzmTjbmaY6esh8vk7xKKBvTgkA+ql7KCPJ5U9sGUzW9
         STNUpFpQ5OSqzlwTEZnRUJU/gvDdpAXCfJLZg0noYSkNHx2A0medx5FSSDcR198qtrF+
         MNs/du/6gPDaqPw2Qm9kWpIddxIVyXH69lrR4DMgpCMGhfBQ8iWtBZIhJ9ScJXkwB6Un
         tKRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=COgu+Smzr2YqzR6tkm3PXZN/dACB/9XYE3hlM4YA6dw=;
        b=27LYVlJzJ+DjfkVe4BIXx1jv+imqIv0Y3C/kQHSNSnTf4TFxMJhnCWpK94cOijsPJd
         KCfw0B1JiiDD9y0lAhPmYhY5Ozu4ZYWivmT+ckHp3/7ZH3q8Gx7BwewliwqA1X2ARTJS
         fKSV5aJhUgAelZdYAM5A2HbfUmZBw0tJWZNX1qj8vya45ErxnvzcvsV0MUbbSvoXWPyO
         z3L0HaEKN/Kjr/E7P53q3htMQ3dt6oP6sF21gO0O1MwFnZnVywTr/3NpdVE+t0+WZa1X
         PT+jRF1CClo1Nx87fU9u9jEjh5Rw577YfqsVFNYI+SZrGQZ4JL68roisIMLPJyfQzRqu
         GHjQ==
X-Gm-Message-State: AOAM5315p2w1mnkq194URK3taVCEZr+4GZ/eyN41EtBIx1XAWUrZ+4sF
        x/zKRDS/CuYd0Q4di4OMZqvqOg==
X-Google-Smtp-Source: ABdhPJy9lqKWDc2vVJ1gP4OMkSbqb54JEPrZrf+SC60tX+YO99loypj7WK7n8H+TA7khKxnjc+uaTQ==
X-Received: by 2002:a5e:a70c:: with SMTP id b12mr6478854iod.119.1631841176222;
        Thu, 16 Sep 2021 18:12:56 -0700 (PDT)
Received: from [192.168.5.221] ([172.58.140.85])
        by smtp.gmail.com with ESMTPSA id x16sm2561006ile.63.2021.09.16.18.12.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Sep 2021 18:12:55 -0700 (PDT)
Subject: Re: [PATCH] sh: pgtable-3level: Fix cast to pointer from integer of
 different size
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Daniel Palmer <daniel@0x0f.com>, linux-sh@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <2c2eef3c9a2f57e5609100a4864715ccf253d30f.1631713483.git.geert+renesas@glider.be>
From:   Rob Landley <rob@landley.net>
Message-ID: <1acace03-4273-a5ad-50b4-5ab8e3baa551@landley.net>
Date:   Thu, 16 Sep 2021 20:32:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <2c2eef3c9a2f57e5609100a4864715ccf253d30f.1631713483.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On 9/15/21 8:50 AM, Geert Uytterhoeven wrote:
>     arch/sh/include/asm/pgtable-3level.h:37:9: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
...
> The truncation to "unsigned long" has been there since forever, so
> probably it still works fine ;-)

1) Linux is LP64 so sizeof(long) and sizeof(pointer) always match, so it's not
truncating.

2) The sh5 only ever shipped evaluation units, it never had a production run,
and we haven't implemented j64 yet, so all superh targets are currently 32 bit.
(I.E. it's complaining about _expanding_ the pointer, which shouldn't be a
problem as long as endianness is respected.)

Rob
