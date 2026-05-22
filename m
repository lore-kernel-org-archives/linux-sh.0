Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2D481ACA
	for <linux-sh@vger.kernel.org>; Fri, 22 May 2026 12:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779453932; cv=none; b=ToxOQdgAcsAGaJA4Pv5kjWQd4w13IKv5tWZ+tbAvNl7aMXg2LX80BJAQsJikWFnvgCxy3EuNuNacFvSxKgsFWnHgz0nLbMOBk9H9qQShcauL5nTSkDUxk9asfYXYc1gFaY1X/bo1nNGDV2LDclModz9I/rzvs64uLSMN0a0KceE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779453932; c=relaxed/simple;
	bh=B6Wrx8wptznPEXE7GgI4oCIpRWZlbijf1SHKh604G6I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eWShlf7r/PNNUJnARAucr86B2+cdFPVGkfMDW/GWHBz/z16c/5d86Cjs7M7ONuL6NfuZS5YyoWWM1YC176iFloLmJa1GCj31uIfFBIqkH6inbY6lJ0z7lX99at60jihtwmZwU54Ar23KFdf2CKjKNaKfUe4yaqV+sIEdrz7gmdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S9TdA1s9; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S9TdA1s9"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5a85b30dd54so7840501e87.2
        for <linux-sh@vger.kernel.org>; Fri, 22 May 2026 05:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779453928; x=1780058728; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jEx08WhtJbuH9Jvv5ffuVG6XRuDs6AIyFWz3HRiJmYw=;
        b=S9TdA1s9sU06k7pAAsQhZgPt6Jm2cy1jpfHiVjy/+4+phsKTB39AbQjFrUaHHvTuHa
         7xcha/kC9qOvlrvOc+x2JTP+jZxZ/e3H1ei/X60CDqJpjGmR8Nzbf9OwEeh6jXSYmMe6
         1lqGhLX9WLcsDUNoRDwB8RN2/7jcZGUB/8QVzZr9eANTujcgTuVz1xsDUvY1h5CzWkhw
         CjjnUJzTgxZB4Xvh+ERZIfoeKsbVY7GHoFXwuSABK574IaI9xqc2uETLj3zU1ZFqV2YS
         GuqN5wtrNjE3MnCX7eUhhI4j839ntAaSS2DRdL1e8/Q6vQSCXDKpTqbm32FekGdEJyes
         Fk2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779453928; x=1780058728;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jEx08WhtJbuH9Jvv5ffuVG6XRuDs6AIyFWz3HRiJmYw=;
        b=WGoObuGPDu1y8FiFQlcktBuM51bLjURYh7h6Dw6Ysx2A6/Gj5iNZWIUxNlMIlWPkcd
         JmOdu8EybqQIqruS6jBZcyCxC8B6nqmTuvN2tQCpWhJv2LLT0SA0qtq27XibmDkQQNsk
         BNuMqN1UBTdw3Z49yTnS9qmmjvaBmhtfUgIfJZO/Vezwx1R5D6EAzqoe7HDV7C53J5EW
         5W2x7K2VREHn5oRwNTJapVqjehyHrNVeM6E2Z38noYKdAifOcP5hU0YoBvax95AsAXzC
         gJTDeGDo4lbZKP/2KzDzM4DsjMkG2V1OcIM8ZYzyyR2tttlapanQGybMRrlaZ9asQ1P1
         MMEg==
X-Forwarded-Encrypted: i=1; AFNElJ+ZgV8sQ2Hjdv0Aqef+DPifC7O+gkNADSNIu/rXCtfCQGdqkqBtvKz1M10cBI8s4EyVWXt7SqOFsw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxKOqvbFraVRu5x3uhW2QIlYZkn/MZWtZD1EneAijrBuNMIROyz
	9bAg91lMz4WmDCt2lCk6yADbeTCChOYvipOVqz24ZDYep4W0kB9ZxO5F
