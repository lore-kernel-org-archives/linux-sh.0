Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793357809;
	b=uxehGzOBbsCQ45u3Qqc57Cawmy6b/sWcI1SN4H70IWwejgHdIuTQQ8o46qmbiVFAJXDF
	 z9zzbEh6LyeN16kvGrVmez2boeAMxyYKWqzpOVdp6U4UGO260Jl77SexssQPtnbqrtqd2
	 WGMXLFrCtpSmMwDTPmlJIuRu/rtlFfbqhUHgjzaOq821mvbSMOOxGxza/YyOcH9zkqpFE
	 d2Amy3w8eBkw4pKHHklqO5g4UrvmVneQ+kw2xKgNqIc8EhrMK+kp5U1zeMUzauRV8Nkzd
	 C4ivpdi+HNEO5+RU2C0bU7NWLnwmbGGDkVmNeu64bT4+py6kOaN6ybAJoW5UA34wz7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793357809;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=zZxX8pTnMO9FXNUIpz1udUKFf4OKo2nsyK1cnYF7t/M=;
	b=K2Gq+WXFtduDE4VVOWys5itZrK9vtAQVl/svfkIsqVKfpOi2T3qoOshkVRgdhqYn9Ebz
	 9mLMNEa2/srUX11+zMUIQc7jLMoUjtEHvGIFruzH4wTif0u84fYEWLF4c7GZ86lkjSIvY
	 ewdwLYkcuq+EM/dR7lbgDV93WvuBEhvY5GXm1CrIPEjFE2gUMm1p9+GJzr8QHf8FInXks
	 ccEHX8qaw6w0/X8f+UvyMRmhFqdWnmen8tyGl6fUpFzGHPMei735Iseoh+UQJS6Huq+7M
	 Ql467b6D8cFMtCsPbHCGQNVQb1ilgd0SLbaR1ZgpkNacwpLVh4QnNqAeREmU5zB4NhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.222.50
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B1A606AC1A
	for <linux-sh@vger.kernel.org>; Fri, 30 Oct 2026 10:56:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2B1A606AC1A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-9906870a9baso304639241.0
        for <linux-sh@vger.kernel.org>; Fri, 30 Oct 2026 03:56:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793357808; x=1793962608;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zZxX8pTnMO9FXNUIpz1udUKFf4OKo2nsyK1cnYF7t/M=;
        b=RzdN1DbSt2RvkmT+Fwj4gaC5Z5z0dp0v1NpaecwaUCXRyr5svwg1nof6EXrDB9BJuf
         dR1oti68l42oYNsrF9ftNNPD0GzjfPhVcOaN40hS6vxpgCSVRCS2mDT+wyqfvbkhGkRI
         XYIoOTHp3raajLb4BAk+Qs39D7Cvj0AwF4GRIMA9hJAyg9apruUyecCxTrZA9LYi0IvM
         KlREyhUSoONFv0syfb8tpz/Yec5guD0s2K/GgRs7PRijRKnnqPnbeYbv4JNcKJW38yX5
         hMZapoFvDZsNvirTzHCxtipyJ7XOZmMxEP+bYCVrYp7+QsrcmEjvyI5L2TWMEtpPNcmn
         JUVg==
X-Forwarded-Encrypted: i=1; AKwUvBxz3aPoF/WAynD0vRm3wPf3SnxgYgfkMswAUWcqHbghbvk7Cbwis1c6Xmq7lyB1yPmKzRivmf3gCA==@vger.kernel.org
X-Gm-Message-State: AFq9FYLe/czSiTCPhfZMDTxEcOcL1kLyPrqhh/34Ae4e21Rif900GJsH
	9O97uzvLcQtN7e2OlspYLHglYgOz9GydZtExfqXgb+8PKLMRzDRu2ypkj1+v02Xb
X-Gm-Gg: AYBFou3NYuA7B2sAfeVv5qCG0N3FCn7S4Ate8UOh/rK/jWRHePhutVH26lXZKv77Hlx
	kgUXyCXDg7CiBEqZ3GL/D7gRXHOG/2Uqw+qIKaQ9LGnwWwHmejGqUZatt5lUka8905UddD4sALS
	btjR8mEUTf/IjlPwKPzwFFgLR2UcouzXBazZGa4/v0IVnBUYC2cAL2/2eS2RkexhU2xj6SxXHNY
	YApINMoTWy/IEJDz3Y//OXLM3b2+7TmUVT2F9jEofKRwHtQCJ/XGJuhtvlteW19GOhl4Cgvv4Pi
	7GEo1GE2w1jb/fy9yZjUN3etBaZRxwtjbsYFYJI2BKFEY5MR421xacp9oe2XGQy+KYUQlyfRMlZ
	EIZdes1JUIsjymb35wS4+jMNU92NZxYssTN/DcfKcaBbuDy9eM4Ax59CJLEEfokaIkqvTIwjZbl
	O9Pj9JspaITJ24+cmoPbpqdDCf6yAve/m0HeSVXJaiVFwJiB1a1PWuavzdG1UB3saO9fgUftqAh
	atBkQ5b81vMt5CDJkm4Dh3alfSsvhEqhjHmV05cQQ2YepOarMEDWQTRcPoCF3MROZCLTYq89Z/8
	TvIwcIvYCqpfssTgjyR5oaGlcSgt4K/5uEliAEDliOWqRWrl7Oe7N7ierZMyR2CT/6o=
