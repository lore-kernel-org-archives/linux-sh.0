Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB7B2EDD5D
	for <linux-sh@vger.kernel.org>; Mon, 24 Nov 2025 08:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763974141; cv=none; b=jTz3L5lEfrX8GLp+gSWrln/qKei3f8Z1gEq5yQDJ2SnSFuapoFOp+YTgTVUJ+Q4d4JnPR3bK1UNKNGqfponb0yt017KjZfx5ZF9cn6uO0+e++9qtwfxmthSGLg+zHPpbYJxzd7+NsWhRXD6J8n25b5FO4T2XBGgFdUBxYYoKEF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763974141; c=relaxed/simple;
	bh=TOUgkU0CnTgD/OMf+BMxBTCRo5GmN09iRTRDWkMpRaQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JPiQ2zKBp1F8/DjR5l+Wqzto2d67JhI+ls4jo57jB/A7FsN6DfgjGM8iBO5MMpMauUj80E+LrrpMCJWn5wg/RZyJMUoqIccq7hiORKGv582ov2JdQqMElfV8D8Q+nexGEYbmIb/yJl9x08juV2HernAI64MC04xlo7LhVp8dOXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xyuIDsUg; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xyuIDsUg"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-477b5e0323bso25769785e9.0
        for <linux-sh@vger.kernel.org>; Mon, 24 Nov 2025 00:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763974138; x=1764578938; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=REAyeuIOej9oylUCUsREGxvZ6tIVyzRPM0vzc+fC4nM=;
        b=xyuIDsUgjIqU1I+bfTJZzWis5GSgAI6s0oSZHvFHvjC8luKxHZlzuFkYBdiOm1GQMV
         z5GnlePWUwSCDNcQSoeXxwq0dSHNQIZBdAVg3KVlY9Ufjy2j8zPvQPeIQocqcrexOEWq
         ffkfmVlmSxuoUnJsQneqzIkzp+m6P2W4tl/KSKhIw4YjPiG2uTPfuSfvT7Vuik02DZ19
         O9pT+dEH/95LjWGdzDYJ8fHHntZQ4xWFDNyED0mX/VU+yqKvIoucMSbd6CGUqJTww3XH
         zZsBFha32fywaUvBtv1KyXfxC6OuGRo+/qYIuSi91fogArtWxHuvVuLSLShA/dUmmfnA
         z6yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763974138; x=1764578938;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=REAyeuIOej9oylUCUsREGxvZ6tIVyzRPM0vzc+fC4nM=;
        b=qYM/1T/LNLrruGew5ms6+WcbcM8Q140gaQ/NeKFxdXyj7D42T6ak7fWJGNw3YQp4At
         LSgEvQUwPI2isZVSAY9fxohWAAEXDE7R/fHjMjVnHzWJ3NB1Sj2qZs3/oZqosnYlse8k
         Oz0RhH6pgjtoa7hQn3eUYws0+r7uu2aHlAIIiLZU0TJZZeb8kXxuq+4gr49BmcqHoQIx
         3m3HXWO3wt/9F9qlQ/s67kRcbqMFHVGTWX8BlNCGpayF0WArbsrhAcSHzjP2rqWhGs6H
         SkGEa42xED2g0Pcq/+1Jh7lAheB6s7lUOGjYXaX75a+0gp9JzjGBjSI0nzq7h9Oz+y3G
         I01w==
X-Forwarded-Encrypted: i=1; AJvYcCVp1jA1X/gLYSgfiWtapoxx9/yGHj8UsGifGb1izORczBVzqxVSJgaFkELb8wBVpvlnHJmYiChstw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6Hdjzk7+oxfb6uNG7EUEDVYL4FPY/INbFORDqBy7KymIwgWge
	mVXR+DYS8dCOvwyB981I2hjJ9k4AhQa6bpzKJODpMb4zCkPcK3HcHtrtoybMLNyEJV8=
