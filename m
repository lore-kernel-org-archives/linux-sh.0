Received: from mail-vk1-f195.google.com (mail-vk1-f195.google.com [209.85.221.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF9D31ED61
	for <linux-sh@vger.kernel.org>; Wed,  7 Jan 2026 13:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767794002; cv=none; b=ND6xryGlKjK3fVy3vfLFzKlR/taqrxPIxeANEji3NYH1kq+eGQ7IqEedueaEAc1Kx1HBYGevsJ51vFJcY4W+8cdsu1LOv5Se8X6fdGTqxyMP0fbZXh5UQGFHOp69fwcdc8RMTJrWVTKg8PFcRRXGgKmX/OLKaUjn7X1yQcVQLzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767794002; c=relaxed/simple;
	bh=V20kFfbnDfFMAsOpR/V2++b5E9prZcOxV6CNuCyeRTQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CHZMAWE68OSXaDAaTesBvj5mBKHzm5er4C7yPm9dbdkMkJMjPJlt/0r99lfUVivRkf5FhjPKezi5Pr1zz3TJDJcC7WIy4PPDik0aDAHNZG00TeIOuwc4mBq3wryG/EpsO99Wjua8D5YyusmF2YCx58PLC0R1/6LU36xpKzarIwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f195.google.com with SMTP id 71dfb90a1353d-55b6a66f155so841495e0c.3
        for <linux-sh@vger.kernel.org>; Wed, 07 Jan 2026 05:53:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767793998; x=1768398798;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vycy5U/9AuJWYCD1lBGFTu2izKl734E+hv0jo2cmLag=;
        b=ZAfb8jIKHQ5JFerv4WlKYUlkp+P9sCJKz5+1aH8IU3Yaik2Ng1Cvh1vMm8ZX8I4MDM
         pyMdJOUD571PjsuKUPRXb64+wxORaJmOnfYNXUE5+LMRkd1xlYD87OYdNczXn9eRrWXF
         BmW5Nv3XeBXwmc/Jyw9SgmxYEzTWB7wgcvxDp0Dk1SgGv5pT/AQrLDhFhVJb64Dx0pu9
         J7WHbKzOB1VDvy0LT820iuEkgNE5qQZOGGa4KHiRcOI2BJF8ylzm9sCuMwwhK+aGTzYu
         nQDVEvzAK958xrFZQXhdTekk6O6qGOdmEZCQdERirflsHbXvHxxxMYVjrkdvOPs8HN8L
         UVWA==
X-Forwarded-Encrypted: i=1; AJvYcCV/ll7k66Cf8ZYDVmVM1CtnoImj7jek+v3UimtuSOt2y51qfGK/tPTYBigNA8MEGuD4QyFU+5kZlA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyjEEwZ6/w0Uct4GJMcB+pvI8id1ZS2Jppnj6+H8BtgKYpPu3JN
	SFXVhiKYSd9wswUO1r7y/Z9fUsmmzd+dsz+NxTzcxcj8dkJ8PuYKnq3kmWqx4I5c
X-Gm-Gg: AY/fxX7jXacAuBOqqn7y/aIu8q5rIJdWbDwXpgldxexQzyGi6NPhm8t7ugflDrg0Fh7
	r+9n62ppTROf4aQ6VBm3dhs6FAh8cnfSjgvWqe6URF0XSvKEoUSG1RT1/B/h0+yGYi083myYDp0
	TaTL9PGv3ZlzStu3gMjFi9JMD6QePgGU42fzT3nejC3PV/4FMmkMsC9364XlXBdPNTzzvXRVwfg
	IVMSd1kHTnFkcCgxjtZUkxE/K1GfRV0AE3Q1FAtBDLhrgIHdCpSuJOkbKzGaCyXpspqPwx28HaK
	stV7buJbE4eNK2/m2+qWLCY7wzBDWdpRHWpnPE6YadOxzqseEljaEkHZinDWPctrP8uwzRpxcUQ
	07D5tvQSLBNnXUiB9LPvGOd9obaB00VUOrSjMfT9DNwRv6rDxNj8MyBV8qZ6sDtd5uoZT8T1EIN
	OIPwMR/SGTYDXUD4Et02HpUN6aKxr/zCj64lzkms/ouK+PtSVj
X-Google-Smtp-Source: AGHT+IFIAlF0yteQL+WdpyyTUqDigTdSE/PwctExod9t7SH09HskRIds9v99Kal4dFaPO6PrtSthxw==
X-Received: by 2002:a05:6122:6b08:b0:563:4a88:6ea5 with SMTP id 71dfb90a1353d-5634a8870f2mr657768e0c.5.1767793998056;
        Wed, 07 Jan 2026 05:53:18 -0800 (PST)
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com. [209.85.222.42])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5633a209b30sm2958723e0c.8.2026.01.07.05.53.17
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jan 2026 05:53:17 -0800 (PST)
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-93f69720a7cso1285328241.1
        for <linux-sh@vger.kernel.org>; Wed, 07 Jan 2026 05:53:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVVrZZdmnMTX5Fc2gw6d4WojTbRGLS6cYlEKwGk9fLTFP6a6eRgb0Bh1gF2udjoTHzZlueoT96x/Q==@vger.kernel.org
X-Received: by 2002:a05:6102:548b:b0:5db:cec7:810b with SMTP id
 ada2fe7eead31-5ecb6904d1cmr977705137.29.1767793997513; Wed, 07 Jan 2026
 05:53:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260101-custom-logo-v2-0-8eec06dfbf85@kernel.org>
 <20260101-custom-logo-v2-6-8eec06dfbf85@kernel.org> <CAMuHMdVy48F5HAfqfJgbY83KDAztb9YWTqm8mT1ntTfj0311oA@mail.gmail.com>
 <dda4052e-b843-43fa-850c-a1bb20e4a8e3@kernel.org> <CAMuHMdXz9uKxQ0dH68a+xt4FHqVgdskvO3QRvev1_Wq8h-a1Qg@mail.gmail.com>
 <487ac672-3a2e-4897-aaba-7ae44bcf341a@gmx.de>
In-Reply-To: <487ac672-3a2e-4897-aaba-7ae44bcf341a@gmx.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 7 Jan 2026 14:53:06 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUqHUrg6XwqXCSwv-3TwiYUOfbBMpMiuS89d1uwChBYaQ@mail.gmail.com>
X-Gm-Features: AQt7F2r20-H4V61D0OQVUYmKrX0oHF-Wf_klXq13jKUBCAwI3lTwG7W_lz7xlEY
Message-ID: <CAMuHMdUqHUrg6XwqXCSwv-3TwiYUOfbBMpMiuS89d1uwChBYaQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] video/logo: move logo selection logic to Kconfig
To: Helge Deller <deller@gmx.de>
Cc: Vincent Mailhol <mailhol@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-m68k <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"