X-Gm-Gg: Acq92OGWdLHICnfIB0VUoBbvEBbcZ8+YgqgwBAuK25LhG5p9Dcsd9xkVb4BdO4/LZW6
	vbWyR0RH1MQk4nVVeI4aK3Yb/DtHAuAjeHXyE4Qfxh8fSIypfd1orbrK02OmnkjBgyveW1Pt8Um
	42gokGnQaeVhe43ZuhMxhcbPZ/PYl1RZalFjcklt74u5id38/q/5zbRaJeydIduHN5wxQu0zwws
	pIVKWXRkBXV8dX5zFMnX8HvJj/EUup9q5Lv0w35vOrOo/4Dvl9IQsE35A42MCTuhRHPVcZteHx2
	RMhWACe1Ws4DoUFk+oq6qlvo45nOQqC1BOCfKBywujBugIo+rYe1TUOmXmBinbcKOnEKdb6k9OB
	Dx2GyJJXwOnpAQI228q8swvkZ7v6gVdAmcYcDNFddECq+FqehvfiP10TvMKp9CN7NWWc2rd0L6p
	D/irR+8ePGVZ1iuzh74lYapsBp3BeAaQJNvlgxeiGZted8YP5Vo9Li0XVi4yKzwYzFSW/06RyJ+
	CN2IsYW
X-Received: by 2002:a05:6512:33c9:b0:5a8:64c4:38c4 with SMTP id 2adb3069b0e04-5aa32314258mr1031399e87.8.1779453927777;
        Fri, 22 May 2026 05:45:27 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa32cb37bfsm401018e87.11.2026.05.22.05.45.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2026 05:45:27 -0700 (PDT)
Message-ID: <55c36da0-6cc4-4c95-88ef-3dd5b2181b0d@gmail.com>
Date: Fri, 22 May 2026 15:45:25 +0300
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] [v3] input: gpio-keys: make legacy gpiolib optional
To: Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@kernel.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Cc: linux-kernel@vger.kernel.org,
 Christian Lamparter <chunkeey@googlemail.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade
 <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>,
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee@kernel.org>,
 Pavel Machek <pavel@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Jonas Gorski <jonas.gorski@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-wireless@vger.kernel.org, Linux-OMAP <linux-omap@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-input@vger.kernel.org,
 linux-leds@vger.kernel.org, Netdev <netdev@vger.kernel.org>
References: <20260520183815.2510387-1-arnd@kernel.org>
 <20260520183815.2510387-3-arnd@kernel.org>
 <b79d8ad9-f36e-4769-9dc2-58baefe23000@gmail.com>
 <681f328c-bc8a-4410-b876-f8c5f116325d@app.fastmail.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <681f328c-bc8a-4410-b876-f8c5f116325d@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/05/2026 11:28, Arnd Bergmann wrote:
> On Fri, May 22, 2026, at 06:55, Matti Vaittinen wrote:
>> On 20/05/2026 21:38, Arnd Bergmann wrote:
>>> From: Arnd Bergmann <arnd@arndb.de>
>>>
>>> The two Rohm PMIC drivers use a gpio-keys device without an actual GPIO,
>>> passing an IRQ number instead. In order to keep this working both with
>>> and with CONFIG_GPIOLIB_LEGACY, change the gpio-keys driver to ignore
>>> the gpio number if an IRQ is passed.
>>>
>>
>> I am (still) all fine with this, even though I like Dmitry's set. I
>> suppose you already have a plan for merging this, but I still have to
>> ask - why the MFD changes aren't in own patch? I feel it would have
>> simplified merging, backporting, reviewing and reverting if needed.
> 
> Splitting it out would break bisection: The gpio-leds change without
> the mfd change causes a build failure when assigning the .gpio
> field, and the reverse causes a runtime failure when .gpio=0 is
> a valid line.

Ah, yes. Thanks for explanation. (I feel a bit [a lot] stupid, as I 
somehow missed the problem of .gpio = 0 being valid. That even though I 
had it explicitly set to -1 myself :rolleyes: ).

No further questions ;)

Yours,
	-- Matti

-- 
---
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
