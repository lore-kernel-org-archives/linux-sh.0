Received: from mail-vk1-f195.google.com (mail-vk1-f195.google.com [209.85.221.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DF52F0C48
	for <linux-sh@vger.kernel.org>; Wed,  7 Jan 2026 10:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767782230; cv=none; b=CCu43LYDQqSQpQYMJz+2ruE65KqKWzRZc5JYJ4Gf8f4fpXnA96KJxsVc9eJrqUfiFfwQn613Z7LhwrP10sL9G+86S1O/95mM62Mn0IR0eeivNGNcrA40Nlxk2uPCUV1NabQlWen8epX1ScwdV+glDZr7xDBZz2+E6xqyGsbQLXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767782230; c=relaxed/simple;
	bh=GodLXSsnWrNdZeqyDmGiRErnjF0qHoHPpF4pgtaEMSQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n2iyVE5B08jDzapQ9JELgSvdVgFeveqZ5ou6Kv+iU49AqGebWTBTGYDDhw4TO01g5BY+Q/p3Zu2vl+dFkja1PRM2WnRiIgevRP/VkwGk5eG4OpgS2IJgCrZaFWVjM8WrnRdsVFiOoTD1ST8tP/wBapReUZJjFmt8ga/PBgLOzRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f195.google.com with SMTP id 71dfb90a1353d-55b22d3b2a6so536463e0c.1
        for <linux-sh@vger.kernel.org>; Wed, 07 Jan 2026 02:37:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767782227; x=1768387027;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QvR5DRwy1DSGr/ekGfe0RQqbV4Hkmy/mYDx8B3sEcoo=;
        b=BQBc2acyjP65gGIJpflF4Z3mQ70nSWw3xJFm/9H6G5mmUmPcSK1tYgX2VaO/X0qU+n
         2PHKF5RwJnXGTsZi94xT5X5o1r8nqGHHe4is+RTahS8KOMkGDLHnDWh4r86vjoUjzvV8
         C45mnqoHmaIkmyF7aEbxr4yA9Qp5uspUwFEEhdUyYVBLGs+zWbwwceYWqWYceNgIG1Rv
         DBatmPW5R2VLU4pFWN5bQAz5WTztRocB1btIgiXTdTmikzRtDpXGWE3IH/rtLpW8lJVo
         i3SeApbSe8OfAsm2iT+x+XjRagCuJJm041zJGSKOx7MvSBY0elku5enkwdoxqM7gXQ+u
         pisA==
X-Forwarded-Encrypted: i=1; AJvYcCW62LCdQqlhf+Ssbnk9Sumak0jGf9OVE8sFQ2m/E9sdhu4aWLXATMIR5BalBNMOFxufu6MP91lamg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwUP6nfVYm5pSgVMcvdwBiwZsYAB259eIFTfIoOY3OmjaBIFWzo
	TOQYMAKIMjP4z89OPDraiP8iVF+ZJHu+MWJahwopoiss3dUJ+lF5Rxk9xXYVxUhb
X-Gm-Gg: AY/fxX4XnubqCnK5A5wsQ5oLMEFxwOfUiPdi+hKxPxxZhrxBhNKrOkMmh4wFfyBfody
	GY8kNwjXXCP4qZQf8FKfA0lFCmgDA+06KpmiaXr2stCj0Oza+5CS8+nCa6jFudiVUuPUTUDugiu
	TSixKtkExYGneAZXWgM/A3ezAbEP7LBG9WZKLUXp2mFIAy56lpQdmS2B1TcmiqJF9VYhvbj+8Fn
	rC9tjgK9aku2HAiRAXr/9NhEZwWVQpKL23e3aaLekYid/9pzUYEGs6RjCTmZYysET1KfqD3paov
	vMSBh14kMgNCZPRQlDA3/qFQbJeA91mM0r3ZEMz7TMrj8alC4Hvchtp0D1ZWBA73uQQlYoliCz6
	DA5g2ASIFIWpAWnDQivJqcWZg0227dKHvbdvrc01GMZvBLoEt2CxPwp8zZHurhtVREpuA6JYvFM
	A92yjf8yyQlKig/ssDHgqQeKiLmHqiCbHGmZCWK6WS4wnfpjAitBpnrQytSXnpQQA=
X-Google-Smtp-Source: AGHT+IGj1uzKciiQw2EyqBrvtXG1LB7bRj+rwEwEj441Lugx2CArc4c2UQJmJK6NhRs6x236NCs92Q==
X-Received: by 2002:ac5:c252:0:b0:55e:4f9a:103f with SMTP id 71dfb90a1353d-56339ea0a47mr1385274e0c.8.1767782227561;
        Wed, 07 Jan 2026 02:37:07 -0800 (PST)
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com. [209.85.221.178])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-944124e906esm2226034241.14.2026.01.07.02.37.06
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jan 2026 02:37:07 -0800 (PST)
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-55b22d3b2a6so536450e0c.1
        for <linux-sh@vger.kernel.org>; Wed, 07 Jan 2026 02:37:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX5nk4yI9AZFQj+NsZ2XufsUxwQ4y90kxmbKM2C6RQ+vCEVmJkV6jFvXrp9FlsARQHa64M1ki7Xqw==@vger.kernel.org
X-Received: by 2002:ac5:ccaf:0:b0:54a:8deb:21a7 with SMTP id
 71dfb90a1353d-56339dbf03dmr1504773e0c.4.1767782226762; Wed, 07 Jan 2026
 02:37:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260101-custom-logo-v2-0-8eec06dfbf85@kernel.org>
 <20260101-custom-logo-v2-6-8eec06dfbf85@kernel.org> <CAMuHMdVy48F5HAfqfJgbY83KDAztb9YWTqm8mT1ntTfj0311oA@mail.gmail.com>
 <dda4052e-b843-43fa-850c-a1bb20e4a8e3@kernel.org>
In-Reply-To: <dda4052e-b843-43fa-850c-a1bb20e4a8e3@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 7 Jan 2026 11:36:54 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXz9uKxQ0dH68a+xt4FHqVgdskvO3QRvev1_Wq8h-a1Qg@mail.gmail.com>
X-Gm-Features: AQt7F2pWk5T5DK2Ps7GBdxmwjo6y5zM4oGY-k4cbzlgDPgVvKEzWy8YEHXjK3cA
Message-ID: <CAMuHMdXz9uKxQ0dH68a+xt4FHqVgdskvO3QRvev1_Wq8h-a1Qg@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] video/logo: move logo selection logic to Kconfig
To: Vincent Mailhol <mailhol@kernel.org>
Cc: Helge Deller <deller@gmx.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-m68k <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"

