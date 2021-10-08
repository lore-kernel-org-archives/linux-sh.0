Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF5F6C433F5
	for <linux-sh@archiver.kernel.org>; Fri,  8 Oct 2021 18:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A0B960F44
	for <linux-sh@archiver.kernel.org>; Fri,  8 Oct 2021 18:19:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbhJHSU7 (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Fri, 8 Oct 2021 14:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238481AbhJHSU5 (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Fri, 8 Oct 2021 14:20:57 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E5AFC061764
        for <linux-sh@vger.kernel.org>; Fri,  8 Oct 2021 11:19:01 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 5-20020a9d0685000000b0054706d7b8e5so12726871otx.3
        for <linux-sh@vger.kernel.org>; Fri, 08 Oct 2021 11:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Wvco89YLBu0DEdVBRR/EZqf56tHvQxnFA9DIAVgf/4Q=;
        b=CCbppUTIUQvTjkPUaUNiIHgqJbgfmRNPXmRT0POd8fNlqCBD/ASCphs6/oyKfJ3/L/
         +3wrqJqEKdzzsG+oz2MqRyT2Bq2Tk7YsMgbAGe26W0XPv1PV3WI+65G/rIhv3eZG7p5s
         R69vHTlKA/zlGfIKR9E7JHwqWRMJNPTgPC6ssQ0JzuqMCMPYPH/BReAN8eSCIBnl8QwZ
         KoL6rBwxW3SNsQRVbaqjqr1RlLUuozfgwyXifXrnr283vkw61czYE3gCi8MGKRKuSYXK
         aa6kcjdCnWHA5Bwj3jHBcFlaUowp+vnjYlibtNIaf70uh0MUZeVxaMBwlKd+iLf9p93O
         kJ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Wvco89YLBu0DEdVBRR/EZqf56tHvQxnFA9DIAVgf/4Q=;
        b=SFp0aUbWiP2Dr0qUXIXb03seTClzS2lTkBUYVJ6W95zU1L8DhJLFLHIiggBT87TdPu
         8NK3zmBGrqy8cjuXR75t4AKVK653vXo0rrvOmSU5/Nev63jkzkfrQTT+Qa3hGNygfLDs
         el9DzzLRHKvdc7pVDaEuhYNLxJmln314K4ZXtBOJekXL5mSONVlXYtXa/jfFgAlDMtBf
         xJ7uD6LC+EwHvDAknelGJ/t0e+3QoIAvVrofpvICtBbUCQDJ5GZmASDPIg6n6legBoUL
         Ue1Oi8lFJhMQrDumY4jtGU/Q5YnG+vD0DcwRJON0nFhc9Mirk6g2V2iwD00PF2e5Q8AU
         TUBg==
X-Gm-Message-State: AOAM532ZdQqvbWs8hJXNoMVHeSn9Spy+eFBgygrWNIjDyy498JZPa7Tw
        Mf/iXAkOgxoEufgGqWKhhngSbg==
X-Google-Smtp-Source: ABdhPJyUheagIg/hKhzvfZcpPOdSHlnIcX7BlEOe1hmwytswtWoq7wiueZrmeNbi1o5kX5XDLaGFNQ==
X-Received: by 2002:a05:6830:95:: with SMTP id a21mr10280463oto.43.1633717141031;
        Fri, 08 Oct 2021 11:19:01 -0700 (PDT)
Received: from [192.168.248.11] ([172.58.83.190])
        by smtp.gmail.com with ESMTPSA id bj33sm33556oib.31.2021.10.08.11.18.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Oct 2021 11:19:00 -0700 (PDT)
Subject: Re: [PATCH 5/5 v3] sh: fix READ/WRITE redefinition warnings
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Takashi YOSHII <takasi-y@ops.dti.ne.jp>
References: <20211005001914.28574-1-rdunlap@infradead.org>
 <20211005001914.28574-6-rdunlap@infradead.org>
From:   Rob Landley <rob@landley.net>
Message-ID: <1191978c-be37-87b1-bbc9-f0aa128d0961@landley.net>
Date:   Fri, 8 Oct 2021 13:39:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20211005001914.28574-6-rdunlap@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On 10/4/21 7:19 PM, Randy Dunlap wrote:
> kernel.h defines READ and WRITE, so rename the SH math-emu macros
> to MREAD and MWRITE.

This one doesn't apply for me. My file has:

#define WRITE(d,a)      ({if(put_user(d, (typeof (d)*)a)) return -EFAULT;})

But your patch tries to remove:

-#define WRITE(d,a)     ({if(put_user(d, (typeof (d) __user *)a)) return -EFAULT;})

Which is odd because git log says my tree is current as of today, but git log on
this file says it was last updated:

commit 2e1661d2673667d886cd40ad9f414cb6db48d8da
Author: Eric W. Biederman <ebiederm@xmission.com>
Date:   Thu May 23 11:04:24 2019 -0500

What did I miss?

Rob
