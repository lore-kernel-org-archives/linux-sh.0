Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4001C2D97B5
	for <linux-sh@vger.kernel.org>; Mon, 11 Aug 2025 13:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754917840; cv=none; b=pn537aLruY3ly73xMeAWUHWYTqGOVXSSlpMaAaRInksDAaxZD21B69WDCqPZMDdo085F0soWl7c7zrsxzzCmlc88cjKQWN3WfW9vlnRw83LNxkM8uvKP3cmgRprwejS1jFv8fjs7aCx1cu6SlParGQlpwOZhwcxUbj+6BSBaij4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754917840; c=relaxed/simple;
	bh=YdcvZYKwitUcECgcbI2UhLZ6metpTwEak9n/5y6m0SA=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AqOT7HU0VumjmdCQaM+EM6ACssesCkWsNTQS7GnDAk8drgTHw0iUCP/pQEIbi5Odpb1c3OocF2z/Bx8ZbVrxMg8etiXQayis6mSlcVg9BJX140yP2vnpqaOH+RTdX+Dm7/+fw8YBXVsIDQtASUfLWXtg4yf4fQw1yGCB4ZOhgkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=ojjnhV8s; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="ojjnhV8s"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-24099fade34so30103185ad.0
        for <linux-sh@vger.kernel.org>; Mon, 11 Aug 2025 06:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1754917837; x=1755522637; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:references:mime-version:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=YdcvZYKwitUcECgcbI2UhLZ6metpTwEak9n/5y6m0SA=;
        b=ojjnhV8sG5RePBCOlfNn+HKKrpovehYP/8l1sr0vNYpFHhYyNj9xWMV43bJeaTo+kp
         pGJmmwo0JTwJGp+EMoH+TiRmSHHwCWtSKYf/ADQ+n41Fq7MLbvF4puoYKzMZIfAb5Yr5
         rfyUeS8+hBywvWWe45et8EVilsYHrox7Ct03tWZtWfpes3F5MB7MSmpvGYu3l/KMy0Lm
         Xz5nZcHYvM5pMpkmNGOifNAmrO7N485x8Dy3qu1/BQr+p2mpzG31DunBz5mKNnrnKK8W
         RdKVIPz8XNIoKoiGQOe1wq9OXTmtM2HvY5MHwnIuZgNfLGAMI4k+PY6m2DfBQiYd+C7+
         Xhsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754917837; x=1755522637;
        h=cc:to:subject:message-id:date:references:mime-version:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YdcvZYKwitUcECgcbI2UhLZ6metpTwEak9n/5y6m0SA=;
        b=eGt3uvJO+Bezrl8bTeittFGdn+DnXWAnzKPUqE+Rq0ELY9wyRfu/3+hHzi85gmjLn5
         4nYWa6XqrkrhIcdFo4LKNKcOKTHMOqYJd367rKO29Pv6oY3YSshI9pG/SMsNw0ITyaVf
         4+lww4oWUtqUj/ka/NSUxvrBRvfn9aIs9Q8WiEt9eD6XUQUFPKOTYLW3Rzjv5FIVRnMI
         TfgdZFDHgwFPwf9NAwEHTAhqjwyDuTUoAb1v2rpfx6fD8y5T9D7ppbsPpeG/xFMKAq7a
         Y/Ar2o0ZxgYzUn2fscX50JzRWDRmyjENE9VUjkiusXoY1h88sF7Pne2K5W6ZEBc1vLed
         uOhA==
X-Forwarded-Encrypted: i=1; AJvYcCUWUE5NH51whbLSsWNlMkNtNUx67twRm1BKEbSOsBHXxCleaNIVWlMSQw5TSIGmmrMWWY24aVxZOA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3U8tUB2TgRswPJtr7dPaEbKnZsUSi94zuuuwDjU553tpfWQBZ
	UNxSGYlxEp8N32OO5rXQqW98OCxf/yTqFycQlSSyroT5qrU3H5RdRnz5+PEA5nOUaz/dfnvYlua
	IccdOtRXxYU1ffEDx9GsrIEqWqSkFHLqu5TT6h8kWCg==
