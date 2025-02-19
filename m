Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0542AD00
	for <linux-sh@vger.kernel.org>; Wed, 19 Feb 2025 14:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739976773; cv=none; b=MTTRcal64OH+caiwjswjXf9ik1frSITUBPD0Fkfh6hz6Lwu54kFTjAOHQDAkWrFrZNgYCmFtYxh5Yet3jU1QRgV7XRPM5tPsjF3uylOkQ9Py4t46+uEnRP+JIYBFjeedCvqZK5dOquYdzD0Ir4DB+xlSx/iqrFYX3n/cnZm84s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739976773; c=relaxed/simple;
	bh=dp5AVOsGmbjgfTQnYJoV/9JkRncskhmWkEaujE8CIsk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zm5Av/fypZRWzzhbA/LfURbqe88EGeZhkMxzpN+KW978m+/doD9HFIVf7UTmB+2QWjcaKFnTr7/VYGtqH2IU1Mxndb6eM9tb154NCtPbgmzDmqvpn+Vu90EN6lMnsS6VpP+ms6yAQmo/pROnQ2HeYkxfIn6Zua68l7Ywoedm7/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IbZAjarU; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IbZAjarU"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-38a8b17d7a7so3772020f8f.2
        for <linux-sh@vger.kernel.org>; Wed, 19 Feb 2025 06:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739976769; x=1740581569; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AcrTLEV536jWejUD/85wpmtXUyXxwJGaRE9pys71VVI=;
        b=IbZAjarUoH+nNPfLQKaBioT4qbnWq3UWHGGnMrne78Jpujb14UXoNVNAfcpMyfvORe
         minumA13H/4aVWO/6DMx8ozMiTpi72nRaz72Pdh66a0dg0B3MIrWsjyaOVByhpGsKo1P
         GNeAyaXFuAgXfBub8oxr8RW9JUpwQd3eRnDl3gRh10J6CucCQjoPaT2SLd7YsPP05I9S
         Y7IFwcV3m5zUBcEY73ycyNfWGsTXNydRxgVwUikvqNkwWh7VHpNISWUFqBqv0Z4q8RBZ
         SUHr8uRyjZm+TRUi1zYdFNKGT4Ez6WWfJzIo10NGkPvAGMztBBrANMg85XA9tM2SVgJW
         QjCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739976769; x=1740581569;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AcrTLEV536jWejUD/85wpmtXUyXxwJGaRE9pys71VVI=;
        b=DamHxlq+UUbpmJOHaiDSuTtlCYlQrmSz3AG/thihV4Fb/0iBjkEDkiaLoPkko4m1bR
         AKQ3EHi5+q5n3NjhEU6U6pfDN1Q9pgBObxNQN8+e/RAi/a0Hmxa/jftpHYCPVUmuIqU6
         U4Y3nNl7HwCMcVS9seV3wEmsfC84IKbqJbmY5z0Je4sg7J9Q6XdOlnpN0KBaUvv3S/v1
         1zsjxzUWNQcR5LZURtHvyWCKS+mL9PwQ0frUDCEmYOP3HKCS7jSfLxDJUPiEuH94T8+C
         zRROPKdr/Ck3V5HETKTHcHzEWsASOWGb0WDU+dfboQK8koKJp4bd158YuatxBEkurOpo
         tzwA==
X-Forwarded-Encrypted: i=1; AJvYcCUjJ0XQGDlH12BuW6BKEmQostuAn8ZWPnCReaYL/+obKL8QFvrm1qzbElW/b+Dww0Ld57eIQX96rQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzgX1rZWib0jlWTEpMjqsTXz99M0ZkldYwpc6WxpSNOB7Xa8yDK
	17Uo4GpgXXmzETWox4UlofXdP1zeaiawSNswBoVYOrM0ExWrgGuCxVmmb/VHJ2g=
