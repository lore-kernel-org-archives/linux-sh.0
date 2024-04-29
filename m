Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8907815E8B
	for <linux-sh@vger.kernel.org>; Mon, 29 Apr 2024 08:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714379379; cv=none; b=muw/WupD8UrFiCYuaUgOo+/uWOK6GLZRUMmjJ8LtUGMx9XUhSnm1WXodcod8d9vx7bG9BY5u/N4cF7ZAGcJwVKTv11/klxRqKn+WUjaESQgdVb5XRttSHfXsO/SXcDnNI+blz+zkHv9+axgpbezUFJmksfQ5OmVAD3153MSS/GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714379379; c=relaxed/simple;
	bh=n23cp+0MKJSv6s7t1/FasoRnS9VRaYPwOM3fs4ziZik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HNjaVPxzTSPli+AdeyTtbRhmEIv9VMCg3I5jcj7TzbPjohUdZuI0Ie/36DT1W/ZQP6CBrJnkipqHDjGg1uZCiDwrOFfTeHFJdgj9L0flgg6D4LJBVLA66zEcgHbOCONqNrYBxVF3+h1hezeRjIic/v5bMWP0DMYMrMwL1yQ6GnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-61af74a010aso41090587b3.0
        for <linux-sh@vger.kernel.org>; Mon, 29 Apr 2024 01:29:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714379375; x=1714984175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qP838ybLo0vClxDieydL/8Gj4Tsl9YbKZ/29WjcXSiM=;
        b=uNUYuAxN24ykrqAiasDxP8LZntNGuoNtB3fhQJ+MfmpyQB4SyzqbpyeOlfSoVCLC58
         yEK9fC1lKRHDdwCjOYs+rvfv79PeTEC4yhjul2kLPbOfiscExZirCkfR6w3wtmGp3JGN
         vdnyCjyRDa8hxYzEhCiswhOiWeV/yfixiBA9RQ8uOrFNvr9vmrcQ0Al5ShSoz7M43g42
         9EVqwF7unZUenSoBc5onldNVQ20KGi5FyTaYl4Xtk6gw4ccZgdv3bFcQLqtgVxYZTI6D
         qCb8kMO7K09wa9IlWOQo8ZSdOp2TWkrRdPzCHKIpCVY7wF/RYJhbov5kHFud5spx4hSZ
         joOA==
X-Forwarded-Encrypted: i=1; AJvYcCV0HduXQW4s1wiyJs9/jSF0nrBG3fWX7QCjHkcwALBwpvvut7hncv4dG0HCKuLLwUpeLKGJgciDUyjVFM9uXrFzMgXpJO8LFLw=
X-Gm-Message-State: AOJu0Yx72/b0WIr291ev7X3Zq0vu8/Z4yth9LHJHv+MXdil8bA4CyvIz
	FxTnoETR4R7eOnXI8tHGWi9XUR71zfqcFTeDMcEkn/ofDEqwLcwWvM1Kv7nD
X-Google-Smtp-Source: AGHT+IE0VRQLCVrlG6LIJW9P4AbROuLWoqdylXSI4NNTnMOdw8l2V17BESNO4938j2nnRj0GkmsMEQ==
X-Received: by 2002:a05:690c:6401:b0:61a:d21f:a131 with SMTP id hr1-20020a05690c640100b0061ad21fa131mr10775179ywb.37.1714379375533;
        Mon, 29 Apr 2024 01:29:35 -0700 (PDT)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id v3-20020a81b703000000b00615bd0701c7sm5298501ywh.118.2024.04.29.01.29.35
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Apr 2024 01:29:35 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-61acfd3fd3fso45002977b3.1
        for <linux-sh@vger.kernel.org>; Mon, 29 Apr 2024 01:29:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWC4Ytc6hnW/wSJcv8u1qSZlZ32zz5TDcExd4s1Ou8nWFoyvawnXq4+yiBYXSMI7UZ6RkydbQPPx0bj+b3W2kSi3o4DAKZPdEE=
X-Received: by 2002:a05:690c:3391:b0:61a:d3ac:5b51 with SMTP id
 fl17-20020a05690c339100b0061ad3ac5b51mr9413022ywb.38.1714379374988; Mon, 29
 Apr 2024 01:29:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <23e9b3fd0d78e46c9fc1835852ba226aba92c3ca.1713959531.git.geert+renesas@glider.be>
 <d5f53c4c490d0058956f6a501191107c4b148720.camel@physik.fu-berlin.de>
 <CAMuHMdW5jMg4K454S=jQkU7EZUXyKYetqFVejL0ft1uxAJQpGQ@mail.gmail.com>
 <23a3abf08f358588ef448c1a2f2ef53013ce6b69.camel@physik.fu-berlin.de>
 <CAMuHMdXRDRfTB7WCP8O2ubgN3_9L6Hz2yEcUY3urFksM-2FEmg@mail.gmail.com> <09d677ad889a0bc2d7ae4324e0ca3e90d741b23b.camel@physik.fu-berlin.de>
In-Reply-To: <09d677ad889a0bc2d7ae4324e0ca3e90d741b23b.camel@physik.fu-berlin.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 29 Apr 2024 10:29:22 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWrzme7Nr400-fcsYQx9Pir38COKGGMjnQG3fcpTHt_bg@mail.gmail.com>
Message-ID: <CAMuHMdWrzme7Nr400-fcsYQx9Pir38COKGGMjnQG3fcpTHt_bg@mail.gmail.com>
Subject: Re: [PATCH] sh: boot: Remove sh5 cache handling
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	Arnd Bergmann <arnd@arndb.de>, linux-sh@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Adrian,

On Mon, Apr 29, 2024 at 10:22=E2=80=AFAM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> On Mon, 2024-04-29 at 10:06 +0200, Geert Uytterhoeven wrote:
> > On Mon, Apr 29, 2024 at 9:52=E2=80=AFAM John Paul Adrian Glaubitz
> > <glaubitz@physik.fu-berlin.de> wrote:
> > >
> > > Don't have the 32-bit SH CPUs any caches? The code itself is uncondit=
ionally executed,
> > > it seems.
> >
> > They do. E.g. SH7751 has 8+8 KiB of L1 cache.
> > But e.g. sh7724 has 32+32KiB L1 cache, and 256 KiB of unified L2 cache.
> > SH772[34] have l2_cache_init() to enable the L2 cache, so probably they
> > boot with L2 disabled, and we are fine.
>
> Understood. But what exactly was the job of cache_control() when all it
> does was flushing the cache area? The cache is not enabled or disabled

I assume flushing the cache was needed to push all code written to RAM.

> here, is it?

No, it is not enabled or disabled. Probably that was planned for later,
cfr. the command parameter.

> Also, I was wondering whether this could be related to the boot lockups
> that I am seeing on my SH-7786LCR which stops after printing "Uncompressi=
ng
> Linux...".

I doubt it, unless reading from 0x80000000 causes a lock-up...


> I will test later this week whether your patch actually fixes this issue.

... in which case my patch will help ;-)

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
