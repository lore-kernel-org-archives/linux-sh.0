Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94421233D85;
	Wed, 12 Mar 2025 08:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741766816; cv=none; b=Hd3NU3VU8YEwjVD7aJ/sQjNXZcj6tfeWIhHbVkNM8ZqqXsMied2AS0wVPKeIGoKamzfAAvQPU71MtoWc4QJ1egZn8PL+ULEV24Six1OEWr2osQxBOV89MdIa9zfI3u6fjMSn8AlCfGLUZe/3A42EfO3xesDTySNP8fW00/UzFa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741766816; c=relaxed/simple;
	bh=/E+CxfZwg+3uh69C7tp13/GXhlnba+LwlXzgTRr4yyE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TSOtNOZ1uockHCZ5KDtCx9jVo3ZBe6LmeILsaW/s2F5nr2Ruxsj7Es7ygiCQLcc66uyNIdYbjiEOZi+TCqLNK02cAd1k9G4VvxveMYFaVngTd39buyGgofKP9x9Sn3uQ2YZdd+TloH2f972OyPQXunnNIwJPOCTd6uVcFyB8rPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-86d42f08135so2188189241.0;
        Wed, 12 Mar 2025 01:06:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741766812; x=1742371612;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qmGqQHBEwBRbkAoYLiZ6rvfGYL5ug5x1JGdr3Bwp44E=;
        b=V/s6c4V7iTCUQqP5ffCJlrsnxP3i7MCHK6/s3QdlZgoS1cr/ma9+stFFP/fCw6cseu
         iMFk5he3Z3mDc+TpaRkBXn/6ochxj/h5nCLo4pJR2wQajgOFivjSIsWl7JFBR4ojAhRX
         Tk1UAAcHiJ33zaLgWWebWluIoZNxwZjPUXQ9jHWOSJEELXMKVAyEo8P+MavMh5pR3Rxf
         o8dcRuiLRevwKF+RFF5tKPfuQZCnCXuEVaFYfEcgDXEubBr2gmncgVxwe/JhXB441oTt
         oSbb4qAFOEPzbqriS20Ma6Pdt746E4XOICf+su6b6Ivy1G86qhP0LXDqlEzVcNyQS9YE
         oSsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqj4qhWdU/xgx5Ds77V3h9ZciKsSz+hx+yNskPzYUbqLUqQwThfnG3DJP33SsItX/qW3kkl9eg/Ww=@vger.kernel.org, AJvYcCXDlAN+puOK7ZDBCIU43wN0fFlgCQhqwH/mVKMkJXU+aZ6HfgzpoGK2VAoRoiR42R/obgQfkaCeedWD1IY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRYet/Gdlfv2UNQlikGFqV4U1madhP2iT7GjwNglZZZRMNP39Y
	EZGL8yUhHYpx9gYhO3KH6SEpXG0ELmiqLGaHn7HD7y0RI/uorWJ5mzUFWcP+
X-Gm-Gg: ASbGncvThL6RxqH9Tw8v6qfdtJj3ozpEMhTutkhdj6bZVkdDdlbeMiPdBuUY8ZyjPX4
	zZzLqZSUNZxLS9LYQsmfHk+vRXWg+H2f1I7h2McSJj9YUdOVWzzKTCpHFuVzyzOFTtBhqYEYmex
	P5iJ4Ybsw8qzNuN9zbtdUN9IunpPQVoJwcBxSadKLNMGxld0injase7ZHOyQzI+34O3zOZe0J6s
	qGaSHkOG11aJBCIzAtK2xqeOqV8bxzZmRSsYRett5BfIdBRt2vJg56aLiBBDj5vEP7FgsCe5Lu7
	oJylNVSF0FxftpvNg9EGjPTAqVH7/MfCFiB9Pz7PfY3bTn1k2PPAPFQHhpXuk1qZqTqXbBy3Y/g
	TiA/UneA=