Hi Helge,

On Wed, 7 Jan 2026 at 13:21, Helge Deller <deller@gmx.de> wrote:
> On 1/7/26 11:36, Geert Uytterhoeven wrote:
> > On Tue, 6 Jan 2026 at 21:10, Vincent Mailhol <mailhol@kernel.org> wrote:
> >> On 06/01/2026 at 12:48, Geert Uytterhoeven wrote:
> >>> Thanks for your patch, which is now commit bd710b3da7308cb1
> >>> ("video/logo: move logo selection logic to Kconfig") in fbdev/for-next.
> >>>
> >>> On Thu, 1 Jan 2026 at 16:26, Vincent Mailhol <mailhol@kernel.org> wrote:
> >>>> Now that the path to the logo file can be directly entered in Kbuild,
> >>>> there is no more need to handle all the logo file selection in the
> >>>> Makefile and the C files.
> >>>
> >>> This may do the wrong thing when booting a multi-platform kernel.
> >>>
> >>>>
> >>>> The only exception is the logo_spe_clut224 which is only used by the
> >>>> Cell processor (found for example in the Playstation 3) [1]. This
> >>>> extra logo uses its own different image which shows up on a separate
> >>>> line just below the normal logo. Because the extra logo uses a
> >>>> different image, it can not be factorized under the custom logo logic.
> >>>>
> >>>> Move all the logo file selection logic to Kbuild (except from the
> >>>> logo_spe_clut224.ppm), this done, clean-up the C code to only leave
> >>>> one entry for each logo type (monochrome, 16-colors and 224-colors).
> >>>>
> >>>> [1] Cell SPE logos
> >>>> Link: https://lore.kernel.org/all/20070710122702.765654000@pademelon.sonytel.be/
> >>>>
> >>>> Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
> >>>
> >>>> --- a/drivers/video/logo/Kconfig
> >>>> +++ b/drivers/video/logo/Kconfig
> >>>
> >>>> @@ -61,6 +63,12 @@ config LOGO_LINUX_CLUT224
> >>>>   config LOGO_LINUX_CLUT224_FILE
> >>>>          string "224-color logo .ppm file"
> >>>>          depends on LOGO_LINUX_CLUT224
> >>>> +       default "drivers/video/logo/logo_dec_clut224.ppm" if MACH_DECSTATION || ALPHA
> >>>> +       default "drivers/video/logo/logo_mac_clut224.ppm" if MAC
> >>>
> >>> E.g. an m68k multi-platform kernel including Mac support will scare
> >>> non-Mac users into thinking their machine was assimilated by the
> >>> Apple Empire...

