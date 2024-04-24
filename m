Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF61157478
	for <linux-sh@vger.kernel.org>; Wed, 24 Apr 2024 06:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713941325; cv=none; b=oXCIK7uHwaPl6zFxkOdAyClD6eEuoyGGqqVQavwcFymBCONh5juFwVld799ikBG84LlE/QTq7lvXWfm/jOOtJ9nYkQhTpW6dwGZgMW99tdq3jhsxsvUJpMaaHaFJlW6+PL6gfbpOoFh0tJrv7ddX30YpMYKHVmpLLo1CKjsFe5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713941325; c=relaxed/simple;
	bh=5CU6mL+iQliAjVWbjAM7cnzdrrPIzC97UjspUCLrXDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TS00jppWQzRF69jpJLoT5+orD9c8/anivq5xlmtbBN/F9rdnGkksJ+iuF1Oa7n6GxPo31vv/Of+3oB/YBDCczrSfS4ydQsS2bmf4jfUYUfgNDmYt/d62cJHgrmIVXeCIVeu6tNjlxstTJXjHOFrfuvqsIxFeZtCd6FkGiNLYBY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vNfExcaV; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vNfExcaV"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-41a1d2a7b81so2881875e9.0
        for <linux-sh@vger.kernel.org>; Tue, 23 Apr 2024 23:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713941322; x=1714546122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r61Kb7IQFeca73kF1CUdR8Nck6Yrqjf3CouDIb1P98U=;
        b=vNfExcaVYtlcpgdiHeOUgMU6utCfNEbc93oR4bUOnhUCA3WyreMkDNujfzC1SNjrnj
         eLTK/uoVJODb5R/DcYNOW788rcl3TNNxcpZ8WzyyhRzsdhnfeTn0lQnquK87D7lx6Pe9
         bi8TlNXddmq3+lUAJY4+xfWZ54KDbg0uRXsi2CI6I4taEClUqAMhw49vAG//NdC4RyDD
         O9ouiL3GDjxnLpUqxgAw6nrCI1l9AEwK32bZe6NzIY5kOGNCM+f0QAqvTxD/i+KZz4W8
         r2HJ7UIS0mgexa7N5fOwtam6U/1EjuYRQ9iA6GE+mon6C/lylu3ljAk1lkLopZ1rz9dg
         Enbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713941322; x=1714546122;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r61Kb7IQFeca73kF1CUdR8Nck6Yrqjf3CouDIb1P98U=;
        b=ARQ7T3isB/9mBL728ZzhtQaaaiJVjid2FkkjjuaNj8MavLUr+rChXJLI96nyZGhJp5
         fdP5cHvCBGPZcqeYiwIkGqm+w3IfTxqtBbTox8gmDaB3n2Y1Jwfi4XYkav/1V95JMpKG
         k9uouFFWCmzJvgv+X0X2EBuqAZPG3ZMssMupaGTVwiCJ3jO/wvrYnMRtglU0fpeF2mDq
         ME9KL9x91CkTGx/T6oXU/wNOg3NRseJrqMJhGBJz53b58WS7Wu2R454f4vgpWK9rk7gN
         K8yNjrFWhIp8w1pUhu0xaqtbao/LjjqS0AXmbw5G7sLNl1lGa3Tnvh2ocZ+7/rylnZIO
         L4EQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRhgs7lF49ItEOFW6sdzujoaOh0KQBhqu28vbeUCX+WNUDZJOn6MFv0eYd+y4V2lt9hBAICizm538aXALwkLv0EbjEg4y6/rY=
X-Gm-Message-State: AOJu0YzZUFBF9oRbxkFml03EAQuzEbU5OYFgSc/UHYewQbXBQN7FQtN6
	+HqBkcLg7D2u9S4YYfukcx/2m/MgGdvVU0XBBNXs6tiPoKw8zP4tgandPLlVwF8FJG815aekHAE
	C8xI=
X-Google-Smtp-Source: AGHT+IHaQADJgMwIajA8lFxEUdw1lpqkdpyaVAJFqWUQcrZ+ZPia4iTy725UEakhayBhM96AyPmpog==
X-Received: by 2002:a05:600c:3b91:b0:417:e316:fbb3 with SMTP id n17-20020a05600c3b9100b00417e316fbb3mr1013641wms.15.1713941322494;
        Tue, 23 Apr 2024 23:48:42 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id iv19-20020a05600c549300b004186c58a9b5sm22433236wmb.44.2024.04.23.23.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 23:48:41 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	devicetree@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Kousik Sanagavarapu <five231003@gmail.com>
Subject: Re: [PATCH] sh: j2: drop incorrect SPI controller max frequency property
Date: Wed, 24 Apr 2024 08:48:36 +0200
Message-ID: <171394121882.41568.17609347008268237958.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240322064221.25776-1-krzysztof.kozlowski@linaro.org>
References: <20240322064221.25776-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 22 Mar 2024 07:42:21 +0100, Krzysztof Kozlowski wrote:
> The J2 SPI controller bindings never allowed spi-max-frequency property
> in the controller node.  Neither old spi-bus.txt bindings, nor new DT
> schema allows it.  Linux driver does not parse that property from
> controller node, thus drop it from DTS as incorrect hardware
> description.  The SPI child device has already the same property with
> the same value, so functionality should not be affected.
> 
> [...]

Month passed, no replies from maintainers about picking it up. Dunno, looks
abandoned, so let me grab this. If anyone else wants to pick it up, let me
know.

Applied, thanks!

[1/1] sh: j2: drop incorrect SPI controller max frequency property
      https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-dt.git/commit/?h=next/dt&id=cc92bf017f7c66c8a4050c61a7d11ddfd43f5cee

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
