Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05F21F37C3;
	Wed, 19 Feb 2025 14:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739976677; cv=none; b=AxvY7xkSjeJz/rEeKC7IpV8oFtwMMkF+6xVVKrKKsnke6uk2iwtubQYbhZR0FD2L9RU20/Xgp92bjRsf3sHrVEBZaXIMQlytYqPcsJoAfI4KjbZixm28YIkc9zMznqzD1Awhwasm9YXdwGPIi28wJQQwsnN2qdfP7Z31FJvsuuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739976677; c=relaxed/simple;
	bh=lP8N9yEpsbHjBuK3eJt8q3tOhlyB4tb2oIIo9LrnAjo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S7LXs0v/V82PeQYhmni45myDzgjUl7oUHHT8vxINb0xeiypexOXRnHW0JqZ8tEh5C96jRU2QgKdcot0HPdBUgSyDf64iAcKMqedZePHZTMkCGImGo2/67f5ftyVDIXOiLuJQzmh2mtQhsU5X/ojtDbGC7SLD91iLsSWRb5dNJeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-868f18a629bso1866152241.2;
        Wed, 19 Feb 2025 06:51:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739976672; x=1740581472;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GPhrqbRJ73NARBvjDwf54MNzWhpg438Mp/HW166U8tk=;
        b=hq+vCNRtEbtvHvp/DO8d2tX1/6IurGr1V6naV6IVI4l6bePXdEdrop7FoZg+XgTHkL
         Ii2af1cowbCw89b1AoRzxD+lBXzo7o8cwNTOhcgG3wZ7aCJGpZ2CKehsDw8LU0K2+XWB
         3PlpsFzVU7rJ8jpNM2EP6axHs+cw5H1xxAsFRA0VLXMfUqi+1vkWivrtBiA1aByEJYY/
         tfLHRbt4r2pEquSSNr/yzR7TemCMj7LvZNZt+xR16ACUxt/S44JCL6wVfO6pGGk9txgr
         5dqMy36kJmMJ07wY6yQAidS/Hz4CePgCRIoZjTl6VMXameusZfC6EhyTwo/6kAAxhhVz
         HJGA==
X-Forwarded-Encrypted: i=1; AJvYcCUUg4Lp7ybFxzKgWbMZ20QldZErVybz2B+OwuumCUQ5xh5rIcQdD4yxOcWh1QkYUgCtcP2rozq+JqNdhm4=@vger.kernel.org, AJvYcCUyFtCuiL6lvH1A0upgW703AyRGuesNG8WHdJpyThdEivMagwU6HunzBmvV7iAOJ7h0JAAl0bz74fU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUB+uttAR/juwUF7Mtzuw43EsjIh0yI41oW24LdfopbQcpaIFH
	OFOttabvAn6zAWKRWe/o8hVWWrLFf/vyAG0r2Jt5OwtVyu2wQPCcKz6pyZDM
X-Gm-Gg: ASbGncswCgYDu5m+JAev5r/bPiEeK9qFZMk9cvXbsD8pZPVoH9yi8kuyau4y1WARBaX
	7d11nKGlbGAYhpdQLlPabC7S+FecQWWCKz4q8bhzxEfEyOg1weHVSGmIF0aaYlncKOgZM90Ryis
	XC3cgce6eyoZLF7JTry/AGG7kcNv8s4KcW3LQLhZJhFtoxhSeLAsWse7q2yIEQnll4mwnU409Zl
	Pv2qg9PWJ/BsuAk/PGBXlER1rW81oMw47xwkmnWQfLnZRVnNmAKG6c4jhQ9ju3qHWhp6REUDn3S
	Qka96WjL21b/EN3Gx3NE7mPJqTiy9c+Wip6iIfsQpk21PLzVuWgGqQ==
X-Google-Smtp-Source: AGHT+IG7LFKPsnTnGnLso8Hvg+IDV4VUzV409wP/92wPgRohNM036Lhp5bjF9e50380OybPTXQVRWA==
X-Received: by 2002:a05:6102:f12:b0:4bb:e14a:944b with SMTP id ada2fe7eead31-4bd3fdfaec5mr9536850137.20.1739976671784;
        Wed, 19 Feb 2025 06:51:11 -0800 (PST)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-868e86cae00sm2891713241.28.2025.02.19.06.51.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 06:51:11 -0800 (PST)
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-86715793b1fso1935120241.0;
        Wed, 19 Feb 2025 06:51:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVKcHcHvS+P/DAWCIMyO7ZrYuMBm3np7FquO/2cBiA+EE1ft9lufUtdAWl+IMZbtBV2YntLsBYDZRw=@vger.kernel.org, AJvYcCW63X6Le1zTOyq1BJF+sorjip+p82MAZn+aB97EM3sQ5AMhvD+7VVhV4ubxoF29JiWJ4Yy1DCWqXuPjo/g=@vger.kernel.org
X-Received: by 2002:a05:6102:38cd:b0:4ba:971a:41fd with SMTP id
 ada2fe7eead31-4bd3fdfaefemr9692473137.19.1739976670805; Wed, 19 Feb 2025
 06:51:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250216175545.35079-1-contact@artur-rojek.eu>
 <20250216175545.35079-3-contact@artur-rojek.eu> <d7484ab2-6da0-4bb9-a2ae-9388dac15038@linaro.org>
In-Reply-To: <d7484ab2-6da0-4bb9-a2ae-9388dac15038@linaro.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 19 Feb 2025 15:50:57 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWX9xeLRDLnteGWR31KbhtdupxVbhjQqY-6VaFA4tVaBQ@mail.gmail.com>
X-Gm-Features: AWEUYZkk1dx0nQEnXnzDen0sgvrNcfD5LxxYbE-RnOcyEj-Il1JHypy2gXP5qIw
Message-ID: <CAMuHMdWX9xeLRDLnteGWR31KbhtdupxVbhjQqY-6VaFA4tVaBQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] irqchip: clocksource: fix jcore-pit irq request
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Artur Rojek <contact@artur-rojek.eu>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	Thomas Gleixner <tglx@linutronix.de>, Uros Bizjak <ubizjak@gmail.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, "D . Jeff Dionne" <jeff@coresemi.io>, 
	Rob Landley <rob@landley.net>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Daniel,

On Wed, 19 Feb 2025 at 15:43, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> On 16/02/2025 18:55, Artur Rojek wrote:
> > The jcore-aic irqchip does not have separate interrupt numbers reserved
> > for cpu-local vs global interrupts. Instead, the task of selecting this
> > property is being delegated to the device drivers requesting the given
> > irq.
> >
> > This quirk has not been taken into account while migrating jcore-pit to
> > request_percpu_irq(), resulting in a failure to register PIT interrupts.
> >
> > Fix this behavior by making the following changes:
> > 1) Explicitly register irq_set_percpu_devid() in jcore-pit.
> > 2) Provide enable_percpu_irq()/disable_percpu_irq() calls in jcore-pit.
> > 3) Make jcore-aic pass the correct per-cpu cookie to the irq handler by
> >     using handle_percpu_devid_irq() instead of handle_percpu_irq().
> >
> > Fixes: 69a9dcbd2d65 ("clocksource/drivers/jcore: Use request_percpu_irq()")
> >
> > Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
> > ---
>
> How this patch should be merged ?
>
> It is touching irqchip and clocksource at the same time.
>
> May I pick it in the clocksource tree ?

Thomas already took it, cfr. commit d7e3fd658248f257
("irqchip/jcore-aic, clocksource/drivers/jcore: Fix jcore-pit interrupt
request") in next-20250219.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
