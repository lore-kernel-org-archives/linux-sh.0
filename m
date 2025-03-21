Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653341F1527
	for <linux-sh@vger.kernel.org>; Fri, 21 Mar 2025 09:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742549810; cv=none; b=mdXPPv0pDlfx0CbSfv8M9M1DkJEI7MnvYxJNvY3jriZr0FJreKPa4eqbJGsnPeqvfs/kBmzwMtsy29oLQHfMdZTr4zkU8mC8DPxyy5CMCDunSYmL8XwCvvXcdbY8NsDlY7j+6sNuDynqk43CBnXW7MySCxXtLOmuF9XbOhTg/Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742549810; c=relaxed/simple;
	bh=/pOwpvz3SSNp8c5scminz/oXZnWulPynBd16kMIEiW8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BDNFh0crzEoruUEkhG23Dzi06XdsGtHred+58Fo9vDNsIR0x22sj/lKa9R5NCi4l2repA7MBZy/Oe7wbxRi46Btvnos5xRrP9d2Y1aVvSWFVuErzpKGTpq87XvVo8TnDRT3go967sw94M55k4foKskJPlIXnDRan6m5KN/y7AD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-523f1b31cf8so804597e0c.0
        for <linux-sh@vger.kernel.org>; Fri, 21 Mar 2025 02:36:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742549807; x=1743154607;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gpI2ZDWuq3G6Uk5QSQZYNIovPpchlt6ElQHUEbJygfM=;
        b=hyCr/JuRFI1hPjA0Iq/T4qR+7luug3aA7/iIMTaAVhLT7GKcDsgRJDFEVVvUVIh8DC
         0M5T1xBmDPYa5YwzGbF5pSh+D8Ax3WxIdClKWpu7SNbLyDViLQgw4RaVWr1qzrrgLbit
         DrEqqRc5Rn614qQai8CZReGj0cktnnqldpHIFJt834L00pT/pV8UPuv/LQzC/YLqFrSX
         Fsj3WQZ1E/Wni8dtGTjOyxYKYVHjJ4nYFa2Ra4mbH4Vi6MaMbnWtUB2Z2H3lShBC7Cgg
         YYAWQPkBmKYfm7XYsWQYnl+7IjTTOwn0obGpBBJHGjliBY80bi/aeH0n9ACaJU6fZEMU
         vImQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKnUiEiytp0o03LhFXv9AMuHDJNNGFmU+avk0mS+bGWVa9JkkfoJQ7QibTYCMYBRd2GbkOPbkEVQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyymLnOn4K5d4Qnq3OLR433Xbc5f2QnTqAFL5zrabPy/qunbKt1
	qdp8/KdpGC4E86maCb1FYZ+jWaKTPkoU7U30r42yLIAj8hHrtRBElGXQV+UN
X-Gm-Gg: ASbGncsX1/f30rPEvKgpwsb24sI+sDmgvb+BaRox3LAkChSewITN3sB9NyhGtLoD5O9
	8VY4rO9NxxY+SNXGUsbFRHBp5aawi+HqECtN0qLKyHCsl+qyn21r5NmLmH7OshNz4PZ1xld4jog
	Pffb2lUYxD/JVR+GstR3DIX5kNWyL+TKDRj6nD+324rVT74pNcGw2XgGCft/eQwTZyUpdXVDP3y
	w4P+6NJsuIFmfw596ZRgCbMHk33qnT4QiqB8gJ+l0Db6DyxbqUs5RJWl+gTFq3Enfq7AUnt1rzM
	90Owni/ZLG24DK7l9ZfsiyHB2EVKGe4g05421qs+sBLqfDb5u3u3jnXrPO9QdP1oNHkN9c6j/ue
	5JNcmpbx40bc=
X-Google-Smtp-Source: AGHT+IG0sq5Jwni+/k8bbYGn2ud08o0NHC53huzTAn/dHcCEgdOmWoN99BcqDZOWJ6AjYEsdZRAyyw==
X-Received: by 2002:a05:6122:3d47:b0:520:42d3:91c1 with SMTP id 71dfb90a1353d-525a856056emr2043282e0c.10.1742549806487;
        Fri, 21 Mar 2025 02:36:46 -0700 (PDT)
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com. [209.85.221.172])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-86f9f3857b0sm328074241.6.2025.03.21.02.36.46
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Mar 2025 02:36:46 -0700 (PDT)
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-51eb18130f9so881456e0c.3
        for <linux-sh@vger.kernel.org>; Fri, 21 Mar 2025 02:36:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVWddTAzo8s3DKqdej4+2tGuxQlltf1hmAYRP/NgMa/WE1nUc4h2XXkXmDinmB0gsoRSzuGN4hODQ==@vger.kernel.org
