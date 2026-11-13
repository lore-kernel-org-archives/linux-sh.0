Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794562440;
	b=XQscZNRYTZJMC7cFx9eULe4vZ9XxqggB2Y83/hovEr7WxlYWwtpWesO0+lq93+4WXJR8
	 uW8Br4iBZEa9AlvvDwCRSwBheI0W501Gju11c/basuwzXHyYTrEen1a2dJ9EWE5jH0jsG
	 Y9m8a91gVq2zzyl3A5jhju/0WkF1lxoCmXctP8RyevGJxnVx/JBM+MRYojo0DH22LYQSA
	 iCZDp4kJrEqpglkJyAiX1IpW9BBwrXO+Kl+2V2mA/QsY9aS4dfwZxhOPUef8RvMT9nasV
	 imXfQOx/Tk1AQT3ict//jfsaC1PFQSA1sn7gbwmAAJN6/n8uVp/oecAaNzBZ1m2eJ9g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794562440;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=u1d+jX7pv4+dKm+uv9IHJgxQaYN/oZbwj0UPraCdJI8=;
	b=pdHuAazOoHLxgK0Es8Ohb03JwO0PDOcPDgyUThT/8YlqMSvx0zQey68vM2P+7wXcBK2f
	 uNYDInf34KylOrfDwT6K+HZ0CTdEgbSmkx4ur+r++f3YD2SfUH5O+yRhIsSyEWgNtTbPf
	 8EKqwXWrkCVZIHx2Mpk+ENrUed7tyWXz24Wixs3mePIUzjCcb9xy2R03/Tl7E3QeK3Sth
	 KUVzviwXG+wOjgACSphR5WJHe0UYVDDM19SGRxxrgfRqz2+0KLRHuu364DQIkZ5+qpgd0
	 2pSdi46uj3cN09HmwLUcygL4GJrOeWRPrlXo4rTCCSI4GA+L2YZO6yK9F6hjX0kR00w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EMsRLejE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5C1606A327
	for <linux-sh@vger.kernel.org>; Fri, 13 Nov 2026 09:33:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD5C1606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EMsRLejE
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1b3beeaf6f9so724223c88.0
        for <linux-sh@vger.kernel.org>; Fri, 13 Nov 2026 01:33:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794562439; cv=none;
        d=google.com; s=arc-20260327;
        b=ZHikVzPnXsrTL4sfoL0+4Io+Hq/CZVHXMEvZDX8j1SxvAr7iPnTCYkce+truRCV3VG
         Kj7ptx9znSLAKSngqqeHzvid4fdDLnfvvjpJ9REL9b1r3ElgFeML2fhye5B88UkHqCzl
         NKJVzTbYomHpGI81ai94IZ978OtaFZnJvrRQAuztAc1GEBrb9GEWHMdctZGHAJHBp3rR
         5KvCOZnJL7oURlm2/QDy0htPIayzhPkVGHB7Vnwa3FOYPs/4H9XJkcyULFpbfFdnF+U8
         cOmwhPT51UKRN+ViYzmeGi/lbIMLR6cNm+xRKPyAXuZ0XLYG2TORMeOz5p4Kojxcbxmj
         UaOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=u1d+jX7pv4+dKm+uv9IHJgxQaYN/oZbwj0UPraCdJI8=;
        fh=7zM0jcDlzbrMZU87c3Fo0+5ejgU2Vegw7Cq6R0E0DeM=;
        b=N5KAz3edBbHnWh4CYcYokhKTJ2R3NwSv0W8OuKdcYZ39k+f/wuzf90h74FKdKCH7S+
         i19Dl1D0mEZ2sNXxNsiDk2X71rQi8ZN4+WuVq/dyPvE/lVvW4Q7X3V1YXaYxpHTQ3ZYx
         kiBs2kRNQ0LV/BhqxpQy4R/MWyIXorFc+CNjm4e68l/VrNVinFuEG/CgTYIz3J0YzM3S
         K5HKnu2Ng88b/c3q21RZtuCsgDoaJt95WAFIEL1dYLJhFfsWfiizB/QFFu198Dh3xrR4
         cX5rVuR+T6bHgj6+erhSuo9/J+785ioBjYAk2X8bgZUqN9mL2/2f4St3F0UojYcLoHd7
         glSA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794562439; x=1795167239; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=u1d+jX7pv4+dKm+uv9IHJgxQaYN/oZbwj0UPraCdJI8=;
        b=EMsRLejECSKve5zKyT/fELnBt1G4eF4EJJaz9wjZ9eLa4XZLaFKjeSAFAVLOiDDy3l
         qEk7iL3pEx4uUb34yWk7dB4gA8hZe0l5s17QOpD3UuaW3NZsTtuieQmmSxMe2HYRww/n
         bsmek53GV53JKg/pZQNNe72dK7/wO1xZX4slOORcTELuVpmyIYeIHw5XO++wfw5m51oD
         OdmQ9ERKMF5QLpAB0u5YmMbJfYz0MGc0JHOgnEnWBHjzoloSpM8W1At3OSlx6EqvweMq
         n3JCH9+TRb5s89yUI2gGtpVabLKgMjc5GjxbX0KaDFhunntNALuGrxwJn0RUptNsYeOq
         Wb9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794562439; x=1795167239;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u1d+jX7pv4+dKm+uv9IHJgxQaYN/oZbwj0UPraCdJI8=;
        b=XBL/4oFH5kmSL5bulcoWOZ4N220ROlgPbYb/fgQZPTsON4+PAnjsrxUx0LoZmp3333
         wE0E5/B4VwOYbT43Mg1KijNce8Hdsx6Bd7bsMyCo9+pboZ6KWAQqsKIBdwOt2PMvRAJ0
         VzVcii8PKH7za+a29aDnjmJHVlN1ougZgMjxEjtXpsKUlUCuoZkYBft+R7WFUq3B1PL/
         9z9Bei5VdP/8xF2SmlTIA2KG+OPx2x2ak9cgAIx9Ie50Dzuh++FKmQ3atupq/rO65ITd
         2IFPi9xJ5pJzMqjY+XqFhwnkwlwZFce4jrcsZNwaY8vB0E6pHgnN874u/90eWBz2ZKs1
         +Fxw==