X-Gm-Gg: ASbGnctESWg4nEy36k0KiwLZGzjepPsS7JSqgFMsAC4qKyPhqtRu0BlEBbUckllR0dp
	gGnsO3Tk8rzMhJb26XIl9w4NCPJxo/ZUTLTmojzBvHyAFysrXJhkIGNGpljsoeGZ/3lykeKF7CS
	sV7yhzwH8BZdyPpBNHKO32AtJ/GbsDvU0Di6obwF6Dn6aayKueSOxQLxRgLMnCeFDiFUmPDfw3s
	g3NQL91XZ37a+mEemsRevSXe14A2yQxDGfMXW4=
X-Google-Smtp-Source: AGHT+IEgMvtsNpCEbzm+bQO3Dq6oVeggGu7qnt+f1HYUPfLnzNmxpfjIx2ohdBUK5XJ+fhQGIjFsq0lNMPvywZaOZwE=
X-Received: by 2002:a17:903:32cb:b0:240:96a:b812 with SMTP id
 d9443c01a7336-242c203d030mr203994295ad.24.1754917837398; Mon, 11 Aug 2025
 06:10:37 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 11 Aug 2025 06:10:31 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 11 Aug 2025 06:10:31 -0700
From: Bartosz Golaszewski <brgl@bgdev.pl>
In-Reply-To: <20250808151822.536879-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250808151822.536879-1-arnd@kernel.org>
Date: Mon, 11 Aug 2025 06:10:31 -0700
X-Gm-Features: Ac12FXxi-t7kK_6HIDwsxWJsHZcp5BcOM26Y8X32Zi2av6pcVu6UuipKim4OtEQ
Message-ID: <CAMRc=MeyW8gtG_hsLWytCpufQRmg3s5QZenxCvP3MNGmaoo2cA@mail.gmail.com>
Subject: Re: [PATCH 00/21] gpiolib: fence off legacy interfaces
To: Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Andrew Lunn <andrew@lunn.ch>, 
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
	Gregory Clement <gregory.clement@bootlin.com>, Russell King <linux@armlinux.org.uk>, 
	Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, 
	Robert Jarzmik <robert.jarzmik@free.fr>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Matti Vaittinen <mazziesaccount@gmail.com>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Jeff Johnson <jjohnson@kernel.org>, Hans de Goede <hansg@kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jaroslav Kysela <perex@perex.cz>, 
	Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-leds@vger.kernel.org, linux-media@vger.kernel.org, 
	patches@opensource.cirrus.com, netdev@vger.kernel.org, 
	linux-wireless@vger.kernel.org, ath10k@lists.infradead.org, 
	platform-driver-x86@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-sound@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 8 Aug 2025 17:17:44 +0200, Arnd Bergmann <arnd@kernel.org> said:
> From: Arnd Bergmann <arnd@arndb.de>
>
> Commit 678bae2eaa81 ("gpiolib: make legacy interfaces optional") was
> merged for linux-6.17, so now it is possible to use the legacy interfaces
> conditionally and eventually have the support left out of the kernel
> whenever it is not needed.
>
> I created six patches to force-enable CONFIG_GPIOLIB_LEGACY on the
> few (mostly ancient) platforms that still require this, plus a set of
> patches to either add the corresponding Kconfig dependencies that make
> the device drivers conditional on that symbol, or change them to no
> longer require it.
>
> The final patch ends up turning the Kconfig symbol off by default,
> which of course depends on everything else getting merged first to avoid
> build errors.
>
> I would suggest that patches 1-20 can just get merged through the
> respective maintainer trees independently when they are deemed ready,
> and the final patch can wait another merge window.
>

Oh, not at all, I'm fine sending a second PR late into the merge window to
get that done in a single cycle.

Thanks for doing this, awesome work!

Bartosz