X-Google-Smtp-Source: AGHT+IE296I3adwjsuzyITlzeScjw+WyrtbNq1rfkc9DzpmD4NKHRWnJy7Dx61NGK0698mhlf9bFrw==
X-Received: by 2002:a05:6102:3e16:b0:4c1:a395:c57b with SMTP id ada2fe7eead31-4c30a72b35amr13824586137.24.1741766811727;
        Wed, 12 Mar 2025 01:06:51 -0700 (PDT)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com. [209.85.222.49])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4c347bb8611sm800316137.22.2025.03.12.01.06.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Mar 2025 01:06:51 -0700 (PDT)
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-86d6976f768so1104119241.1;
        Wed, 12 Mar 2025 01:06:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVPNgQT7G+kpzb3pomcvTmY5s9QsZ9qR8EhWzHZlvmEi70A+Xvd5PDTjO1atxNLWsGfV9gxnSUsg2dzxBE=@vger.kernel.org, AJvYcCVudFvW04t6vuZOGnUdU1+YHrRgmkb6cukIjqMnYV6XvuHqBHi5KfLp+rjcLAW5fA6TIiVjv7EWOoo=@vger.kernel.org
X-Received: by 2002:a05:6102:808f:b0:4b6:d108:cac1 with SMTP id
 ada2fe7eead31-4c30a5a7306mr14483092137.9.1741766811160; Wed, 12 Mar 2025
 01:06:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250216175545.35079-1-contact@artur-rojek.eu>
 <20250216175545.35079-2-contact@artur-rojek.eu> <5365422a9715376c76a89e255c978fc39064e243.camel@physik.fu-berlin.de>
 <433bc8a0732bf8a63c64c4bf0e6ad4a7@artur-rojek.eu>
In-Reply-To: <433bc8a0732bf8a63c64c4bf0e6ad4a7@artur-rojek.eu>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 12 Mar 2025 09:06:39 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVmKk9vML=p1MsnkGATzUh3HD+Pa==7C=QMYjjzqzxk2A@mail.gmail.com>
X-Gm-Features: AQ5f1JpVcQIR2AUq5CsSqZ5TfhWlttBNgDchgzFmEA9b_wdiswP8JhWKfF1izpY
Message-ID: <CAMuHMdVmKk9vML=p1MsnkGATzUh3HD+Pa==7C=QMYjjzqzxk2A@mail.gmail.com>
Subject: Re: [PATCH 1/2] sh: align .bss section padding to 8-byte boundary
To: Artur Rojek <contact@artur-rojek.eu>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Uros Bizjak <ubizjak@gmail.com>, "D . Jeff Dionne" <jeff@coresemi.io>, Rob Landley <rob@landley.net>, 
	linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Artur,

