Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C221F2B87
	for <linux-sh@vger.kernel.org>; Wed, 19 Feb 2025 14:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739976222; cv=none; b=CLpZePPQXjFHqLFzw+2tBxG6v43eHs/2Muv7UnIrbOGth6UdTOIGpZOCR37UR/AKozsCjHv/LNlOIBTCQdRxxWHYzAhPHByrOYJhKEpUUGhKYUsZm/8WOvH6hqDjw8W2bNjaMLdjfRfVvRWy3Aw/AXZUel8uUwYZ6cmXeu1aPOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739976222; c=relaxed/simple;
	bh=XXJzkYspgnpCWCcrBdndAxSLHrm5YJblVEb/RtSh968=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PGPUAIBoM1IycrfLs2GePO5QFdlJcASgVdDwj0BI7MtVvRWVr/pHfHmoEE0iaYiz3vgQTBeFwnUb5TZfDOHiItSYoAV78ErqXmG7O+pEmjr7JIaLDLad/Pdoh+6KPGQiyDJ3b2OcLHTwyEk7yNF1P7BqZQKFyMP4QpHifW7haO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pnOOdhmR; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pnOOdhmR"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-38a8b17d7a7so3766471f8f.2
        for <linux-sh@vger.kernel.org>; Wed, 19 Feb 2025 06:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739976219; x=1740581019; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CB7D/FiNY5baVQEMZN1/IzSqi1RBp0oVyn9FeISCPkE=;
        b=pnOOdhmRlMo/WlZGZDnxvr+T4F8yUMF5xRSVrM0+8zV8AfNKuyikLBzaSir99kif1V
         cBloXPgwQEY2h05qHFbRKmqntdSgmbeveArYEdqE81hUIPba1qpyAg7P1f2csBgtkGcG
         dGr/FH4448npeMtIo+ICVsxCL/SUzuNr2kUGuxPZjMmpvc8EA8MFfjs/xY0qHbqrpRJV
         gtUA7i5gpPVq/u3r1XmlUmpyxOL2PiQSl+d3PKgbw39BZCk+BEL7DXiq1zAeuQWh6rDa
         eJ3HuG9tjjM00f9Ipekxefzox+3KQlXXPsy+79R29Qxg71ya3EJhQgDXYrlorLBmpwyz
         xB9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739976219; x=1740581019;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CB7D/FiNY5baVQEMZN1/IzSqi1RBp0oVyn9FeISCPkE=;
        b=spwBNscuqEtxD6iJ36s4cRqNry5TMCUPWLvG8CAr/oI14ke6P1bJ9mgWXwxz3w4A5g
         p45g5DZ80iJ+/2yLEcxbrZ4GG7FusZi/0HjJSJZ7q0ak8kn8DqllTnk6xZYLe9LqKhRf
         cApar+xULPduP4FGWFrGaRiD1aDOpEGcwd9idoyt2ykrbnQzdZt/Oc+T7hzsTcPb1KN2
         93+4ARUBs1IhMZBiatEJNLxmO4DGQjBZCDCRNAt8fqwqAKeJzaOXJ+4wgnfkgiGOd4xB
         MHczEnLXIqwbrC/hYRX/kzv5ow/ofFp4yeH4w1lJ4MsBCMJ6S2Bm9UKSuPnCEhWR8Zst
         aI+w==
X-Forwarded-Encrypted: i=1; AJvYcCUJvgfySdu3EjdFGU8+nSlfzQHdmdxAu4FNCIr3jrr4+HW00pVgJ4lNRhx3wQNq0SPVxAh1VwaIQQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9M9JVL5eYl8FasIkM0EWGBS6KS+Lf8+OhBSxG23y4UCjhwJbr
	6Mdmc5VKaNZ9791uJ/oJu9AB6YFGDN2bMys/MtgYyQ0I11CZtdzlKhspsYTQe+U=
X-Gm-Gg: ASbGncuFvDExAf7/dKDUTAeJ9VV/MXw7bbocTbzbZAnE8am96bUWAQ59C4zONI65nAO
	Q1I83Ox2sRPjHQXoOXHM3SEkfaAvUeiWaKrNP1jE5/HdJK+Dy4+grjrivZ2ejtmehFennFRtI2m
	oIyp64+rN/R5cUMFXM+fXv3mOXtBBk/NHJMl9bbqMAYJnxXBARfo3tlExq8Y2UWG9fHJuVlqSaM
	uEHB6nEZcvtxrpAMtXoQwUbJGjoHTDUjEYv7enVEbIi80F59q2eCU+WnNB93VV2Tmn9zG6P3WwE
	2RuZRYZr+ghpVg1RXqv6HZRorB6qzRnLbk+9GB3bFh3nKxHiXVAGlzc=
X-Google-Smtp-Source: AGHT+IGG9It8D+g9Z+h38+jTAPsXA4RAxVB1cY9lICrXMt4960TT9OySBuKZmnHsRJt+WQCSqCRTvQ==
X-Received: by 2002:a5d:47a3:0:b0:38f:278f:58e4 with SMTP id ffacd0b85a97d-38f5878c88dmr2421933f8f.12.1739976219017;
        Wed, 19 Feb 2025 06:43:39 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4398a64febasm75324215e9.1.2025.02.19.06.43.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 06:43:38 -0800 (PST)
Message-ID: <d7484ab2-6da0-4bb9-a2ae-9388dac15038@linaro.org>
Date: Wed, 19 Feb 2025 15:43:37 +0100
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] irqchip: clocksource: fix jcore-pit irq request
To: Artur Rojek <contact@artur-rojek.eu>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Thomas Gleixner <tglx@linutronix.de>, Uros Bizjak <ubizjak@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
 "D . Jeff Dionne" <jeff@coresemi.io>, Rob Landley <rob@landley.net>,
 linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250216175545.35079-1-contact@artur-rojek.eu>
 <20250216175545.35079-3-contact@artur-rojek.eu>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20250216175545.35079-3-contact@artur-rojek.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 16/02/2025 18:55, Artur Rojek wrote:
> The jcore-aic irqchip does not have separate interrupt numbers reserved
> for cpu-local vs global interrupts. Instead, the task of selecting this
> property is being delegated to the device drivers requesting the given
> irq.
> 
> This quirk has not been taken into account while migrating jcore-pit to
> request_percpu_irq(), resulting in a failure to register PIT interrupts.
> 
> Fix this behavior by making the following changes:
> 1) Explicitly register irq_set_percpu_devid() in jcore-pit.
> 2) Provide enable_percpu_irq()/disable_percpu_irq() calls in jcore-pit.
> 3) Make jcore-aic pass the correct per-cpu cookie to the irq handler by
>     using handle_percpu_devid_irq() instead of handle_percpu_irq().
> 
> Fixes: 69a9dcbd2d65 ("clocksource/drivers/jcore: Use request_percpu_irq()")
> 
> Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
> ---

How this patch should be merged ?

It is touching irqchip and clocksource at the same time.

May I pick it in the clocksource tree ?


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
