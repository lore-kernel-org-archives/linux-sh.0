Received: from mail-ua2-f29.google.com (mail-ua2-f29.google.com [74.125.226.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC0136402D
	for <linux-sh@vger.kernel.org>; Mon, 28 Sep 2026 18:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.226.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790620493; cv=none; b=dbH/LlZYffda92P7fFVttpuyvcWONegf4NXqa2731y7nRK2ECWkWy2PR/D7l+RWWHs50Y7K2YU1zL10FzLGxfE6jsLlUCoosg5xRVNHmLie5xKxJBteHvh4gVjvJ7lrY9k8X/fpu326XlLiNzQgcycjNJqVW2EiIAeoVgHsYANg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790620493; c=relaxed/simple;
	bh=XLItMJPdAx0hBKSEVX164+vsLvrIEiEGfT05Ltl1XnI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VwxGYpGbou07B7v+WXP7QCzjDPi5VEard3t2oClxAm49363qY/PzzG+GNDuwiOhyo/3nmlxgfggqeCWeW+tAvtNWO98deWnd2lNp/BOT4ilcvyWjjLcWgWzmBSL8Z87sbQyV0AfxAaRM2cFK0CymqM79OFw+6+CmSxBAs9cxaqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.226.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua2-f29.google.com with SMTP id a1e0cc1a2514c-988bb9d055bso25662241.0
        for <linux-sh@vger.kernel.org>; Mon, 28 Sep 2026 11:34:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790620490; x=1791225290;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Dao+KgMYeGslshjBh6bHUN/qsnnMh5dXTPRbot4HOPo=;
        b=C3U8XdCRNVGExzKOOal4rpMEhncqPGx+wvbGlQGYks734Lt2mxV9ogYvyOqQ9lopZL
         JdcPpRRXM4+JT4cVzAhamCH3u1s7OctwlEw8xjqrUTllflAGmQRj8LYvy+rDb3VOITwd
         Uf/0fdcdXUTcRRbkKyVsdAd56J47Zm4sNGhF2ALIyCArLKK5mpCEjjwRf9LjD38PsKoI
         3W102kv0IZwpTAi1h/z036Sm6yqrtMKCTQMbbm6yE2+WulZqehF7fNm6hRKO+G32i6Tm
         VaHqQ39JG8HiEV5u6gAvYTN/c6Qanf4dfn8R0TyFz/IuMKJ9Bac6LIhZmB2Mx9iCAuNt
         c6ow==
X-Forwarded-Encrypted: i=1; AKwUvBxu5aX2AJZwtZfyLn7Qi0r6NJAfLTDcfS9T7jzRZBxDlPygNrBiQElnY2w+1hptxSE4phP1ghQE2w==@vger.kernel.org
X-Gm-Message-State: AFq9FYLwP1lbEfhLKEhOuq0pJYQKkDZoMQ+nX2lRc6K6s6zC1oNIOuaI
	qh3q3nIB1YQQ6ennLSuFQ751LdjRRvSog2Rp2Qt/T3r3DPpFn2N+OHP1/3G9n3J41lk=
X-Gm-Gg: AYBFou1ovF0hneqdS7TQXBwB41O4Z3u/uCEh7SVmlR1McPs2g5mQV+b/H9qvHyhU81K
	+XOMqNswCCoYsjNqPX7e9aoCNqiUjCYBlwiqOBr+XIF039coB4GfbIMMBOE60FjnHOy78hx84cz
	KTSWBstUMbH+nVgR6o6gZp8g4/xG929JL6onW/nc5b+pCiWxAVaCELKrNy/B5jfNV6ThAEY7oOH
	62oitTVPNzMZqdD3B6Ic2YzDAQCsaN4StrFWExTG3gMU+acyhw4kXBfG2vSLoSG5CMY8nXXYyu0
	8FzTKG/gevKizTWIOFXqYX9KFPqSJVCGrwVfsLEuqFps5E2WXHwG2em1gw1LMjfONP5EqeGtEAV
	YHevzCH0NdKdlLaCHxlICXXvN/rhDQfwplb//Jl8Tsz0TlRwZVWlb6n5yqvSJroIEIzZEMULcBo
	KepvPQPyf53DKQrz9vf81oqLSAEXLefGxNfWL8Jl6QHxzqJOVNV9v5wx8S1c5SWQvMmbH3Prxm9
	XGX8Ho145Fi0pxYqciMBhzMTuF+5+g9gMZGeQ==
X-Received: by 2002:a05:6102:8695:20b0:7b8:1812:9b9a with SMTP id ada2fe7eead31-7b81812a717mr723836137.20.1790620490305;
        Mon, 28 Sep 2026 11:34:50 -0700 (PDT)
Received: from mail-ua2-f29.google.com (mail-ua2-f29.google.com. [74.125.226.221])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7b39bcb1f14sm10053384137.10.2026.09.28.11.34.49
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2026 11:34:49 -0700 (PDT)
Received: by mail-ua2-f29.google.com with SMTP id a1e0cc1a2514c-988bb9d055bso25642241.0
        for <linux-sh@vger.kernel.org>; Mon, 28 Sep 2026 11:34:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzCACFgxjcmlb9HMHFPOifTfvzxy9ymBvWe7ftx55wJfjlTIsZAbZ8MZV3X20PMSBlT26fc86gs4Q==@vger.kernel.org
X-Received: by 2002:a05:6102:5491:b0:7af:8089:2734 with SMTP id
 ada2fe7eead31-7b79926dc9fmr1139598137.27.1790620488844; Mon, 28 Sep 2026
 11:34:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260927191359.6144-1-kmehltretter@gmail.com> <d4f35d5001924ef9ff4b28ac412a9d4b6048d789.camel@physik.fu-berlin.de>
 <CAMuHMdVRznzGdRwZOHa3=cxhoDNBh1kJqGUoBHqowgj_nzKCRg@mail.gmail.com>
 <ed4f818f00df446df53a9168054bee1a9a993409.camel@physik.fu-berlin.de>
 <CAMuHMdW=amt+3ej6+i5TMaO6VUKJt3qqYvSWctFtSt8Tttrk2g@mail.gmail.com> <cdb4898094f152eb617ea353c0780e7fbb000659.camel@physik.fu-berlin.de>
In-Reply-To: <cdb4898094f152eb617ea353c0780e7fbb000659.camel@physik.fu-berlin.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 28 Sep 2026 20:34:36 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVw+-V5OKgRugm2Jz+S=0dOD7hi1p-U=Fzmh3piCOkE3Q@mail.gmail.com>
X-Gm-Features: AclHuK9bbUIKcZF4zgbW3tRGKzYbZJEfzpLse2uaWdPoVWd3lVPNeO1ic2feMew
Message-ID: <CAMuHMdVw+-V5OKgRugm2Jz+S=0dOD7hi1p-U=Fzmh3piCOkE3Q@mail.gmail.com>
Subject: Re: [PATCH] sh: intc: sort the prio and sense lists after filling them
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Karl Mehltretter <kmehltretter@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Adrian,

On Mon, 28 Sept 2026 at 19:21, John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> On Mon, 2026-09-28 at 19:00 +0200, Geert Uytterhoeven wrote:
> > On Mon, 28 Sept 2026 at 18:46, John Paul Adrian Glaubitz
> > <glaubitz@physik.fu-berlin.de> wrote:
> > > On Mon, 2026-09-28 at 18:03 +0200, Geert Uytterhoeven wrote:
> > > > On Mon, 28 Sept 2026 at 17:10, John Paul Adrian Glaubitz
> > > > <glaubitz@physik.fu-berlin.de> wrote:
> > > > > => usb reset; fatload usb 0:1 0x89000000 uImage-7.3.0.gz ; pmb ; bootm
> > > > > (Re)start USB...
> > > > > USB0:   scanning bus 0 for devices... 2 USB Device(s) found
> > > > >        scanning usb for storage devices... 1 Storage Device(s) found
> > > > > reading uImage-7.3.0.gz
> > > > > 3649306 bytes read in 2074 ms (1.7 MiB/s)
> > > > > ## Booting kernel from Legacy Image at 89000000 ...
> > > > >    Image Name:   Linux-7.3.0-rc5-00001-g8cd915e93
> > > > >    Image Type:   SuperH Linux Kernel Image (gzip compressed)
> > > > >    Data Size:    3649242 Bytes = 3.5 MiB
> > > > >    Load Address: 8c010000
> > > > >    Entry Point:  8c011000
> > > > >    Verifying Checksum ... OK
> > > > >    Uncompressing Kernel Image ... OK
> > > > >
> > > > > I also never understood why the load address I used at the u-boot prompt
> > > > > differed from the one that the uImage build process showed at the end of
> > > > > the kernel build:
> > > > >
> > > > >   GZIP    arch/sh/boot/vmlinux.bin.gz
> > > > >   UIMAGE  arch/sh/boot/uImage.gz
> > > > > Image Name:   Linux-7.3.0-rc5-00002-g02d53450e
> > > > > Created:      Mon Sep 28 14:56:15 2026
> > > > > Image Type:   SuperH Linux Kernel Image (gzip compressed)
> > > > > Data Size:    3649249 Bytes = 3563.72 KiB = 3.48 MiB
> > > > > Load Address: 8c010000
> > > > > Entry Point:  8c011000
> > > > >   Image arch/sh/boot/uImage is ready
> > > > >
> > > > > Any idea?
> > > >
> > > > 0x89000000 is the address where you load the uImage.
> > > > 0x8c010000 is the address where the unpacked kernel image will be
> > > > stored.
> > > >
> > > > The latter comes from your kernel config:
> > > >
> > > >     arch/sh/boot/Makefile:UIMAGE_LOADADDR = $(KERNEL_LOAD)
> > > >     arch/sh/boot/Makefile:UIMAGE_ENTRYADDR = $(KERNEL_ENTRY)
> > > >
> > > > It's similar on ARM platforms that (still) use uImage.
> > >
> > > The thing is that it stopped working after 6.5.0 and I never figured
> > > out why. I did test all kinds of changes and it just never worked
> > > again while pre 6.5.0 kernels work just fine.
> >
> > Have you tried to bisect it?
>
> Yes, I did. I did not manage to find the commit that caused it.

Perhaps a size limitation? Your kernel image is flirting with 4 MiB.
Perhaps a config issue? The safest way to preserve your config for
bisection is:

    cp .config arch/sh/configs/bisect_defconfig

and to run "make bisect_defconfig" in each bisection step.

> Maybe Karl has an idea. This image is known to work [1]:
>
> glaubitz@suse-laptop:~> file uImage-git.gz
> uImage-git.gz: u-boot legacy uImage, Linux-6.5.0-rc2, Linux/SuperH, OS Kernel Image (gzip), 4416616 bytes, Mon Jul 17 14:17:35 2023, Load Address: 0X80001000, Entry Point: 0X80002000, Header CRC:
> 0XBA69203A, Data CRC: 0XD097D603
> glaubitz@suse-laptop:~>
>
> It boots fine with:
>
> usb reset ; fatload usb 0:1 0x89000000 uImage-git.gz ; pmb ; bootm

Do you have a config for that kernel?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
