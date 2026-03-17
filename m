Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9935D2D7386
	for <linux-sh@vger.kernel.org>; Tue, 17 Mar 2026 16:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773763353; cv=none; b=Cw4xRzh/ICmpNcjcArPyBYp3xzNQCruur4tSguNYjlRz8uteo8BC8l/Bm8k1KY0sHmeCRtn2uZn4UUiKFNQJPoIvq3Wrv3h9Inf9/WC9kbFxvlTzr+nXM5mMcuMrtvkd6T6OPm6qa6f/E/bBUk3jQMGo9NiIxo9M6GRHVNT46T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773763353; c=relaxed/simple;
	bh=sIXRyKcBB8QlxcJr7L52j/3CiZELN2iAHmA6Aw4pzm0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P7nfJYsAE7S08G9cN8jGKZ9d4hMXGJ3095fAjBD+D2padJiHcWgi5DB2OoKr5Ab4zSA0Ey8+YseBE49+s/d14KbjvM72qZuPhFXU5KKK/mkk/F1wVeiA1DNrZzkCvpy4zzjPpfoARgyGOrVKI0F59DT5rfH8X/C3RWuRTonNG34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5a13f6bcbf4so8413491e87.1
        for <linux-sh@vger.kernel.org>; Tue, 17 Mar 2026 09:02:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773763349; x=1774368149;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=twLG+LiXs44QUcz9Iwy6OkpeTFkusmg+ejXI1TbxJ+E=;
        b=gM/XDFUqaYiGaYBgQXtIrTlv3SZ3sAI6w3vQEULDCRjFtd5Q00idD9ShOpMm9oM6FY
         I9jrtGJj6mEfi1IUBHPhawGyU2XUDizsJYLEvAJ7XN7SOFDKgiM/9vexc6QtEt1IRiKV
         YpQcUPAWb449sZCwJbvoEIqsRuy76RXDhxpvEE/AMW+5ywuQwSnXeEDpadvTvhv+ehDw
         jw1/bBbVTRrp7liDk+j3fuiMUcOPIRchohx4kuekI5N+H1fV5gpyk1EGJs67oNKmczLX
         8JZ1kjQScej5465XGC4fH4h2cE+a1wuMzmMz/vETbXb2euiZyoYsQsLTD8kh83jVYAhI
         hDvA==
X-Forwarded-Encrypted: i=1; AJvYcCVfGfaZgH0sz1BYECm+CgrzRMmF2lClTQ15spYlYyOw/ZA1rE2A6/gc/HLERQ2Ked8PjoWR9shdlQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6iml298qd3NPWIgBD3uUr5/eS3ivSgw33VvCNx99ZCobBQ56n
	Z1DmrGVzB6Pm9cploUJVlaR9r/DKXjSy4y700nKzoi2krzOSkZHd1wFRQ3Ev0GmK95k=
X-Gm-Gg: ATEYQzzw6hNyyjKIqBspFVzgcTzSwtUA5IfElhSg119Rmtx3Vsdig//sZ1q5+wVElCK
	GX8vc0i4zBMo74Syp7zLTOhQIwG/1JtjvD5kjgbGBGWlKr3oE6wIKsoWp/b8FrBSHBOKL71EgGl
	ECsOV3SBlqXBWinC+fkUk6fd9KQWZGUm3d1IryXRU7CEuaG7yxYol9cAeatd9zuKg44D6LLI1Ti
	na7RL0O1CV1J8Li7xUMkIYaQkZQQyGspnxAut6K6WoUJSaVe7mN+vfVAiw8QHWRrxlbaARYHF0b
	dUv1tJJJGZKPBGL8O6TNAjJlT7tVGv+Npycn4OrvvR8U9cBfUNyeqnwJNcS7CzRXqusXpPwgd8N
	z4PrSgsSXaof9keI7D4J1Z+9lm1rHR3Ydt8VXQReT+zygNd4qBUOPbUT6yJ7A+SIdn3i+dWW86V
	Opsdc/FsKVJKOTvHpZ9GWWPG4I5c0LIo9RIAXqNnbb0NvoNKAvp+j3u0blb2c+
X-Received: by 2002:a05:6512:3d1e:b0:5a1:2a20:9255 with SMTP id 2adb3069b0e04-5a2795909a9mr48991e87.18.1773763348339;
        Tue, 17 Mar 2026 09:02:28 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a15602e239sm4174121e87.23.2026.03.17.09.02.27
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2026 09:02:27 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5a13f6bcbf4so8413433e87.1
        for <linux-sh@vger.kernel.org>; Tue, 17 Mar 2026 09:02:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXOyP4nzD+FXs8bs9ODSOrW6IvUQXWjXqMXdGGq1Q3l/co6omjAQl2WKAkE02OxjuChQpkAxlGKOw==@vger.kernel.org
