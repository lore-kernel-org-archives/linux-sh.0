Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB76912FF77
	for <linux-sh@vger.kernel.org>; Wed, 31 Jan 2024 18:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706725360; cv=none; b=AjIhauLFZCkNWNkyD5f/qwqWlwphz8I4CVFKwn5QRW2//i5zVNGECEt3ZGLkf5ctm/t7SHOuU8h82XOFYDMYXcwgLg4WJfTlVWgQtViX5R+dCnJ0WIxdX8gb414eLd/QDslRFpRwdvcig0TCZtIlVYN9IRsQacWzVAbRmMLQtig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706725360; c=relaxed/simple;
	bh=z16ACY49/1e7bOj0OReF7J/eAVkgaJxbfAVjTzxIMlg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fjf3yXDIVGj4XpibtBEQNAU5yXEY3y+8QxCHh1Wu9DSWtKS8Ja9DAf1T56tExkm5c8ZaItTuW2qgZcqp4njTqrv3rrF9GviDnE/KPtcUMmpHpERCtxJ+HWsyEnDHS0DWBSlYhgPfGEtzvXgXL2r8f7d3LKx0VNH26f/LUYHWnhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gRQp8upK; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gRQp8upK"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40e800461baso1026605e9.3
        for <linux-sh@vger.kernel.org>; Wed, 31 Jan 2024 10:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706725357; x=1707330157; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gHKzDZd1mqTqqV0mGTc0u8ONZh6m7/ntJ7FejoiVhh0=;
        b=gRQp8upKrzdbHPzFknA2xC4HI9oTtNLKbM/lKq4jht0nc5h7S0hGRzZkQzkg9YYDzJ
         mifkC1vfwvAraF3+07bXaLreNqablDAvQb0eR9VDBUpH+9eOebcD69dW9Qm2J9l09tZk
         q1It7ij8l8w67bxmzP8UL85Sk+V+pmMX59x0e0qxb7VWlfRN5CnkqKHmn8lCeFS9UCB5
         GY3W4ZKzKdhVthVNowO1M8ezKQWuDLgda+dI5CeLrQI/23bWUq5ow6M4b7vANiVWeQWC
         Jo1mXXCz1krUvdThzNREB0/QrjYQOrQ2qSbX74UZ8erSgtjVuiPpa/eDpv77y6VgZYF6
         HIdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706725357; x=1707330157;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gHKzDZd1mqTqqV0mGTc0u8ONZh6m7/ntJ7FejoiVhh0=;
        b=PYK3lszJKiRpC60eVbhBSShBgvS+VemwwY64NHNlkHpEpH3shfKxkc02x1dQwy2ru/
         REJxYa0nWIk0hCGn06LUtGaZ1NBpnqWUhsaURSzEk8hk0AH3bdinxYpt+pcUmDSzJVzx
         T9ifLfxI5871Dl7t+r6Pq18WTFq8TmBcpFX7MzGofjiRXIWzqvgOVFJCyrbIFMVGxMaD
         FIrhcvClHCuy3Sn9RFfK3+33ZfSlpW5t5k4FWVgk94VtI5tFb8oXYg01utJF3k/Et5J1
         U7cW7IQys72BTh8O7dk31MTkCNEtunrv9XbQafV2gBOvUoCwUhEr7PFq/KY1J0BvuGuF
         ftpA==
X-Gm-Message-State: AOJu0YxJ4HX74LC2vDXGXE4QqhSVk3Z0exuLQnBMYpZgkfc61fqqHEYb
	gjztli08v96mA5up9/ebtaGDV42VcnAlzggn5yYyHKRlMluGa/fHG+BWaYrrVgI=
X-Google-Smtp-Source: AGHT+IHlqZn5apC0OcSNN2Acf7t6Aaryh00SY4kbBmWqx0XsIPRgDEaqwCciuHNYKlmHRmoA8cxoSQ==
X-Received: by 2002:a05:600c:138e:b0:40e:fbdd:238a with SMTP id u14-20020a05600c138e00b0040efbdd238amr2123576wmf.37.1706725356765;
        Wed, 31 Jan 2024 10:22:36 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id n36-20020a05600c3ba400b0040ed1d6ce7csm2265786wms.46.2024.01.31.10.22.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jan 2024 10:22:36 -0800 (PST)
Message-ID: <4e8c1025-fcea-45fc-bec4-5b377b7064ac@linaro.org>
Date: Wed, 31 Jan 2024 19:22:35 +0100
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: timer: renesas,tmu: Document input
 capture interrupt
Content-Language: en-US
To: =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
 Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, devicetree@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <8cb38b5236213a467c6c0073f97ccc4bfd5a39ff.1706717378.git.geert+renesas@glider.be>
 <20240131180013.GE2544372@ragnatech.se>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20240131180013.GE2544372@ragnatech.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 31/01/2024 19:00, Niklas Söderlund wrote:
> Hi Geert,
> 
> Thanks for your work.
> 
> On 2024-01-31 17:11:45 +0100, Geert Uytterhoeven wrote:
>> Some Timer Unit (TMU) instances with 3 channels support a fourth
>> interrupt: an input capture interrupt for the third channel.
>>
>> While at it, document the meaning of the four interrupts, and add
>> "interrupt-names" for clarity.
>>
>> Update the example to match reality.
>>
>> Inspired by a patch by Yoshinori Sato for SH.
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> 

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

