Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1E123C8AF;
	Wed, 12 Mar 2025 09:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741773354; cv=none; b=LGUXln1MF9tO+YG9i1mCUaY4lgdbhTco1o/k/cix+9LbvTY3Hgau6I5QOWcTkB2N4p5XaOABu6V4+j499RojTFkIXsyDc74g3TI5WvgO74PhQkV4u+wd/9xxYdX4NJOEzcRQoJJapfzzyq/1vxt6OXjfE1sM5E3xjIquVHFM1B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741773354; c=relaxed/simple;
	bh=wM2HN1jol78lBKJONHq0uwXK+aLeXlK9dWyj0d8vnzw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BoUp+1f4ra4OzzRzhA8otuRxeJztidlUZtC/S6bDWI6Jt//6bs9DeCg0ALOfFAO7/igu/q/A251IdKljpiaxWzRFHMNrvPNvyD5Fhsg5B1jzaDn+mxw1d0LfiGWmYrJtRN1Etn/rTo1F6gRNSpMQEa31O+CqHQ8pSPXfrV/7sqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c7dpckgy; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c7dpckgy"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-30bf3f3539dso6960371fa.1;
        Wed, 12 Mar 2025 02:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741773350; x=1742378150; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hxtLMkmvM1PHAfvgTkxjLhwip9CJUtQkdApYBOtXlFQ=;
        b=c7dpckgykHIkOa66fAYLtaIagZdQjcGxL5x7YKGDHMiZ5LnioKJILA4ZR0Njdfa0xb
         2aNsDH6DzT9TI9b8UmNiAnvjX1RgHkC1ArfEo3FJ9GfFcYn/qCLGIK3xmQ7NLB2OWU6f
         NbajJ3VAFkLjDf/UdZlTom/hm5SC11fSgGwMd3AswNxprRNCep+NTNtL4qJFWGDJr9g7
         EysRG++OURx1tZNlRuUZZCHLPbTOebyc+yj9C5qmSYJR1hBGPOOXWwoAn579EjD97BBq
         QphWuYNqgokCuvxrXlIT+5L6r8ZPvVP+QywH6DqeCe8YKkA6ax1WK6+slgoLDcg7dRIo
         cAuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741773350; x=1742378150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hxtLMkmvM1PHAfvgTkxjLhwip9CJUtQkdApYBOtXlFQ=;
        b=R9+WNuwwka7WFteSeh2XmYfOLyczedV6eU8UK2tGyj2M5DkoLSwsKxSrNbJxK8oduX
         wwmKCWH3nzHjOfLxtIRBRFU0uly5iFHk39vtxoQMog3nGf9wMICCLLgnAE5TFJz8nbN2
         JMHnaZ19BE92tt0iU61NXy7fmrGMhpg8FfftWcekpk2YHhzcMUdyluyJZF/HxIBvixct
         BabkevQOUGmetf37UrPu7qrSl/k3Le10xoHk9tiP35HBaDzismeKxcPsEAqfmK++NIPZ
         S/25bZfpKzWhKGr2yf1Tt0zTB6H7o8fWBoK3nprul0/xqL6RwDLK15spWaL5smzsZh47
         Oa6w==
X-Forwarded-Encrypted: i=1; AJvYcCVpPcehmJ0BMIm99imUHA78DyJrcEWMScSQ562uchI1FkIMtFUhAUmZ1KDYgXSb/8jymNX8A2iNvhw=@vger.kernel.org, AJvYcCXiY4IX2Jes+yS7KvOAque5eykhcqQJC493HwZ//DpZ0RbAOZTBPAbnvVFdR01lxMRUmaWyHf1r1l/WoYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOhq9FUATcKBftq421I9fsCv8t9RjLQNDFe8dkLggfvmMdRNlQ
	7UM4mTchU7tQtQXpoRTdudeVuwIrR2JhGnbzC33u+PC22+M4x7b2BfbcbwDHd0RrEE8gDhbpIwr
	vReLs/1Qx7pgwgvODqjKK5lGSQeo=
X-Gm-Gg: ASbGnctQfYLxxFv2nB8mar8OA6KGfcMXi9emRs0IGnCAtsDasU9TX8FJ3FOTL/JUt69
	TIaArXDv4sonCCD7KHPLqNPyXXdZ+TyPcsC91Jz2FX6FBXU1HGgdhEApCGXF3tx1gBwlKsMgJZE
	sJGIewrV7FrW47PeGr7zcMdWsFVw==