X-Received: by 2002:a05:6102:54a4:b0:4c1:8b8e:e9f7 with SMTP id
 ada2fe7eead31-4c50d4b370emr1929888137.8.1742549805933; Fri, 21 Mar 2025
 02:36:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202503211029.DnQpqsJs-lkp@intel.com> <927105f8-4aa8-4579-ac2e-bce4bce12b1e@app.fastmail.com>
In-Reply-To: <927105f8-4aa8-4579-ac2e-bce4bce12b1e@app.fastmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 21 Mar 2025 10:36:34 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUeynpmUUmZPViEBttANFmEhpjFn0wqNc1wQB6wRbd0rQ@mail.gmail.com>
X-Gm-Features: AQ5f1JqEvbttQ-lKLZf8npFjdUhrt-aqV_OwYka3KjE3DchYx8eW7jqUyLFbARM
Message-ID: <CAMuHMdUeynpmUUmZPViEBttANFmEhpjFn0wqNc1wQB6wRbd0rQ@mail.gmail.com>
Subject: Re: [soc:soc/drivers 20/24] ERROR: modpost: "__ffsdi2"
 [drivers/platform/cznic/turris-omnia-mcu.ko] undefined!
To: Arnd Bergmann <arnd@arndb.de>
Cc: kernel test robot <lkp@intel.com>, =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
	oe-kbuild-all@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	arm <arm@kernel.org>, linux-sh@vger.kernel.org, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"

Hi Arnd,

On Fri, 21 Mar 2025 at 09:41, Arnd Bergmann <arnd@arndb.de> wrote:
> On Fri, Mar 21, 2025, at 03:41, kernel test robot wrote:
> > First bad commit (maybe != root cause):
> >
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git
> > soc/drivers
> > head:   ba8755ab541fc629948233125db870d4dbf00a75
> > commit: ee7f8ed72990f28657b5bf598e695fcf4633f4ed [20/24] platform:
> > cznic: turris-omnia-mcu: Refactor requesting MCU interrupt
> > config: sh-allmodconfig
> > (https://download.01.org/0day-ci/archive/20250321/202503211029.DnQpqsJs-lkp@intel.com/config)
> > compiler: sh4-linux-gcc (GCC) 14.2.0
> > reproduce (this is a W=1 build):
> > (https://download.01.org/0day-ci/archive/20250321/202503211029.DnQpqsJs-lkp@intel.com/reproduce)
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new
> > version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes:
> > https://lore.kernel.org/oe-kbuild-all/202503211029.DnQpqsJs-lkp@intel.com/
> >
> > All errors (new ones prefixed by >>, old ones prefixed by <<):
> >
> > ERROR: modpost: "__delay" [drivers/net/mdio/mdio-cavium.ko] undefined!

Bug in driver (must not use __delay() directly).

> > ERROR: modpost: "devm_of_clk_add_hw_provider"
> > [drivers/media/i2c/tc358746.ko] undefined!
> > ERROR: modpost: "devm_clk_hw_register" [drivers/media/i2c/tc358746.ko]
> > undefined!
> > ERROR: modpost: "of_clk_hw_simple_get" [drivers/media/i2c/tc358746.ko]
> > undefined!

Missing dependencies for driver.

> >>> ERROR: modpost: "__ffsdi2" [drivers/platform/cznic/turris-omnia-mcu.ko] undefined!
>
> This comes from __bf_shf(spec) in omnia_mcu_request_irq().
>
> As far as I can tell, this is not your problem but in the
> SH architecture missing one of the libgcc functions that are
> called by gcc.
>
> Since this is only for compile-testing sh allmodconfig, and
> that is already broken because of other bugs, I'm not going
> to care either.
>
> Adding the linux-sh list to Cc, it would be nice to get a clean
> build again. All four problems should be trivial to address,
> and some of these have been broken for many years.

So one SH-specific issue to fix...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
