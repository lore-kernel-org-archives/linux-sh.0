Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698881DC991;
	Wed, 12 Mar 2025 09:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741772839; cv=none; b=L7o+1nqSZahE4+/GMyzn+tNEYQTI5nce8kxEU049bavmbPQLK/yyHw3goqsKhPa7Ow2GVYON8rMZwwZSS/ZY65dzt5ZI8NhoJfL4dMVTBFVVjK3RDp7PJ36FxIxTzhWYX000WE+etd5hOcZZMggB/INZt7v6YiESa7o3NdtOtzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741772839; c=relaxed/simple;
	bh=r58vrp2EstxFyN26G7F/QhcD0jYpTudGlXZLmZGjH6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pzfv/tzGIV4HqkYT574FvYOa7P2CNNUuBAjG7ur3mMVY2qb8Jph+nZ13bXYgaLYi/X+sXoo0Zl0dzth3CPkULmB+2ER2zpZdJm8GvIlLlgVZfdOSryP0yY9jaiqJKJB8duJrmCHQhcVH0O104Jt/z5O6ERA60MKRsrzqUl/cfX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-523ee30e0d4so2255038e0c.2;
        Wed, 12 Mar 2025 02:47:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741772834; x=1742377634;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d62xAkjCjzvah8gGs20whVVYHb+UQ2bouE+wm1G9QwE=;
        b=qg2RwtkW+IJ93WCGyOBZnQnUckkHWiOyzaErRf2xvCuLMDMWZ9E1cqH45R/41xHi1Y
         1DwMGZ2Ot02bPDnCpuDhaOUtTcL+RAXZ4J2alqJ6eE6laj2rURADw5d28HTRwPdaHddU
         dxyh4c8Z/yBPZ37gOdwdljUwjHm+z7prktUMkKXDO8k+Ryn0EQqH4CAAEDKAoUeJ4sXq
         zwjDsdcv+lK24AkVLIwG+LVXs40EsUpELxGDlH0HUT3E1yIFa0ATq00luwHXMGEZ6fh7
         OoSMNXSl7EPhQd3Yj18nZkVId0A5Mcs4viYcU8+o35NgkuqEfY6CckuYU3vcWkJhYXX1
         0NbQ==
X-Forwarded-Encrypted: i=1; AJvYcCULRETbo4BH9jhK+25FWjSBSM+cG2V8ZgUNiepR1VFHMIlRMUZMk9GKDYHj8LMSVIgyLFTqaCtZ2Go=@vger.kernel.org, AJvYcCWKBBbYkAdzKkyMIzlO2EZLp6f2vO0UqsT2VmbUVPorAYh4ig/SXBCfOwo2pcRig4RSR95N5qnFneTnKMA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2OKPz68b9/tM+ds1yYHoQ/Mz4KrZDi8kZC73KycC32OG67P2M
	Mo7G/govaTLUf980DaSPODpDzLGmKNj08XjfFgiXDhLfDrjXPNZNtjCpTE/J
X-Gm-Gg: ASbGnctWCZ0oM+ITdZFLeavLZb6FCYNMnQhM2ETHwkJfjni1CksgXARJvYWXD/eArGn
	zuCvssItiA0zzE31xlic+xtOb+SYycqLGjqallJ4sBNQ1/My5wvJ5H4So69leTsU652/6ihPJlC
	YMAojk0D96g3eTneKSbMsaw0cm/qTqcTPqOj8oUS2aokFnOal8apFImdDsd0rTLUf+jF5Us44cg
	duQnAO++jxW+8oDvuS++JzzddumJk1FiBNfXwVqfPNYClqhUBQoVJIda1UiZK2HiG1+DnqpzgMv
	Xwmk1X7H8jvpG/qmkXdO6MB06PVaYvnitDtq+NSQRgEK++R3Dl1ZPV4Rtu2GOQhIpzhoBtlGBUE
	UwgCt8NO3l0U=
X-Google-Smtp-Source: AGHT+IHI/kwET4BOyIL5R8ogAYziQ1rhHQx4zxxfLuxMDVsHZun5c1zS0pE5P6WU4tJQ96taz5wzuA==
X-Received: by 2002:a05:6122:3191:b0:520:61ee:c815 with SMTP id 71dfb90a1353d-523e4188194mr11709957e0c.10.1741772833709;
        Wed, 12 Mar 2025 02:47:13 -0700 (PDT)
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com. [209.85.221.170])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-523d8a84f06sm2119915e0c.10.2025.03.12.02.47.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Mar 2025 02:47:13 -0700 (PDT)
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-523ee30e0d4so2255015e0c.2;
        Wed, 12 Mar 2025 02:47:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXBzyMh8JXK7p4kX9k5STXObBO1jyFo/lYwm3UDkxXU4I9dizf2c99qOt2qG5TXJaFpHti9WiRGfWnzs4U=@vger.kernel.org, AJvYcCXbpQntSui9KkdARckOJGRMCpwJWnLoVyc8Po9f0oBfzBkRBvA5FYxiX5cctmYBV8or7ZKs/NhwknY=@vger.kernel.org
