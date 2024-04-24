Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1D6158208
	for <linux-sh@vger.kernel.org>; Wed, 24 Apr 2024 07:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713943521; cv=none; b=LVR9lqjZI1TP8MBtXHEnV6TkT58bq665MgjwdUDVef4ZWWP6TG+vtqY+BqffQs6tJmHyfhdAdAvAdZumlzAJocdaAoGnzwpRMEqGMmid8UkfHyKdPVNnZdIkHsfrh11B7xxVlFbnJNiJ49ArQCFWGTA+wEeMdnV7I84Iqnpd4KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713943521; c=relaxed/simple;
	bh=RIu1JGhRZ02llSnVGLycwc/6ETXRy8Xt17+jIFxdi4Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KYT/V4mpTBfEv6T1DAaXxjyf0uXJQdNwqreB6/ryW0a2ToQwJ+E/EP2FrJFbITlYYCJNQobMCKqs2o6lea2XGAlV9TmA6blCGmMeV1jhgh8ko3/RwcZZWFlMQXXdISQdy0AKQaP2jLLuFruA+OX1/xVXaltDE+2iQGHN66fRjUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GlC5BKlb; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GlC5BKlb"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-572256b1636so1237796a12.0
        for <linux-sh@vger.kernel.org>; Wed, 24 Apr 2024 00:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713943518; x=1714548318; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CwafZMe8gaueEb0P4tjU5eyuBDfGbh+CtIQKXoJiQ0c=;
        b=GlC5BKlbN4Tu8XyPzLxDPR8lml2orTytYvfPYPGS1aCDJzgZq+IGUZYLW8kyg+m7GW
         Zk0nJvZtKlAv8bC0/Ppa6eeJPtRrsaK33cRYqfPXMfxkQ9jzWt/v4Vk3JVMQJysTYuvr
         OUlz5q2Gdju6VrttWg66cFhcY+U45gujQo4CA9TAmgocePbNMjprFwp6YH+acytWpKNi
         zc/9Vt0SWW5rydFIT2ga9ODK5zBTvNFgIZNx4bwGUpz2REKxrblz4WieFq0w4/D5Q5xV
         kHJ9hPr9zyBaG9twmvk/xHzlUVqrDiN/jpRxw9b6CYM7JUlyCrYCnlzQ9kUNPmg09aFu
         XfEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713943518; x=1714548318;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CwafZMe8gaueEb0P4tjU5eyuBDfGbh+CtIQKXoJiQ0c=;
        b=J4ZmMroOm22A50FRsx70MYRljvA8J5ZYGmRKpIVbtQQWdxLd6E6YCsDpUEq8iun+T0
         II2CdAbDOjBIjM4q5R+63I2j4i7XjUHIgFIpaSVNaqO9Spv5A0MZJq9C35BGhPnfYe0U
         s+wSe2UzIX4scAmebhOmLTRL4xvXF99Inn0oMRx8zRQ7gl6v3RhxHlw9VJPMQfay/LFn
         tGhtnZULhvgzVupRW5ygz1Quaq7+ux0ymNkh6WJYhNSbLeLR7TrQwLL6crKZHsdincyM
         oB8Vf+YaLNqi/U4/zIuQjoJm4+WWAqGbkW8ajY0f7or4UR5bfhjoXp+QP7BPNrQXi3Rs
         ii3g==
X-Forwarded-Encrypted: i=1; AJvYcCUKug43WDhCh8ooUucyo6l+Cw2ADDjyRNueqaWpxEqUfp9lglpHFt/lgyOnrlfdA1DrJEenXz1igCd+MlnUTcIS3CG6RVcqOzM=
X-Gm-Message-State: AOJu0YxRAhi9z2VDd2uJnaxUEcI12Q/XTz/1jIKlBNRazzudtkMm0f4R
	nnpPn9Jf8KYvgT/GOYyfrikED0BIsrHIhA8XH+kzj0OzhyOGqa7KMqPfhQMhAnI=
X-Google-Smtp-Source: AGHT+IEaflybUi4TXR5teeSXkXx1KSKYcRrJut5+MGiUoHL2i04yvxsp5aTBW0Xu6YHWeoV2/QXOTw==
X-Received: by 2002:a50:9998:0:b0:56b:fd17:3522 with SMTP id m24-20020a509998000000b0056bfd173522mr1051806edb.14.1713943517877;
        Wed, 24 Apr 2024 00:25:17 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id x1-20020a056402414100b00571bc3bb70csm7406980eda.87.2024.04.24.00.25.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 00:25:17 -0700 (PDT)
Message-ID: <dbb07d0e-2741-4742-bf7f-c464bab577a4@linaro.org>
Date: Wed, 24 Apr 2024 09:25:15 +0200
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sh: j2: drop incorrect SPI controller max frequency
 property
To: Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 devicetree@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Kousik Sanagavarapu <five231003@gmail.com>
References: <20240322064221.25776-1-krzysztof.kozlowski@linaro.org>
 <171394121882.41568.17609347008268237958.b4-ty@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <171394121882.41568.17609347008268237958.b4-ty@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/04/2024 08:48, Krzysztof Kozlowski wrote:
> 
> On Fri, 22 Mar 2024 07:42:21 +0100, Krzysztof Kozlowski wrote:
>> The J2 SPI controller bindings never allowed spi-max-frequency property
>> in the controller node.  Neither old spi-bus.txt bindings, nor new DT
>> schema allows it.  Linux driver does not parse that property from
>> controller node, thus drop it from DTS as incorrect hardware
>> description.  The SPI child device has already the same property with
>> the same value, so functionality should not be affected.
>>
>> [...]
> 
> Month passed, no replies from maintainers about picking it up. Dunno, looks
> abandoned, so let me grab this. If anyone else wants to pick it up, let me
> know.

Dropped now.

Best regards,
Krzysztof

