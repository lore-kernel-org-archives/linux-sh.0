Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794564528;
	b=vemGQ5rUJ8C5NFgO5QomgvirQM8OXR13RsW13lAp7ZROhYDREFKOhjNVIXal+59pHZSn
	 lxd4Jc18XIvfh2FqRsRE+tfnh5gUBHYQN3OrUQ7kJMeU6HlVhOwjdnYQIBoCvDVxBRdta
	 HbzFg18BLtqWhLSo5htX7KChkavvOx4yXzHuOK2y25i0pdRPQ3N5Kh9VmAzASSbV5BCwU
	 eUi0Tpu3HJL9C9AUv+YtVRWCyd90mPQc84wnNGXv467NkbBvlKUIPzpIh6Z3whklvxeAj
	 FYHlJu/G38n71zII0vv8qfTeZa3P0h/pQMsnKcfAiCqssVCoVETJRXdCOlgrGa+FxzA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794564528;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=rKWOW9+LLEImVEGgv+UL91WRNiS03i6s+m/NnnyTegE=;
	b=oVd84vP3gUMgSPl2qIQHHHoKpvY64J2HdykmTTQvjsrBhOkMMzp4yX6e5ZauUW1weZ+r
	 ef1PLdVn+0TiV5ayPkwgY1UezqKgGBQQchgke2ETcIq6wWOHCozNzi4TXwivEjkc5yaY5
	 vWNuEzNFUooe+DHxvfFtYHTJa/ZY9FMnMZCILobdGu+YINuLZE09wbRmdKfoy2D6dGL5E
	 Yw9R25HzgkNy3G6hM37pQVcvSSd3Kb9t5uVE8Fcqmay20MT1Hp6G1PUTl0OtGH1JY7zvQ
	 SD3FFzExiAwvCeV3dzf3Pj32DOnrHdn18jGqy9RgQ9SbM92UKfQuzUbZ6WIi+Y77Asw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JOHjHrKw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.177
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003D1606A886
	for <linux-sh@vger.kernel.org>; Fri, 13 Nov 2026 10:08:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 003D1606A886
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JOHjHrKw
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-8b31448caccso6569557b3.1
        for <linux-sh@vger.kernel.org>; Fri, 13 Nov 2026 02:08:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794564527; cv=none;
        d=google.com; s=arc-20260327;
        b=ARuH2q9Yrjm4cW381E3WClnf6Xzs/OOnk8feLlkzijt0kSdSU7+TkEi1+GHh6Y5smu
         S9guszrIFH3LRV7tweb1rNG8crtiKM39sFHX+ud2YCJUe1mdIobFRE21c6VY0aDAr6rh
         kNFtrHFZu4CWkib+fZm6B3F+itF6g7ZF7xJgMy58jdOVXCA165LsZgC8RcFltjdS1b5j
         c99BgL5A2SyvcDxGKOlQCRPewx+aW9GbVJFvsdeXaKTpVmZIbQ+OauA15NyCl9w2ChWy
         g7/kWl9jVo0PwvsPu+2ySJLLYRpFeOKG/Yx+JsDI/gKx8EqM0dkoqMX5vW9x7LjLWCl5
         LdfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rKWOW9+LLEImVEGgv+UL91WRNiS03i6s+m/NnnyTegE=;
        fh=0/sSSVI7dNHVqwlxdpsVjHq6HegnC1EoRpHXsTvXauU=;
        b=RL8pmZ2kp3R3275lCEgC10HdKg5n70UApBuccRI2K4BKP8eGu8T98mOBg5INFbBjxA
         IwZWOWQiY2WX3ODHfOWZjsFl8Oco2dTxXVKW1D6lFgUw29na4d67zkMNlzRJw9gAGK4A
         UxrjWeJH1bVT6KLheTcpAeIOGG2qmqtdTg+166a1rzIC4uuGeIkbaq73FvpHCp72TG9M
         ds9R4PWT9HrVzOBh705TphOEd5ozFz66zGSrmYxqNPO/xCvj3W2p0q3edFbuUDU2Yu5m
         q7HQQoemJZwAin50I6zTn5qGj+QqmMqNJfSjrCWNz52l65jvnChlFZ/yZGwohJZYpMOT
         TQHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794564527; x=1795169327; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rKWOW9+LLEImVEGgv+UL91WRNiS03i6s+m/NnnyTegE=;
        b=JOHjHrKwW0jJI5tHFSRlGlzX8vgF5h90RovdHP10mbXC0f3qrowCJW//O8BBklbmGZ
         ytneDq6zTIO6t8z+Dd/cTaDui27l4VySHAZ0TtoxlOq1lY3/hl9tqfQWADCUvyzj8Y9O
         jtyrS7CgL9VoJxXQFlMRXX2TA3qm5CV40l8rLoBq5NcrhVN5F9HYfoaTwS+RP8eylsDh
         lynaOrt1ud2snOnot19Br7JRxY7AZY+6RsOqxTokjJhvaLT0MfQsl/quo7ylCeHy86cy
         39xtGdWxCEmiBq0Gdf/CfuKXncUOs1wF7goPDv+aIZ9cdto1sjoklpl2E2a3d9Tur28Y
         QTRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564527; x=1795169327;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rKWOW9+LLEImVEGgv+UL91WRNiS03i6s+m/NnnyTegE=;
        b=p3c+PNxfMgeijCa5uQhhR+blaQKL6nMClVN1wCbNVNH+njZ+E4rXEwecpgVme1ebwB
         lbjiifRnjLp1AxHaxb3X+TbwB6tHGxGHK10ASFfg6YllVs4OIA9s48aTlFtECWD13CKE
         ZlshYFl+eet8mYaoK0AvYGmQpjzw/PTaP67gnnto0Oux6lQwEyVh287+hRpKL3FDPtZo
         607VHks66kg1azSJRkTWOoMwmFlzlQNKFvfJHAQI+O3RNocm+eJL9QpB4+i+4WPCEIz4
         MX6fG+B3U481P9Y2XFAsRo4l341eBv2StGn7k0Q4JhrpvcvuQCvU8yRgY26amUjydTa6
         2HFA==
