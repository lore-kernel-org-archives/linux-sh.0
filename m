Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C88B14A8D
	for <linux-sh@vger.kernel.org>; Mon, 29 Apr 2024 08:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714378020; cv=none; b=FU4hdxaqI0+xJiKGw5DOG5Sp8XSMhgX3dquUnkaN7EL7rOAXB4z6Pfuey8DrQ+2vIzR2obJRbBy6k4PR72byZXBwFhzYURK1QodNbS5N56fUBIkuT35qTLw3RBfAMgo8IN8vzwb8kdNwTK7XCu5908oGV6DbghFgpKFJ2EXyzPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714378020; c=relaxed/simple;
	bh=O8zZcpOvtQ7zkfACSSvapqKdaSh0bGyz4GBsYdWF/qI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tClp+NCYMMRO2NFX8bpn1jXlhhHo5jSrz0H3GuhyMy/b3+BlSX9Q6RrPCe+RzkqcHqekp4rxfl3ewmnJ7IJrPj4+m+wChqIcuRhsrM4M4pVU85j5ynvWYW0NA+DPFRo259E8JkGLVrh7FbsMkecPXhnuwKmKdn7bHxnJExnLNYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-de5d439b729so1119770276.0
        for <linux-sh@vger.kernel.org>; Mon, 29 Apr 2024 01:06:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714378017; x=1714982817;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MWLeSqbMzVsa7fApWAr1a5qv0rMxItQhD2vBZUq81cc=;
        b=fBVnG0Vs3bXnrV0gUEgS+ax9qPuiijNqWB+E4I+pRVpimhIv1cCJrevE4Sjeuj0KdP
         V9UkaY8Kpn/jRN1cVIcdN+j39B5XWYIFlHJrYNCrW2k6yS6mrdlyZZVYJEWwsRCN1CNk
         CsVNz44jTDl2cqF/d+VXaXLk+JRIcIsb29eZdRnoxIZcBRzX2dY6XQSRuf70/P9MmgGf
         givBSEdXEOOuQ4NXrxMZEOBtdwYRg6Uq/8toQr6XuEqg781b/b+dSdSqe3iA8Fhu/JFX
         TjXgIZM2xoKLyOAZCsXCEP/d5L/L0UHmChL27Ow4AezRiSiZywcJHoi9GWJ7M9Mcyxlz
         bztw==
X-Forwarded-Encrypted: i=1; AJvYcCXTdhzlyeq5/Rpl+75gu7E3wXN4tf8p5yyOvlmEX7H+LsS9k6M4iLpbAp81121g8usmyVVYGMDSymM4JGMYbyDABQ5oWlHXCUw=
X-Gm-Message-State: AOJu0YwlAsRiU3ZAATq4eYKzwdOqna9N40hxKnNMAgjdDorU0FIu5dee
	E77DzPMP58uM14cUjtM+FsCsztnUPJkgz2zpRCYqknHV8Hxovr4LdB5AslNz
X-Google-Smtp-Source: AGHT+IE2XH30U1UD5laArbHMe6xHqbdeToBea8xaJN2vKT+eKlo7JntF9ebbzWFTbh7dvtNcXKE1bg==
X-Received: by 2002:a0d:e28d:0:b0:61b:12d8:64cf with SMTP id l135-20020a0de28d000000b0061b12d864cfmr4652706ywe.20.1714378016861;
        Mon, 29 Apr 2024 01:06:56 -0700 (PDT)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id w7-20020a81e347000000b006184d7943casm5228142ywl.33.2024.04.29.01.06.56
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Apr 2024 01:06:56 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dbed179f0faso3607553276.1
        for <linux-sh@vger.kernel.org>; Mon, 29 Apr 2024 01:06:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVQEMnlLfjqSglIf01d9mTxs2rov8rGDZagHrJKAgK17WGtLMNj771lCULneyljJJAvQD1E0MhcsPBNW28cotv0JNKMNU84q20=
X-Received: by 2002:a05:6902:2193:b0:de5:dcb6:83a8 with SMTP id
 dl19-20020a056902219300b00de5dcb683a8mr2554455ybb.23.1714378016501; Mon, 29
 Apr 2024 01:06:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <23e9b3fd0d78e46c9fc1835852ba226aba92c3ca.1713959531.git.geert+renesas@glider.be>
 <d5f53c4c490d0058956f6a501191107c4b148720.camel@physik.fu-berlin.de>
 <CAMuHMdW5jMg4K454S=jQkU7EZUXyKYetqFVejL0ft1uxAJQpGQ@mail.gmail.com> <23a3abf08f358588ef448c1a2f2ef53013ce6b69.camel@physik.fu-berlin.de>
In-Reply-To: <23a3abf08f358588ef448c1a2f2ef53013ce6b69.camel@physik.fu-berlin.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 29 Apr 2024 10:06:44 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXRDRfTB7WCP8O2ubgN3_9L6Hz2yEcUY3urFksM-2FEmg@mail.gmail.com>
Message-ID: <CAMuHMdXRDRfTB7WCP8O2ubgN3_9L6Hz2yEcUY3urFksM-2FEmg@mail.gmail.com>
Subject: Re: [PATCH] sh: boot: Remove sh5 cache handling
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	Arnd Bergmann <arnd@arndb.de>, linux-sh@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Adrian,

On Mon, Apr 29, 2024 at 9:52=E2=80=AFAM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> On Mon, 2024-04-29 at 09:49 +0200, Geert Uytterhoeven wrote:
> > On Mon, Apr 29, 2024 at 9:46=E2=80=AFAM John Paul Adrian Glaubitz
> > <glaubitz@physik.fu-berlin.de> wrote:
> > > On Wed, 2024-04-24 at 13:54 +0200, Geert Uytterhoeven wrote:
> > > > Commit 37744feebc086908 ("sh: remove sh5 support") in v5.8 forgot t=
o
> > > > remove the sh5 cache handling.
> > > >
> > > > Suggested-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> > > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >
> > > > --- a/arch/sh/boot/compressed/cache.c
> > > > +++ /dev/null
> > > > @@ -1,13 +0,0 @@
> > > > -// SPDX-License-Identifier: GPL-2.0
> > > > -int cache_control(unsigned int command)
> > > > -{
> > > > -     volatile unsigned int *p =3D (volatile unsigned int *) 0x8000=
0000;
> > > > -     int i;
> > > > -
> > > > -     for (i =3D 0; i < (32 * 1024); i +=3D 32) {
> > > > -             (void)*p;
> > > > -             p +=3D (32 / sizeof(int));
> > > > -     }
> > > > -
> > > > -     return 0;
> > > > -}
> >
> > > Interesting, looking at boot/compressed/cache.c, it seems that the wh=
ole code
> > > is actually a no-op and does nothing but increasing a pointer. So I a=
gree we
> > > should just delete it.
> >
> > It is not a no-op: it also reads from memory, to load new data in
> > the cache, and evicting the old data.
>
> Yeah, I actually came to this conclusion right after sending my reply. Ho=
wever, the
> command parameter is never used.
>
> Don't have the 32-bit SH CPUs any caches? The code itself is unconditiona=
lly executed,
> it seems.

They do. E.g. SH7751 has 8+8 KiB of L1 cache.
But e.g. sh7724 has 32+32KiB L1 cache, and 256 KiB of unified L2 cache.
SH772[34] have l2_cache_init() to enable the L2 cache, so probably they
boot with L2 disabled, and we are fine.

Unfortunately I don't have access to a SH772[34] system.
Sato-san: can you confirm?
Thanks!

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
