Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0EE13BAEE
	for <linux-sh@vger.kernel.org>; Wed, 11 Sep 2024 07:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726039802; cv=none; b=EedmCsOnmf8mj3u4AMdYy5f9gAxBcLJGxbzZ/stflMZErNR0dd+s1TUnXl5wXVg3gwoY+ITMXtGUX+R48a2xhO7JQyUhxSFSLJGvI0DhWkMkKdBhjKcON+6sftlCT9+E2/Btg+Z37s9yHFyKuwmGve/a8XITZU28zW9tJbJTYU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726039802; c=relaxed/simple;
	bh=cjjaHCI8mNXu9Hwd/4D/Np03pWTpzgz4jBBiaQz8j64=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tjpCZGfZCygw6DwL7X6JBNJ+RQ7B6PnCNumZLuk/V2dyxrivWm2jZkVN4KCSzYA1XLvBuZ+D4bRs261s+yMH2qcNGc7QLqaC9euN66R0+FCF08zhu2TS4U7IWGCLdZ/8PWM1gMXpfUI+qdyv8ORYp8S4rPTJDAvALUVeY3RAfgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6d74ff7216eso59337767b3.1
        for <linux-sh@vger.kernel.org>; Wed, 11 Sep 2024 00:29:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726039798; x=1726644598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BOk1FOCcSSBwtC4d1EyvDirnO1scOxPxa13ggfz8vRg=;
        b=uc1aKOJvop7rSYueUqvNjem9G5HHqFs72qQ+OkG/O4qWRx6kC82bBv3YxfNFqTof28
         h1nh6HZZWnxkVG4WLixKooygNhhFuaHC3B8gCDJeLjQSJ7zmMjm2FxUdmnFkuhs+zkHd
         +KqogdFl0PhMKvLoc2BXvabgaFlTTtxh3ycdljPlVEfGt4wl5uWH+b6qJXdvxKxaRlWa
         kFfGZCX726gjwLnN+9bsV6b431LuBKlArOh12b71CEN5xDAFknr+U9Remssxvc3D/0Yq
         9h4H571ykU0a1yzNQwFiH5HMH8mHGoghHyyXMtXf/cYlt3+LDVls1dCxRvGejpy+qxnL
         m1uA==
X-Forwarded-Encrypted: i=1; AJvYcCWBdmZVnO7oDv8HJCYSjH0llYAVZOVOUxoSw3bv+/VIfyUYskMriJnYKE34Tw/3doc/ddgZ/NXgyQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz74VZkAURxu2yKUlBal4tsZq+e8E4xOF7qqSdSDZUM7rp9n2G9
	qyJAwAgjtl/z3d6r2M/YwzuZOyxDHyHXgubE0OPo+Bu/anakaI9LyjDo/jCi
X-Google-Smtp-Source: AGHT+IHVVZ1UAMNn+pQedJ7PEV/TZ/8627T2dnQIlhW5o+Ri4y1ahWRVBxa7y3fQQ8a+/0+aDYhKGA==
X-Received: by 2002:a05:690c:c1e:b0:6db:98ad:86a with SMTP id 00721157ae682-6db98ad0960mr44441517b3.40.1726039798476;
        Wed, 11 Sep 2024 00:29:58 -0700 (PDT)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6db9652d024sm5917157b3.141.2024.09.11.00.29.58
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2024 00:29:58 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6d49cec2a5dso59033997b3.3
        for <linux-sh@vger.kernel.org>; Wed, 11 Sep 2024 00:29:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWNNc3LqkqlxOGvyTBH7UqyXt2mX8OygMftOkPiZyHuwpMe0jdQy1tumruFfHpRWyk7Xy+8Mprkdw==@vger.kernel.org
X-Received: by 2002:a05:690c:39b:b0:6d3:be51:6d03 with SMTP id
 00721157ae682-6db44f2c1damr187680177b3.23.1726039797973; Wed, 11 Sep 2024
 00:29:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240910001612.88569-1-marek.vasut+renesas@mailbox.org>
 <20240910172151.GG4252@bill-the-cat> <1cd4c1c1-b709-43aa-aff8-14cb1d21aee2@mailbox.org>
 <CAMuHMdVvHtVmH+YP=m20U9-buXKi1+Kwcrkf8vWhQYagcg4JRQ@mail.gmail.com> <2c133f811fca225a0f796b8b94b16e63b33e56a6.camel@physik.fu-berlin.de>
In-Reply-To: <2c133f811fca225a0f796b8b94b16e63b33e56a6.camel@physik.fu-berlin.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 11 Sep 2024 09:29:46 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXv3yAwPpw2-qoKB8ijb+sA+U73t5-HQgtAoU04NRJs2A@mail.gmail.com>
Message-ID: <CAMuHMdXv3yAwPpw2-qoKB8ijb+sA+U73t5-HQgtAoU04NRJs2A@mail.gmail.com>
Subject: Re: [PATCH] sh: cache: Fill in invalidate_icache_all()
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Marek Vasut <marek.vasut@mailbox.org>, Tom Rini <trini@konsulko.com>, 
	Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
	Linux-sh list <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Adrian,

On Wed, Sep 11, 2024 at 9:23=E2=80=AFAM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> Odd, I haven't received the original mail.
>
> @Marek: Could you resent your patch CC'ing the current maintainers of arc=
h/sh?

It is a patch for U-Boot, not for the kernel.
Full thread at https://lore.kernel.org/2c133f811fca225a0f796b8b94b16e63b33e=
56a6.camel@physik.fu-berlin.de/

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
