Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA96233EA
	for <linux-sh@vger.kernel.org>; Sat, 30 Mar 2024 04:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711773307; cv=none; b=NfZ0Q/zh1wVkw7WmogSwK2yWcX8fPopMvWvFlkYZveEzeqsCTETU2y0kDkkkulO/LrenWhFJxMqGBOMZaoAkj3pQazZHC7SG6pCJmrBZZEvhTpV1ilQjazi3li8/TYKPM79Aq2aInO/4xMHVWcMcEDB+1EvyhhRDqUQ4x2YaPqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711773307; c=relaxed/simple;
	bh=KESsGVL3oQ1Tct2/upTcGdKcslstjs6sa4QhcS3OUb8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O5nX6CsbfX1iBFRFCSXqTstAljtG60ZbC/UQBsIDbVwkdpXudcO3ozUGFawpsQIlx5sWH17anN1tU4P61SFTX2T3FZWNv1/AjlQk3tZmoliz5KobSbzSr44cj8Dg/Og9iNDWpIKk3OEkAH5Rw21DSwkLjtuB7qS6nUl6JLZaRo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net; spf=none smtp.mailfrom=landley.net; dkim=pass (2048-bit key) header.d=landley-net.20230601.gappssmtp.com header.i=@landley-net.20230601.gappssmtp.com header.b=pn+I6jol; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=landley.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=landley-net.20230601.gappssmtp.com header.i=@landley-net.20230601.gappssmtp.com header.b="pn+I6jol"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-36867dfe940so8647825ab.3
        for <linux-sh@vger.kernel.org>; Fri, 29 Mar 2024 21:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20230601.gappssmtp.com; s=20230601; t=1711773305; x=1712378105; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L+ftDv20t3wS0Lsp+7lIK+iX7cApQwfKmXsWpq65Q1o=;
        b=pn+I6jol3VZursntEQ0kfg6PNtqDv6fzj+HujyJXw4SONL9CJ8gmjf5w8hS3CnClhT
         DuzeWzSIsxxMGWdfMUdz6l5JsiZFoQEqJ1PlVCzm93VS0RqG7VrfwI4ers5ivM1b9BXp
         Xf5tGj7ewRfsCXl1Gx1bVFopbSDiMp8e0PApo3fFvZVe4OjiG1h7TqMt4uE0D9lZmEAt
         rhWvaKA/zeflu4PDRRLvLdpCdyD6xr8ZsppcsbivxCGvdqc8oTdHrsTUcI3zjYfrrAz3
         r2xzoN7xDymOxGcIEb9pMGf8GMNc2jlKA8huKEvvTgJN1spctAwIoFq7ypTMbJKcRCnq
         CjGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711773305; x=1712378105;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L+ftDv20t3wS0Lsp+7lIK+iX7cApQwfKmXsWpq65Q1o=;
        b=wKIflgN/pBtLBUuso1gBsXBqFDJZ4KZkLK22akqO9ugrvvtEA3YrEGFdgKvXVKo68O
         jIsw94/dWo8YfTGIDz888e9VNIaSHpEvryam0YQM0NEtilCU5CSO5plHEefFTGILST5R
         puuNZDunhtXqxXNkuMpbKykzTLQ+VAL/u+gzZdVwSu5ATu0+45jJ68R/DrQ6V2K/HN+d
         Oui1qoM5fqccprKSBze0LGGL+ey3ztBGEtfSuCQE9AXpqF2xZvGoPRLBYwWAEzO1b/0a
         n4JZyGB+4lgII3n5JbrZbRbube/QVYte0pk/PAf3SQ/T2mqOB/PzBIAFDIVG21BJdMsC
         lYUw==
X-Forwarded-Encrypted: i=1; AJvYcCVvscqqGAJ/TVvL+dqySyp7lTVWzW6s3Hep6NKU8DLp7ezsfS/6Dma0OL0EB94y53ci5ABFruwVq6xy9kf4GbWUjcVx/aV6l2c=
X-Gm-Message-State: AOJu0Yx5GfSiXxsr4czZq9ym3p3vLsRdSR2egEObiWt23IAvywzpFyJX
	HRHkM9d8BwRZeUZ7fyN6XmVik5vtIY35Um9iQXu38b1ux3GupiM5VOiPEktaPdI=
X-Google-Smtp-Source: AGHT+IGVLCNwHHytCGoayaTDND3tvqRbKIuPONixjN7UAmpNoIbU9H30r7YohRTWJyBUdfew/qU6jQ==
X-Received: by 2002:a05:6e02:268a:b0:365:cd40:c1e7 with SMTP id bz10-20020a056e02268a00b00365cd40c1e7mr4188375ilb.11.1711773304829;
        Fri, 29 Mar 2024 21:35:04 -0700 (PDT)
Received: from [172.16.32.83] ([198.232.126.202])
        by smtp.gmail.com with ESMTPSA id x4-20020a920604000000b003684edeba7esm1442888ilg.88.2024.03.29.21.35.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Mar 2024 21:35:04 -0700 (PDT)
Message-ID: <7b28fe62-a1e9-1359-72aa-1dc75409d118@landley.net>
Date: Fri, 29 Mar 2024 23:44:01 -0500
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] sh: j2: drop incorrect SPI controller max frequency
 property
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 devicetree@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Kousik Sanagavarapu <five231003@gmail.com>
References: <20240322064221.25776-1-krzysztof.kozlowski@linaro.org>
From: Rob Landley <rob@landley.net>
In-Reply-To: <20240322064221.25776-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/22/24 01:42, Krzysztof Kozlowski wrote:
> The J2 SPI controller bindings never allowed spi-max-frequency property
> in the controller node.  Neither old spi-bus.txt bindings, nor new DT
> schema allows it.  Linux driver does not parse that property from
> controller node, thus drop it from DTS as incorrect hardware
> description.  The SPI child device has already the same property with
> the same value, so functionality should not be affected.
> 
> Cc: Kousik Sanagavarapu <five231003@gmail.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Tested-by: Rob Landley <rob@landley.net>

(By which I mean a 6.8 kernel with this patch applied booted to a shell prompt
on my J2 turtle board.)

Rob