> >>>> --- a/drivers/video/logo/logo.c
> >>>> +++ b/drivers/video/logo/logo.c

> >>>> -#ifdef CONFIG_LOGO_MAC_CLUT224
> >>>> -               /* Macintosh Linux logo on m68k */
> >>>> -               if (MACH_IS_MAC)
> >>>
> >>> MACH_IS_MAC can be a runtime check.
> >>
> >> OK. I missed this.
> >>
> >> I think there are two options to fix this:
> >>
> >>    1. Keep CONFIG_LOGO_MAC_CLUT224 untouched
> >>    2. Remove logo_mac_clut224.ppm
> >>
> >> The first option is less controversial but I would like to ask you what
> >> you think about removing the logo_mac_clut224 file.
> >>
> >> Here, we are speaking of the Macintosh 68k which ended sales in 1995,
> >> right? So the user base should be rather small, I guess.
> >
> > Yes, the user base is small.
> >
> > BTW, the only reason you don't have this issue with MACH_DECSTATION and
> > the various SGI_IP* options is that MIPS does not support multi-platform
> > kernels.
> >
> >> And people who still want the custom MAC logo would still be able to add
> >>
> >>    CONFIG_LOGO_MAC_CLUT224="path/to/logo_mac_clut224.ppm"
> >
> > LOGO_LINUX_CLUT224_FILE ;-)
> >
> >> to their config to restore the old behaviour anyway.
> >>
> >> My choice would go more toward the removal option but what do you think?
> >
> > I am not too attached to keeping the dynamic behavior for the Mac logo,
> > I just wanted to point out the impact.
> > I expect most people who care about logos (in products) just have their
> > own custom out-of-tree code.  As fb_find_logo() and the underlying
> > infrastructure still exists, I don't expect them to have too much
> > trouble forward porting that to newer kernels.
> >
> > What do other people think?
>
> This is about a small visible icon. It's not some relevant feature.
> So, I think it's unfortunate that the patch then drops the specific mac logo.
> But adding additional coding and complexity to simply make this logo
> visible for such a small user base IMHO does not justify the effort.

This patch does not drop the specific Mac logo.
Instead, it prioritizes the Mac logo over the generic logo when Mac
support is enabled in a multi-platform kernel.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
