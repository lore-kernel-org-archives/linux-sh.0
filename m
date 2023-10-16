Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A472CDB465
	for <linux-sh@archiver.kernel.org>; Mon, 16 Oct 2023 05:28:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjJPF2x (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 16 Oct 2023 01:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjJPF2w (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Mon, 16 Oct 2023 01:28:52 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F1EDC
        for <linux-sh@vger.kernel.org>; Sun, 15 Oct 2023 22:28:50 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-5041d6d8b10so5241230e87.2
        for <linux-sh@vger.kernel.org>; Sun, 15 Oct 2023 22:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697434128; x=1698038928; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8naBtqhO6Tu54yC6QLXMv00+Rk43BVq/gedx5p1LU24=;
        b=zWc+nVArVMIE1SdZciAl4RyJFSx7EwoCAUZKMBVI7FVUPvHUNSY8kaUldj2oULXNG+
         ZkudRxEYVGryiqrfdBBcc/yuHRo0ZAFoJKerpL/dAA5h6CIQYg37DFaHQkvmCqCEaBpt
         o2ZzXsXkSNZLSOLm4L8Yvs30tculF8EH11+iPWr0DaYkheHtESHTS5yqE7w+WYNhku/R
         YjQaDLBXAF9ON14qWvXRWickK6BG9fDEj6R/c8n7K6/YGMaJwbs5uT+y2yImmpiPNp8+
         rL/HY1cl3jTChYPnMBUA73Vj5HzDwb/0gtuHALFPXwArqmIO9nKEWRhFNN0NFvkTzWAI
         Q1jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697434128; x=1698038928;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8naBtqhO6Tu54yC6QLXMv00+Rk43BVq/gedx5p1LU24=;
        b=TFgF7RSxKrAznkkoNjZ+ZRM4RwN2EUNVpq4KAZCJXxqxrtb0VgF0mwykMgaus6yKtv
         A02w95vih325l3rAfIf4NErJEsh/Aas+PKST7on0YxZSsT+h6C5KMM5WyZs5mHDM0QjK
         ucPcty8ZZoqmlqDrJYxBnRyKoWzGbK8es90Jyl4BLngTzgugbADkpL6xZrn7nQMpdK6z
         a5xc+JiIl3ZBNCwaqxPUdxxNwnvl/4gZ7adecSliEXKSvskJx8ChO0/NqB6xy1cOuZbJ
         sJx4FrxXrRDCYJJwmkZ9/6828h962bi1TKIUplZbTpSBjgiiFEyPiEfAjiVAORX6bKW9
         lqkA==
X-Gm-Message-State: AOJu0YxfDI6Ifa1KWYLdWeO4PWpMCFc4JQ67NEQdgQqKnqNbMBTJIMFv
        HOo4ReqAT0D2m0u/hnaHzF54jA==
X-Google-Smtp-Source: AGHT+IFQeu7pPfipFNAEGEetyWSK9/dAmkZ/edWmunhKR6E41zhJOKAN72TIsQVEJNxJ/GzswV4+7w==
X-Received: by 2002:a19:4f0f:0:b0:502:ab7b:e480 with SMTP id d15-20020a194f0f000000b00502ab7be480mr26194799lfb.36.1697434128339;
        Sun, 15 Oct 2023 22:28:48 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.154])
        by smtp.gmail.com with ESMTPSA id o1-20020a1c7501000000b0040641ce36a8sm1713295wmc.1.2023.10.15.22.28.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Oct 2023 22:28:47 -0700 (PDT)
Message-ID: <048449cf-f496-4869-bd59-b453dec24cac@linaro.org>
Date:   Mon, 16 Oct 2023 07:28:45 +0200
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

It's still RFC, so I assume it is not ready for merging and it is not
meant to be reviewed. In case it is not correct - some people actually
expect RFC to be merged - trivial comments:

1. Please use subject prefixes matching the subsystem. You can get them
for example with `git log --oneline -- DIRECTORY_OR_FILE` on the
directory your patch is touching.

2. Drop final full stop from subject.

3. Missing commit msg

> 
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>  .../bindings/pci/renesas,pci-sh7751.yaml      | 123 ++++++++++++++++++
>  1 file changed, 123 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/renesas,pci-sh7751.yaml

If sh7751 is the name of SoC or device:
renesas,sh7751-pci.yaml

> 
> diff --git a/Documentation/devicetree/bindings/pci/renesas,pci-sh7751.yaml b/Documentation/devicetree/bindings/pci/renesas,pci-sh7751.yaml
> new file mode 100644
> index 000000000000..a6081c3de51d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/renesas,pci-sh7751.yaml
> @@ -0,0 +1,123 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/renesas,pci-sh7751.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Renesas SH7751 PCI Host controller
> +
> +maintainers:
> +  - Yoshinori Sato <ysato@users.sourceforge.jp>
> +
> +allOf:
> +  - $ref: /schemas/pci/pci-bus.yaml#
> +
> +properties:
> +  compatible:
> +    items:

You can drop items

> +      - enum:
> +          - renesas,pci-sh7751

renesas,sh7751-pci

> +
> +  reg:
> +    minItems: 3

maxItems instead

> +
> +  "#interrupt-cells":
> +    const: 1
> +
> +  "#address-cells":
> +    const: 3
> +
> +  "#size-cells":
> +    const: 2
> +
> +  ranges:
> +    description: |
> +      The PCI bus memory area and I/O area.

Drop description, just ranges: true.

....

> +
> +examples:
> +  - |
> +        pci@fe200000 {

Use 4 spaces for example indentation.


Best regards,
Krzysztof

