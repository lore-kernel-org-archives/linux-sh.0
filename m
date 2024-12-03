Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6104F1F8AC9
	for <linux-sh@vger.kernel.org>; Tue,  3 Dec 2024 16:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733244582; cv=none; b=F9lucOmRekleLAE+QwIaW+otWvSeVTxqnGCk35vlvEqNIoNcmTLCi8g4poI+vYp9pOTvzy1wvRBo6dfQEpUIao+OIlrw24KAwLH5R0ePrMK+dwbw+OYIw487tAc8EBqfvjOoJ8oGyvVNj4OXXV5bmHgN2d2xSZ3Fgi2ErgC38fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733244582; c=relaxed/simple;
	bh=rP8WCl9KXwWdYzRKyzkCki01UNdVN/Fpb3/lyUZgLZI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=GOog5e82++9B3t4uHy9kYC5Vu5aw+m46OHVvO2K2MduGz3c62Eu4XbwY60KmZesZsWWyD5Dkow5D4RFDZOMf/gj0fjCcMvbzFiDz/TRwksUqfSwdFF8kZwcG5e4u/O2Vl8UIzCR6uQPniq8I7fi+Zro2t0L0djoXc3XoN5NVxEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Ach9vGgf; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Ach9vGgf"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-434a90fed23so48706485e9.1
        for <linux-sh@vger.kernel.org>; Tue, 03 Dec 2024 08:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1733244578; x=1733849378; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q4VmWrSSj/7zXUbh+NYZqbK4S1QOexkNE0xeEkErR8w=;
        b=Ach9vGgf/u6uxfR6dU2XDHlUC8GI+QM96hayjxlKOTD7SJvuzQgGp6zfP0Cf1gO1Dt
         gny5FfOITvm9sd1j1RN60Vn/mmvQcgboLXJXp/C8hGYrn63mT1eDsdwVLAVLpsCF9i2Q
         56hcK00o6/AX4JdwnrzZ3p9Pzw5lIl18ByuOyyA+h+yO7Cbm3OX325V3ZN1euVa429xu
         vZmCrx7oClF9yZ/Hd1878GBCOFvRZ/8Wuz4Di+/iwObHAXwj11mZ8sUvRofr86kdO+kV
         uKIhVMCCsY+OF4/TeETKT1ZY0OZx7KfqadALAPwkagEtSUPBnSZs5nOPK4f+1RoBZadB
         uQxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733244578; x=1733849378;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q4VmWrSSj/7zXUbh+NYZqbK4S1QOexkNE0xeEkErR8w=;
        b=IuTv8sxCrFzlY3sl1kKPIm9h3ecog6wkcmyZ38i9y6Yyv6bEdCdjlqjwUSi68qcWRK
         iL2VUx8rjDMPFptGi6eBRj85fvrWGyRC/0uOb9WdKBhorszs6eOISUF5TAP+9I/kQ7dW
         TtYSHwBH1CQAJL23p03lmSxJwxp+lBzY0WiTQcjMlOFkTtB+N9FturiKIh6ZvXyBFdus
         PX5kGndVi+y2BpES5wSL0j0927rPL2dX6Yt+WHhE+yNg8/i9l0DvUqyd5I7g+ssc5Por
         ix3se+hqWmmiY1FAD4qd8rr7sh0hJ1ws8VLei7eNN1lXoDOTn3NNwn2lKvnI+3vpUdBq
         5bZA==
X-Forwarded-Encrypted: i=1; AJvYcCU1MIB3NCuSFln8sfQoSCFhnfN+LNaPm/od41hpVdsR9coT1NyBTBqfdQp2bjuPb59cdbexlf4lZA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwVTPVGrJKLJVaQYoKxGdJzHDHQn5M+sSuBEj/9FCTJLRzBTcm2
	Hfjx+GGHTUwPeeMy8E4o/cUqHm5uQqtDh8f/qzkrOWyA/Xn3i11vjJrJhFO3EGk=
X-Gm-Gg: ASbGncs+sqMO+juOGfxULzePV+FaYkCY96JodvCZrcAUDmuOSpDTU/EDkx9zhdCMzxU
	2oEa/gaQIamaVBjBNeivZ49kaHVWBm3GCOhoZxBIkYy+c3TgF71reR9DTC2QqQ4DcNi6lqc+PTF
	yPXXH+iAZjnvDcqaZPh5okqOQU5uaVs1AUE7j7Zm+2VNP6icIa+92r4Zl8c/yUMZuYw9w9btnjJ
	LY7BHigOT9/VZOoAozFPjGyoCk11rXXSJZs8rBqTXlsdWY0kCY707pzyv4=
X-Google-Smtp-Source: AGHT+IF8xk5YUKpQ2WS30TSsE/BDo+SYDlLam0pZbOL1ZMMuaAzGwoSuG1kxkRYwJbZKPJNXTkGqJg==
X-Received: by 2002:a05:600c:3108:b0:434:a27c:b864 with SMTP id 5b1f17b1804b1-434d0a1cf53mr25519705e9.33.1733244578277;
        Tue, 03 Dec 2024 08:49:38 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0f70d91sm192897255e9.39.2024.12.03.08.49.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 08:49:37 -0800 (PST)
Message-ID: <1eebe854-9e33-43d8-b3be-abaa5b71cd18@tuxon.dev>
Date: Tue, 3 Dec 2024 18:49:36 +0200
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
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-sh@vger.kernel.org
References: <e097e5c11afe5bd4c01135779c9a40e707ef6374.1733243287.git.geert+renesas@glider.be>
 <b71bb27e-003f-4b5d-8654-c7639b105e29@tuxon.dev>
In-Reply-To: <b71bb27e-003f-4b5d-8654-c7639b105e29@tuxon.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 03.12.2024 18:45, Claudiu Beznea wrote:
> Hi, Geert,
> 
> On 03.12.2024 18:30, Geert Uytterhoeven wrote:
>> Using memcpy() prevents the compiler from doing any checking on the
>> types of the passed pointer parameters.  Copy the structure using struct
>> assignment instead, to increase type-safety.
>>
>> No change in generated code on all relevant architectures
>> (arm/arm64/riscv/sh).
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> Not sure, do you think it should carry a fixes tag?
> 
>> ---
>>  drivers/tty/serial/sh-sci.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
>> index df523c7444230836..1ed13ce2c2952547 100644
>> --- a/drivers/tty/serial/sh-sci.c
>> +++ b/drivers/tty/serial/sh-sci.c
>> @@ -3542,7 +3542,7 @@ static int __init early_console_setup(struct earlycon_device *device,
>>  		return -ENODEV;
>>  
>>  	device->port.type = type;
>> -	memcpy(&sci_ports[0].port, &device->port, sizeof(struct uart_port));
>> +	sci_ports[0].port = device->port;
> 
> I'm currently preparing my fixes around this code. I think I should rebase

s/I think/I'm not sure if/g

> on top of your patch :)
> 
> 
> Thank you,
> Claudiu
> 
>>  	port_cfg.type = type;
>>  	sci_ports[0].cfg = &port_cfg;
>>  	sci_ports[0].params = sci_probe_regmap(&port_cfg);
