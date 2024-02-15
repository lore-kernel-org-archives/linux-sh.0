Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883E5433B9
	for <linux-sh@vger.kernel.org>; Thu, 15 Feb 2024 14:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708008851; cv=none; b=msiLj8mc7GBNVmyhW0T8vLK8hXJ0JpqeKeSPMJI8eVq9vM5wjY9TDCdfXBZTf3BqXAtFj9KgZDpE5I1u2NmK2J/HUHD7Ir9MPb0wUNO61ibmh1Hv/Niq6skrGW+ARyXd2hNXUt57EQvTxdhbHv1cSVeLV0SluwEQIWHRszdsCWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708008851; c=relaxed/simple;
	bh=5wIS/56aIuobFKSUt03EcJoBfAeE+hNNRkN/bRWpsLc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kO43QXL7nyDEU682ilLA/Z8wsnbyiFd2Q3VBYOYpk9m4OP7Qz9+nCQl5Xi+WED4B2z/FXWaeQ+cGKqQ22zHfjpOVUEkb0Wn/dGZECMrOL4jfUIC9N4Qw9RYspoRElt8t7rOMMPFq6HOYCrD0pKIlbkiQpakUDXPJ4P8v6Li278Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-60782336a3aso7600617b3.2
        for <linux-sh@vger.kernel.org>; Thu, 15 Feb 2024 06:54:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708008848; x=1708613648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tv8W02IwoAGjajQhC8ew+i9EdxhvajI92aHSXZwEPIQ=;
        b=Mw/Gcv/j5dBpoNj5nh0ZirYzYJdLnAh8HuW3SgBb9IGFfaeXnUpl28nUlrm1Y0z/Fu
         nkm+/p37MNBcLVsYEjoalxFw5uv/2u4m8Xoa2a4bMg3Km7gQ/yAYF99BNw2Eh/vygJxj
         6gSeyAIb4HhV+glgZ39kBiCP5xFz9W9W9fEZj9Ir1eSS+ybSDArDnr/f1NfKYobLHj9E
         wY/BFMKJmrFJvO7onVYcUZgrBgExg0NhJsbztlMgS7/o1W92UIbKg+xHSFnBT90letxj
         pMIAA2jtG5YpmUSq99aEmebE+qc+KshBqYNq1ZzIOjnJfUG+UveV0k/OufDTHbZtEQoE
         9v1g==
X-Forwarded-Encrypted: i=1; AJvYcCXkSZuJG+j9RAEXRdK4yooVZCyWzoQccFW9bqFPoFszhvyl16rjmB6OuzEBDhx7B27ahlTIiL6VPeHpLntN9+2eWd2TkhzGKhI=
X-Gm-Message-State: AOJu0Ywkbh8GEjL6eLh4nZb8gJoqKrrW2ZznKjBj2qQmFtKoCaIV4xiT
	TIJm/9E7dggUE0ghu5IRwYtZ05fKkPsGDUoJAlDmWOoMsjYERpH0VBkdl+FEFE1fUg==
X-Google-Smtp-Source: AGHT+IH+WT+JMIwb2GhXT+JR9S2cQjRWEj1QuRW920sFqutx5OmK2ycA3RwzFa6++beAylT176Ke5A==
X-Received: by 2002:a0d:d842:0:b0:607:8057:dec9 with SMTP id a63-20020a0dd842000000b006078057dec9mr2131416ywe.7.1708008848125;
        Thu, 15 Feb 2024 06:54:08 -0800 (PST)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id j127-20020a0df985000000b0060499a24901sm270439ywf.92.2024.02.15.06.54.07
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 06:54:07 -0800 (PST)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-60792653b94so9520747b3.3
        for <linux-sh@vger.kernel.org>; Thu, 15 Feb 2024 06:54:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWoF/XvXIURC+Mggd+PHdOwnXip0V9Hj0nylwVDFLK1OYazIVEe1evds80UUDIPNdhSugcnRgcj1D2tffUcF0gEwwMwUeY8p40=
X-Received: by 2002:a81:6d48:0:b0:607:cefd:3bdf with SMTP id
 i69-20020a816d48000000b00607cefd3bdfmr1899039ywc.24.1708008847633; Thu, 15
 Feb 2024 06:54:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2d8878fa-c990-e187-9040-934cce908e7c@landley.net> <20240215134941.GE4163@brightrain.aerifal.cx>
In-Reply-To: <20240215134941.GE4163@brightrain.aerifal.cx>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 15 Feb 2024 15:53:53 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVczQMiyDkhgAd4G6Zrmw7-pBYMnDvVn18vxd-3CSsSaA@mail.gmail.com>
Message-ID: <CAMuHMdVczQMiyDkhgAd4G6Zrmw7-pBYMnDvVn18vxd-3CSsSaA@mail.gmail.com>
Subject: Re: [musl] FDPIC on sh4?
To: Rich Felker <dalias@libc.org>
Cc: Rob Landley <rob@landley.net>, Linux-sh list <linux-sh@vger.kernel.org>, 
	musl <musl@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Rich,

On Thu, Feb 15, 2024 at 2:49=E2=80=AFPM Rich Felker <dalias@libc.org> wrote=
:
> On Thu, Feb 15, 2024 at 04:31:00AM -0600, Rob Landley wrote:
> > Is there any easy way to build FDPIC support for sh4 with-mmu? In theor=
y ARM can
>
> On the userspace toolchain and musl side, yes, I see no reason you
> shouldn't be able to build musl for sh4 with fdpic ABI or build a
> toolchain for sh4 that defaults to fdpic and has fdpic target-libs. I
> just tested passing -mfdpic to sh4-linux-musl-gcc and it seems to
> produce correct fdpic code.
>
> On the kernel side, I'm not sure, but the normal ELF loader should be
> able to load fdpic binaries on a system with mmu. It will not float
> the data segment separately from text, but doesn't need to because it
> has an mmu. If this is no longer working it's a kernel regression;
> that's how I always tested sh2eb fdpic binaries on qemu-system-sh4eb.
>
> > do it, so I tried editing the kconfig BINFMT_ELF_FDPIC dependencies in
> > fs/Kconfig.binfmt to move "SUPERH" out of the !MMU list and put it next=
 to ARM,
> > switched on the FDPIC loader, and the build broke with:
> >
> > fs/binfmt_elf_fdpic.o: in function `load_elf_fdpic_binary':
> > binfmt_elf_fdpic.c:(.text+0x1b44): undefined reference to
> > `elf_fdpic_arch_lay_out_mm'
>
> It looks like there's an arch-provided function that's conditional on
> !MMU in arch/sh but that, now that fdpic loader is intended to be
> supported on mmu-ful systems, should be changed to be conditional on
> fdpic support (or maybe even unconditional if fdpic can be loaded as a
> module). Just look for where it's defined in arch/sh. If it's in a
> nommu-specific file it might need to be moved somewhere more
> appropriate, or an mmu-ful variant may need to be written and placed
> somewhere more appropriate.

ARM is the sole architecture that provides elf_fdpic_arch_lay_out_mm().

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
