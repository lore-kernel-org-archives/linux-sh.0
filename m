Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3566CDB47E
	for <linux-sh@archiver.kernel.org>; Wed, 18 Oct 2023 14:03:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbjJRODV (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 18 Oct 2023 10:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231864AbjJRODU (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 18 Oct 2023 10:03:20 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2260109
        for <linux-sh@vger.kernel.org>; Wed, 18 Oct 2023 07:03:18 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-32da4ffd7e5so2637327f8f.0
        for <linux-sh@vger.kernel.org>; Wed, 18 Oct 2023 07:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697637797; x=1698242597; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SZDbuhr8zhVfKswMhHzluvTuLcbWDyipQ++ihqDVsjE=;
        b=ZFobvfBcvTeFp+ceWpyTCMuCk/FgBcIwZFlzq6StsAMh/ZnSQrl3BgFR7aJu9d3qkB
         ahkJOx/5cmH6UB1MlETu3Lza07OhtHKJvMIBTYtbqYHNrtXyOqByUNxbMPTXtEEGQs9s
         7Ll24YU7C/YlD1ZetfD9Zmk+1+kFz4TY0r2GLJ3vik/JGeRF6kBTQ7xdLzVsQOdFc/Ha
         JS3FRGTnYyI/vVwO6fkbVEPPgrQhuQKokX2Stk862OOIv171w0Do57NXKjsDgXxB8y5q
         8ARLH6VkgCAbugFin4rSIjmym0jXtwl2Vw4h9oAftbGY4VrnJgun2kYV8eNmL9GVXOoH
         w3Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697637797; x=1698242597;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SZDbuhr8zhVfKswMhHzluvTuLcbWDyipQ++ihqDVsjE=;
        b=UZfhlbc3hMYeZTl9xnjZhG8mY8LYGSwaIkA0s05DyQjwdTH0NEjxsIT0IF+BBFFOmA
         6FP6flFjJFBJLATnioydUpJ5KKr+yKdDjONNdgZPQXu/sIcHIo4h7UvMXASGFVyIw2FR
         rY+HavU9fMa4kXNu8cG7+UKPS2MlnWEy9F+ooJBy7EQVmIdd3tNxCfkcTZFc+p4sIGrR
         rgmGBvvYFb6IbghUAfE7oY5HKP+Hxy0Xzo5WZuvef+Ow0joCVW7hXnWSGydPiJ5YbBZc
         k9eSq2cFa2Z0yLoP9dYwPM4zHX3ufkY+zo9yMXFKCPDtu4wfB+uh8TyBHuJXjejImv76
         4ldA==
X-Gm-Message-State: AOJu0YxMTBmwBfww+T+FHQJvBl3//YSn5o/BD/JXVJ93U6EacSakXErN
        3fBRA/wGBkDerPT9BgcCVcGW8Q==
X-Google-Smtp-Source: AGHT+IHrQLyRkDkp4W2pF/Gu7NabcPtAH8+LgGi9v1kF2DEa490fADvchoGbIlVGqyzrmOlu+7ho0A==
X-Received: by 2002:a5d:678b:0:b0:32d:cb4c:4eb3 with SMTP id v11-20020a5d678b000000b0032dcb4c4eb3mr3657460wru.34.1697637797151;
        Wed, 18 Oct 2023 07:03:17 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.154])
        by smtp.gmail.com with ESMTPSA id h5-20020a05600c350500b003fc0505be19sm1787525wmq.37.2023.10.18.07.03.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 07:03:16 -0700 (PDT)
Message-ID: <3c66630f-2989-4d1b-871f-9da7effe1d4b@linaro.org>
Date:   Wed, 18 Oct 2023 16:03:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 24/35]
 include/dt-binding/interrupt-controller/sh_intc.h: renesas,sh7751-intc.h
 helper
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     linux-sh@vger.kernel.org, glaubitz@physik.fu-berlin.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
References: <cover.1697199949.git.ysato@users.sourceforge.jp>
 <5fd6a128de04b88bb22520cffe955f83af6700b9.1697199949.git.ysato@users.sourceforge.jp>
 <CAMuHMdXpS=BWMnG3h0M=iQ=OGmnj1xXi7oFEsXm-i=tZfQXwyQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CAMuHMdXpS=BWMnG3h0M=iQ=OGmnj1xXi7oFEsXm-i=tZfQXwyQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On 18/10/2023 15:39, Geert Uytterhoeven wrote:
> Hi Sato-san,
> 
> On Sat, Oct 14, 2023 at 4:54 PM Yoshinori Sato
> <ysato@users.sourceforge.jp> wrote:
>> SH7751 Interrupt controller binding helper.
>>
>> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> 
> Thanks for your patch!
> 
>> --- /dev/null
>> +++ b/include/dt-bindings/interrupt-controller/sh_intc.h
>> @@ -0,0 +1,18 @@
>> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> + *
>> + * SH3/4 INTC EVT - IRQ conversion
>> + */
>> +
>> +#define evt2irq(evt)           ((evt) >> 5)
>> +#define irq2evt(irq)           ((irq) << 5)
> 
> Please drop irq2evt() as it is not used, and not needed, in DTS files.

And we talked about this already... just like about few other things
which did not improve. This patchset is repeating the same issues over
and over again.

Please call it not RFC, but "DO NOT MERGE" or something like this.

Best regards,
Krzysztof