X-Received: by 2002:a05:6102:5809:b0:7d0:65f5:2bac with SMTP id ada2fe7eead31-7d072d53ed8mr1106471137.35.1793357807919;
        Fri, 30 Oct 2026 03:56:47 -0700 (PDT)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-992ee39730asm2076528241.3.2026.10.30.03.56.47
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2026 03:56:47 -0700 (PDT)
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-99071945aa7so346561241.3
        for <linux-sh@vger.kernel.org>; Fri, 30 Oct 2026 03:56:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBy+ZL0YPHqzNxRJli4g2rDYThZP0dHUkCGBabcPe8UQwsvyqyUyy5F7na/61CiNXmGV6du45ZwR7g==@vger.kernel.org
X-Received: by 2002:a05:6102:2906:b0:7d0:57e3:d480 with SMTP id
 ada2fe7eead31-7d072bc7545mr969116137.11.1793357806982; Fri, 30 Oct 2026
 03:56:46 -0700 (PDT)
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Post: <mailto:linux-sh@vger.kernel.org>
List-Help: <mailto:linux-sh+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sh+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261022051021.322705-1-artem122novak@gmail.com>
In-Reply-To: <20261022051021.322705-1-artem122novak@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 30 Oct 2026 11:56:35 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXjtb6JeQzQEGtOUZDBTdkbrqn74prgXjs834oM6VH-MA@mail.gmail.com>
X-Gm-Features: AclHuK-raKkavqAnXA5yb8ziHt_cunR7fYe8AA3WmHlqSjTPKtCXGrUItohDcxw
Message-ID: <CAMuHMdXjtb6JeQzQEGtOUZDBTdkbrqn74prgXjs834oM6VH-MA@mail.gmail.com>
Subject: Re: [PATCH] sh: sh7305: add TMU0 module clock gate
To: Artem Novak <artem122novak@gmail.com>
Cc: glaubitz@physik.fu-berlin.de, dalias@libc.org, linux-sh@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Artem,

On Thu, 22 Oct 2026 at 07:10, Artem Novak <artem122novak@gmail.com> wrote:
> Register the SH7305 TMU0 module-stop clock using MSTPCR0 bit 15.
>
> Provide the fck clock lookup for the sh-tmu.0 platform device.
>
> Signed-off-by: Artem Novak <artem122novak@gmail.com>

Thanks for your patch!

> --- a/arch/sh/kernel/cpu/clock-cpg.c
> +++ b/arch/sh/kernel/cpu/clock-cpg.c

This file is only compiled if CONFIG_SH_CLK_CPG_LEGACY=y.
Probably you should not use it for new SoC support.
E.g. the similar sh7724 has:
arch/sh/kernel/cpu/sh4a/clock-sh7724.c: CLKDEV_ICK_ID("fck",
"sh-tmu.0", &mstp_clks[HWBLK_TMU0]),

> @@ -58,7 +72,15 @@ int __init __deprecated cpg_clk_init(void)
>         clkdev_add_table(lookups, ARRAY_SIZE(lookups));
>
>         clk_add_alias("fck", "sh-tmu-sh3.0", "peripheral_clk", NULL);
> +#ifdef CONFIG_CPU_SUBTYPE_SH7305
> +       if (!ret) {
> +               ret = sh_clk_mstp_register(&sh7305_tmu0_clk, 1);
> +               if (!ret)
> +                       clkdev_add(&sh7305_tmu0_lookup);
> +       }
> +#else
>         clk_add_alias("fck", "sh-tmu.0", "peripheral_clk", NULL);
> +#endif

... and thus there is no need to sprinkle #ifdefs in this file.

>         clk_add_alias("fck", "sh-tmu.1", "peripheral_clk", NULL);
>         clk_add_alias("fck", "sh-tmu.2", "peripheral_clk", NULL);
>         clk_add_alias("fck", "sh-mtu2", "peripheral_clk", NULL);

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
