Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ACB3CDB465
	for <linux-sh@archiver.kernel.org>; Mon, 16 Oct 2023 11:55:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232745AbjJPLzr (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 16 Oct 2023 07:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233485AbjJPLzf (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Mon, 16 Oct 2023 07:55:35 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB9711D
        for <linux-sh@vger.kernel.org>; Mon, 16 Oct 2023 04:55:22 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-533d31a8523so7475748a12.1
        for <linux-sh@vger.kernel.org>; Mon, 16 Oct 2023 04:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697457320; x=1698062120; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N6TBmVEV7VIOZF4/X4uTiyeFMAQOiRrLvH88SJprAF8=;
        b=SzUtIjChtL+KxZpj5Ya8SQ1d+OdGRPFsgdIMv+Vd2JIMd5KIfULPXRJGqtpTUM5RD6
         dC5lTwPdtEihz9PQhLgosDweCpUquhxzzOAr1ab2jgv28aI0hnF86q7nuPlVaKNtReTx
         kPgNr7Liymbqs3IijDD9pDQNc8L9NSpDVyvP2zyEznHk6pqGxah+Sli08PoHzb5+7ZsC
         dhZAFlfcJa6u7V0v/vJLkIwThgQqvsiyknhY66HhkpNoTwIeboBFETCpd4//z+LckWC2
         qRTYr2iGkh3sgW8am4jiRUEUecnBAMMsZbJTt9tixpMr7/tV1OFQoiihlT2j9lqs9f38
         P/Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697457320; x=1698062120;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N6TBmVEV7VIOZF4/X4uTiyeFMAQOiRrLvH88SJprAF8=;
        b=km32z4cjqU8evANuTd/6D4joFqjKbRT7sDN/fUC/s2w35nTV3hf7W92TCbIvOi3qzD
         uwJxdWDZ2Gqn12xSKaMeA/QR7G5qVsBSji4diy0A8rOhs21hjBOHc5iYLGXvmdyWh72l
         /R7Uqyb1pDySGhAl/p75hG3hysTHTtKfc2D/AY/shf6SGg6OGuMjddLsLuGes9Frq1bz
         vhJeegc/HwJALCKa0kdw5BwPIHBa3+IYToWXUuM8Mrw6AgrTXQh7R6ICw7886nIFWtr3
         JfUIB7e21bD0U+Jh2OwUnwsyNhIXiVz9jlPf8j47yi78C8yVoJ3JWtDEEtFwaE9tAV3Z
         tUIw==
X-Gm-Message-State: AOJu0Ywz4oKK8XEpxtcOih/lzz3r021DBaAH4arjOqpquuAlS95rId4A
        6C7fkNJGYPrAREZ434bcNZbN6+ipPLoiaX6U2hQ=
X-Google-Smtp-Source: AGHT+IGAG4RsThXhRoCEcRNeQYuaSWT9sm+k8NErprv+TzH2tH0CpqiuOnfU6+481fvx9aDxEQeATg==
X-Received: by 2002:a05:6402:2072:b0:53d:ec99:271 with SMTP id bd18-20020a056402207200b0053dec990271mr11003124edb.33.1697457320498;
        Mon, 16 Oct 2023 04:55:20 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.154])
        by smtp.gmail.com with ESMTPSA id eo15-20020a056402530f00b0053d9cb67248sm8478383edb.18.2023.10.16.04.55.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 04:55:20 -0700 (PDT)
Message-ID: <1bb96d99-6de0-4c04-866e-0c70fefb80e7@linaro.org>
Date:   Mon, 16 Oct 2023 13:55:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 10/35] Documentation/devicetree/bindings/pci:
 renesas,pci-sh7751.yaml new file.
Content-Language: en-US
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org
Cc:     glaubitz@physik.fu-berlin.de, lpieralisi@kernel.org, kw@linux.com,
        robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
References: <cover.1697199949.git.ysato@users.sourceforge.jp>
 <ef935285edcc1ddf56616ec0c7291749a266922e.1697199949.git.ysato@users.sourceforge.jp>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <ef935285edcc1ddf56616ec0c7291749a266922e.1697199949.git.ysato@users.sourceforge.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On 14/10/2023 16:53, Yoshinori Sato wrote:
> binding document for renesas,pci-sh7751.
> 
> 

One more comment - this was not tested so is not ready for review.
Standard disclaimer:

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC. It might happen, that command when run on an older
kernel, gives you outdated entries. Therefore please be sure you base
your patches on recent Linux kernel.

You missed at least devicetree list (maybe more), so this won't be
tested by automated tooling. Performing review on untested code might be
a waste of time, thus I will skip this patch entirely till you follow
the process allowing the patch to be tested.

Please kindly resend and include all necessary To/Cc entries.

Best regards,
Krzysztof

