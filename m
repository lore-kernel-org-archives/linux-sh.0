Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F9EC4332F
	for <linux-sh@archiver.kernel.org>; Tue, 14 Nov 2023 09:02:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232424AbjKNJCc (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 14 Nov 2023 04:02:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232332AbjKNJC1 (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 14 Nov 2023 04:02:27 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9039A4
        for <linux-sh@vger.kernel.org>; Tue, 14 Nov 2023 01:02:23 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2c5b7764016so64446831fa.1
        for <linux-sh@vger.kernel.org>; Tue, 14 Nov 2023 01:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699952542; x=1700557342; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vwuloXOIfUk5uWblSiwi6fF4pSah8hpSQQrf+FhjHhg=;
        b=cmwOntgpvARrFLp2KImVw5JmUJKdZxKw4J1jhTRHzBczNx1laVkVGVjywu2XpIR7/y
         iEPYTre7ty/YqmaA5Wk9n/lGyBjbMhUFDLVxw60LTHTIIUHulLk+ePAyfHgmt9aX/UEg
         aUWfufa1CtWHFq23LZ/x8YtKTZ3JlxHyeEtZKJqc/SKMfxe2NkoEQCc2QZ8jwMVLTs8d
         cf+xU9GTawiEISbHIN/6kSmxHf62HXLxMXimqSyarjh3ehXmg8IgAhEtELMd3uDXMdKq
         DdbbcnnAsGEzdlpgShO2d0aj7pwJ7qy4pW74Spj3vEBIdvzqzTv4EtsI9HQ2xdejMIUY
         CCtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699952542; x=1700557342;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vwuloXOIfUk5uWblSiwi6fF4pSah8hpSQQrf+FhjHhg=;
        b=NERPVdwDkhJ7Xq3KGkaf4WQkwnXzB6lGwz9dkvW9EB2/UTnSD9HfyAvnE67X6sleWg
         aCvIDHGUmy0RTqCW9VUxTJv+lkLFpVbYar0c1vXvGJ92S9viMF8BZh/j6gFHmoF02HnL
         CZb4KAmjQAo+FLwx3Kdqo7qCNVbFNM52Uc5txqPfblBEoMF1/hp3We8rGOGiLXu5Qjcv
         XZHjNdkYBI0W5Fe/nLQXp5n3zTA5Y7eNt9jxMEaTFUW3vVOlL99d6+qoOi85Xwkw1ZiI
         gVlVHrH3WGUUR3+F180INJVbGbfL1dEDsWsSb0GmInxMv0smM3hKB8n2htEVibmcZ0Yh
         BEUw==
X-Gm-Message-State: AOJu0Yxp2J0chdNqvagGGZMcHsL9Ofe5zfU6zhlXOu99555SYD7PI442
        pt8V2C1hnQRZA3gVMSoGIDq8Vnnpo0s=
X-Google-Smtp-Source: AGHT+IF+9P5LDZJ605N6FkiE2WqP0gDLjVlLWI+NBcUuhoeMd18LIolWl/hRI9eUAy6+Ci3ncfaOow==
X-Received: by 2002:a2e:9197:0:b0:2c5:1bd3:5658 with SMTP id f23-20020a2e9197000000b002c51bd35658mr1474234ljg.28.1699952541841;
        Tue, 14 Nov 2023 01:02:21 -0800 (PST)
Received: from [192.168.1.103] ([178.176.75.241])
        by smtp.gmail.com with ESMTPSA id s19-20020a2e1513000000b002bcdeeecd11sm1293067ljd.66.2023.11.14.01.02.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Nov 2023 01:02:21 -0800 (PST)
Subject: Re: [PATCH v4 32/37] sh: Add IO DATA USL-5P dts
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>
References: <cover.1699856600.git.ysato@users.sourceforge.jp>
 <59c11b5e41d94b5b10e12fe5d8179adc0138a666.1699856600.git.ysato@users.sourceforge.jp>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <97c5c835-dc9e-c783-1d85-42fed2abf5ee@gmail.com>
Date:   Tue, 14 Nov 2023 12:02:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <59c11b5e41d94b5b10e12fe5d8179adc0138a666.1699856600.git.ysato@users.sourceforge.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On 11/14/23 11:00 AM, Yoshinori Sato wrote:

> IO DATA DEVICE Inc. USL-5P devicetree.
> 
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>  arch/sh/boot/dts/usl-5p.dts | 84 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 84 insertions(+)
>  create mode 100644 arch/sh/boot/dts/usl-5p.dts
> 
> diff --git a/arch/sh/boot/dts/usl-5p.dts b/arch/sh/boot/dts/usl-5p.dts
> new file mode 100644
> index 000000000000..fba37472ebae
> --- /dev/null
> +++ b/arch/sh/boot/dts/usl-5p.dts
> @@ -0,0 +1,84 @@
[...]
> +	julianintc: sh7751irl_encoder@b0000005 {

   The node name should be "interrupt-controller", according to clause 2.2.2
in the DT spec.

> +		compatible = "renesas,sh7751-irl-ext";
> +		reg = <0xb0000005 0x01>;
> +		interrupt-controller;
> +		#interrupt-cells = <1>;
> +		#address-cells = <0>;
> +		#size-cells = <0>;
> +		renesas,width = <8>;
> +		renesas,enable-bit = <5 0>,	/* PCI INTA */
> +				     <6 1>,	/* PCI INTB */
> +				     <7 2>,	/* PCI INTC */
> +				     <8 3>,	/* PCI INTD */
> +				     <9 4>,	/* ATA */
> +				     <10 5>,	/* CF */
> +				     <11 6>,	/* Power Switch */
> +				     <12 7>;	/* Button */
> +	};
[...]

MBR, Sergey
