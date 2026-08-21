Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E503390C85
	for <linux-sh@vger.kernel.org>; Fri, 21 Aug 2026 13:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787318142; cv=none; b=uUJhwzAY1XwtjsLqX+H1GLq+7h0SECAiEQLGPzxQUu+8RyG6u18+h0Xz5bzEjL0WX637Joc4gssvevvk9fbzGuraO7cmKZDMr0Wx7XI7mf4L+14dZ5ErP6nrSboS63GPeCCsgnB0Vo2fAniTrDFCNnlxKeG+aab5s27t1D+wPTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787318142; c=relaxed/simple;
	bh=6kQbT1gIu0XiHuVTt+KxzuS97ZAU3Rgnj/AF0hkWYXw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DnF/ORmWhZewND42JOP+oTMAszYpzj+GvszWnsfjUbcfvewnOOYdbMnvd1i+Bh1ynYlRa8TbYGQNMjDmSyF1Sg349WsFZAf0upIJ4cGvCQWa4Dl50w9mispzG28P/ALrmn7003oU5XhiAEnHztXnL+evwhH4VwL7ZxJzK/yd0EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-74dce749cc5so231362137.3
        for <linux-sh@vger.kernel.org>; Fri, 21 Aug 2026 06:15:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787318118; x=1787922918;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KbR/IqWWJ9SoTQBLflO8X0Oc5JuNMDe4oTcqikxJVts=;
        b=UgRKl50yl3HzJkImZ3V46WvcDAYaQGTAb8GPrSRjazmo6bFKDvd1iQlDlWiVUmsmYo
         jLcEmprtLWECMgOm4HO5HGF6+ns+8dFCH0fGBMCo33tehVHtYkDQoAC7Ik5L8gDdPcFf
         mWQWHNHdAIO8OsjSO1oYHY3D4cT/qv3v6lF+1kgkQ676p4gi/+0ZRAhdlGkzb9A3UF0b
         OIj1dLay26p71GNNtWZoC1rBn9UxV6S5gUPrDXASSUVVthEjAd4OZEcejF2LR4ii/Y5Q
         p5/2pHAIdA+Xea1GsuDIauBv0gUvaRKezRzJwYlI6azpBcVdic8KIiz0OWNunAQuIhFd
         b74w==
X-Forwarded-Encrypted: i=1; AHgh+Rp5UPYT2X6VLcWDIFY3lOqPq2iXEbf2rop8w+055xlL4/1okRDuUj71PVFowbj+KJTQ5KWqvROiCQ==@vger.kernel.org
X-Gm-Message-State: AFuF++mGDMLrMNZu94VKkEpFPFGTLunbk7/HKWBkI9KMpFpuKSAfMG7c
	7nCwBQbpOj4Q6gK+m1/fe3KoVl6aTvsxnbuO1yp20BcoL5Mz4KxcrmiPDBAVqDgZ
X-Gm-Gg: AR+sD12BQncXqu1om6OFbybjrVvH/zq2E1lr7mRAD5v96gBzwrt5bfc6IzVQIAS0d4u
	w51LEg3TMryqrsMHjx2GrbKJxhY8bS0Kq1ct3k6omcI/Ilqp8STpm4g6oWtdFfSEbjg9L27xcgy
	+MIVCGjAGNw4ky97Evl0FRUnIClQJfEfKvqS+yFPmo1TJ+ymrZ/SxWDQi1dgUx8uCoTpgFdR1pa
	OzondaeqqB8ZfEJDk7cxZGO5s/AWt97w1AiAhxxka2iDzAkNo4431MB+FiOqvIadfCHcsRvz8hf
	s9uzGYJ7JiLhtlWkBMZEqQ6mWLHIgpwtsFBmDdiNJvI4WQ4Dt2DUlVMKu9D/Ylhs9VQwTdALAez
	ctlZGuegoTHFkLIgBF+i8Pc3dvSSLYPkW5zna8lsl9FOQtloQ9jpsQM9DgS1szefQhae+764EUo
	pj8kpEmFtfCqPHlI8olxPSbq6WTLEna7Q3y6ZweSXxEXiSAF1wNYq5QEhQp33i0xiMwaueqIfOz
	kEEVsu0k1SHQ834VKJBxmUxwUJd01zbv4+E
X-Received: by 2002:a05:6102:390d:b0:73a:128b:ea07 with SMTP id ada2fe7eead31-77a65474816mr1986145137.14.1787318118274;
        Fri, 21 Aug 2026 06:15:18 -0700 (PDT)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-777dafa9b1dsm8562988137.1.2026.08.21.06.15.17
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2026 06:15:17 -0700 (PDT)
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-75738fcb0d9so254085137.0
        for <linux-sh@vger.kernel.org>; Fri, 21 Aug 2026 06:15:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpaJkAGRCZZzIhXM1y78Q702XU9vURFVMlib0aT8y3xjlzfbFJ+Jg2C7ZpLnEAwyIfQm+v59+dH9Q==@vger.kernel.org
X-Received: by 2002:a05:6102:d8e:b0:739:478b:5bf2 with SMTP id
 ada2fe7eead31-77a65274602mr1722130137.13.1787318117087; Fri, 21 Aug 2026
 06:15:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820123931.142532-1-ailiop@suse.com> <047975cb5fdeb0e3cb52cb78d55c3a45023cc992.camel@physik.fu-berlin.de>
In-Reply-To: <047975cb5fdeb0e3cb52cb78d55c3a45023cc992.camel@physik.fu-berlin.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 21 Aug 2026 15:15:05 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXT44zxeNmNZeufKxUWz3_iYPqAY7Nu6g8eL4EBx1grnw@mail.gmail.com>
X-Gm-Features: AcwNN1UgxukBrqyPOvtFT8QN7xa-BgXMe0TLSK2N3359or-fT7NvoBUgyvML6JU
Message-ID: <CAMuHMdXT44zxeNmNZeufKxUWz3_iYPqAY7Nu6g8eL4EBx1grnw@mail.gmail.com>
Subject: Re: [PATCH] sh: remove unused setup_profiling_timer function
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Anthony Iliopoulos <ailiop@suse.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Adrian,

On Fri, 21 Aug 2026 at 14:11, John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> On Thu, 2026-08-20 at 14:39 +0200, Anthony Iliopoulos wrote:
> > setup_profiling_timer() is not used by any code at this point. Since a
> > default weak implementation exists, there is no need to keep this
> > arch-specific definition around. Remove it along with the now-redundant
> > profile header includes.
>
> Do you have any clue why it was still implemented for LoongArch which is
> a rather new architecture? I'm also seeing that it's not used anywhere,
> I'm just wondering why it was not removed before and why it was even
> included when LoongArch was added.

To make it _succeed_ when writing an integer value to that file?
The default weak implementation returns an error code.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
