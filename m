Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06ED113B29B
	for <linux-sh@vger.kernel.org>; Wed, 11 Sep 2024 07:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726039176; cv=none; b=IzTNC1LEvp2ZSTAa2djkvH740UQjC2JivdrfIuTe1zRG8pw6XcKFjyjVIjtlSeZWCaNMXBwC8o9q2/najJevEgYW1KvZeOVefRlWAt/s1yWnAhCl2zKClEM9gL5j9DkYMBWwvNcoBtyne+xb0fhmMzbPiNWJhn/uV0t1efT5lM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726039176; c=relaxed/simple;
	bh=oS6WUVdt66Gt4A7cThvnnPDwLJbY1ON2nYakO+1S6/8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fZzioAG7r/yiO/WJPKsnALSg6csrOxKD0uCky5bXNevFUfN9avQ9vApb6fA2K5hox8ugme3DQwMoTCbig/A/HHDFJSE3g/wBeQtrBk4bH7huHHtaSd4QGzbmp8olspyH/j2YDZeXXUj9N4gqof76MCVc9AzIfKlhnQaOz8ADLCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6c49c9018ebso57344407b3.3
        for <linux-sh@vger.kernel.org>; Wed, 11 Sep 2024 00:19:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726039173; x=1726643973;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AeJbkvhPJVWaQsL1Gg3KD5A9iDFYoBb81strZRyK6YM=;
        b=NIdfbRnA3+CM9+h++87wLn7d2txEkPxPMhjiHAjBTpXw1kf/yhzQF/wOjR6IN4dmQY
         DFpzcnzcWZ0GU7oSBSMxqsC+emjKcFEeYVBxILhTsYQcIPByb4Iaq3UEDiLIsoqugSKL
         UbH1IkVwUfJwasCzuaDoVPzhEhsaDKof5TmEmPZ3lYM1Rmf7+03I+j9dxJ6dofW9JiQx
         1nc8hjkP235TrgpJXphpiHUZI9SrWDo3Xza61Oj3EXeQYmCAdlUB34zCpIE47msOIgAl
         8oC2uvA62rkuudUwbhZNAaOpo2qn0VNBBnVKaHTkGBJxMoCTqzNCZtx2t9SJo+r2UiSD
         +A3Q==
X-Forwarded-Encrypted: i=1; AJvYcCW01XO5qWHDuHcWLxgWSYvFptokjQZvl+MDL5tk0rrbeyqJqb7F1+x3fym8qwLEbZ1FwD3hsqd3Hw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxLAgncmRilxRM8jxBlTllOXT1E8Ig9N3fwxyAsbVKB7mnUOzy1
	LJJc44l+6JnOyD82BlKgJhOH5trrvR5N1+svRK5tWIYJ7tWhcuuJ0sIfXCNf
X-Google-Smtp-Source: AGHT+IHe5oNpsBlgkFJAGe0gZ5Srk4wCySVwMExLuGcq2pXG0/tOjRFLOLeVkL9uSDjTt6iYXORrGQ==
X-Received: by 2002:a05:690c:360c:b0:6db:9bc5:bbb5 with SMTP id 00721157ae682-6db9bc5c521mr42287387b3.40.1726039172627;
        Wed, 11 Sep 2024 00:19:32 -0700 (PDT)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6db96491b4esm5890707b3.65.2024.09.11.00.19.32
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2024 00:19:32 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6d6a3ab427aso48990797b3.2
        for <linux-sh@vger.kernel.org>; Wed, 11 Sep 2024 00:19:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVJ4KE4qqRBaCDc4W4pzcq/wDcDCaeq6pHDQoMj/wA1sC4umSlGtYSPK9hRH/oX89Gc6mVBJ4NyBw==@vger.kernel.org
X-Received: by 2002:a05:690c:f:b0:64a:90fe:911e with SMTP id
 00721157ae682-6db45154290mr154555537b3.31.1726039172169; Wed, 11 Sep 2024
 00:19:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240910001612.88569-1-marek.vasut+renesas@mailbox.org>
 <20240910172151.GG4252@bill-the-cat> <1cd4c1c1-b709-43aa-aff8-14cb1d21aee2@mailbox.org>
