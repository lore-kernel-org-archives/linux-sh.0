Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D2A21C9EA
	for <linux-sh@vger.kernel.org>; Wed, 22 Apr 2026 06:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776841059; cv=none; b=QBmup70/6d5McMLRygGn+DsfMAhghDTLj10yAP5KUPOokq7eRYpBg2gk859LxOfxiWVSg/Il7bct3QQBbNjz11GWj314N+CtGpJ1O4Xby0oqxNa43c03OXvrMejNfVZV/ONlhYVUVYxyvJ0W4MZ7yYmDhi4qhkjUmqfjmiYuqQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776841059; c=relaxed/simple;
	bh=5Se9mmGOdAKNOZf46jIOT2dd1KRWhn02v34saGHG/6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ignza9Evlq88LybJ5z9UtTxg0yXg0/mRykrIqHwOIYNzdUQlBOP/K05d8tfm0CtLQeiP9FuBJE5IpY7/m7Qxr51sMyHqHSVs2FRCyQsgEopXmiwrjz0I9nwmK133ShjPDktH+/9pJRm1JscNRl/UPuM48nW1CMqlMbPqaK7Svt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-944168e8c5fso3099101241.2
        for <linux-sh@vger.kernel.org>; Tue, 21 Apr 2026 23:57:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776841057; x=1777445857;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4e+EuUu8L/Jho0NvgfzVmfB1qP+hLKiQ7lxNfiicIQw=;
        b=HBn1oRu+jnXGbAtXCIThNfeBW8VVYSMWfQ752QrKIoxdmt084Bc7Xr20TXnYMh3Eqy
         WcdHGGk9d+BYzbneerxRMktCnIVkv5IJ3IoPZGddbZBlpezVVIzju+0582MESTmRkQVx
         xp0rMjyDXhpAgTTfB3ywtLER8UZcX/5aEZwUNPLxjN9ms1j2ADjk0IlDCEKG+X3lN0GC
         JplPPs40u6dYsIy/AgOd0IZRZZwkueM65enFuT7z1Pu0SugA+FQj+IVGtoQxekaZYI28
         aRTSgnv0ZRU8Ot0uxA5nChnQ8EHybm9MC2A7NkpisS3JwlXC3Tv9ffAt/7m+BV0WBYHp
         erLw==
X-Forwarded-Encrypted: i=1; AFNElJ9qDCwPjYxNBEV/H51YuFdM1Rh8P5MtqviG0HBqLjRw9Vw+RtFBiHaevW+HjNghHRJ816xiofQPqg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyoGeKlTDOxlGfxkDWxhWpevl2/pyXrXcjjhmhbxYi/ZhbKgdJr
	ECXmyD3JHUy5+Z6AKOFkF1GQYUGlMNU4IHHR3+KUB7XVJctVxzHGx4ZS+xSIQpad7f4=
X-Gm-Gg: AeBDievcSi8tojFP1HC/j1umJylebQwrCcLiGG6bHgDCvpJ0c6HSUl5ZHMkJKY2MzXx
	7kT7UK0DFOEx1i15EfDtk4UFVRxf8Txz7/u7et8MLu+XdG+OISp9ePdoL1hRYBds+ZIuaBPkTNa
	k7ucMaXqeksfAk+v1FZp/Sz5q2MHJBmDvCco6vIw5S06yIKZrdYJqiWNxByKZw8ooCILr/j1hii
	bgO8kuWL8KDQn1iMeWtlQEzsy4ZMH0oDl+NiANifQhfvYURAsWsrEC5eFYGl0nDI6Uq/gi2nAX7
	9Rziy7H/pjkKmJzrN3lEMWlHEEllXbC6H0qW06wM7tltUaQrUeun5V3Q70X1PWBNBWbU63XSvN6
	AFDkiEwiqp93GRbZ7tujchMi4oT20BR9I0EBMCaA/dOUf8kqk9364U1zS2qRMbHnKW8gwYCXXD5
	kwfO9z7evW01FAJt92K1x2DqRvFFUiiBilOCtdnb+RtlAlz3PL403GWUYnprCAdIZY8TTRA7j2j
	p4=
X-Received: by 2002:a05:6102:c47:b0:602:ba51:5235 with SMTP id ada2fe7eead31-616f7c4b540mr10331987137.29.1776841057472;
        Tue, 21 Apr 2026 23:57:37 -0700 (PDT)
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com. [209.85.221.177])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9589065388asm7330989241.0.2026.04.21.23.57.37
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2026 23:57:37 -0700 (PDT)
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-56e91f17a99so3364083e0c.3
        for <linux-sh@vger.kernel.org>; Tue, 21 Apr 2026 23:57:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+vzv5RZxkbWlTKKM86lKIOvprS12Mf13NAJnu9jzO4tnx2wtG1aem933gfSST4GJdr+W9pr1jgNQ==@vger.kernel.org
X-Received: by 2002:a05:6122:3d0c:b0:56f:1bbb:83d6 with SMTP id
 71dfb90a1353d-56fa59d7ed7mr10453273e0c.10.1776841056862; Tue, 21 Apr 2026
 23:57:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260420150958.17072-5-thorsten.blum@linux.dev>
In-Reply-To: <20260420150958.17072-5-thorsten.blum@linux.dev>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 22 Apr 2026 08:57:24 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW7ozfH2cLmtHYVsYSsz31jPs103d2FFhsTFaiwDp5=aA@mail.gmail.com>
X-Gm-Features: AQROBzA7rJ044Nj8u44LYAUZksIwezmwBBtTTXPk3Nzedvl5Lpn7LdaDKkDK2-Q
Message-ID: <CAMuHMdW7ozfH2cLmtHYVsYSsz31jPs103d2FFhsTFaiwDp5=aA@mail.gmail.com>
Subject: Re: [PATCH 1/3] sh: dma-sysfs: use sysfs_emit{_at} in show functions
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, linux-sh@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 20 Apr 2026 at 17:28, Thorsten Blum <thorsten.blum@linux.dev> wrote:
> Replace sprintf() with sysfs_emit() and sysfs_emit_at() in sysfs show
> functions. sysfs_emit() and sysfs_emit_at() are preferred for formatting
> sysfs output because they provide safer bounds checking.
>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
