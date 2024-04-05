Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5476F072
	for <linux-sh@vger.kernel.org>; Fri,  5 Apr 2024 13:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712325258; cv=none; b=CFVsvZKDNJWrCC74s1nxtHRCjvviQNQI7rDEpboYJkxNL7++Lcb9mlS5l3b9voex3Gzif5BWTVw3iYvRVv6PdHpTQLCvbFIyluyTMCp6CDv5Je235QXwKRDbIAelomLL2efL0MRvrK6fBs2K85PQu+MoovJ8cVPOqdwb3YBIHZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712325258; c=relaxed/simple;
	bh=W5ADQYDvBol/tHyyHCoQDNWAtcgQm2gE+ai1Tw2cfLU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rVCodssJv99/LKa5QUHmN7W3IPNa72HIsJEe7LiBkt2eAOnjClL9baTEqbOM58MglODuoHZE9vhpC/k12KmbN90q+GDzAn6AeONQLCTMoQX3Zhoxzi106NQRu0gRE88bIz2V3kYQ05vMVfwMl76R/FvofxIy2RtnynYlgjLyJ+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dd161eb03afso2092930276.0
        for <linux-sh@vger.kernel.org>; Fri, 05 Apr 2024 06:54:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712325255; x=1712930055;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0X57nwX1fnYNTSzSPkb22SKaGK5ypOy1YUHs9wX1paE=;
        b=ZKJUYaNfyzODXNoBvYVk+rOdquFE/rQ83VXLOtzOCut8cF2s35rWpCSItsDVoghrqJ
         AuH/AL9GuwKPhdlx6H/j8H+kCPCsZyihyBdxXBG/rAZl3uKgAKLr8s7tPqkg8+TM9oVQ
         4NxmRc0B6TGSgU5rNmD9FgRGlIp7AlZUDZXcqkEQwPEV6aiwq2n5Btq2wHv7QPmlBN0r
         G2kiY80udlSVSapkupkRix8dB91+1U5eqNVg0cJ+I/gDaV13V3UBSwM/ZO3smxAyDK1z
         LPCO2oRb2aIpY/a9pogjTCKCzv/V39oAkPAuL/eGY0RWaa4uVcrabZ6/NXVoIoVcERE2
         Sc0g==
X-Gm-Message-State: AOJu0YwphC/TR9uH+IyFuzLbZTlyA2Y2crGxDia7y+q1AdE6IZp/n3tC
	AxVngqAmI54yNThYJeZZTdapvdIyWCa8qx6Yv1EgBrilFOsnKPDKeEqnXV15/LM=
X-Google-Smtp-Source: AGHT+IFZ7mwxXPbuYl6Gt34bjZ0HDV9MIrNYTMo6GlnHR4HlVExp9uzX4ddYSa5lr9lpROnqeZ+kEA==
X-Received: by 2002:a25:2941:0:b0:dcf:2cfe:c82e with SMTP id p62-20020a252941000000b00dcf2cfec82emr1186394ybp.55.1712325255314;
        Fri, 05 Apr 2024 06:54:15 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id r35-20020a25ac63000000b00dcdb6934617sm315649ybd.62.2024.04.05.06.54.15
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Apr 2024 06:54:15 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dd14d8e7026so2138269276.2
        for <linux-sh@vger.kernel.org>; Fri, 05 Apr 2024 06:54:15 -0700 (PDT)
X-Received: by 2002:a25:900b:0:b0:dcc:d196:a573 with SMTP id
 s11-20020a25900b000000b00dccd196a573mr1333266ybl.36.1712325254911; Fri, 05
 Apr 2024 06:54:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1712041249.git.ysato@users.sourceforge.jp> <abb64289b08ad4a19b47f2d4d4d75405db1cf1cc.1712041249.git.ysato@users.sourceforge.jp>
In-Reply-To: <abb64289b08ad4a19b47f2d4d4d75405db1cf1cc.1712041249.git.ysato@users.sourceforge.jp>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 5 Apr 2024 15:54:03 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXMs9X1S2cpXsoASsLg0ERLwkas7diZR4Khu0uh3igWLA@mail.gmail.com>
Message-ID: <CAMuHMdXMs9X1S2cpXsoASsLg0ERLwkas7diZR4Khu0uh3igWLA@mail.gmail.com>
Subject: Re: [DO NOT MERGE v7 19/36] serial: sh-sci: fix SH4 OF support.
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sato-san,

Thanks for the update!

On Thu, Apr 4, 2024 at 7:01=E2=80=AFAM Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
> - fix earlycon name.

Might be wise to explain what was wrong with it...

    (because else "scif" will invoke rzscifa_early_console_setup()
     on non-DT platforms)

> - fix earlyprintk hung (NULL pointer reference).
> - fix SERIAL_SH_SCI_EARLYCON enablement
>
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -2717,7 +2717,7 @@ static int sci_remap_port(struct uart_port *port)
>         if (port->membase)
>                 return 0;
>
> -       if (port->dev->of_node || (port->flags & UPF_IOREMAP)) {
> +       if ((port->dev && port->dev->of_node) || (port->flags & UPF_IOREM=
AP)) {

Looks like the dev_of_node() wrapper exists to handle this.

>                 port->membase =3D ioremap(port->mapbase, sport->reg_size)=
;
>                 if (unlikely(!port->membase)) {
>                         dev_err(port->dev, "can't remap port#%d\n", port-=
>line);
> @@ -3545,8 +3545,8 @@ static int __init hscif_early_console_setup(struct =
earlycon_device *device,
>
>  OF_EARLYCON_DECLARE(sci, "renesas,sci", sci_early_console_setup);
>  OF_EARLYCON_DECLARE(scif, "renesas,scif", scif_early_console_setup);
> -OF_EARLYCON_DECLARE(scif, "renesas,scif-r7s9210", rzscifa_early_console_=
setup);
> -OF_EARLYCON_DECLARE(scif, "renesas,scif-r9a07g044", rzscifa_early_consol=
e_setup);
> +OF_EARLYCON_DECLARE(rzscifa, "renesas,scif-r7s9210", rzscifa_early_conso=
le_setup);
> +OF_EARLYCON_DECLARE(rzscifa, "renesas,scif-r9a07g044", rzscifa_early_con=
sole_setup);
>  OF_EARLYCON_DECLARE(scifa, "renesas,scifa", scifa_early_console_setup);
>  OF_EARLYCON_DECLARE(scifb, "renesas,scifb", scifb_early_console_setup);
>  OF_EARLYCON_DECLARE(hscif, "renesas,hscif", hscif_early_console_setup);

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
