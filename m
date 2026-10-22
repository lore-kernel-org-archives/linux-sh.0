Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792656312;
	b=RA2heVBQrCkZ5Lm+XjqXjZmDPMvEcR3cDkyF/5EFSEuCfjN7c3gc2X0Nk0ZKBcm00FUZ
	 eVHWWwYfLGm3Z/ofY1T0JizI1pUYrpC+GVUjaj431mA0pTf73pitXwU6O10Fxrti3BQqs
	 9+PEJhDCPYwg+Ltq9ke474BX9oSpljj6yc7nc59/jfpk1LAF/aZW6SzA9u3grNUvS9shl
	 S2TbQhK976Ght8tRX4HZxFBjEzO2nfYCtCoOqM2gcyMbnBYNMZBNfBxs7ww5YVmAarUTO
	 GXI2vHDLRq9z1Ch+IU9ObjnfBuwUIVnisCYrp/OFkVtzLbCG6jD3sjzXY4n4V6yXUqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792656312;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=6vETnhFRgbr5N3P6H71MD/C/rWSkvJBPHq3abNue+/k=;
	b=SHNsAYoPGuwSxIyOGhFf2ru5HB+o9OCi+VjcjNXgg/LJRJsYjhsFlidWUZVBL6BPmBVJ
	 uf1ji+aZVV2LDCQLsau/M/yVyhzpkXNvrk7duTihgGL5Bp6jhvGNvVsT99/KM4es14h/h
	 Oy9Lc3BqtDNwdrKwPewlk9VYHE69s/Ziwu9H4i29ei/s65MriQQd0SvIWodVVztcOUi9E
	 tbaolboCTCYlAIPoDFR/U1Uy2HXzf8mcU6v+MEkY/hAi3oVnf38bCdYEq8DI6T7zqjL0L
	 80Z8AatloU8vDksBZqeyX0YmCTL/v8Y3rh+lWcX7d070BtDg2SS4tBpbuwv1L6MsNmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GCNYvGdx;
	arc=none smtp.remote-ip=209.85.216.42
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D375606A31B
	for <linux-sh@vger.kernel.org>; Thu, 22 Oct 2026 08:05:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D375606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GCNYvGdx
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3ab41538192so1142933a91.0
        for <linux-sh@vger.kernel.org>; Thu, 22 Oct 2026 01:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792656311; x=1793261111; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6vETnhFRgbr5N3P6H71MD/C/rWSkvJBPHq3abNue+/k=;
        b=GCNYvGdx1xfqdkfN3PYylA1qFCOlW5X0i0yNFPzUzAdVvj51dZys43EOniuEZdigNd
         rKgfs9/hmzmEiVQaLPt0DLJ8iihzEAxWuXBGjCdV28arQHACX1hImglWJ8UXXcraQM8D
         C9ryU0Io2lt6PW5RqwZWllGjLmV2FpGuD+5pPxQZ4/1iX/3+5U7Ux+Ye3LLBsdNvjsQ4
         KpWx3Pok+BAemt2Lk0+TsptIGw4A8XXWOJqf0xm+az3xNexVx6Ub4IaCPLT0a6VN71RG
         XhQOyZVP1qzYjT8iWxwBg70EygVoa5WtlZpq0NYlNOgig4RDHjlHtv7pyOyfYLm0CECA
         ikEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792656311; x=1793261111;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6vETnhFRgbr5N3P6H71MD/C/rWSkvJBPHq3abNue+/k=;
        b=CLUJ/deFI36P5AWX07MwJdLUI5CWXsyBnF2vgpjPnMFIfyRzUgbB5pjdZVg3uepLhV
         UZGfxSwOd26ezjKe/HcgvA6RBCmjRuTijjg5xxIRyPx6gbdFTzmLXsUKic/ec7mHoQU1
         MVDgKj/BNLEjkz1JvMl6sy4DWnqf1lSIhF3gt5PjAQjZWA1O0uWqhj9LEK6nb1VQes8/
         QLruVrU1HGEnhpj2lxdHJxLTDKcUMErhuJ3kEYb2t8EiI8Mq/wfVnqtMWO/OqQmYnJNG
         DREqcc/pRkKdx4v1rumpcFRjxn9SrW7KwHc/2o7DRHzoaeLHInVeHmjPD/bD6h2M+4jZ
         lQOQ==
