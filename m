Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D10EB64D8
	for <linux-sh@archiver.kernel.org>; Wed, 14 Jun 2023 18:45:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjFNSp6 (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 14 Jun 2023 14:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjFNSp5 (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 14 Jun 2023 14:45:57 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C7C2133
        for <linux-sh@vger.kernel.org>; Wed, 14 Jun 2023 11:45:55 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1b3c578c602so27478505ad.2
        for <linux-sh@vger.kernel.org>; Wed, 14 Jun 2023 11:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686768355; x=1689360355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ClhXyTMCOAhGnHue/rYnwljuM17idvr3usaXpO/VYvI=;
        b=iN5gmCcfAB7dsmep+MstonHEHRYzEhlS+IDRUeD1FVo2baBN7gE1e/6OykHCJtDM6k
         Aiv//w+9AXJ/zy/NXNT20xnVtwfIlXKbYo/O5dPK5a9/RFmRk3PVym1cdIHem0bj4BEf
         as7tjxepzRLn+7/UlA4gAW6PAVikEu3RC1W1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686768355; x=1689360355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ClhXyTMCOAhGnHue/rYnwljuM17idvr3usaXpO/VYvI=;
        b=Q1jzsft28/6fUM9lLfDxmNOLOEUv2txh0lrX1pbJTYR3T6CCQ+ec/+t/V7GW1+r5y9
         sCAtMjDKvjZGWeDHbu1cpsqmPKYOC3QuKmifkWJxeTWhV0MqhZkVm7ALq/mblY7wfwXP
         ZNKxtPP9eLmuncsXgqAEmbyykM/E0RbVIe4GUbM/IC2cQQBh49TPEXmEErq7/DzYfBmi
         UlOr/UgRr3FB0oRUDCXJ2hFWAerhk+pDUV1xytJ1MI+N8chzDLBNZebHAR13n7RRPTGj
         sOZ8hgOXEyU7Tn8xIPRMO5JrRepQSq/sK2LqDLwguXEU0qBMxBG7mf+Mi4yQhDAidDzi
         ny2Q==
X-Gm-Message-State: AC+VfDza+z7Fm5VlZkSARTYAvab4bLgcG6G1wkL4xQ6xQf6bisCSl3XZ
        2jkL15PtI1m9ibOfbddj7puU6Q==
X-Google-Smtp-Source: ACHHUZ6J3AlNKEtdy+6aTy3emeKWFNXqfnFihyGEv/Pc0nkR+DlArJgpJPxQ9pGtGnsi+YY/88GzpA==
X-Received: by 2002:a17:902:d389:b0:1b3:b84b:9017 with SMTP id e9-20020a170902d38900b001b3b84b9017mr10213717pld.14.1686768355338;
        Wed, 14 Jun 2023 11:45:55 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id v3-20020a170902d68300b001b243a5a5e1sm5902905ply.298.2023.06.14.11.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 11:45:54 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        ysato@users.sourceforge.jp, azeemshaikh38@gmail.com,
        dalias@libc.org
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org, linux-sh@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] sh: Replace all non-returning strlcpy with strscpy
Date:   Wed, 14 Jun 2023 11:44:29 -0700
Message-Id: <168676826702.1963449.9061022814058323294.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230530163041.985456-1-azeemshaikh38@gmail.com>
References: <20230530163041.985456-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Tue, 30 May 2023 16:30:41 +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> No return values were used, so direct replacement is safe.
> 
> [...]

Build tested with sh4 GCC 13.1 from:
https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/13.1.0/

with defconfig and:
	CONFIG_CPU_SUBTYPE_SH7343=y
	CONFIG_SH_DMA=y
	CONFIG_SH_DMA_API=y

Applied to for-next/hardening, thanks!

[1/1] sh: Replace all non-returning strlcpy with strscpy
      https://git.kernel.org/kees/c/ca64da3052be

-- 
Kees Cook

