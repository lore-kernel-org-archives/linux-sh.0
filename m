Received: from mail-vk1-f193.google.com (mail-vk1-f193.google.com [209.85.221.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980393A1E7F
	for <linux-sh@vger.kernel.org>; Tue,  6 Jan 2026 11:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767700107; cv=none; b=RrVczccpi7bxTtUMokHJjV+xLLDad2Dzs3nEnReTm353aQcTeQbSqtFeIaJ1NNGtC1hdRgpxWhxSxHBP7Q7Bb5rgdAceGhZ1d1kUshBYgLJzyd/VEw3tr/L/3msoBo8gugQrqFl/QqAML8hYnK1KZ2AJ1aWysu4tguG9wZtngrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767700107; c=relaxed/simple;
	bh=cy90DhPfHZ+Icz6r89LIwxLLHRAHP0I0oJNrsBe1qfk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W5YNGhpVLBx03A0gmmJuSOGSKAq6z02ZtbUvXFWy2cB4k+YW03DSBH5Tx0imb16gxDvkEAY185a7erAf5kipdVpoM+fNgYnN9BUbjj+38hRd+qIXVvBY+UHNukTF2NYFYmr1ubeF25MnQE4s/3qbgkQEx12o4zqaeQHCjMROBSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f193.google.com with SMTP id 71dfb90a1353d-55b2a09ff61so280868e0c.2
        for <linux-sh@vger.kernel.org>; Tue, 06 Jan 2026 03:48:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767700103; x=1768304903;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eme3GKSVVTwekk5ahSqs0LbJRLjiKfIn3cO6kiKk5PI=;
        b=bou6WtKzsKvvE9aHO/GWt7pVYFZCWwEr1wAzWsI93nWKciY/0aKKG8g2FImGhgeVgV
         Ib1p0T5GdStN144FDjx36LgL44onYdYhG5P0c7y76qbhz8oND0Iy3GiH1CC4Hq+SQYKM
         gW95iZf0fjhEQ+41pXHQcUakbxZh3/MIdQiI/T3A58IbAGP52dSnpMa8G/7cmwDY3IJY
         sTApHDUZ+a3OKfsyayS3SUL6sAKzz4I2qhmv+UawAT6JriC4XlRoIVIK64zZQvDtJrRG
         pSfDj41fMn4sjZwUvJDLnrKADcbzqHpQ2pfgZeQ4ZtWL61fvWO86hX+ZmOTomwyIDaG+
         sdlA==
X-Forwarded-Encrypted: i=1; AJvYcCVBEYmIXTpK3f2ySsXJ2iVRUOKxGboJi755Y5jcTaX952YjYes2U3I0AbSFXhQR/6lR4wBpG1n2Pg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy4mSmoysj90cZagXh+VsLGnjFHD0wdOrVZ3cU4vGgE3UD4eHW
	DnlsPjXXYp5GRMkPeTw9uO0NZUIQkoEpV136L3pG8WeNBbbcL51tsgCS+MOELD+c
X-Gm-Gg: AY/fxX4oHKXoDh/BS5Ors8AEQv5kTD7svEfkkTE7pmhjvUJukaA9AWlt9teHc8Z2Hb2
	TKdk/lpkTSZN8gk/3TrAd5dhcdUZCi6c9z2N8gzZaFTW48Stfr4N7GZYRNCLFfwae3qCajZz1AS
	M7zqFblsiz/WzySPObNEITFiuFi4xg80NFVYo7kKZqUj92XsBc+LHKaZbxda6t71I2jW8mqm09j
	FGSvinSaTUFmZ7VwvPNPkCvbxLqFHiispbcOWE9ZZuL4xIhO1A0kf/ZNSZT9lre5prKkI/WCfJS
	q3NC3w+nCoaL9gVJERjGrFmGPzv7UK3CF22EMGsKeXuEhL7Ky82+0pssLz5kBuz0ciBU1RHNT0W
	TyqbeOScTYwUNps+4BpHxlYI+snV3x727F43VutGy1jdBd4le2ml/K2JBnW51d+xy3fF7Cb87uK
	ueDfxPdzqlusOZJ/efFYPqmPu9jXHKJms61m+KsgH4leFGg4YtroZAY0Jxpg8=
X-Google-Smtp-Source: AGHT+IHc7R0eomWEi6bKrnmtLHuLh1wIyfFDVoivc4yFrtjezfLhWHchLxi2+oa105YZ7RbLKjLrsA==
X-Received: by 2002:a05:6122:3194:b0:559:8051:223a with SMTP id 71dfb90a1353d-563392c675dmr676109e0c.0.1767700103454;
        Tue, 06 Jan 2026 03:48:23 -0800 (PST)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5633a3f69fdsm608997e0c.14.2026.01.06.03.48.22
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jan 2026 03:48:23 -0800 (PST)
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-5dfd0101905so292187137.3
        for <linux-sh@vger.kernel.org>; Tue, 06 Jan 2026 03:48:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXDnqdLyQpCHAGfuVfbiALkYUJyCaZ4YT8b970GEgEmtSU8Meb1URooRE19EoLe/vPUcktcp/L6tw==@vger.kernel.org
X-Received: by 2002:a05:6102:3588:b0:5db:d411:20cd with SMTP id
 ada2fe7eead31-5ec744a8304mr863867137.28.1767700102655; Tue, 06 Jan 2026
 03:48:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260101-custom-logo-v2-0-8eec06dfbf85@kernel.org> <20260101-custom-logo-v2-6-8eec06dfbf85@kernel.org>
In-Reply-To: <20260101-custom-logo-v2-6-8eec06dfbf85@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 6 Jan 2026 12:48:11 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVy48F5HAfqfJgbY83KDAztb9YWTqm8mT1ntTfj0311oA@mail.gmail.com>
X-Gm-Features: AQt7F2oMgVPDZ6yIPBL4v-hrcVUiy-32V0b_EbYL6M5HBMZvyW9vi5iymuHAylg
Message-ID: <CAMuHMdVy48F5HAfqfJgbY83KDAztb9YWTqm8mT1ntTfj0311oA@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] video/logo: move logo selection logic to Kconfig
To: Vincent Mailhol <mailhol@kernel.org>
Cc: Helge Deller <deller@gmx.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-m68k <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"

Hi Vincent,

CC linux-m68k

Thanks for your patch, which is now commit bd710b3da7308cb1
("video/logo: move logo selection logic to Kconfig") in fbdev/for-next.

On Thu, 1 Jan 2026 at 16:26, Vincent Mailhol <mailhol@kernel.org> wrote:
> Now that the path to the logo file can be directly entered in Kbuild,
> there is no more need to handle all the logo file selection in the
> Makefile and the C files.

This may do the wrong thing when booting a multi-platform kernel.

>
> The only exception is the logo_spe_clut224 which is only used by the
> Cell processor (found for example in the Playstation 3) [1]. This
> extra logo uses its own different image which shows up on a separate
> line just below the normal logo. Because the extra logo uses a
> different image, it can not be factorized under the custom logo logic.
>
> Move all the logo file selection logic to Kbuild (except from the
> logo_spe_clut224.ppm), this done, clean-up the C code to only leave
> one entry for each logo type (monochrome, 16-colors and 224-colors).
>
> [1] Cell SPE logos
> Link: https://lore.kernel.org/all/20070710122702.765654000@pademelon.sonytel.be/
>
> Signed-off-by: Vincent Mailhol <mailhol@kernel.org>

> --- a/drivers/video/logo/Kconfig
> +++ b/drivers/video/logo/Kconfig

> @@ -61,6 +63,12 @@ config LOGO_LINUX_CLUT224
>  config LOGO_LINUX_CLUT224_FILE
>         string "224-color logo .ppm file"
>         depends on LOGO_LINUX_CLUT224
> +       default "drivers/video/logo/logo_dec_clut224.ppm" if MACH_DECSTATION || ALPHA
> +       default "drivers/video/logo/logo_mac_clut224.ppm" if MAC

E.g. an m68k multi-platform kernel including Mac support will scare
non-Mac users into thinking their machine was assimilated by the
Apple Empire...

> +       default "drivers/video/logo/logo_parisc_clut224.ppm" if PARISC
> +       default "drivers/video/logo/logo_sgi_clut224.ppm" if SGI_IP22 || SGI_IP27 || SGI_IP32
> +       default "drivers/video/logo/logo_sun_clut224.ppm" if SPARC
> +       default "drivers/video/logo/logo_superh_clut224.ppm" if SUPERH
>         default "drivers/video/logo/logo_linux_clut224.ppm"
>         help
>           Takes a path to a 224-color logo in the portable pixmap file

> --- a/drivers/video/logo/logo.c
> +++ b/drivers/video/logo/logo.c
> @@ -48,59 +48,21 @@ const struct linux_logo * __ref fb_find_logo(int depth)
>         if (nologo || logos_freed)
>                 return NULL;
>
> -       if (depth >= 1) {
>  #ifdef CONFIG_LOGO_LINUX_MONO
> -               /* Generic Linux logo */
> +       if (depth >= 1)
>                 logo = &logo_linux_mono;
>  #endif
> -#ifdef CONFIG_LOGO_SUPERH_MONO
> -               /* SuperH Linux logo */
> -               logo = &logo_superh_mono;
> -#endif
> -       }
>
> -       if (depth >= 4) {
>  #ifdef CONFIG_LOGO_LINUX_VGA16
> -               /* Generic Linux logo */
> +       if (depth >= 4)
>                 logo = &logo_linux_vga16;
>  #endif
> -#ifdef CONFIG_LOGO_SUPERH_VGA16
> -               /* SuperH Linux logo */
> -               logo = &logo_superh_vga16;
> -#endif
> -       }
>
> -       if (depth >= 8) {
>  #ifdef CONFIG_LOGO_LINUX_CLUT224
> -               /* Generic Linux logo */
> +       if (depth >= 8)
>                 logo = &logo_linux_clut224;
>  #endif
> -#ifdef CONFIG_LOGO_DEC_CLUT224
> -               /* DEC Linux logo on MIPS/MIPS64 or ALPHA */
> -               logo = &logo_dec_clut224;
> -#endif
> -#ifdef CONFIG_LOGO_MAC_CLUT224
> -               /* Macintosh Linux logo on m68k */
> -               if (MACH_IS_MAC)

MACH_IS_MAC can be a runtime check.

> -                       logo = &logo_mac_clut224;
> -#endif
> -#ifdef CONFIG_LOGO_PARISC_CLUT224
> -               /* PA-RISC Linux logo */
> -               logo = &logo_parisc_clut224;
> -#endif
> -#ifdef CONFIG_LOGO_SGI_CLUT224
> -               /* SGI Linux logo on MIPS/MIPS64 */
> -               logo = &logo_sgi_clut224;
> -#endif
> -#ifdef CONFIG_LOGO_SUN_CLUT224
> -               /* Sun Linux logo */
> -               logo = &logo_sun_clut224;
> -#endif
> -#ifdef CONFIG_LOGO_SUPERH_CLUT224
> -               /* SuperH Linux logo */
> -               logo = &logo_superh_clut224;
> -#endif
> -       }
> +
>         return logo;
>  }
>  EXPORT_SYMBOL_GPL(fb_find_logo);

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