X-Forwarded-Encrypted: i=1; AL+hErFtvKH9OpgjrD8x1LBbyiwtmRtqiDPwQAIwhXQdvXeA0zjxafBraElyuWX1a4IHY2gSSp2DdqN6PQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z/qBeqNk4d+atWbjmPgC1DUBJvfCVTiSNyjZJxEn2VmBf9HRHJY
	/OaES4zlUuCVfleZYY2DYbfIdK2kWsLUDMWiyH2AwvAuW4+8sPT/uW0gbehuROXGYcBHgc2WY1f
	Xj6Afq/5CTwZnj55RlNZKsuOLwzF3X2o=
X-Gm-Gg: AYBFou3ZRYlr8r8ngEAtQtRg+MzH0CbijjPv7wauMsz65hxnS0Ks23hH1hZ9itO+1es
	XAutZk72tAPjmJbEv8yC8QrhNrsdIQq+XngacJWvVmxaKKJjPgubuLgrp4GiqbAVsNPceH26XRZ
	EE7S7FNp8MLcsLWKkEwIMTGCUHMI1B4CfgknFBEnopiVVcowf0ns79aJgEpiaSPIhp8BmHzfjSH
	nnFhT06iq8s0lLcnkw6GUdGDQSCR3hE5xi3fcEpFX4nHQrvrs4MJTu6Hz1yguJsikLrU7f2W4Xh
	xszCgF2UQ/u+laTZgge/1iHzw9J34DmNtdtHEPyFgXgH30VRDpGrXpaAgNx09NMZnsGw/AT7UiW
	mNRveJiUnw0VzePqyhAQRbJCES+CpS+ymVBMXnuu6KrLqZTTEnphahgr3DZnIUqyKO/fGf2cGJ3
	t25vM8jsTkPGY3/BS3yWHDI6eZLPXh5A==
X-Received: by 2002:a05:693c:811b:b0:358:dfed:d0fe with SMTP id
 5a478bee46e88-37964b0992emr1888359eec.5.1794562438756; Fri, 13 Nov 2026
 01:33:58 -0800 (PST)
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Post: <mailto:linux-sh@vger.kernel.org>
List-Help: <mailto:linux-sh+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sh+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112065037.1800467-1-dmitry.torokhov@gmail.com>
In-Reply-To: <20261112065037.1800467-1-dmitry.torokhov@gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Fri, 13 Nov 2026 11:33:46 +0200
X-Gm-Features: AclHuK-f5iEwYMAt0ScbOlLfsX82RSmp1G8_ulBxjHo5JqdIzy0PJiY4cj272gw
Message-ID: <CAPVz0n25-LyOFFu-h7Sc0iUcjLMk0njOuAAHr-NepQbnZU6gxg@mail.gmail.com>
Subject: Re: [PATCH 0/5] Input: tsc2007 - drop platform data support and cleanups
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "H . Nikolaus Schaller" <hns@goldelico.com>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, 
	Andreas Kemnade <andreas@kemnade.info>, Johannes Kirchmair <johannes.kirchmair@skidata.com>, 
	Yuki Horii <yuuki198708@gmail.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-input@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=87=D1=82, 12 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 08:5=
0 Dmitry Torokhov <dmitry.torokhov@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Now that all in-tree boards using tsc2007 (including SuperH ecovec24)
> have been converted to generic device properties, this series drops
> legacy platform data support and its header file, removes redundant
> memory barriers, fixes minor coding style issues, skips registering a
> non-functional input device when no interrupt is wired (when the chip is
> used purely as an IIO ADC), and uses IRQF_NO_AUTOEN when requesting the
> threaded interrupt.
>
> Thanks.
>
> Dmitry Torokhov (5):
>   Input: tsc2007 - drop platform data support
>   Input: tsc2007 - remove unneeded memory barriers
>   Input: tsc2007 - fix minor coding style issues
>   Input: tsc2007 - do not register input device without IRQ
>   Input: tsc2007 - use IRQF_NO_AUTOEN when requesting interrupt
>
>  arch/sh/boards/mach-ecovec24/setup.c     |   1 -
>  drivers/input/touchscreen/tsc2007.h      |   5 +-
>  drivers/input/touchscreen/tsc2007_core.c | 183 ++++++++---------------
>  include/linux/platform_data/tsc2007.h    |  23 ---
>  4 files changed, 60 insertions(+), 152 deletions(-)
>  delete mode 100644 include/linux/platform_data/tsc2007.h
>
> --
> 2.56.0.567.gdb80ae8cd5-goog
>

Hello Dmitry!

I have tested this series on top of the latest next/master on the LG
Optimus Vu P895. My device uses this chip as an ADC for battery
temperature measurements.

Your patches works as expected. Input device was no longer registered,
ADC part was present and worked as intended. Thank you!

All series

Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # LG P895