X-Gm-Gg: ASbGnctT50lejJmwXkMjzn5Z/sV6Bv9jlk4rAu4u/dAuQOp4Xv+/i1do70MRgp+evPo
	nN2PVv5+f4O3p7CtN86rdXSpz1uLdYPk4imSQUAJThhAlMMR5WT6E4umZSuruIjQV+M/U3gWuqG
	yZwl9l+3OBvo/9uFbS37Ju6EEGJeDaRG8215EvJ4m14iW9H5iiC7PT1onvhu468NrP7loh8S0z4
	YlDiLnAh2uVnW1vNWD7hogt+M9WgGQ/fBk9KGTDEANrconwDi8ylq0xWdGLHRU4wRnYtbRherhc
	fxGDlp7InqMZQuVtKuBDCUjfjx9Cxtl5tu5qI0wx6HRGVki+vWJ726U=
X-Google-Smtp-Source: AGHT+IEGpOUT2Kql6BOz/f6CUFqRsZvcez+B8YGnnSN/N6M/oshP7AzII9i03CFTfTUAIR5PkMXw/A==
X-Received: by 2002:a05:6000:2a4:b0:38f:483f:8319 with SMTP id ffacd0b85a97d-38f587f3ec3mr3475441f8f.51.1739976769565;
        Wed, 19 Feb 2025 06:52:49 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-38f259f8115sm18324866f8f.92.2025.02.19.06.52.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 06:52:49 -0800 (PST)
Message-ID: <5f7cb96d-ccc5-47d6-a732-560dcedfa04f@linaro.org>
Date: Wed, 19 Feb 2025 15:52:48 +0100
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] irqchip: clocksource: fix jcore-pit irq request
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Artur Rojek <contact@artur-rojek.eu>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Thomas Gleixner <tglx@linutronix.de>, Uros Bizjak <ubizjak@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 "D . Jeff Dionne" <jeff@coresemi.io>, Rob Landley <rob@landley.net>,
 linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250216175545.35079-1-contact@artur-rojek.eu>
 <20250216175545.35079-3-contact@artur-rojek.eu>
 <d7484ab2-6da0-4bb9-a2ae-9388dac15038@linaro.org>
 <CAMuHMdWX9xeLRDLnteGWR31KbhtdupxVbhjQqY-6VaFA4tVaBQ@mail.gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAMuHMdWX9xeLRDLnteGWR31KbhtdupxVbhjQqY-6VaFA4tVaBQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19/02/2025 15:50, Geert Uytterhoeven wrote:
> Hi Daniel,
> 
> On Wed, 19 Feb 2025 at 15:43, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>> On 16/02/2025 18:55, Artur Rojek wrote:
>>> The jcore-aic irqchip does not have separate interrupt numbers reserved
>>> for cpu-local vs global interrupts. Instead, the task of selecting this
>>> property is being delegated to the device drivers requesting the given
>>> irq.
>>>
>>> This quirk has not been taken into account while migrating jcore-pit to
>>> request_percpu_irq(), resulting in a failure to register PIT interrupts.
>>>
>>> Fix this behavior by making the following changes:
>>> 1) Explicitly register irq_set_percpu_devid() in jcore-pit.
>>> 2) Provide enable_percpu_irq()/disable_percpu_irq() calls in jcore-pit.
>>> 3) Make jcore-aic pass the correct per-cpu cookie to the irq handler by
>>>      using handle_percpu_devid_irq() instead of handle_percpu_irq().
>>>
>>> Fixes: 69a9dcbd2d65 ("clocksource/drivers/jcore: Use request_percpu_irq()")
>>>
>>> Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
>>> ---
>>
>> How this patch should be merged ?
>>
>> It is touching irqchip and clocksource at the same time.
>>
>> May I pick it in the clocksource tree ?
> 
> Thomas already took it, cfr. commit d7e3fd658248f257
> ("irqchip/jcore-aic, clocksource/drivers/jcore: Fix jcore-pit interrupt
> request") in next-20250219.

Oh, ok, thanks for letting me know

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
