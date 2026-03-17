Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59F2394481
	for <linux-sh@vger.kernel.org>; Tue, 17 Mar 2026 08:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773736587; cv=none; b=eU/EqIi/hHKtvvzSpz71ajLt4BaQGbjosQmyR15pZVvWPpir2uSOnS9qJa+lVm5rR2KCuiOcAoqj9Q6R/weTEPyXsGmiZr2q65j2+S22MQ/uifZ27ASzlPS3k1vrO5znGl/C67Sau//KXoBH10Rw+ZEtUCG39qR9eHU8KQmVh9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773736587; c=relaxed/simple;
	bh=1IbAI1LF70M+Kjw+h3BaLZwBsh7cf418N6PFDl+oOnk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g/tGwwyAJJaNVpy2Jbc+wnqoCK9C+yVvO4Np+Sq886W+HllSaOTiBgvkzsh7aez5d77yDIOm9kv3a74bxVN5v9MlxlWolSizbcpWZuzGIY7ltrHbv5Bzlb4JpkfPK5inruJbjyiuzdN9RkYYKMzfvbagi7rEgsKsCfVls0A+bfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-5ffc6a96665so1416890137.0
        for <linux-sh@vger.kernel.org>; Tue, 17 Mar 2026 01:36:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773736585; x=1774341385;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=idH2bB7nbOzzZw2WFTC74GwVow5g1kiitlzGsuFZK5o=;
        b=H0WFz+1835bK1RvyVNErY4V/XfjviJsBpqaSrQBAbQLnFgFCOrOZx8TAYtHdtqoIiw
         0rKM3haP5VWGFDIUYEH1+lauvakW/DN47yBHYNLVWcWU6oxM29ayHAZwyXfHAsj9nRmu
         TwzPjlhMGQnfxXJQdTuih/vnCtd9HDwGUlBm3SKkZ40k2Kf6fhxrnkGVVbj6GkGXrJC3
         VfueWfxweGhXG7LZdm2UwFPqv2znkT/MFqIQJUWfFploOillBSfjT6nU2dghc7pd0Ika
         e0mhhSZ34TOvN3f29oUmQEkM3LwcOEuqS+d9KWIZUHKxfXospL1PfzenC73Ag1aDZCI5
         hySQ==
X-Forwarded-Encrypted: i=1; AJvYcCXY33aBjxczXMuU2IyDT/Wq9BxPnJNq9e4cNp6z9feM6xKbU6YdtJuimUyrG+5Vwz3aGEEE99zJRw==@vger.kernel.org
X-Gm-Message-State: AOJu0YymqJtPwblEoQhs6FZnemgUo8z3iDEtZFmeeQQngZEf4g4mC5f6
	p/qnrG9twa5PXYGF2u6eOp9sxXY0wAxLSEvzbJO54YUzPC8z92TdnPTShL9IcdYE
X-Gm-Gg: ATEYQzxfxd6gFAc6S5FP2tdF0k++M3xViXvW8OOI761XB1/x5VjfGsuv0Isz20NRwt+
	k35p/yCDn1tXs+nqxU1/TOljH14ClXoFUasv3e+fatn2xIGu4eFJrPyAW8KPT+a7L4pWdAYKeD+
	7YT3QSMuWO5VK6db3MagydnL54mPmbn5YVA0VYy1uvSVkhKc+V2dY+F4zbjCkc02vLMW3b/Rn7a
	D+tJWREnGr2TEAyTJxU/qIKFGbcYEvy2LfwFAaCsi1NZEE+OrS5soWDQKimOLUW1308qwOsU5IR
	/J9dzNCQ7rmrq1FA+uauPWTjdDF5DJRIe+Idxu0NRylW3yXi22FIlirg1/Yj7t0NTb6uIIwm/fU
	HR8mKt2B9DwK9n2szYR6Rl2bqFkjgo5bVgAAS+efjYoKl0DXejkzeV2a8UV4+DfSs9jjV55klPv
	Hdcs4IzQmdrKBcHQKuj5abteUD2u1wI1qVIZCKS3Czr7vfzf8+GfQZSuESvGBXFRuh
X-Received: by 2002:a05:6102:358e:b0:5ff:d192:ff2f with SMTP id ada2fe7eead31-6020e50efdcmr6582390137.26.1773736584924;
        Tue, 17 Mar 2026 01:36:24 -0700 (PDT)
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com. [209.85.221.172])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-950cb55c975sm2837504241.5.2026.03.17.01.36.24
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2026 01:36:24 -0700 (PDT)
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-56af30dde0cso2063929e0c.2
        for <linux-sh@vger.kernel.org>; Tue, 17 Mar 2026 01:36:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXWI9sqXEdaAKdiAvMvFb9Nme0YgGwH/XEZ3r3QfnG7s8FZx91d/tpnP759HQCj/AQl2fwqQPGWNg==@vger.kernel.org