X-Received: by 2002:a17:907:d1e:b0:b94:1d92:7eb with SMTP id
 a640c23a62f3a-b976505a45fmr1113540866b.18.1773762847178; Tue, 17 Mar 2026
 08:54:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260317-arm_defconf_cleanup-v1-0-8eecb7fdd24d@kernel.org> <20260317-arm_defconf_cleanup-v1-3-8eecb7fdd24d@kernel.org>
In-Reply-To: <20260317-arm_defconf_cleanup-v1-3-8eecb7fdd24d@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 17 Mar 2026 16:53:54 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV50nOT06wKfj_X5LU2z=1XZZGd6Gac0C41qWWNZHRLXg@mail.gmail.com>
X-Gm-Features: AaiRm53kA4BcUnu8DzmJWc_bmCImw2GJpSjbqTP7vNJFqk2-PxsMkq0NOVh2FgU
Message-ID: <CAMuHMdV50nOT06wKfj_X5LU2z=1XZZGd6Gac0C41qWWNZHRLXg@mail.gmail.com>
Subject: Re: [PATCH 3/9] configs: remove obsolete assignments to CONFIG_NFS_V4_1
To: "Vincent Mailhol (Arm)" <mailhol@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
	Mikko Rapeli <mikko.rapeli@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, 
	Matt Turner <mattst88@gmail.com>, Magnus Lindholm <linmag7@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
	Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Pablo Neira Ayuso <pablo@netfilter.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Vladimir Zapolskiy <vz@mleia.com>, 
	Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>, Liviu Dudau <liviu.dudau@arm.com>, 
	Sudeep Holla <sudeep.holla@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
	Gregory CLEMENT <gregory.clement@bootlin.com>, =?UTF-8?B?VGjDqW8gTGVicnVu?= <theo.lebrun@bootlin.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Janusz Krzysztofik <jmkrzyszt@gmail.com>, =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, 
	Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Arnd Bergmann <arnd@arndb.de>, Heiko Stuebner <heiko@sntech.de>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>, 
	Eric Biggers <ebiggers@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, 
	Sricharan Ramabadhran <quic_srichara@quicinc.com>, Bjorn Andersson <andersson@kernel.org>, 
	Michael Walle <mwalle@kernel.org>, Guenter Roeck <linux@roeck-us.net>, 
	Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>, 
	"Rob Herring (Arm)" <robh@kernel.org>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Anna Schumaker <anna.schumaker@oracle.com>, 
	Alexandre Gonzalo <alexandre.gonzalo@arm.com>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, linux-samsung-soc@vger.kernel.org, 
	imx@lists.linux.dev, linux-renesas-soc@vger.kernel.org, 
	linux-parisc@vger.kernel.org, openbmc@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"

Hi Vincent,

On Tue, 17 Mar 2026 at 10:16, Vincent Mailhol (Arm) <mailhol@kernel.org> wrote:
> CONFIG_NFS_V4_1 was revomed in commit 7537db24806f ("NFS: Merge
> CONFIG_NFS_V4_1 with CONFIG_NFS_V4"). However, some defconfigs are
> still referring the old configuration.
>
> Clean-up all the leftover references to CONFIG_NFS_V4_1.
>
> FYI, the suppressions were done using:
>
>   git grep -z -l '^CONFIG_NFS_V4=' -- 'arch/*/configs/*defconfig' |\
>     xargs -0 sed -i -E '/^CONFIG_NFS_V4_1=/d'
>
> CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN and CONFIG_NFS_V4_1_MIGRATION
> were not in scope of the renaming and still use V4_1 in their name, so
> keep those two untouched.
>
> Fixes: 7537db24806f ("NFS: Merge CONFIG_NFS_V4_1 with CONFIG_NFS_V4")
> Signed-off-by: Vincent Mailhol (Arm) <mailhol@kernel.org>

Thanks for your patch!

> --- a/arch/arm/configs/shmobile_defconfig
> +++ b/arch/arm/configs/shmobile_defconfig
> @@ -217,7 +217,6 @@ CONFIG_TMPFS=y
>  CONFIG_NFS_FS=y
>  CONFIG_NFS_V3_ACL=y
>  CONFIG_NFS_V4=y
> -CONFIG_NFS_V4_1=y
>  CONFIG_ROOT_NFS=y
>  CONFIG_NLS_CODEPAGE_437=y
>  CONFIG_NLS_ISO8859_1=y

Already done, cfr. commit 8c6cccefb33e2022 ("ARM: shmobile: defconfig:
Refresh for v7.0-rc1") in next-20260309 and later.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
