Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793609382;
	b=xSgyq3WZcKh4r9fuYJauLlOjsJJpsGvnam1teGXwrQT3rbCHENS6x/cZeM/jsILeQsx7
	 egSEcUo7gVUdFQX9UBjt08zIwRU/6XHQzaIoiTbjmpc/SsCS3ibywmmzrmd7RAcHRze0e
	 Jlg9y+XstyKxR2QYhMSyxw1dBJMZEvgMT35Q0ghWSa2zAkpOKwEpRso+rig6hn74IcQX5
	 wPrbtBl7GBZRKeai7IlIMK6q2y6txTaOT2D4yPRqMA34f3CRX2tUeXjDAomIcdSza+fV1
	 WrXOGmXGJWnc159gQASa1QMwI6nS4drL1rz0hCH9TTEw/gbxUUqsyN52E1koSSUhf3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793609382;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=+YEAseZvXPy4rzi3ilmBCswmMdSrruj82r2UTnccKOw=;
	b=v2D5BvNp1iwutsRpNb5VwyZDNTjqGKF2bWUB7Sj7kfNWSGJ5rTFHVrr+/jrHzRKZgTF1
	 oAEvXBKQO+AuyZcUUTFwJcqp/AcugPF/0Pe54U8sySUexCkAwb49iE21swceHng3ElK5S
	 NsRVu77l8LvAJsD2PzmgraUcTR6Cy0e8KC7tKo/lSAoT+2jYk8kakBAC7w9nP++KaM8BN
	 l09YdjsoQlQxbRfQWNwoC60HKGplEJJhdvr5cAhXfSHeOfn+Cmnh6apPb6lQtLmefsBVp
	 ZJbckR4x/JW83CmOkeGEyiKlUHYLekCAyYoOrEu05dwNvG8Sq81a268/PuseWfGl5ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.221.171
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4FA606A329
	for <linux-sh@vger.kernel.org>; Mon,  2 Nov 2026 08:49:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA4FA606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5eadf48fb2dso986692e0c.1
        for <linux-sh@vger.kernel.org>; Mon, 02 Nov 2026 00:49:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793609381; x=1794214181;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+YEAseZvXPy4rzi3ilmBCswmMdSrruj82r2UTnccKOw=;
        b=0A6zmcM2g5BmFwK2t87cposxHCrPmwWRFkQcUUvHBEtIRfsjIzLaI66ykqbAHjxieC
         oYZLmkyujRFVrdT0iWoIF5vUdl+/1sGxE3epcvt/r6czYF7Q8Y3DJDKzDvb4HwMOjhBm
         6umkPW8M8GYKer4wY7bMDr1Pr1scHal3Z3vTtvuCkD2Lz9ovFkQpWODDkvuTalFf/Qv4
         jXdgX1eX7hB+5VyfEwd6bTDzgBdso1oyKSe7cm7kp92/vt0Y8pZLU4sxCqtlhYpmy3u4
         5uDQCdvt2xy/H50cpYRRBxSIfsh+qNvj7vu/ga0NCxqgGEesA/ToO7iXWtFGGiJLORJP
         41iw==
X-Forwarded-Encrypted: i=1; AKwUvBzb1RswYV8cXz9qRktwt6f9hcFi4TLMtRAc8dvP1vO15UhCjD7LjAppRL389PzskGeOR09uj69LMw==@vger.kernel.org
X-Gm-Message-State: APuU4Z805iRmHI5oZTYuCrur/v4iZNf33Z5W5r3IMxiqCzOX80V0/ENI
	866+D2eD2ykUaaWKZPzPRnSdO+42bsYN4UjhsV6+QBlHN6bVoWyhbBsjXQR+TFRj
X-Gm-Gg: AYBFou2CsNS2zWbSENqAf0xoSttro7KEumQ7/vB1SgB9WBFZ3kms7Dz8Wll6RVSgrd9
	UplIYw8KJHClqx0qahfw+IGfEaxSIJ2axmjsh0N98omI3hvsuusHKb+MiPTFJIUQfMLrOG8EZa8
	o+tZqtrrIkZHM4N61EouiqURiz9zlpyFIm2DVLxIpApAK7wpt68IkmFqGxcw2T31cnGnc+wAsbt
	PcgaQSF+SPdkrTGa/mIM35iIIuqrGlJarC8+NiGwL9bwCAdfBO71SCsmjoEFNJkjY7K2QY0uWU1
	hlDkDcpYUQClE5ZOIEAXMlBwrEjKLnK7GfATjP23vdTpL1gWA/xJBkJZpeFzGewG89SioQ2QrcB
	vjNEX1rK1bqIOseouC+dFQ2f97iiBBJmj88c4+OypyhmRDLpH/h/35UPQyoyRrmYFmIR3DLG8s8
	OmRnyJDup51Cu1NzrBLzTRPBh4bhDssc1VjE8z64dJ+7RVkKENJT4oLp0EthL8CuFZ91zNFc0sQ
	ZmH1cdCz3Pf+mYbb5axxkY2yFAEEGsBzRIkBQomFCBZeFk3qki8gQrrA+whgn026gr+RYAz/Uia
	2PXaI6TBpAay4GoJpBPvkyA0ay7jAPvLBUqBKRAOU3KRXlnUXYpJSZ3Kg3yF418t1w==