On Wed, 12 Mar 2025 at 00:40, Artur Rojek <contact@artur-rojek.eu> wrote:
> On 2025-03-11 18:28, John Paul Adrian Glaubitz wrote:
> > I'm currently trying to review this patch, but I'm not 100% sure how it
> > this change helps grows the .bss section, see below. Maybe you can help
> > me understand what's happening.
> >
> > On Sun, 2025-02-16 at 18:55 +0100, Artur Rojek wrote:
> >> J2 based devices expect to find a devicetree blob at the end of the
> >> bss
> >> section. As of a77725a9a3c5, libfdt enforces 8-byte alignment for the
> >> dtb, causing J2 devices to fail early in sh_fdt_init.
> >>
> >> As J2 loader firmware calculates the dtb location based on the kernel
> >> image .bss section size, rather than the __bss_stop symbol offset, the
> >> required alignment can't be enforced with BSS_SECTION(0, PAGE_SIZE,
> >> 8).
> >> Instead, inline modified version of the above macro, which grows .bss
> >> by the required size.
> >>
> >> While this change affects all existing SH boards, it should be benign
> >> on
> >> platforms which don't need this alignment.
> >>
> >> Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
> >> ---
> >>  arch/sh/kernel/vmlinux.lds.S | 15 ++++++++++++++-
> >>  1 file changed, 14 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/arch/sh/kernel/vmlinux.lds.S
> >> b/arch/sh/kernel/vmlinux.lds.S
> >> index 9644fe187a3f..008c30289eaa 100644
> >> --- a/arch/sh/kernel/vmlinux.lds.S
> >> +++ b/arch/sh/kernel/vmlinux.lds.S
> >> @@ -71,7 +71,20 @@ SECTIONS
> >>
> >>      . = ALIGN(PAGE_SIZE);
> >>      __init_end = .;
> >> -    BSS_SECTION(0, PAGE_SIZE, 4)
> >> +    __bss_start = .;
> >> +    SBSS(0)
> >> +    . = ALIGN(PAGE_SIZE);
> >
> > What this effectively does is removing ". = ALIGN(sbss_align);" first
> > from BSS_SECTION().
> >
> > Then it inserts ". = ALIGN(PAGE_SIZE);" after the "SBSS(0)".
> >
> > If I understand this correctly, SBSS() inserts a zero-padding and if
> > I'm not mistaken,
> > inserting ". = ALIGN(PAGE_SIZE);" will cause this padding to grow to at
> > least PAGE_SIZE
> > due the alignment.
> >
> > Is this correct?
> >
> >> +    .bss : AT(ADDR(.bss) - LOAD_OFFSET) {
> >> +            BSS_FIRST_SECTIONS
> >> +            . = ALIGN(PAGE_SIZE);
> >> +            *(.bss..page_aligned)
> >> +            . = ALIGN(PAGE_SIZE);
> >> +            *(.dynbss)
> >> +            *(BSS_MAIN)
> >> +            *(COMMON)
> >> +            . = ALIGN(8);
> >
> > If my understanding above is correct, why do we will need an additional
> > ". = ALIGN(8)"
> > here?
>
> I'll tackle both of the above questions at once.
> I'm by no means an expert at GNU Linker syntax, but the intention of
> this patch is to put . = ALIGN(8) inside the .bss : { ... } section
> definition, so that the section itself grows by the requested padding.
>
> In the original BSS_SECTION(0, PAGE_SIZE, 4), the last argument inserts
> a 4 byte padding after the closing brace of .bss section definition,
> causing the __bss_stop symbol offset to grow, but not the .bss section
> itself:
>
> #define BSS_SECTION(sbss_align, bss_align, stop_align)                  \
>         . = ALIGN(sbss_align);                                          \
>         __bss_start = .;                                                \
>         SBSS(sbss_align)                                                \
>         BSS(bss_align)                                                  \
>         . = ALIGN(stop_align);                                          \
>         __bss_stop = .;
>
> TurtleBoard loader is only concerned with the .bss section size - it
> doesn't care about any symbol offsets - and hence this seemingly cryptic
> change (you can display the section size information with
> readelf -t kernel_image).
> The rest of the changes are simply to "inline" the BSS() macro (as I
> needed to access that closing brace), and the former sbss_align,
> bss_align (that's your PAGE_SIZE) and stop_align arguments are passed
> accordingly, the same way they used to be passed before. The only
> visible effect should be the move of ALIGN(stop_align) inside of .bss
> section definition, and the change of stop_align value from 4 to 8.
>
> Arguably the TurtleBoard loader should read the __bss_stop symbol offset
> instead, but in this patch I'm trying to solve the issue from kernel's
> point of view.

What about moving (or duplicating, e.g. sbss_align alignment is
done before and after __bss_start)  the stop_align alignment
from BSS_SECTION() into BSS() instead, i.e. just changing
include/asm-generic/vmlinux.lds.h for everyone?  I don't think that
would hurt any platforms, while fixing the issue for good.
IMHO it is a bit strange that the size of the bss section can differ
from __bss_stop - __bss_start.
One last question though: what about sbss? How does the TurtleBoard
loader handle that?  __bss_stop - __bss_start is not the size of bss,
but the sum of the sizes of sbss and bss, plus extra alignment in
between. The latter might cause trouble, too.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
