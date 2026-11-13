Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794562712;
	b=DNCEPaLFYR4MhCD6mWmsC0EWVBgpXGFfdCx7fTzDm2+NAcByu7HtsKPaZ0E/BI8GSMGz
	 tbbVnFSje3d7b8SoZ+UecfjVsB0inFi8zRXftOnsLjk1ywrmm9NEHJlTS+mqaNg7c/3Li
	 a9sYcJyS/3B5038wXpze6vi0j4ulhty3oapXPGMCYoSpeK3H1298J031aGzFW/FzBw3On
	 PaqU3y575jtn8/DVK688hKMThaKP6UX5JsIecTAP2bJvpxS/kVvpYYci1mpcpsSKY1nqK
	 BNGnr0cYX+CwG8Wvr0c1/Jm4FZO5cTtiHb5SbODAQHMqG7BDBv4qpeTIRWi/TMkK9DQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794562712;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=vwaSOUD1+F3Uh3wDhst/F9A1M+bA9w5kaeCRuz3dMQ0=;
	b=oAHqjXz4cenw47P1eseod3Gu0sfeXl98GWv++59TMmhtOOdIt7Dhf313GlJJtXMGtYVr
	 DXthdvgsSJdvX8VC34e17fu99bHbC+8/2OHFaWRSIY4yixxOOGiKCdbZw+oMc8hhICMQj
	 HAUeOrTzL4aJgv8g7gxyYGrPZMov0aadcF3op6aC6q1vEiJlOclLDXH+PoKFh6Osio/jl
	 bV8VExhcf6szkHmoqiXiCMOm8My5riyuhGDaqLiZmEIx2FsPpE1OCW1Gp1ak1B6oLkf1n
	 uEotMZUSDxfg5YLj7lwKokBu4a6/yIB3qk0kuzwRjZpvPFPSM7xkQS2ZCMDm5Bunjfg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=avpyrTvi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.170
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB80606A321
	for <linux-sh@vger.kernel.org>; Fri, 13 Nov 2026 09:38:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6BB80606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=avpyrTvi
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-8b305d38bafso5325717b3.3
        for <linux-sh@vger.kernel.org>; Fri, 13 Nov 2026 01:38:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794562710; cv=none;
        d=google.com; s=arc-20260327;
        b=G8lmvND2SlJ3sU3pXrWtuhQiNGo1AHGuc1EvtWrqHY3ocTlhGL4NcSXSjmfDB4FZgk
         gD244Y0GIZoP2R3BNfFxGgS5hPc4/Hu/6pMnq57MgfMlT4GIetny0EYObT14Rd9J3PDE
         vCIpVvFLDDieN9HuWVrb7EJ2VurUt6LdkocZf4bpJuWukYdwdj782FgXyQ0XgnIK7hG5
         vWJhe1Lqv1asAlTjxYXJPhsEnavENdlHHazqMteHdQmAM4NP5OjG9XL70YWnHgb5VLXE
         QSnSbg+fkMmln/MVIPnzt6J1epKYGo7iOo24UBJXJ6TDrH0KbCGWXbi1ri5xhjjsAG3B
         ZqIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vwaSOUD1+F3Uh3wDhst/F9A1M+bA9w5kaeCRuz3dMQ0=;
        fh=ORaeKODfma47/IBqwdn+0A8v3u4X1s+va/eK0wknJ9g=;
        b=b+YP/pMN6UfEbpHY9np0rykUxKcza2J6NAO956BrC2nfdM1LD5h+E8kheLaZMfFslD
         BW+addHEBTm28BTSW4ZuxluC25GFlt1EjlsSp6F8dEQHXxLEgpE132f9zSZ4IMi6uQpe
         jJXJaWGjRPoTSyTosKjzbIbKWQ6QZazr5rrLM3LIR+3BizW4dmnekJ9aWBY5hw2pJ/z7
         sw4tLGA75RsSQ4Liuqiy0afQ5n1eOuVMi50W9G6FYyoZ/jM2LwHZFvJyGoV6IhcYGy+S
         Fb9qjwbUPY9NJOQmndtShN9RQGmm8RA6tKjZgTV73KNer3pBonSWXCF6Ifb0wBjcCRv0
         VqEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794562710; x=1795167510; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vwaSOUD1+F3Uh3wDhst/F9A1M+bA9w5kaeCRuz3dMQ0=;
        b=avpyrTvi4oK5W3E4mvGN2d3McV1cvJMinrQQk9ZcQAlCjlH0BfUksq4dhRDqRitzIn
         wB1FCrOOPRqI3Rn7xXhQW11ZOgRa0Gjd3ExI03bogX9cwH4iCYOu+/BPwkahcbRAN/6d
         NTWuIeW0NbkghW7vkpnUfx6CYRzzIdDWsleLny2760Xsq3YhS+u2DOnmdoP/25yfBihU
         MoEk9e4jmII8V2TVVwx69pIsY3XcR4b+NoqzJYVmYPvRLQfAKzg5EDTrtsEhwoCi6gD7
         FBguBY9bMbd0GGBhb/nRJOYo2PHYSuKAe3F68zv8Q22pCiKCQSjZdXTq5q6sWNrn0mYM
         6wCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794562710; x=1795167510;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vwaSOUD1+F3Uh3wDhst/F9A1M+bA9w5kaeCRuz3dMQ0=;
        b=jBX3qtDoDxPs7DcA/kA5ErsHQNCbjzBF9bQGfmQ0YjqjiI8YIIg4b2MA/5cM+VQviZ
         1ibEknS6n3RtLMkIgY6LWJ6ghe10IPHeNUO+rzmADy5xXIwTmkfbnmcYm25k/qjn+5A6
         x+aW5RHE2bkksPplEvhIktDf5vndmXCoRv/Qy1p1bQEuNtKn2j89P9C9Uo5TyEte4Dhn
         wbv+Pke2N6GpqI2eRaHzvYzZ+pVPCeppk/zQ6UTPOzwoRlsQ5z7H6mEst4yPEVI32NQ6
         PrKk4P85KgnZVdABexSbwB8kDM3+FdS0E4u9dTGpPxNl1e7amwzmwBuH8FbRej9u0uAR
         omdw==
