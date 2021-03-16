Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F29BC433E0
	for <linux-sh@archiver.kernel.org>; Tue, 16 Mar 2021 08:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E14064FB9
	for <linux-sh@archiver.kernel.org>; Tue, 16 Mar 2021 08:19:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbhCPIT0 (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 16 Mar 2021 04:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234395AbhCPISx (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 16 Mar 2021 04:18:53 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB11C061756
        for <linux-sh@vger.kernel.org>; Tue, 16 Mar 2021 01:18:52 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id si25so14927240ejb.1
        for <linux-sh@vger.kernel.org>; Tue, 16 Mar 2021 01:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OmmE3ufEAvDgtjy9vpprocD5iN2+Uqu85g8HBGh8RxU=;
        b=LHEgSMvc3cWqM90kZ4gvD6TaEqf3+6Z+QFwyFujTOXKuj8vhH9mBpNX24ZIrVsOI02
         U0la/1WtXHDdzlaSo720o1SWFpzEDdwIH9xsmFuVg2t6SfJcr8NK3Jkd0yX8Dq+NDWOJ
         KChtHzbHPP17LCyJCpNdZf10gUXrkW2ch4mGY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OmmE3ufEAvDgtjy9vpprocD5iN2+Uqu85g8HBGh8RxU=;
        b=RcOXy5Go13vdo6X8mg6HVUUUN5iEOoMdtl1GU9kosF9K75sCtjeWQf4bx5TrKoWbWq
         gB17V8US3vvXSHz3N1EsR76auA1c1YPdtpWFJC4qpqY49pauRXk0N9RaJeLmbISdR3yP
         T45Rjnar9F5riD6q8blyvBm4M8N5kIAIR0R4E1G9sSV8s4Fb7PgNnuVy0OAeJXiaUvXh
         j7D/hsxJLI8/gJzeHJ1o1lLgbzoaNiNKyv3f2KwlaP+grFy/t5kF9osvGc31SDo463H6
         1lT78DIEGPPgrF2fObyTbXGVOmfKm5pfXdVJZEXfyfcaJuqgmgSTPUs4SdWbBNBKgiul
         0Ruw==
X-Gm-Message-State: AOAM532dsNRXSxtI8zwPTxkIdPB1Jf+S71gIMzwSR7XE4L0G8jENgKC7
        LHFjElyXolEMU1ZQYOcbO/G6qg==
X-Google-Smtp-Source: ABdhPJwKtInEZcyt1fXWt+TUJ77BSu39uwuRxne2DMvOwoF0XUOOeiBRKdKwwpuOnjLLSOFZ1bvRaA==
X-Received: by 2002:a17:906:a248:: with SMTP id bi8mr28148535ejb.260.1615882731772;
        Tue, 16 Mar 2021 01:18:51 -0700 (PDT)
Received: from [192.168.1.149] ([80.208.71.248])
        by smtp.gmail.com with ESMTPSA id u24sm5149640edt.85.2021.03.16.01.18.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Mar 2021 01:18:51 -0700 (PDT)
Subject: Re: [PATCH 02/13] tools: bitmap: sync function declarations with the
 kernel
To:     Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org
Cc:     linux-m68k@lists.linux-m68k.org, linux-arch@vger.kernel.org,
        linux-sh@vger.kernel.org, Alexey Klimov <aklimov@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, David Sterba <dsterba@suse.com>,
        Dennis Zhou <dennis@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jianpeng Ma <jianpeng.ma@intel.com>,
        Joe Perches <joe@perches.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Rich Felker <dalias@libc.org>,
        Stefano Brivio <sbrivio@redhat.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
References: <20210316015424.1999082-1-yury.norov@gmail.com>
 <20210316015424.1999082-3-yury.norov@gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <4d1a1616-1e6d-fcef-82ab-38083a2430b8@rasmusvillemoes.dk>
Date:   Tue, 16 Mar 2021 09:18:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210316015424.1999082-3-yury.norov@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On 16/03/2021 02.54, Yury Norov wrote:
> Some functions in tools/include/linux/bitmap.h declare nbits as int. In the
> kernel nbits is declared as unsigned int.
> 
> Signed-off-by: Yury Norov <yury.norov@gmail.com>

Acked-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