X-Received: by 2002:a05:6102:41a8:b0:4bb:e14a:944b with SMTP id
 ada2fe7eead31-4c30a6c0602mr13369838137.20.1741772832869; Wed, 12 Mar 2025
 02:47:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250216175545.35079-1-contact@artur-rojek.eu>
 <20250216175545.35079-2-contact@artur-rojek.eu> <5365422a9715376c76a89e255c978fc39064e243.camel@physik.fu-berlin.de>
 <433bc8a0732bf8a63c64c4bf0e6ad4a7@artur-rojek.eu> <967e29681c8bc39edfdd9c645d943f17d341c2ae.camel@physik.fu-berlin.de>
 <CAFULd4b8+HsmJC2XkW50pxtw=fHNrL9gH1_WM90jh+rfLCbSHw@mail.gmail.com>
In-Reply-To: <CAFULd4b8+HsmJC2XkW50pxtw=fHNrL9gH1_WM90jh+rfLCbSHw@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 12 Mar 2025 10:47:00 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXaw117mimN_7UgwbfbG9grVg09WfjKa2Lz4eGqM24EvA@mail.gmail.com>
X-Gm-Features: AQ5f1JpmvV1WR8P4TSacSWlcg8eeK0249gT4jim4zcWy0MoFkMgE7kfgLifM39g
Message-ID: <CAMuHMdXaw117mimN_7UgwbfbG9grVg09WfjKa2Lz4eGqM24EvA@mail.gmail.com>
Subject: Re: [PATCH 1/2] sh: align .bss section padding to 8-byte boundary
To: Uros Bizjak <ubizjak@gmail.com>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Artur Rojek <contact@artur-rojek.eu>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, "D . Jeff Dionne" <jeff@coresemi.io>, 
	Rob Landley <rob@landley.net>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Uros,

On Wed, 12 Mar 2025 at 09:32, Uros Bizjak <ubizjak@gmail.com> wrote:
> On Wed, Mar 12, 2025 at 9:22=E2=80=AFAM John Paul Adrian Glaubitz
> <glaubitz@physik.fu-berlin.de> wrote:
> > > In the original BSS_SECTION(0, PAGE_SIZE, 4), the last argument inser=
ts
> > > a 4 byte padding after the closing brace of .bss section definition,
> > > causing the __bss_stop symbol offset to grow, but not the .bss sectio=
n
> > > itself:
> > >
> > > #define BSS_SECTION(sbss_align, bss_align, stop_align)               =
         \
> > >       . =3D ALIGN(sbss_align);                                       =
   \
> > >       __bss_start =3D .;                                             =
   \
> > >       SBSS(sbss_align)                                               =
 \
> > >       BSS(bss_align)                                                 =
 \
> > >       . =3D ALIGN(stop_align);                                       =
   \
> > >       __bss_stop =3D .;
> >
> > OK, that's really odd. So, the __bss_stop would be moved to the desired
> > position but the section itself still remains small? What exactly does =
the
> > linker fill the region with? Sounds very strange.
> >
> > > TurtleBoard loader is only concerned with the .bss section size - it
> > > doesn't care about any symbol offsets - and hence this seemingly cryp=
tic
> > > change (you can display the section size information with
> > > readelf -t kernel_image).
> >
> > Looking at the actual kernel image with readelf is a very good suggesti=
on!
> >
> > > The rest of the changes are simply to "inline" the BSS() macro (as I
> > > needed to access that closing brace), and the former sbss_align,
> > > bss_align (that's your PAGE_SIZE) and stop_align arguments are passed
> > > accordingly, the same way they used to be passed before. The only
> > > visible effect should be the move of ALIGN(stop_align) inside of .bss
> > > section definition, and the change of stop_align value from 4 to 8.
> >
> > OK. FWIW, do you understand what SBSS is for? I couldn't find any expla=
nation
> > for it.
>
> Small BSS section. The compiler can put data objects under a certain
> size threshold to the .sbss section. Looking at GCC sh config, sh does
> not use this section.

Hence the moment gcc (or clang) starts using that section, the
TurtleBoard loader is broken again...

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
