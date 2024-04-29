Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B24B14A98
	for <linux-sh@vger.kernel.org>; Mon, 29 Apr 2024 08:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714380622; cv=none; b=If89Vc+KVR2c36OZfpnRuNzN0Yc9sDW76fSBplqaLhW1mN8MMPDA++rrEenaO1mS29kr4G08V0Cl5HV+RDOAqV+jvelewzA3sVGcKDX9cBXwL5lAfuTnzIPUfHTyl/xiL9pONEXe77I0GgkWwze/LCxFA2PNY7ICNkGYkX7zRe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714380622; c=relaxed/simple;
	bh=UEftw4bypC83j5FB26vPGAB+xWzHocHd3cthIUjvWEI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e9vj/4m+5pvOBcidjRLCM3kZUKls8Bg3msWGMBdLZDZ2v9LdPDT/RzzEeD7/RUoduE5L7nPmReFRVMfGucg4ujo7ZJe/tlHQXNkfgFgZ7xg1HzXOReQBU9Yg7W4+YKZIsSadALUzb7RW4/vPr11pw7PVkQUNkHXwELY/II8iz8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VmS3j3Te; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VmS3j3Te"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a58f1f36427so161563566b.3
        for <linux-sh@vger.kernel.org>; Mon, 29 Apr 2024 01:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714380619; x=1714985419; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wJ2dspUAZTJIyxNFJe36YLQ9sGiLmUwzrDU28IFnD3g=;
        b=VmS3j3TeZucmT3Txa+S2mUR5sex2g2k+WEmA7FBd3KEssyXdYISx467GcRTg5PTYNQ
         taHuq6PSTog2A++LGuLmooDO0bZJQ2pv3PC5LZ/Slv3bK0sovUqyNgTAmk+Xl4OkeIsm
         3D/bWVLLvoOcnKL3YD5YLw/JQcc2hrw6PBVB/Lwwev8o3E8rOGzXae/DjJJhdQfFQay6
         DELvCjj7GzgH5FuYT0qXRXNcVLKV1WjRqj2HQVaOfetBmoLpK+HY/Gbpzyqz5NnCjB3I
         orYtHMCz8/RfxzhWIMd+BoK9yqEX0ztsIMMN4vvN4BDjvsurROhZRxEVb9BWlMFa9Jz2
         NtMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714380619; x=1714985419;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wJ2dspUAZTJIyxNFJe36YLQ9sGiLmUwzrDU28IFnD3g=;
        b=RRLVsACk7jYv5+uSumUeq76rXPbAiCnsBqU7hQQle2pLhyxcxiUUXZoNTnXmAzdCB7
         sedwBL2gWSOJTzOOeabpyKr7atNPeTfIwegS0gAfS/RYMZhEWVNj3xCvmFlioBD6HfVY
         LlgrfhZDPMosvjXBCpv4iwlkjSesaFyzpYos9Ms2boG9OZYyEcwLbZo1z/BLXdbAtdxK
         xdEY5H3ZtY2lAhS3KJcajhhkPrSbQzRzLf7JgwQ+aVv9TUmCvBfUzv54uPWyun7Qq2jT
         Xff+ZZ8iu93MwEg/H7aHlPeZg1JEKeLcNCbKk9UmsZpFfraOpMPAPJeeA2TlR1I7u4E0
         ROPw==
X-Forwarded-Encrypted: i=1; AJvYcCX7Buzxktld0i6ePGm8VsHa1LRtVXV+R+0YdRgoStkyjBlZKTXdm/wf47A+azxhzZ1n/oq8M/VNunNt1NRolHwSjpL2WkjHM5I=
X-Gm-Message-State: AOJu0YxN8TSF0++MsyLfV1+QvhlBsL1DmBHGZYeSVpK4EF02giudJzFE
	abHse4vJMpwKdSkse2kP96ivFJlyEsdLnaafcrP2jjnppPcZl4CNhcRoUp6GZMDc7hxOrQT9T51
	vqtk=
X-Google-Smtp-Source: AGHT+IHNAnbf391vNLLOtI6hxFOkSeLXRESnQKTCG64z/DXXxuzgWUbtk/MtLOKlaj/4RAIJ9uGvMw==
X-Received: by 2002:a17:906:786:b0:a52:6cb2:9347 with SMTP id l6-20020a170906078600b00a526cb29347mr5390414ejc.8.1714380618670;
        Mon, 29 Apr 2024 01:50:18 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id d13-20020a170906640d00b00a5267ee40efsm13879801ejm.18.2024.04.29.01.50.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Apr 2024 01:50:18 -0700 (PDT)
Message-ID: <a105ba2b-a809-4a6e-84fc-f67eb11606be@linaro.org>
Date: Mon, 29 Apr 2024 10:50:16 +0200
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sh: j2: drop incorrect SPI controller max frequency
 property
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 devicetree@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Kousik Sanagavarapu <five231003@gmail.com>
References: <20240322064221.25776-1-krzysztof.kozlowski@linaro.org>
 <d6b562f336b3750c131830a984b148ea7103ab0d.camel@physik.fu-berlin.de>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <d6b562f336b3750c131830a984b148ea7103ab0d.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/04/2024 10:16, John Paul Adrian Glaubitz wrote:
> On Fri, 2024-03-22 at 07:42 +0100, Krzysztof Kozlowski wrote:
>> The J2 SPI controller bindings never allowed spi-max-frequency property
>> in the controller node.  Neither old spi-bus.txt bindings, nor new DT
>> schema allows it.  Linux driver does not parse that property from
>> controller node, thus drop it from DTS as incorrect hardware
>> description.  The SPI child device has already the same property with
>> the same value, so functionality should not be affected.
>>
>> Cc: Kousik Sanagavarapu <five231003@gmail.com>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  arch/sh/boot/dts/j2_mimas_v2.dts | 2 --
>>  1 file changed, 2 deletions(-)
>>
>> diff --git a/arch/sh/boot/dts/j2_mimas_v2.dts b/arch/sh/boot/dts/j2_mimas_v2.dts
>> index fa9562f78d53..faf884f53804 100644
>> --- a/arch/sh/boot/dts/j2_mimas_v2.dts
>> +++ b/arch/sh/boot/dts/j2_mimas_v2.dts
>> @@ -71,8 +71,6 @@ spi0: spi@40 {
>>  			#address-cells = <1>;
>>  			#size-cells = <0>;
>>  
>> -			spi-max-frequency = <25000000>;
>> -
>>  			reg = <0x40 0x8>;
>>  
>>  			sdcard@0 {
> 
> It seems that spi-bus.txt has been replaced by spi-controller.yaml now, so
> I think we should update the filename in the commit message, shouldn't we?

I think commit msg properly says what is old and what is new....

Best regards,
Krzysztof

