Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFEE15E8B
	for <linux-sh@vger.kernel.org>; Mon, 29 Apr 2024 07:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714376971; cv=none; b=NisEcascgIjrKrb7iCn3UAZ9GgZnuuUx2LEUyS1pPjldUu4anw0mxxxwFDlrCFbBCbCTvbeYDL8bTrBl3w/8QgprqnuwCcEbOaJFpMxXl33zi59CPQc0tnF6K48VaZcbBNgq3rae8fsQTiAAUuwmJoNPXXb9pIaoHTtm11WUcSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714376971; c=relaxed/simple;
	bh=53QPaGoKaQEMLJN1dBZSmSSLu+K5vO4o/94z372rAqY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SMiHwCFCLKbkbPzBVRVtVIWt+luzu7t3vkE23euqntwy+lQmiWPY3W0EYdM9B1ZbqU51LcFJR6Iim7K3MIm5nq2e1t8y3Lc6RNujhQWu/filDhLqN/HaDsH/TSJ+zJ/cerod6y10b72Dn3yWIbayz+QCLUQVGg4bmfIGwKuCnZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-61b62005f38so41312957b3.2
        for <linux-sh@vger.kernel.org>; Mon, 29 Apr 2024 00:49:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714376967; x=1714981767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ArqTX42K0gk+2PKplQ6S0Q/xd0pl8jD5be0hEy+JfQA=;
        b=fM/Z3tSYvBxa6WA0UWmV1U131h+s+bvYKLzzW38ADsj5f5le4G3IZtPXnuJnQcH5XB
         5LK+lh2FyJ0ABeFi3VZw6CWmK69RfUwz9z/Gw79YeAFUSDW1Cw2EKYCVZaa6kjjMbuEh
         OcTxf2AJCZUOcleeyEw6Ju7bjo30TuXJ/rft2TGDPbrZPw29Re/xHegxZfeEXOOEeQk/
         wugsVB57Hfj6Hk15NKDoPtuMi5vSqF+XzXtwSfoEVUn1+JsDI04K+i6wvvokPnT7lik4
         xIBT0expp+5/b36CmbjZD7ody9Vo7uB8CfemRZUXxjoiJSr1qfssSGh2opAkR7N+xxQG
         qs+g==
X-Forwarded-Encrypted: i=1; AJvYcCX1Xdlw2qCRSUENnVC6sxEU/0EjAnJqk/LfRTpvgcdahE7hNLruAaLYk2Wr6Eok8lp16Hr8IQSxwLlpVa3yjbk/7j3o+jY6Op4=
X-Gm-Message-State: AOJu0YzlE4IqlVUgXp8WAbtp7Bu0hircWXlspHdjqCuyBlcpDdTG+h4K
	yoet/qvaexO1IdDqU5mGG5F0sJ9AO6Sfvx/leD8ZVgc7O16xBljIIbjJudgC
X-Google-Smtp-Source: AGHT+IGwWtQjq4qyvFRBq7hNm/3raRx3/LVuPA7alO4u/AsRK/tF+87w/JC0NOyjjN8vZg1lKwog2A==
X-Received: by 2002:a05:690c:a8d:b0:61a:c17e:d79b with SMTP id ci13-20020a05690c0a8d00b0061ac17ed79bmr9602098ywb.28.1714376967599;
        Mon, 29 Apr 2024 00:49:27 -0700 (PDT)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id y192-20020a0dd6c9000000b00617c1a45432sm5300193ywd.46.2024.04.29.00.49.27
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Apr 2024 00:49:27 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-61b68644ab4so38770107b3.0
        for <linux-sh@vger.kernel.org>; Mon, 29 Apr 2024 00:49:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW98umK3N2Artc61YofUll6IAiJjxPyWu1tdAHBvT+sNnaoJfa+uk/9N+ppf2cjDdTS18odmHZYqQuOgTEYT5LCbS4pOxWiIBA=
X-Received: by 2002:a05:690c:fc4:b0:615:20db:4a4d with SMTP id
 dg4-20020a05690c0fc400b0061520db4a4dmr11457189ywb.35.1714376966982; Mon, 29
 Apr 2024 00:49:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <23e9b3fd0d78e46c9fc1835852ba226aba92c3ca.1713959531.git.geert+renesas@glider.be>
 <d5f53c4c490d0058956f6a501191107c4b148720.camel@physik.fu-berlin.de>
In-Reply-To: <d5f53c4c490d0058956f6a501191107c4b148720.camel@physik.fu-berlin.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 29 Apr 2024 09:49:15 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW5jMg4K454S=jQkU7EZUXyKYetqFVejL0ft1uxAJQpGQ@mail.gmail.com>
Message-ID: <CAMuHMdW5jMg4K454S=jQkU7EZUXyKYetqFVejL0ft1uxAJQpGQ@mail.gmail.com>
Subject: Re: [PATCH] sh: boot: Remove sh5 cache handling
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	Arnd Bergmann <arnd@arndb.de>, linux-sh@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Adrian,

On Mon, Apr 29, 2024 at 9:46=E2=80=AFAM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> On Wed, 2024-04-24 at 13:54 +0200, Geert Uytterhoeven wrote:
> > Commit 37744feebc086908 ("sh: remove sh5 support") in v5.8 forgot to
> > remove the sh5 cache handling.
> >
> > Suggested-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

> > --- a/arch/sh/boot/compressed/cache.c
> > +++ /dev/null
> > @@ -1,13 +0,0 @@
> > -// SPDX-License-Identifier: GPL-2.0
> > -int cache_control(unsigned int command)
> > -{
> > -     volatile unsigned int *p =3D (volatile unsigned int *) 0x80000000=
;
> > -     int i;
> > -
> > -     for (i =3D 0; i < (32 * 1024); i +=3D 32) {
> > -             (void)*p;
> > -             p +=3D (32 / sizeof(int));
> > -     }
> > -
> > -     return 0;
> > -}

> Interesting, looking at boot/compressed/cache.c, it seems that the whole =
code
> is actually a no-op and does nothing but increasing a pointer. So I agree=
 we
> should just delete it.

It is not a no-op: it also reads from memory, to load new data in
the cache, and evicting the old data.

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