X-Gm-Gg: ASbGncvbtmjJPohg+qXzN7TS+6Z45pK/4x78OjM6Jj6by+J0plpYDKoPB2JQZs/4Rvv
	9M+C1+CXbXLHW8HRC1vvVE/ZPCZHyCvWCGiyEt73IHBYzczhLQDuOzUk/lzO9XMO35C/+YzSZTN
	Ax5xJFyCw++7YouwZwY5x88atHJhsI7OGs4s6/dkuBvNiBrNIPvAHQ9ANygZvJb1v2KUrdzWSU2
	019rWwyIEnlTA3euXu5uT09KAKYWM4l0Ym7LFsL+LO7bXYF1mK5FuT2LZhWoVDnYdiwPxB/Bm4I
	a83rqm0HbirjVLaHUD5uh/qEEW0mVSB1RUootAFAx2F2bGeGXoI20PfJvWpMVV2FgzLUHtf8h0+
	Pw4yjtRyurW1pcqNa/DkjLf6kLDIxE+W5ZeNnShbXEnrRxl+VlslBGafX6butIWSr23zD05roch
	/cLhuV52X5FKLIQdXrV7+sRxcESvF0RVIx5Xl3hDvpWY7dUNv4iYmqNIW+gDAkGUt+
X-Google-Smtp-Source: AGHT+IHsEOznXAUy49fhVYlZq2Lhi2GTZmBEsY+WLEPDs2jIKnFWmMD2Vp4Hu+/sDSso+QQ6V4sYew==
X-Received: by 2002:a05:600c:4f45:b0:45d:5c71:769d with SMTP id 5b1f17b1804b1-477c04db9a0mr116274985e9.8.1763974138163;
        Mon, 24 Nov 2025 00:48:58 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bf3b4c13sm182560995e9.13.2025.11.24.00.48.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Nov 2025 00:48:57 -0800 (PST)
Message-ID: <ea61d8b0-8307-4796-85af-04113c13deeb@linaro.org>
Date: Mon, 24 Nov 2025 09:48:56 +0100
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 64mb limitation of qemu-system-sh4 board
Content-Language: en-US
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Rob Landley <rob@landley.net>, Thorsten Glaser <tg@debian.org>,
 Michael Tokarev <mjt@tls.msk.ru>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker
 <dalias@libc.org>, linux-sh@vger.kernel.org
References: <aKi6IWVX2uIlGKnw@seger.debian.org>
 <Pine.BSM.4.64L.2508230023030.21591@herc.mirbsd.org>
 <6abe2750-5e2c-43a1-be57-1dc2ccabdd91@tls.msk.ru>
 <119d5858-52f4-ce1b-9ee7-9615ce2054b9@debian.org>
 <79f14fef-123f-4938-b069-10f07e7d0405@landley.net>
 <b42433a7-e102-43f7-a7fa-1c9417a21146@linaro.org>
 <91b74af52f69c360a27269ab3145eeb377ef816a.camel@physik.fu-berlin.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <91b74af52f69c360a27269ab3145eeb377ef816a.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 24/11/25 08:33, John Paul Adrian Glaubitz wrote:
> Hi Philippe,
> 
> On Mon, 2025-11-24 at 08:31 +0100, Philippe Mathieu-Daudé wrote:
>> On 24/8/25 20:07, Rob Landley wrote:
>>> On 8/23/25 09:19, Thorsten Glaser wrote:
>>>>> There are no alternatives - qemu is unique in this regard.  And
>>>>> it has never been designed for this usage.  What we had for 15+
>>>>> years, unnoticed, is like `chmod u+s /bin/sh`, which is never
>>>>> supposed to be used like this.
>>>>
>>>> Perhaps, but there’s shades in between.
>>>
>>> I find qemu system emulation a LOT less problematic.
>>>
>>> For sh4 I boot qemu-system-sh4 and then use a network block device to
>>> provide swap (so the 64mb limitation of the board isn't a limiting
>>> factor).
>>
>> The R2D+ board uses a SH7751 SoC, which memory controller can access
>> 7 external banks. This board has its boot flash on CS#0, a FPGA on CS#1,
>> 64MB of SDRAM on CS#3, a SM501 display on CS#4 and some ISA bus on CS#5;
>> leaving CS#2, and CS#6 available. CS#2 can have SDRAM, while CS#6 only
>> SRAM (not really a difference in emulation).
>>
>>   From QEMU side, we could fill these empty slots with 2*64MB of RAM, so
>> the machine could use up to 192MB. But then it is up to the guest to
>> use it.
>>
>> Looking at Linux i.e. it seems to hardcode the RAM base/size in
>> arch/sh/include/asm/page.h, so we'd need changes there to use more
>> memory, which seems unlikely to get for a such old board...
> 
> I'm the upstream kernel maintainer for arch/sh and I would be happy to make
> the necessary changes to get the Linux kernel support more than 64 MB in
> QEMU.

Great :) I should post something shortly so you can play with.

Regards,

Phil.