X-Forwarded-Encrypted: i=1; AL+hErHgPDrXIHvJNih1W4erUtf4CjZaZO79ZLHLw8MMzblcS7nWR6PwSE8CCatDREo6kgo8guRjDinUHg==@vger.kernel.org
X-Gm-Message-State: APuU4Z9PtpcDqIcdIkJHnq/Kxy+w1Tt9BapBtYWGOdtSNTcvbJPSo82O
	SM9OTKr00Ka6Mcam+TnJVuK9g1zhf1WHE4NozS5Ls5Rxwc7dwnCB37QmjKhp6u8SNnRB5ztcfng
	qQHHf/8wD/49eJdBtlBkYsi/0PvkSY3E=
X-Gm-Gg: AYBFou0T+tk2shERBytEirl2YHQ70TssxQUZzWSgTpDho0XaV1m51Yz0QkFSL8tL4B+
	ei1mIfEm8JODcMPRdbvn7tAC6WkuNpbYEmqHRNLsA7YW+GGABfeL6xeV1HUxqqYzqBXbDlHA9/S
	o6rK4+z03tw2IB6qv8vKbPbi8EBLkmwXyhYzsIju3T+sD5rE0JZCOY9NXq77Tun8jAgN6Pgg0Eq
	FslFVaukGwsmXPmM4gLVzMRGTESwEZU0a82LS0fKxPGRhNSYWJI1bPKAPdY+/AYx6CDHtO9/Oil
	EYJ+a9Nu72t14zUmFIZXo/mDDzMv0fOXNE0zoyvPdWiXecfzxHfSeC081AM/VeZ/epN8YH6JYXv
	RS0f/rDGk773fCKks6schul9LOvLT8np+swaO3F+QBo5N8YMYeVpn/RDQbvxBYNy+pjeBI+EwcF
	mHXTLMg5co5P9AYebU7GH2S0wOeZjGJJGeU6iZ8RRN9JMpd46eyZ1GFEPwGJvVoXwM0LXmOoY/L
	GiJLtOyE6yeuGzWbUcbb8gu2utB0MKAoqDWmNZRgdcen2wQHiwT6PwwG7Cxpw==
X-Received: by 2002:a05:690c:e1d3:20b0:8b3:4f53:91c4 with SMTP id
 00721157ae682-8b4aa326b49mr10197467b3.29.1794564526979; Fri, 13 Nov 2026
 02:08:46 -0800 (PST)
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Post: <mailto:linux-sh@vger.kernel.org>
List-Help: <mailto:linux-sh+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sh+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112065037.1800467-1-dmitry.torokhov@gmail.com> <20261112065037.1800467-5-dmitry.torokhov@gmail.com>
In-Reply-To: <20261112065037.1800467-5-dmitry.torokhov@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 13 Nov 2026 12:08:09 +0200
X-Gm-Features: AclHuK8Y20CK-uRfjZMkziALZSmbzxcenVC4HU4NYiah5SSa7aVtNNizdoU07Uc
Message-ID: <CAHp75Vcta1YuUfLkxh96NoeOVGjn=paTHXw8ive=+kS9pvBoDw@mail.gmail.com>
Subject: Re: [PATCH 4/5] Input: tsc2007 - do not register input device without IRQ
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

On Thu, Nov 12, 2026 at 8:56=E2=80=AFAM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> The driver has no polled input mode and only reports touchscreen input
> events from its threaded interrupt handler. When no interrupt is wired,
> the device is used solely as an IIO ADC, so registering an input device
> serves no purpose and creates a non-functional input node.
>
> Only allocate, configure, and register the input device when an
> interrupt is present. This also allows removing the unnecessary
> ts->irq checks in the open and stop callbacks.

...

>         ts->stopped =3D false;
> -
> -       if (ts->irq)
> -               enable_irq(ts->irq);
> +       enable_irq(ts->irq);


Looking at this makes me think that if "stopped" is tightened to IRQ
enablement, the IRQ framework already has an API which may be used
instead of having a local flag. This can be achieved with
irqd_irq_disabled(irq_get_irq_data(ts->irq)), but this is most likely
for the other day.

...

> -       snprintf(ts->phys, sizeof(ts->phys),
> -                "%s/input0", dev_name(&client->dev));
> +       snprintf(ts->phys, sizeof(ts->phys), "%s/input0", dev_name(dev));

Perhaps scnprintf() to avoid compiler warnings?

...

> +       err =3D devm_request_threaded_irq(dev, ts->irq,
> +                                       NULL, tsc2007_soft_irq,
> +                                       IRQF_ONESHOT,
> +                                       dev->driver->name, ts);
> +       if (err) {

> +               dev_err(dev, "Failed to request irq %d: %d\n", ts->irq, e=
rr);

This has to be dropped in a separate patch as dup. The above API
prints the very similar message on error.

> +               return err;
> +       }

--=20
With Best Regards,
Andy Shevchenko
