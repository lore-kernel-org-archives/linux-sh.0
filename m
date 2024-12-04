Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FE4156F3C
	for <linux-sh@vger.kernel.org>; Wed,  4 Dec 2024 16:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733328774; cv=none; b=FWcpqDxLU/bnokQbOOCrkfsCFR8bY6eJ6cf0Q166qV854EzcF74s7fC4hVULgQchSVQarPu4MU4i5I9yLTSV2xvfyvpC3zbv8ShEeeMsSKlh5QJGQZlexBhnwZ9jYDJ7VniZHDML2DSh1nA0u3OrW54gFbYSSoch4mZUGSAVvo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733328774; c=relaxed/simple;
	bh=WMotf16BNP2hl+VFEpZRiKSDivn8XEcTtqQ7ghZ/DsY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KrifG7TgeesAh95sDunZI4k6mpo3t9jct2d+9JaDQQCXBVeurldui4XqNJGldghY24h/MFw+1AuOolmbUM++BapiPSiMnO9bOtSTqqPVHnp5EfoMaVuffv6oo06z/8xVIyOelDQve+br9bqzcR4ibRohBLJ2a8wQjRQLz6WD5PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=WBedOOG/; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="WBedOOG/"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-434a2f3bae4so64936805e9.3
        for <linux-sh@vger.kernel.org>; Wed, 04 Dec 2024 08:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1733328771; x=1733933571; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hQTQKeCKhE7MCIO8rjYyScRAwZVqxhfCtHNY0N/EVfU=;
        b=WBedOOG/+cUqDyNvxcPeikjnyJG+pPqA8DckCC0q0CIKPZWjBx5842PCKtvmVNA9Di
         d5CtgrbUrbJCWw6VBQodsnNaQxYilSxj/l5C+PGyQs+Meih5jpzZ7ZmqPXQU6MkwAkWm
         Dr7lbIirLOZxq8XN4sFN3LpBvGL+afxcw51SYWc6hud4nrDpkgO2CJ5mtkojNoLH7C4z
         nQqJEcquknH3baW1JWspGUPPFcCMSH8DCMWPGneTwfcMoq7ASaMlGVdimQcvrlEsIZS8
         zGHX1/eGn2nRAgQw8zgQoV2bcgabENqChk9FKLWKqQfFpy4XctzjZtWQN3/9ejOSEuC0
         BDoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733328771; x=1733933571;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hQTQKeCKhE7MCIO8rjYyScRAwZVqxhfCtHNY0N/EVfU=;
        b=ilbjmjaT6uNwQVnD/yEGcIh4MxGn6CVBddEQQEi/j9OTwYn4hqVK/tOojANOy8sqCy
         Bh+5uPeqvTGPwflnLWi3thqglTjl6XCncGX5ed9jLhhrLhvwbdy4MrnYTAECkHVcWiGL
         O7f5Z0fnA/A6Qrm0gL2Xyo48MqOGQs2p3ujmQxggBI6zSaGdJYWWDN/HiBt0Cn1VdKhh
         U1ytSpoGfkU7xom78+0hUCjA6rGcASinO2CyImhusWC66FMhRwmuy8iwexJ1A3u3Knok
         VbPTY1rILZV+Watl1JJIZMy+mpplhwWjf1/kVzWz2831Wv/JhAtpNbQ+ytAd1zXnvI9j
         3ITA==
X-Forwarded-Encrypted: i=1; AJvYcCUV2o9SMNcmlORP4PbTmFQwBu9GZD+PWbmcFOwpOkwC+WfUFF7K3luAPVlzgy/Oe26wKCxOdFLm9A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyaIuv3q7RZyPmN/11TBrC8Zl0RS8Zmugr8nJbdNHEeMHmC4ITT
	IRhxgjRHICfq6ow/GlYFwEiI/fC1QpeeFZqKmFAhCKOUdpf2B+vLUnl9agEjyM9R4VDaAPLRned
	/
X-Gm-Gg: ASbGncuJV5G1mBNTS9gEqTApBUz1wTZBwbSaO1epka0g7iMKdLTJVBGRFA7RevCnBoN
	wW0z3iRVHS3m0cn+u9AdT0xYr3C1rPIVT4IFrWH1AGGttPrPjCsIGQSPIu7tiv2JUNmfUy5zytI
	je/zEYRJkL85UMPoFlcaXPMAfHPxR+VYfFqqX23OBvIVlUuCeZAkAX+oN+Z55x7TBK+fAYwShIq
	0veabwLeWeW3X+GY2JR+8FjloQZPZqNiEuFppLoDmZ42NLh0Nv4FCogXEo=
X-Google-Smtp-Source: AGHT+IHSduioKZEL8oXnhOPYaiOLYjsifTz/WCnsJQmND2DTXtSP9onkHLbSag5wfD9W0f7uppzcdg==
X-Received: by 2002:a05:600c:3550:b0:434:a781:f5d5 with SMTP id 5b1f17b1804b1-434d0a15047mr70591065e9.30.1733328770818;
        Wed, 04 Dec 2024 08:12:50 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e3b99249sm13430700f8f.88.2024.12.04.08.12.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 08:12:50 -0800 (PST)
Message-ID: <ae80262c-82c6-466f-bbcf-90ba3551dabc@tuxon.dev>
Date: Wed, 4 Dec 2024 18:12:49 +0200
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: sh-sci: Use plain struct copy in
 early_console_setup()
Content-Language: en-US
To: Geert Uytterhoeven <geert+renesas@glider.be>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-sh@vger.kernel.org
References: <e097e5c11afe5bd4c01135779c9a40e707ef6374.1733243287.git.geert+renesas@glider.be>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <e097e5c11afe5bd4c01135779c9a40e707ef6374.1733243287.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Geert,

On 03.12.2024 18:30, Geert Uytterhoeven wrote:
> Using memcpy() prevents the compiler from doing any checking on the
> types of the passed pointer parameters.  Copy the structure using struct
> assignment instead, to increase type-safety.
> 
> No change in generated code on all relevant architectures
> (arm/arm64/riscv/sh).
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

I've tested this on RZ/G3S on top of series at [1] and device tree + clock
patches from [2], with renesas_defconfig and with upstream config, in the
following scenarios:

1/ "earlycon keep_bootcon" in bootargs
2/ "earlycon" in bootargs
3/ none of the "earlycon keep_bootcon", "earlycon" in bootargs

All good!

Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Thank you,
Claudiu

[1]
https://lore.kernel.org/all/20241204155806.3781200-1-claudiu.beznea.uj@bp.renesas.com/
[2]
https://lore.kernel.org/all/20241115134401.3893008-1-claudiu.beznea.uj@bp.renesas.com/

> ---
>  drivers/tty/serial/sh-sci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
> index df523c7444230836..1ed13ce2c2952547 100644
> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -3542,7 +3542,7 @@ static int __init early_console_setup(struct earlycon_device *device,
>  		return -ENODEV;
>  
>  	device->port.type = type;
> -	memcpy(&sci_ports[0].port, &device->port, sizeof(struct uart_port));
> +	sci_ports[0].port = device->port;
>  	port_cfg.type = type;
>  	sci_ports[0].cfg = &port_cfg;
>  	sci_ports[0].params = sci_probe_regmap(&port_cfg);
