Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8366BC433EF
	for <linux-sh@archiver.kernel.org>; Fri, 27 May 2022 17:35:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348149AbiE0RfO (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Fri, 27 May 2022 13:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344304AbiE0RfO (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Fri, 27 May 2022 13:35:14 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C166CAB8
        for <linux-sh@vger.kernel.org>; Fri, 27 May 2022 10:35:13 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-edeb6c3642so6559362fac.3
        for <linux-sh@vger.kernel.org>; Fri, 27 May 2022 10:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=+szD65DmTWurjSWc6XMInWuLlWeYAEXbxBl34qJ8DzQ=;
        b=UCx6oxE5VGIe6WdPUoI0m4ILu4fXJgqFItcGmnINibH81JK5epfQq7/rMYf3SqllJz
         3eitv9c7a1KnSPVRKqOijsGg1/gnDVRjzfQcMpTJ0WMPDE4C/+L5UjVPulTlEGCka2+I
         m0T7hPWp7tsKXSKAwLEg3+wsTZxO2z3FnNkizNiFSQZ0mYc0qqTd/pCdUlUTklDHWky0
         Me1elGJ1R5N16q7hvDxPr/WHQKowWPmm44rk/obeZYxpeWdf01EAxLBC+UcNDagCn7hG
         jal02QgYfrecM8ozE+lDz/bbp2h79pi/utbh16vvYJvUkalvEpTQs4IeiwmH6WGTQ2ta
         nFBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+szD65DmTWurjSWc6XMInWuLlWeYAEXbxBl34qJ8DzQ=;
        b=mFqqusFqtuAdEkQx1xgp88JL63SyATuswQJkZ81fvEofbb8gMzVFS3wthJAN4vfcnD
         nlgyFlxqFhF5d9kICnDgltubNB+y5o438vmg/wJ4S6SAk0guDLr8NWpOLtnZhfqLnJKJ
         +RZK8qhQs9oQYEQMpPne/L/oIFbF4F7oiHNr1Qdw47xzsRGV8+vdbtwZZhaeH8di89B8
         kS0paRyThwAWscYM0u9Y9u14uEJY3SNun4bYECQppw/NY04btWtKVbXImOPRoZAJ/r2P
         3ebMf+5VsfGGeA1zNt6ud/VNZqCdpmLGH7oYhdui2axfA2MjTuIRQzUAdFJFWFmtmYfo
         KyiQ==
X-Gm-Message-State: AOAM531QCeYvy2fpK4YX+lg9Hq6Fo+2BZJVIRiTL34PZSG3+7x0DznJ7
        bCxi21/GXh96NOAJZIcGTerHFA==
X-Google-Smtp-Source: ABdhPJzRl3ALQ41P61IlZIx5u1JKEKWFV4mPpQqbko2cukGTATWaaooh9t/Q/zJtolEcvF0I19Xu5w==
X-Received: by 2002:a05:6870:610d:b0:f2:ebb1:54fd with SMTP id s13-20020a056870610d00b000f2ebb154fdmr2853546oae.26.1653672912881;
        Fri, 27 May 2022 10:35:12 -0700 (PDT)
Received: from [192.168.86.194] ([136.62.38.22])
        by smtp.gmail.com with ESMTPSA id f9-20020a056830204900b00608b8e6fad5sm1981126otp.76.2022.05.27.10.35.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 May 2022 10:35:12 -0700 (PDT)
Message-ID: <6b3f7c1f-35a6-13ba-c0b3-c3b3b6532b1c@landley.net>
Date:   Fri, 27 May 2022 12:40:34 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] sh: clk: Extend valid clk ptr checks using IS_ERR_OR_NULL
Content-Language: en-US
To:     Phil Edworthy <phil.edworthy@renesas.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc:     linux-sh@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
References: <20220523091633.5217-1-phil.edworthy@renesas.com>
From:   Rob Landley <rob@landley.net>
In-Reply-To: <20220523091633.5217-1-phil.edworthy@renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On 5/23/22 04:16, Phil Edworthy wrote:
> In order to allow all drivers to call clk functions with an invalid clk
> ptr, ensure we check not only for a NULL clk ptr, but also for errors
> before using it.
> 
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> ---
> Note this has not been tested at all, I don't have any SH boards.

Tested-by: Rob Landley <rob@landley.net>

Rob

(Not _extensively_ tested because I dunno what I'm looking for, but it compiled
and booted to a shell prompt and I could wget a file.)