X-Google-Smtp-Source: AGHT+IHc8Gi9SKOIsVlFCkkx6o96+MJgAWMgmEsek7pgXRVnRGL88Fz9vN1fXvRgOtct8JJ9We05PebnUBB7GGy67Xk=
X-Received: by 2002:a2e:7006:0:b0:30b:f599:d78f with SMTP id
 38308e7fff4ca-30c20e883a0mr25759501fa.7.1741773349935; Wed, 12 Mar 2025
 02:55:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250216175545.35079-1-contact@artur-rojek.eu>
 <20250216175545.35079-2-contact@artur-rojek.eu> <5365422a9715376c76a89e255c978fc39064e243.camel@physik.fu-berlin.de>
 <433bc8a0732bf8a63c64c4bf0e6ad4a7@artur-rojek.eu> <967e29681c8bc39edfdd9c645d943f17d341c2ae.camel@physik.fu-berlin.de>
 <CAFULd4b8+HsmJC2XkW50pxtw=fHNrL9gH1_WM90jh+rfLCbSHw@mail.gmail.com> <CAMuHMdXaw117mimN_7UgwbfbG9grVg09WfjKa2Lz4eGqM24EvA@mail.gmail.com>
In-Reply-To: <CAMuHMdXaw117mimN_7UgwbfbG9grVg09WfjKa2Lz4eGqM24EvA@mail.gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Wed, 12 Mar 2025 10:55:56 +0100
X-Gm-Features: AQ5f1JolTJVJhN2SYtghi2NyeluvO7V1pNUB6NL8-ykasafaE2lYgryvCC9OYyU
Message-ID: <CAFULd4YhqH=5eEptwqSFrH=x02W7VKeuca-zBthS_ckLjHWN8g@mail.gmail.com>
Subject: Re: [PATCH 1/2] sh: align .bss section padding to 8-byte boundary
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Artur Rojek <contact@artur-rojek.eu>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, "D . Jeff Dionne" <jeff@coresemi.io>, 
	Rob Landley <rob@landley.net>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 10:47=E2=80=AFAM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> Hi Uros,
>
> On Wed, 12 Mar 2025 at 09:32, Uros Bizjak <ubizjak@gmail.com> wrote:
> > On Wed, Mar 12, 2025 at 9:22=E2=80=AFAM John Paul Adrian Glaubitz
> > <glaubitz@physik.fu-berlin.de> wrote:
> > > > In the original BSS_SECTION(0, PAGE_SIZE, 4), the last argument ins=
erts
> > > > a 4 byte padding after the closing brace of .bss section definition=
,
> > > > causing the __bss_stop symbol offset to grow, but not the .bss sect=
ion
> > > > itself:
> > > >
> > > > #define BSS_SECTION(sbss_align, bss_align, stop_align)             =
           \
> > > >       . =3D ALIGN(sbss_align);                                     =
     \
> > > >       __bss_start =3D .;                                           =
     \
> > > >       SBSS(sbss_align)                                             =
   \
> > > >       BSS(bss_align)                                               =
   \
> > > >       . =3D ALIGN(stop_align);                                     =
     \
> > > >       __bss_stop =3D .;
> > >
> > > OK, that's really odd. So, the __bss_stop would be moved to the desir=
ed
> > > position but the section itself still remains small? What exactly doe=
s the
> > > linker fill the region with? Sounds very strange.
> > >
> > > > TurtleBoard loader is only concerned with the .bss section size - i=
t
> > > > doesn't care about any symbol offsets - and hence this seemingly cr=
yptic
> > > > change (you can display the section size information with
> > > > readelf -t kernel_image).
> > >
> > > Looking at the actual kernel image with readelf is a very good sugges=
tion!
> > >
> > > > The rest of the changes are simply to "inline" the BSS() macro (as =
I
> > > > needed to access that closing brace), and the former sbss_align,
> > > > bss_align (that's your PAGE_SIZE) and stop_align arguments are pass=
ed
> > > > accordingly, the same way they used to be passed before. The only
> > > > visible effect should be the move of ALIGN(stop_align) inside of .b=
ss
> > > > section definition, and the change of stop_align value from 4 to 8.
> > >
> > > OK. FWIW, do you understand what SBSS is for? I couldn't find any exp=
lanation
> > > for it.
> >
> > Small BSS section. The compiler can put data objects under a certain
> > size threshold to the .sbss section. Looking at GCC sh config, sh does
> > not use this section.
>
> Hence the moment gcc (or clang) starts using that section, the
> TurtleBoard loader is broken again...

Rest assured that the compiler won't just magically start using SBSS.
This is part of an ABI and in case ABI allows SBSS, the compiler needs
something like:

  if (in_small_data)
    switch_to_section (get_named_section (NULL, ".sbss", 0));

when emitting the declaration.

Uros.