X-Received: by 2002:a05:6102:5127:b0:5ff:2569:cfe7 with SMTP id
 ada2fe7eead31-6020e2129e6mr6024902137.10.1773736584585; Tue, 17 Mar 2026
 01:36:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260303115720.48783-1-dakr@kernel.org> <20260303115720.48783-5-dakr@kernel.org>
 <DH4M3DJ4P58T.1BGVAVXN71Z09@kernel.org>
In-Reply-To: <DH4M3DJ4P58T.1BGVAVXN71Z09@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 17 Mar 2026 09:36:13 +0100
X-Gmail-Original-Message-ID: <CAMuHMdW=hfK82_QKXL=n-nMos-HjScKuw9jNTy4xsxJ2qnPYyA@mail.gmail.com>
X-Gm-Features: AaiRm50LJFP1R3ITAUSRjqb1napf13plX5N5KjefHP89RPorlF5H9VKuGn2urAs
Message-ID: <CAMuHMdW=hfK82_QKXL=n-nMos-HjScKuw9jNTy4xsxJ2qnPYyA@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] driver core: platform: use generic driver_override infrastructure
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, hanguidong02@gmail.com, 
	ysato@users.sourceforge.jp, dalias@libc.org, glaubitz@physik.fu-berlin.de, 
	abelvesa@kernel.org, srini@kernel.org, s.nawrocki@samsung.com, 
	nuno.sa@analog.com, brgl@kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
	linux-hwmon@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-sh@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Danilo,

On Tue, 17 Mar 2026 at 00:57, Danilo Krummrich <dakr@kernel.org> wrote:
> On Tue Mar 3, 2026 at 12:53 PM CET, Danilo Krummrich wrote:
> > diff --git a/arch/sh/drivers/platform_early.c b/arch/sh/drivers/platform_early.c
> > index 143747c45206..3cd17bb0be67 100644
> > --- a/arch/sh/drivers/platform_early.c
> > +++ b/arch/sh/drivers/platform_early.c
> > @@ -25,10 +25,12 @@ static int platform_match(struct device *dev, struct device_driver *drv)
> >  {
> >       struct platform_device *pdev = to_platform_device(dev);
> >       struct platform_driver *pdrv = to_platform_driver(drv);
> > +     int ret;
> >
> >       /* When driver_override is set, only bind to the matching driver */
> > -     if (pdev->driver_override)
> > -             return !strcmp(pdev->driver_override, drv->name);
> > +     ret = device_match_driver_override(dev, drv);
> > +     if (ret >= 0)
> > +             return ret;
> >
> >       /* Then try to match against the id table */
> >       if (pdrv->id_table)
>
> I was just about to pick up this series, but then noticed that checking for
> driver_override in the platform_early case doesn't make sense in the first place
> and was accidentally added when the platform_match() callback was copied over in
> commit 507fd01d5333 ("drivers: move the early platform device support to
> arch/sh").
>
> Thus, I'm going to drop this hunk and add in the following patch; please let me
> know if there are any concerns.
>
> commit 39cae4095efda4b00b436c0fc46f21de84128969
> Author: Danilo Krummrich <dakr@kernel.org>
> Date:   Tue Mar 17 00:37:15 2026 +0100
>
>     sh: platform_early: remove pdev->driver_override check
>
>     In commit 507fd01d5333 ("drivers: move the early platform device support to
>     arch/sh") platform_match() was copied over to the sh platform_early
>     code, accidentally including the driver_override check.
>
>     This check does not make sense for platform_early, as sysfs is not even
>     available in first place at this point in the boot process, hence remove
>     the check.
>
>     Fixes: 507fd01d5333 ("drivers: move the early platform device support to arch/sh")
>     Signed-off-by: Danilo Krummrich <dakr@kernel.org>
>
> diff --git a/arch/sh/drivers/platform_early.c b/arch/sh/drivers/platform_early.c
> index 143747c45206..48ddbc547bd9 100644
> --- a/arch/sh/drivers/platform_early.c
> +++ b/arch/sh/drivers/platform_early.c
> @@ -26,10 +26,6 @@ static int platform_match(struct device *dev, struct device_driver *drv)
>         struct platform_device *pdev = to_platform_device(dev);
>         struct platform_driver *pdrv = to_platform_driver(drv);
>
> -       /* When driver_override is set, only bind to the matching driver */
> -       if (pdev->driver_override)
> -               return !strcmp(pdev->driver_override, drv->name);
> -
>         /* Then try to match against the id table */
>         if (pdrv->id_table)
>                 return platform_match_id(pdrv->id_table, pdev) != NULL;

Nice catch!
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