X-Received: by 2002:a05:6122:2904:b0:5ea:94cd:c5d7 with SMTP id 71dfb90a1353d-5ec6895bc14mr3840487e0c.16.1793609380947;
        Mon, 02 Nov 2026 00:49:40 -0800 (PST)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com. [209.85.217.47])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec69c99e3csm9647671e0c.15.2026.11.02.00.49.39
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 00:49:40 -0800 (PST)
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-7cbbb7b90efso560959137.2
        for <linux-sh@vger.kernel.org>; Mon, 02 Nov 2026 00:49:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvByrAwye6Z6Ji+I+YFLK/UaYlLYzn8FyU6OzXaSL5WKiYA3PdnRbo1mrQ49aDVvvKKT8WoQzpeIaRA==@vger.kernel.org
X-Received: by 2002:a67:e10d:0:b0:7b2:b159:98c3 with SMTP id
 ada2fe7eead31-7d072640147mr3163529137.28.1793609379443; Mon, 02 Nov 2026
 00:49:39 -0800 (PST)
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Post: <mailto:linux-sh@vger.kernel.org>
List-Help: <mailto:linux-sh+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sh+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261030230646.709687-1-artem122novak@gmail.com>
In-Reply-To: <20261030230646.709687-1-artem122novak@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 2 Nov 2026 09:49:27 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUacwihjpfJiGY486PT=tu2-jrSQX+ZTGAqk-iaLUzffw@mail.gmail.com>
X-Gm-Features: AclHuK_7cktGh1g2g1V-jYGT89r8njgV4UvXrWAUVy37X6WOtxJHbkDtb7srpgY
Message-ID: <CAMuHMdUacwihjpfJiGY486PT=tu2-jrSQX+ZTGAqk-iaLUzffw@mail.gmail.com>
Subject: Re: [PATCH v2] sh: sh7305: add TMU0 clock support
To: Artem Novak <artem122novak@gmail.com>
Cc: glaubitz@physik.fu-berlin.de, dalias@libc.org, geert+renesas@glider.be, 
	magnus.damm@gmail.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, linux-sh@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Artem,

On Sat, 31 Oct 2026 at 00:07, Artem Novak <artem122novak@gmail.com> wrote:
> Register the SH7305 master, peripheral, bus and CPU clocks using
> the SuperH clock framework. Add the TMU0 module clock gate using
> MSTPCR0 bit 15.
>
> Keeping SH7305 clock initialization independent of the legacy CPG
> initialization framework, which relies on arch_init_clk_ops().
> Disable SH_CLK_CPG_LEGACY for SH7305.

Thanks for your patch!

> update: SH7305 TMU device tree node will use the
> renesas,tmu-sh7305 compatible.

I don't think this correction should be part of this patch?

> Signed-off-by: Artem Novak <artem122novak@gmail.com>
> ---
>  arch/sh/Kconfig                        |  2 +-
>  arch/sh/boot/dts/sh7305.dtsi           |  2 +-
>  arch/sh/kernel/cpu/sh4a/clock-sh7305.c | 78 +++++++++++++++++++-------
>  3 files changed, 60 insertions(+), 22 deletions(-)
>
> diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
> index 5ce7df11c3ec..315a1d6ee452 100644
> --- a/arch/sh/Kconfig
> +++ b/arch/sh/Kconfig
> @@ -532,7 +532,7 @@ config SH_CLK_CPG
>         def_bool y
>
>  config SH_CLK_CPG_LEGACY
> -       depends on SH_CLK_CPG
> +       depends on SH_CLK_CPG && !CPU_SUBTYPE_SH7305

Why not add !CPU_SUBTYPE_SH7305 to the existing list below?

>         def_bool y if !CPU_SUBTYPE_SH7785 && !ARCH_SHMOBILE && \
>                       !CPU_SHX3 && !CPU_SUBTYPE_SH7757 && \
>                       !CPU_SUBTYPE_SH7734 && !CPU_SUBTYPE_SH7264 && \

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
