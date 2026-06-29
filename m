Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBE64418CB
	for <linux-sh@vger.kernel.org>; Mon, 29 Jun 2026 16:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782749079; cv=none; b=fcAdBiBdXg4O0QrNIYVh6KNlZIaxsBxX6gq7QKRYx2rV243pJxQuL5dGKhZ69rC8IB/GmNgzzr0+3pmvBz2poNDqW6bJpqwd+LBfWoNvEYWGidKsrz/taBSf5wY7UnuwkvC6BjtwXiZdKKxszXPm2/wJWw7jvV1SKyzG9+1pqq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782749079; c=relaxed/simple;
	bh=LHZ+CtSrs1sFgqxg1SDgUv6SV2Q72AbvoN/75du65As=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l+fVOah0BuVVTJaV97ysmxqJ3UqIc/pR72M0cFCl5Zlfecu7TyBzmj8FXGnJOwQ0P6w1YxtV0qmg+QalZ1gw9PlAwcEBru9S3QnSOxWQJXrwOnRxs2zX5LUbeeR9o5O1HbZLjuo/jtwXp9PUWymLgW52HTfCymqBUxsbqS0LArQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-96710629eb1so2445033241.2
        for <linux-sh@vger.kernel.org>; Mon, 29 Jun 2026 09:04:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782749075; x=1783353875;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sEWuyLm9nvyhq9LS7vVK2FWNUi6758jMrQo6mncWdtU=;
        b=IfJlIThcavSm8jeCG5afM+/mO4pmpHDca24MQu7h4JTE0K9fPPDYbuY5DZrhj5Tkea
         /tNt7mA/uzaETazW7HmNyQApp9jiOAsVLlMyUOabjXkN7FSc/351rC2ZN9KRsJAf1bbG
         8IenFQUTiOtOu24SUkkeSiSDspsnPLfRil48n2vkDX0ZdW3638dY9vv7rpczL6uD//qN
         YmallaNDqVjjehsFJBHeppGgloCxu9Q4vHqK8Y9/oRzUyw3eUcDtQ7eCNV/qdfaT2XvV
         2JBIpX3gBUyPysakXFawzB5fSQ2o7hfrTu5412GlIFpkd+ig3aTd3/XAEL1fonWkhGgt
         7W6Q==
X-Forwarded-Encrypted: i=1; AHgh+RpDJoXiMLzG/uSkeRCqx/rdaJOQd/7cjjAUS4zJNJr/G7IDOupG7MB+b1PeAPEMl+TNfIHe9hwogQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3EperY6BY1Y5Tmy6yP786QwN82kaNmckPNuJlaEdkztRVV+J8
	ov9bqNF3k6OwRxek1HkwrSspfXxXOsOSXfDw8XMpgssNxshayOq/r5emqoOnw/d/4uk=
X-Gm-Gg: AfdE7clAHaQ73kQtdpoyg+ZpmcOILdKxwSICG46yhv5mwdruKIvRi9oPsuqJeYJ1/EL
	5Uwc4h5QqC8d2p/jv9dPhLIMnDOYLxwhJF7ifR3R7pC0lHwZe61XEO62W11E3l8EIMwLghaj1Co
	aodcAYU+hetVvGYkC+U6IQB0/CqlmslZ5XBO8DgewxF402qFou+yKM21jA8EYVE4lYOJ7T2lhse
	45FvMVBv0QZSvNI8dkPWnlswJTh6yp8Bv5y819V8zlw6ZfO2rK05E3/nAFIeuH307+eCeWLrZUL
	8vbfL/sPEqSYffaIM8HDufGF+THw2wxJ9nUFnlGvZan+2/n3JoVVlITner9L7aQyMUfOFCC23Ok
	NjRcpaOv7TaYNjiBt5gO/2pQcoGTzkFRW4ZjCM3sSDZ5LNBitU7yXklx6KQQzKGcJisqZWESw6n
	3Ksgv8YWAPru+WPBDnT4jsU4KgPZPl4HnQzd5RhvvcPBhwRkDYsw==
X-Received: by 2002:a05:6102:c4f:b0:737:172e:e4f6 with SMTP id ada2fe7eead31-73a3841fbefmr255612137.16.1782749074379;
        Mon, 29 Jun 2026 09:04:34 -0700 (PDT)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9691f84fc71sm4886228241.8.2026.06.29.09.04.30
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2026 09:04:31 -0700 (PDT)
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-96710629eb1so2444974241.2
        for <linux-sh@vger.kernel.org>; Mon, 29 Jun 2026 09:04:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpBZ1gVFx8vgl+ZocDk1vUFrDgwBG5/aZWyqgVHGtzjqnh9PWHikTqweR5+agvVw8Vu9NYMAapXzA==@vger.kernel.org
X-Received: by 2002:a05:6102:148a:b0:738:ff1b:940 with SMTP id
 ada2fe7eead31-73a365e2846mr277383137.4.1782749070424; Mon, 29 Jun 2026
 09:04:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629130329.1291953-1-arnd@kernel.org> <20260629130329.1291953-7-arnd@kernel.org>
In-Reply-To: <20260629130329.1291953-7-arnd@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 29 Jun 2026 18:04:19 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXjJRCW2v=ocjaG1xv2Bhhn1fcgL1YKsV3+MWbhboFtpw@mail.gmail.com>
X-Gm-Features: AVVi8CeLP4wAatdqRaN_LpUF4e5DDi2Drj76tc85gOykWJhBx1i_jZadj7vLGOk
Message-ID: <CAMuHMdXjJRCW2v=ocjaG1xv2Bhhn1fcgL1YKsV3+MWbhboFtpw@mail.gmail.com>
Subject: Re: [PATCH 6/6] [v5] gpiolib: turn off legacy interface by default
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-gpio@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Jun 2026 at 15:18, Arnd Bergmann <arnd@kernel.org> wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> All users of the legacy interface now select CONFIG_GPIOLIB_LEGACY,
> so it can be turned off by default and only get built on platforms
> that still have one unconverted driver.
>
> Allow turning it on manually for compile testing, in order to keep
> the build coverage of the legacy drivers in allmodconfig and
> randconfig.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v5: added patch, now that we are getting closer to completing
>     the series

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