In-Reply-To: <1cd4c1c1-b709-43aa-aff8-14cb1d21aee2@mailbox.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 11 Sep 2024 09:19:20 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVvHtVmH+YP=m20U9-buXKi1+Kwcrkf8vWhQYagcg4JRQ@mail.gmail.com>
Message-ID: <CAMuHMdVvHtVmH+YP=m20U9-buXKi1+Kwcrkf8vWhQYagcg4JRQ@mail.gmail.com>
Subject: Re: [PATCH] sh: cache: Fill in invalidate_icache_all()
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
	u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Linux-sh list <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Marek,

On Tue, Sep 10, 2024 at 7:55=E2=80=AFPM Marek Vasut <marek.vasut@mailbox.or=
g> wrote:
> On 9/10/24 7:21 PM, Tom Rini wrote:
> > On Tue, Sep 10, 2024 at 02:15:58AM +0200, Marek Vasut wrote:
> >
> >> Implement invalidate_icache_all() by clearing all V bits in
> >> IC and OC. This is done by setting CCR cache control register
> >> ICI and OCI bits.
> >>
> >> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> >> ---
> >> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> >> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> >> Cc: Tom Rini <trini@konsulko.com>
> >> Cc: u-boot@lists.denx.de
> >> ---
> >>   arch/sh/cpu/sh4/cache.c | 11 +++++++----
> >>   1 file changed, 7 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/arch/sh/cpu/sh4/cache.c b/arch/sh/cpu/sh4/cache.c
> >> index d3c480e79ed..99acc599965 100644
> >> --- a/arch/sh/cpu/sh4/cache.c
> >> +++ b/arch/sh/cpu/sh4/cache.c
> >> @@ -33,8 +33,9 @@ static inline void cache_wback_all(void)
> >>      }
> >>   }
> >>
> >> -#define CACHE_ENABLE      0
> >> -#define CACHE_DISABLE     1
> >> +#define CACHE_ENABLE                0
> >> +#define CACHE_DISABLE               1
> >> +#define CACHE_INVALIDATE    2
> >>
> >>   static int cache_control(unsigned int cmd)
> >>   {
> >> @@ -46,7 +47,9 @@ static int cache_control(unsigned int cmd)
> >>      if (ccr & CCR_CACHE_ENABLE)
> >>              cache_wback_all();
> >>
> >> -    if (cmd =3D=3D CACHE_DISABLE)
> >> +    if (cmd =3D=3D CACHE_INVALIDATE)
> >> +            outl(CCR_CACHE_ICI | ccr, CCR);
> >> +    else if (cmd =3D=3D CACHE_DISABLE)
> >>              outl(CCR_CACHE_STOP, CCR);
> >>      else
> >>              outl(CCR_CACHE_INIT, CCR);
> >> @@ -103,7 +106,7 @@ void icache_disable(void)
> >>
> >>   void invalidate_icache_all(void)
> >>   {
> >> -    puts("No arch specific invalidate_icache_all available!\n");
> >> +    cache_control(CACHE_INVALIDATE);
> >>   }
> >>
> >>   int icache_status(void)
> >
> > Thanks for filling this in, I wasn't sure how the implementation would
> > look from a quick skim of the linux kernel code.
> I believe it should look like the above, but lemme CC Geert to be on the
> safe side.

I have no idea.  I removed the corresponding (but incomplete) code
from Linux in commit 25c7d77d695a4104 ("sh: boot: Remove sh5 cache
handling"), as it was a relic of sh5 cache handling.

SH4 cache handling seems to be buried deeper. At least the above
matches for invalidation:

arch/sh/mm/cache-sh4.c- /* Flush I-cache */
arch/sh/mm/cache-sh4.c: ccr =3D __raw_readl(SH_CCR);
arch/sh/mm/cache-sh4.c- ccr |=3D CCR_CACHE_ICI;
arch/sh/mm/cache-sh4.c: __raw_writel(ccr, SH_CCR);

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
