Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E3CC4332F
	for <linux-sh@archiver.kernel.org>; Tue, 14 Nov 2023 09:04:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbjKNJEo (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 14 Nov 2023 04:04:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjKNJEn (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 14 Nov 2023 04:04:43 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0444198
        for <linux-sh@vger.kernel.org>; Tue, 14 Nov 2023 01:04:35 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-507a0907896so7491780e87.2
        for <linux-sh@vger.kernel.org>; Tue, 14 Nov 2023 01:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699952674; x=1700557474; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c0FTIhz1lklg0adI7O93yP6uZC4br/8OS4S3SOBstnY=;
        b=AaKH4unWvMBsyt5otkCZvVRyIu6BhA5nDo/4vhMEfOGefkKCNuQi+A1p990MM0dxfJ
         8IOqkXosRlh02VR2V0g10VojbEXKPtOp9UV7naF48lyflaLnYsnc5491LQ6ShGxAJ4hy
         LoVmVocl+WfL9VJTkMqN0fGjC8A0fFadHpNnbz/wEanFNU4DQ3FGG/pF+R401KZ/kvNO
         OkR3yDEXDe47TXDmxRjE/4wut3/6Tkuai1y+SL1rOlNSNJmaYLwTgIs2YbVC5+BO40qy
         24rqhMk9YadeVkDXkz96RUr8UFnW8Su5rc9mpHe+ZCJ2J1E1y8XRJ0j8kTxOGm1OM8Ft
         8J6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699952674; x=1700557474;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c0FTIhz1lklg0adI7O93yP6uZC4br/8OS4S3SOBstnY=;
        b=H2pS6Om4byqS9Y2cN/GGoQZeM6Mgs3k+huM8ESzsidyV7WH0sxjmVFiKbZU7ae2z3A
         /u/OKU/x+LMlX3p0OUw3MR8zj0L2ggCp4LfKLTt8vLCeZn9W5ABuZCRzkDHMwwrVPuYF
         8PXM8YQRVRVSi1hkOy/pZlYMsUxvBN4/pXZqPGZuf/zy+eL5CcpDE7qCHV9na60HZKvw
         8UOCuGHVUSnsGLLh8bO1gbZX642eDr+YWhnhynFppCVp9W11lenQXOEkw288h0fMra3u
         JOKQXXTPRnn7q/xVjfSo2YgxJ0Z/+iYTcgxme6nXqLWaeltrw+i1hZwYkXa6p1+W3lw3
         6lvg==
X-Gm-Message-State: AOJu0Ywbkz6tJ2aYFn6WpcmBf1iXcMFtjhztFR4OXF2KyOsPLe841ima
        FSh30d6c6b41qDzHKX1Z6kc=
X-Google-Smtp-Source: AGHT+IGRaj+9Rok3uCXCQNVS/uWfLKGg8CZrkn4nFYLKzwDEztvT+RpFFyCaFn8pgCEe1liE21r5jA==
X-Received: by 2002:ac2:5dc2:0:b0:509:dd0:9414 with SMTP id x2-20020ac25dc2000000b005090dd09414mr6132066lfq.24.1699952674035;
        Tue, 14 Nov 2023 01:04:34 -0800 (PST)
Received: from [192.168.1.103] ([178.176.75.241])
        by smtp.gmail.com with ESMTPSA id z14-20020a19f70e000000b005031641b40asm1242151lfe.159.2023.11.14.01.04.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Nov 2023 01:04:33 -0800 (PST)
Subject: Re: [PATCH v4 32/37] sh: Add IO DATA USL-5P dts
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
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
 <97c5c835-dc9e-c783-1d85-42fed2abf5ee@gmail.com>
Message-ID: <2dce7a20-ef44-8ed8-dacf-47a4457cf6eb@gmail.com>
Date:   Tue, 14 Nov 2023 12:04:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <97c5c835-dc9e-c783-1d85-42fed2abf5ee@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On 11/14/23 12:02 PM, Sergei Shtylyov wrote:
[...]

>> IO DATA DEVICE Inc. USL-5P devicetree.
>>
>> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
>> ---
>>  arch/sh/boot/dts/usl-5p.dts | 84 +++++++++++++++++++++++++++++++++++++
>>  1 file changed, 84 insertions(+)
>>  create mode 100644 arch/sh/boot/dts/usl-5p.dts
>>
>> diff --git a/arch/sh/boot/dts/usl-5p.dts b/arch/sh/boot/dts/usl-5p.dts
>> new file mode 100644
>> index 000000000000..fba37472ebae
>> --- /dev/null
>> +++ b/arch/sh/boot/dts/usl-5p.dts
>> @@ -0,0 +1,84 @@
> [...]
>> +	julianintc: sh7751irl_encoder@b0000005 {
> 
>    The node name should be "interrupt-controller", according to clause 2.2.2
> in the DT spec.

   Likewise for the other boards...

> 
>> +		compatible = "renesas,sh7751-irl-ext";
>> +		reg = <0xb0000005 0x01>;
>> +		interrupt-controller;
>> +		#interrupt-cells = <1>;
>> +		#address-cells = <0>;
>> +		#size-cells = <0>;
>> +		renesas,width = <8>;
>> +		renesas,enable-bit = <5 0>,	/* PCI INTA */
>> +				     <6 1>,	/* PCI INTB */
>> +				     <7 2>,	/* PCI INTC */
>> +				     <8 3>,	/* PCI INTD */
>> +				     <9 4>,	/* ATA */
>> +				     <10 5>,	/* CF */
>> +				     <11 6>,	/* Power Switch */
>> +				     <12 7>;	/* Button */
>> +	};
> [...]

MBR, Sergey