Hi Vincent,

On Tue, 6 Jan 2026 at 21:10, Vincent Mailhol <mailhol@kernel.org> wrote:
> On 06/01/2026 at 12:48, Geert Uytterhoeven wrote:
> > Thanks for your patch, which is now commit bd710b3da7308cb1
> > ("video/logo: move logo selection logic to Kconfig") in fbdev/for-next.
> >
> > On Thu, 1 Jan 2026 at 16:26, Vincent Mailhol <mailhol@kernel.org> wrote:
> >> Now that the path to the logo file can be directly entered in Kbuild,
> >> there is no more need to handle all the logo file selection in the
> >> Makefile and the C files.
> >
> > This may do the wrong thing when booting a multi-platform kernel.
> >
> >>
> >> The only exception is the logo_spe_clut224 which is only used by the
> >> Cell processor (found for example in the Playstation 3) [1]. This
> >> extra logo uses its own different image which shows up on a separate
> >> line just below the normal logo. Because the extra logo uses a
> >> different image, it can not be factorized under the custom logo logic.
> >>
> >> Move all the logo file selection logic to Kbuild (except from the
> >> logo_spe_clut224.ppm), this done, clean-up the C code to only leave
> >> one entry for each logo type (monochrome, 16-colors and 224-colors).
> >>
> >> [1] Cell SPE logos
> >> Link: https://lore.kernel.org/all/20070710122702.765654000@pademelon.sonytel.be/
> >>
> >> Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
> >
> >> --- a/drivers/video/logo/Kconfig
> >> +++ b/drivers/video/logo/Kconfig
> >
> >> @@ -61,6 +63,12 @@ config LOGO_LINUX_CLUT224
> >>  config LOGO_LINUX_CLUT224_FILE
> >>         string "224-color logo .ppm file"
> >>         depends on LOGO_LINUX_CLUT224
> >> +       default "drivers/video/logo/logo_dec_clut224.ppm" if MACH_DECSTATION || ALPHA
> >> +       default "drivers/video/logo/logo_mac_clut224.ppm" if MAC
> >
> > E.g. an m68k multi-platform kernel including Mac support will scare
> > non-Mac users into thinking their machine was assimilated by the
> > Apple Empire...
> >
> >> +       default "drivers/video/logo/logo_parisc_clut224.ppm" if PARISC
> >> +       default "drivers/video/logo/logo_sgi_clut224.ppm" if SGI_IP22 || SGI_IP27 || SGI_IP32
> >> +       default "drivers/video/logo/logo_sun_clut224.ppm" if SPARC
> >> +       default "drivers/video/logo/logo_superh_clut224.ppm" if SUPERH
> >>         default "drivers/video/logo/logo_linux_clut224.ppm"
> >>         help
> >>           Takes a path to a 224-color logo in the portable pixmap file
> >
> >> --- a/drivers/video/logo/logo.c
> >> +++ b/drivers/video/logo/logo.c
> >> @@ -48,59 +48,21 @@ const struct linux_logo * __ref fb_find_logo(int depth)
> >>         if (nologo || logos_freed)
> >>                 return NULL;
> >>
> >> -       if (depth >= 1) {
> >>  #ifdef CONFIG_LOGO_LINUX_MONO
> >> -               /* Generic Linux logo */
> >> +       if (depth >= 1)
> >>                 logo = &logo_linux_mono;
> >>  #endif
> >> -#ifdef CONFIG_LOGO_SUPERH_MONO
> >> -               /* SuperH Linux logo */
> >> -               logo = &logo_superh_mono;
> >> -#endif
> >> -       }
> >>
> >> -       if (depth >= 4) {
> >>  #ifdef CONFIG_LOGO_LINUX_VGA16
> >> -               /* Generic Linux logo */
> >> +       if (depth >= 4)
> >>                 logo = &logo_linux_vga16;
> >>  #endif
> >> -#ifdef CONFIG_LOGO_SUPERH_VGA16
> >> -               /* SuperH Linux logo */
> >> -               logo = &logo_superh_vga16;
> >> -#endif
> >> -       }
> >>
> >> -       if (depth >= 8) {
> >>  #ifdef CONFIG_LOGO_LINUX_CLUT224
> >> -               /* Generic Linux logo */
> >> +       if (depth >= 8)
> >>                 logo = &logo_linux_clut224;
> >>  #endif
> >> -#ifdef CONFIG_LOGO_DEC_CLUT224
> >> -               /* DEC Linux logo on MIPS/MIPS64 or ALPHA */
> >> -               logo = &logo_dec_clut224;
> >> -#endif
> >> -#ifdef CONFIG_LOGO_MAC_CLUT224
> >> -               /* Macintosh Linux logo on m68k */
> >> -               if (MACH_IS_MAC)
> >
> > MACH_IS_MAC can be a runtime check.
>
> OK. I missed this.
>
> I think there are two options to fix this:
>
>   1. Keep CONFIG_LOGO_MAC_CLUT224 untouched
>   2. Remove logo_mac_clut224.ppm
>
> The first option is less controversial but I would like to ask you what
> you think about removing the logo_mac_clut224 file.
>
> Here, we are speaking of the Macintosh 68k which ended sales in 1995,
> right? So the user base should be rather small, I guess.

Yes, the user base is small.

BTW, the only reason you don't have this issue with MACH_DECSTATION and
the various SGI_IP* options is that MIPS does not support multi-platform
kernels.

> And people who still want the custom MAC logo would still be able to add
>
>   CONFIG_LOGO_MAC_CLUT224="path/to/logo_mac_clut224.ppm"

LOGO_LINUX_CLUT224_FILE ;-)

> to their config to restore the old behaviour anyway.
>
> My choice would go more toward the removal option but what do you think?

I am not too attached to keeping the dynamic behavior for the Mac logo,
I just wanted to point out the impact.
I expect most people who care about logos (in products) just have their
own custom out-of-tree code.  As fb_find_logo() and the underlying
infrastructure still exists, I don't expect them to have too much
trouble forward porting that to newer kernels.

What do other people think?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