X-Forwarded-Encrypted: i=1; AL+hErE9DTVb9Hxv++ar3YswDSYf547OPbX+LHJ6/QNz3yvaZuqoH6GIEsXs2PFrnIvvoPGBZroUEfg+JQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z9UAMy/An5pxNE9kjuzPWrdNGYFOG451wUl5Kf6SQmarLXpRVIV
	aSXM8zvpKsi8rfPVxvE9N/jA6uz7z6h4140TQa0AkTQoQFMZFni5oqifbFXJJl7wj6UBL/1+/an
	UlBCS9re+06BIlpzV2OgluHs2ineWijM=
X-Gm-Gg: AYBFou1OXxqG8sR8pnq7xEwbsIeYoZNMvbUx7VbMR13mFL0yce02l9h2sL3BDLO4O28
	US+SDlRD6eZS1/NmANYcsS5SopoZbvgxZ+xDX7oZ83Ze89sb6JmtIzR6aaWdSETIpJhJGO8yWqc
	wVB11njNrRUc9VowQWLFTgz0LUvWJMCgNL2KZaNk3BQha3a6YaT6/gD4MEkufiTGOhm+9qUZ3DO
	L7I2S1mEhSDDeX0QbenKJ5oz30Q2+QtrzjgIUQ5L7sn5sa14zacsrPKsgMItJajV+ZnJtFUD8Rm
	1M/FtRCidf4WinOV1PVJzACcXhmOnwwFLeow0A+Ohg+2JifPvBdDV6aLyhvCYxSvMlQfpcOCKBl
	oEpUOG7aMrWKM37Pi+qDtMgBDABgb/vE34wGcjTl/4n8ZX5leWwU7iZ7DikxQsh9i2SN7Uo+WoU
	kzdgMn3zFYw09hSAgs+6Nh6P59Ue2Y128R4e+FmInAEUmhBj6fUusOccofhRydy4cQ29+ODODK+
	G05+ZNrZASbKw9ByjV3EAsBGf17NWQJZzAlgooEVgP5J+bV0mpfCX7qwDUDCw==
X-Received: by 2002:a05:690c:c4e5:b0:8ab:4989:bc9d with SMTP id
 00721157ae682-8b4aa3126d2mr14797977b3.65.1794562710293; Fri, 13 Nov 2026
 01:38:30 -0800 (PST)
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Post: <mailto:linux-sh@vger.kernel.org>
List-Help: <mailto:linux-sh+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sh+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112065037.1800467-1-dmitry.torokhov@gmail.com> <20261112065037.1800467-6-dmitry.torokhov@gmail.com>
In-Reply-To: <20261112065037.1800467-6-dmitry.torokhov@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 13 Nov 2026 11:37:53 +0200
X-Gm-Features: AclHuK_djmP9MqgezxklWmxc9D08cGWxuo_8XnZ2UDBve8INb7OAHhKwKVITLVk
Message-ID: <CAHp75VeWV39isCSpSxsuzw07iXf7rBfdYeSn=eJsBM-oWui01Q@mail.gmail.com>
Subject: Re: [PATCH 5/5] Input: tsc2007 - use IRQF_NO_AUTOEN when requesting interrupt
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, "H . Nikolaus Schaller" <hns@goldelico.com>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, Andreas Kemnade <andreas@kemnade.info>, 
	Johannes Kirchmair <johannes.kirchmair@skidata.com>, Yuki Horii <yuuki198708@gmail.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-input@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2026 at 8:50=E2=80=AFAM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> Request the threaded interrupt with IRQF_NO_AUTOEN so that the interrupt
> line remains disabled after probe until the input device is opened by
> user space. Explicitly initialize the stopped flag to true before
> requesting the interrupt and drop the immediate tsc2007_stop() call.

I believe this also closes a window of possible IRQ storms or floods.
Reviewed-by: Andy Shevchenko <andy@kernel.org>

--=20
With Best Regards,
Andy Shevchenko
