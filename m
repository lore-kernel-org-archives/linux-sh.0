Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A006C38385;
	Fri, 23 Aug 2024 13:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724418838; cv=none; b=UdnlI5qC5QUavv3jlxPtssKQvvyF37g97V02+u1fpXLWcqcHa4MRspg3HvpyA79EUMqBo6e7xgyphJkUSMes19ojbWnN/96ff+XZy4mF67deDT1s3xOqWDu9tJN9RQbxC9h7//1pIhHBovjNSyOAbKbGKm1581a6MfbMYBVm+AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724418838; c=relaxed/simple;
	bh=IGwpQrOhAHosB3TI8YDf+T5PFrlozjZ8OIrkLEB/Kyc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mEpVoryfEWlJhWrv7jC0kDH2FWUD02XKo02WcMKuwFAtkhkiBuH+k2wIHq6xqi/X/fDJzzhbppPsEnqGnlQfZLjSsgrrMHptzY/cQFkyMwgb1WHYzypQ6/cdaIeEjRf7SgPiCKPNGLJxXJjpQbErrhPlWSIES6U6d+EOjfEbBBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e1633202008so1971445276.2;
        Fri, 23 Aug 2024 06:13:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724418835; x=1725023635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VRXshE5FXx/w57L6jYhRTv5oTpv9rEAiuwveGGFv1n8=;
        b=saEAmYwEtWCSBACjoPFkYjOilehsoJlS4GipUse6MkSurJYW8AOwHCFd+4JQTaqrCr
         x0vvHbATnRNrVZ0p0r/u099OOtwxd3SELvuNtfz8vapYcPZsviWehps8x9ofdf6sz5wk
         wHC4uQ5pmyt3PLY/ZPB34IetKaQ/tqpkYu0LKxlM4QLLH+geb+3+EDSff3grho1h9CO9
         tofHlXObDWPQuuUIYgNjatPrlOtNIZDRtAftBH5JWBGPU12v4YJp2gjso30FLzlj2fDM
         yJUxDWIArMKuOtYFMxRIUScD3uBZaOeiZKyMZ7i3md3BZpfShmMniOGL5kFLJb5N1uyj
         H83g==
X-Forwarded-Encrypted: i=1; AJvYcCUBAdjoUjXX8pZqypc8R/l0wZWGZJnUYc4PFwJSEIbrwUKcU3oeix9jTj+IvFu/djVE/K5x3KH0JbLunFM=@vger.kernel.org, AJvYcCW0BrneX7G+A/rwQsYlJ93LMblGboSWZB5iuVinocighvryQ29yuecSEHDAzfEN88rtg+kCZl9o588=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS/kRkI5MtBvG+D0u/QkTSpV+DRg4bqE/GW5fLfbGau64tVlwM
	ifHhTYED3FYimolShKukhWidD5ex2/VgMvmtWgHKA8viJG+zn4Go0jEpdXQ0
X-Google-Smtp-Source: AGHT+IExvKVuyx4HywnrQhAd31qJ8qvwbDIhU8uLIPVs0yxqisBelMhf2TuEUvXPL0Xs46wwlf7T/A==
X-Received: by 2002:a05:6902:100f:b0:e13:d392:82bc with SMTP id 3f1490d57ef6-e17a83b5e23mr2600074276.12.1724418834736;
        Fri, 23 Aug 2024 06:13:54 -0700 (PDT)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e178e56a2b8sm671868276.41.2024.08.23.06.13.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Aug 2024 06:13:54 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6b8d96aa4c3so17331757b3.1;
        Fri, 23 Aug 2024 06:13:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWR0bqF5fc1pCa1xecDFmlAoF6PbAjgXXlte3sbMpAfRX0t63ujvFKIIqy51IH/EWZfl6K0x57vfQ8=@vger.kernel.org, AJvYcCXahXDMPoWtKpwbgBZB0ov24AVXZGOkS5WCRjju7Q+dvhodxBKaDkyqJZNGQQWKx8doBqv67p1WEkM9t5E=@vger.kernel.org
X-Received: by 2002:a05:690c:4d04:b0:6b1:3bf8:c161 with SMTP id
 00721157ae682-6c62538d076mr24871437b3.13.1724418833900; Fri, 23 Aug 2024
 06:13:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240823125156.104775-1-dave@vasilevsky.ca>
In-Reply-To: <20240823125156.104775-1-dave@vasilevsky.ca>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 23 Aug 2024 15:13:42 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVYNhFJ+qBDP3_fi9oeHsgOL0vqPe1YqE18+M8n1onssw@mail.gmail.com>
Message-ID: <CAMuHMdVYNhFJ+qBDP3_fi9oeHsgOL0vqPe1YqE18+M8n1onssw@mail.gmail.com>
Subject: Re: [PATCH] crash: Default to CRASH_DUMP=n when support for it is unlikely
To: Dave Vasilevsky <dave@vasilevsky.ca>
Cc: glaubitz@physik.fu-berlin.de, bhe@redhat.com, 
	linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, mpe@ellerman.id.au, 
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	=?UTF-8?Q?Reimar_D=C3=B6ffinger?= <Reimar.Doeffinger@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dave,

On Fri, Aug 23, 2024 at 2:54=E2=80=AFPM Dave Vasilevsky <dave@vasilevsky.ca=
> wrote:
> Fixes boot failures on 6.9 on PPC_BOOK3S_32 machines using
> Open Firmware. On these machines, the kernel refuses to boot
> from non-zero PHYSICAL_START, which occurs when CRASH_DUMP is on.
>
> Since most PPC_BOOK3S_32 machines boot via Open Firmware, it should
> default to off for them. Users booting via some other mechanism
> can still turn it on explicitly.
>
> Also defaults to CRASH_DUMP=3Dn on sh.
>
> Signed-off-by: Dave Vasilevsky <dave@vasilevsky.ca>
> Reported-by: Reimar D=C3=B6ffinger <Reimar.Doeffinger@gmx.de>
> Closes: https://lists.debian.org/debian-powerpc/2024/07/msg00001.html
> Fixes: 75bc255a7444 ("crash: clean up kdump related config items")

Thanks for your patch!

> --- a/kernel/Kconfig.kexec
> +++ b/kernel/Kconfig.kexec
> @@ -97,7 +97,7 @@ config KEXEC_JUMP
>
>  config CRASH_DUMP
>         bool "kernel crash dumps"
> -       default y
> +       default ARCH_DEFAULT_CRASH_DUMP
>         depends on ARCH_SUPPORTS_CRASH_DUMP
>         depends on KEXEC_CORE
>         select VMCORE_INFO

IMHO CRASH_DUMP should just default to n, like most kernel options, as
it enables non-trivial extra functionality: the kernel source tree has
more than 100 locations that check if CONFIG_CRASH_DUMP is enabled.

Letting it default to enabled also conflicts with the spirit of the
help text for the symbol:

          Generate crash dump after being started by kexec.
          This should be normally only set in special crash dump kernels
          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
          which are loaded in the main kernel with kexec-tools into
          a specially reserved region and then later executed after
          a crash by kdump/kexec. The crash dump kernel must be compiled
          to a memory address not used by the main kernel or BIOS using
          PHYSICAL_START, or it must be built as a relocatable image
          (CONFIG_RELOCATABLE=3Dy).
          For more details see Documentation/admin-guide/kdump/kdump.rst

          For s390, this option also enables zfcpdump.
          See also <file:Documentation/arch/s390/zfcpdump.rst>

What is so special about CRASH_DUMP, that it should be enabled by
default?

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
