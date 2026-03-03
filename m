Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0B83A874E
	for <linux-sh@vger.kernel.org>; Tue,  3 Mar 2026 16:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772557071; cv=none; b=BwQOIS5fVseWKPGBbKUpvjg3N59N5BzFMJbQnAvSgilcs5pGRgUwonS+g7d5HXdUikZBYyPLLMo5rNju/c3m/aq1WBI+GsygdpDdfB29PTOSvqQcbp7nOENBVTVwGvhAosn0SmZvwbT5QFX9a8RSy5l0RuAOFP02yj8QkoRbZ7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772557071; c=relaxed/simple;
	bh=3/GzSmoRFQsgGZDBWOEZf5WA45dc4iHal7c2SQqyU/M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dhaj0d20F4Xy+bXbphrj0WhgdKGhOP8dJR6SRf99RS7YB9lR9envDLvubEArkoZRzA3byoaeXkEnkDOp3/Vi1wkltiSatVoIKRENLUOAMrGyJRfa2ZmkEWl0ciZNpWXAaY/ADmF0x+RO6wc6EIHvms5CkMYHy5VUQxL3/S7dieE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HvwwAKDA; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HvwwAKDA"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2a9296b3926so43749345ad.1
        for <linux-sh@vger.kernel.org>; Tue, 03 Mar 2026 08:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772557070; x=1773161870; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=DV/HSQAamVa6HSuuaGYt1Sx9aCryyCjzy9hIsHP5+oE=;
        b=HvwwAKDARrPFqD3SS5xzq/r5mXo7NoKE7T6BD9dD8EDEFQAuJqiXbPvOGTZ7zuexG+
         p4++vojTrsNVrp7npf+SU6Nw78R1rhpXT8fcWBzC+YBecRbmnYKdZXDoE12WbFRid0zG
         eoeRH77r9zOan6tV+X89Ph36kU6ygpjYsrWzcc1zfYScYeiAnDtXXMGoHrh9+03Twx/k
         nKTXQQYYfBdhyQgvm5xhqY/1Vq+jz1jHoqNOkXXD/udJGDS4sxQ2keR2sNcF07T+ogoa
         YkzxBu72PM8Eyjh6GQnOjQQtRaHDztyY5J2WrUXUEXm+3CAPvv0Tuz3Wvcx/T5USEVAu
         6aQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772557070; x=1773161870;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DV/HSQAamVa6HSuuaGYt1Sx9aCryyCjzy9hIsHP5+oE=;
        b=R+VJ0DSg6MMXuvhoZzCzHaeOAUU0ijQ0pxz+FZwWbWk7AUpxyymjmjg+UO+zXDVU05
         A6g5k9LkTOtOKz/OzTYA/4WTO1CDuDy68+DZ3n/b2cqr8WdbDEcSTH8VTnZkUKqDB7xG
         9EIWjpeTws+AIH2WQdf7HdRRegtzHi5k+XaDNQ5rDUBtOCrAUGUJ9teYaAG8K2yOKuUP
         tPbOPgVqQL8r2IhIF2qBuQndzyqL+dzMLCfQN1JC3m9KFSC9NSI2ZxpRotbUWvDffzis
         Kcf0Y2wUzckozC0+VRzxyZmGZh3kf3m2VcQyaqqncaBtU3Q87BYdJ2Q/IwiD/J/MCQWu
         a25g==
X-Forwarded-Encrypted: i=1; AJvYcCWJiLXhv//8pyfLLkIPR7M/YrrN2N07CIwriqauMgBjjFChyo6dUQqEmZJ6GyrV9X4M+R1g3XaxhA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyQa5d1h/FkpZkRUquibEopoyveVqOyCXE0ROvPHjbsy05yFWc4
	Kh9OLrNj0QJ87ThKbLw0Cm4pkFQ6eqmOewROS0Wb5o9+ba7NW5Bpqllf
X-Gm-Gg: ATEYQzwoGVc8yhnQLaztzfILLtUnp8nEpXbQ3XcNID3pHe7NW+X/yPJpLtJoQJDkqo3
	Y9B1qllazk2acRt0gU/FnY3n6+fUaHVGteFeiaO8Wkq56QGcPH/qCZMRO0yzR7HLY6iHlauCGdU
	5SQvXvtncHhfzvqv5XeWxQPF9QwIXmyH1EW02tVgLA8X4cIK2746iV6S4KI4rAd7lYYcYizfZ4t
	bq+BmeJSMKW54BzaqS1Loh8qi2LsQe2vqwC5szVx7WdqNx2fx3bJtrZS5Wq3L4cHNUNpunjllQ4
	wjW7Tvl6tz5gLZIWbR1/nm2gA6h4745atKnQczW1VIM/Mkq3SIQyVpPqqnip8hAuJl5A04dLHAD
	cAzYf1MMlxi2Eq1IdYVQPMmxq0AAuWvzuOnW9g6GUqwWZhaV92dnLpY84IMOo+n5JgTL2WaZT1a
	OUKSDwT+GBhvejtWxQVtbyQ0I9hX3IW4lTARMjbGdEw5g4lz6+RZvS/LuOacJVfYZJEEJVsIFZx
	unpwcM4OEc=
X-Received: by 2002:a17:903:2f89:b0:2ae:6317:56e3 with SMTP id d9443c01a7336-2ae63175cb8mr20707785ad.28.1772557069742;
        Tue, 03 Mar 2026 08:57:49 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae4802645bsm83989515ad.12.2026.03.03.08.57.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2026 08:57:49 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <4a7ac923-0f1a-431f-a029-8843a8eddca3@roeck-us.net>
Date: Tue, 3 Mar 2026 08:57:47 -0800
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] hwmon: axi-fan: don't use driver_override as IRQ
 name
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, hanguidong02@gmail.com,
 ysato@users.sourceforge.jp, dalias@libc.org, glaubitz@physik.fu-berlin.de,
 abelvesa@kernel.org, srini@kernel.org, s.nawrocki@samsung.com,
 nuno.sa@analog.com, driver-core@lists.linux.dev,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linux-hwmon@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-sh@vger.kernel.org,
 Guenter Roeck <groeck7@gmail.com>
References: <20260303115720.48783-1-dakr@kernel.org>
 <20260303115720.48783-4-dakr@kernel.org>
 <b46c5757-b67d-4949-b8d8-54b799464b5d@roeck-us.net>
 <DGTACERFTTCV.29XON9ZLYAEQL@kernel.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <DGTACERFTTCV.29XON9ZLYAEQL@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/3/26 08:25, Danilo Krummrich wrote:
> On Tue Mar 3, 2026 at 5:23 PM CET, Guenter Roeck wrote:
>> On Tue, Mar 03, 2026 at 12:53:20PM +0100, Danilo Krummrich wrote:
>>> Do not use driver_override as IRQ name, as it is not guaranteed to point
>>> to a valid string; use NULL instead (which makes the devm IRQ helpers
>>> use dev_name()).
>>>
>>> Fixes: 8412b410fa5e ("hwmon: Support ADI Fan Control IP")
>>> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
>>> Reviewed-by: Nuno Sá <nuno.sa@analog.com>
>>
>> Applied.
> 
> I need this patch in the driver-core tree, otherwise I can't land patch 4 of
> this series [1]. :(
> 
> Any chance you can drop it from your tree?
> 
> [1] https://lore.kernel.org/driver-core/20260303115720.48783-5-dakr@kernel.org/
> 

Sure, I'll drop it. Please add

Acked-by: Guenter Roeck <linux@roeck-us.net>

Thanks,
Guenter