X-Forwarded-Encrypted: i=1; AKwUvBy4jOsTpoMuBdgOV0clmc1zy2PnBJ/lmEpRL2rSY8mVsfHZ0eGS8N2xVXJ8kw2dCEcPMiB8m8HTag==@vger.kernel.org
X-Gm-Message-State: AFq9FYLBcrBYd8vkmVMAW9+MvI0Sufor3CQI5hSm1fTSL5mKbFFC+CHm
	XgJQRxgsZkaY2IC9NCYHAQhsmbi7UrUUzj7zzcDnxyBU43eg9gekD9tl
X-Gm-Gg: AYBFou2lmt5d5IBUH2H7HX4WHmcVJbyqwgNPBXszFTal4uH25E0J+Tg67yvCtrNL+FJ
	pncSnyfIxniQHqfLQ1egCAkvSj41JBBHl0PWXIYipqiSE9ng91YddS1sLCDa6RS6NRwyFlOuFHG
	PR83ZMHSt+fuG8ry7MjChX207UlrTXs1VXZhvVBMqULNlc+w+/izHs5xowdoO9rilKqM2O/aLQ6
	VvU7TK1ZibfiWoMCeLnTgLf1VOVDzWx8Yv+qIzP63/qj1CZRMKU3NjU2UkauL7iQo5Cvsbq/Y1q
	ekkJri+vQoHFePfpzx7ugonNLGmKsh5Il/71KNHS5Ix1zVjY9bNMKhX/Z9p+FX8/r/OndMu8NV5
	quzQQYsF7Mi0K381g2W9shdM4OxOW6ksNL8gAQHHkL6Ttaht7Qbwc6xN9Hxr/wRQs8cg0LtljHw
	2/LvOai265+d/AzuxqMLc18T6ifAmd5XbSLF2JzhxRdUrq60PzduC8ENv2jpC3O5+c86GdbSWUd
	44/kTNEYyNu/O+qvBlNPBdyLhyJHnH+owps6fUogLq2f9Wo2B8fVWq+mesjaVUaGxKVEHjBPKJ9
	Bef8uBr5OpNBw+Y3UCr9U80=
X-Received: by 2002:a17:90b:4c49:b0:3ac:9176:e83c with SMTP id 98e67ed59e1d1-3ad86f1bbfdmr3893053a91.12.1792656310889;
        Thu, 22 Oct 2026 01:05:10 -0700 (PDT)
Received: from [192.168.1.222] (d173-183-236-7.abhsia.telus.net. [173.183.236.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ada49544f1sm3092543a91.16.2026.10.22.01.05.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2026 01:05:10 -0700 (PDT)
Message-ID: <dee32e53-babf-4826-929b-f6afabf64d7d@gmail.com>
Date: Thu, 22 Oct 2026 02:05:07 -0600
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Post: <mailto:linux-sh@vger.kernel.org>
List-Help: <mailto:linux-sh+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sh+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: soc: document Casio fx-9750GIII
To: Krzysztof Kozlowski <krzk@kernel.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, robh@kernel.org
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 linux-sh@vger.kernel.org
References: <20261022063902.471383-1-artem122novak@gmail.com>
 <d6562416-05aa-452d-8fe5-a68cb8f50f01@kernel.org>
 <87fe0b0339e6f8763b9b385dbe8b8b5e587deebb.camel@physik.fu-berlin.de>
 <b8c7db3a-ad4d-4378-9e50-4c8591b93de8@kernel.org>
Content-Language: en-US
From: Artem Novak <artem122novak@gmail.com>
In-Reply-To: <b8c7db3a-ad4d-4378-9e50-4c8591b93de8@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Good morning,

The board Device Tree is at
arch/sh/boot/dts/fx9750giii.dts,
in separate patches though.

https://lore.kernel.org/all/20261022063936.472520-2-artem122novak@gmail.com/

https://lore.kernel.org/all/20261022063936.472520-3-artem122novak@gmail.com/

Thanks,
Artem

On 10/22/26 1:33 AM, Krzysztof Kozlowski wrote:
> On 22/10/2026 09:27, John Paul Adrian Glaubitz wrote:
>> On Thu, 2026-10-22 at 09:16 +0200, Krzysztof Kozlowski wrote:
>>>> +properties:
>>>> +  compatible:
>>>> +    items:
>>>> +      - const: casio,fx-9750giii
>>>> +      - const: renesas,sh7305
>>>
>>> Where is any user of this?
>>
>> There is a Casio calculator community out there that are users
>> for this.
> 
> Upstream user, so any known upstream open source project using Linux
> kernel DT bindings. We do not need bindings for non-upstream users.
> 
> Best regards,
> Krzysztof

