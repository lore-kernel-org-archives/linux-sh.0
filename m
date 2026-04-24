Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C8D394493
	for <linux-sh@vger.kernel.org>; Fri, 24 Apr 2026 11:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777028767; cv=none; b=CfGOyKJE5Ux+aTEywPb0+rhir2mre0mAeHd+vGLEhGoUOjO34zw4e7hhkWzpAVofnTt6a7bKHBXF2TnP8epc3ADl3Iy9iJzo/mBdeiEctIUETChmP5KzxyWf5AOG3bqjV7vyUj2e41DpDjWPeJDxskme7DjURyhONfJCGoGl3w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777028767; c=relaxed/simple;
	bh=t5a9hCknwJ0hWWET0nSRaaDZsZWkGV1IY8uIy4fugKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=akATd9YrjIu+AV6gqZYZnp6mLwC+baNePNcCibtx+qVt4L+SMn/83CCv+l69mtaygbqfhUnMF5/KrAsiliyYXWGEWJxFkGxTJxVNvLvE2UnQBLQ6Ryw2TEIS+v/3181h1y5qwkHsMo9TxsiMf91kWedPVs9D6sfUA8MF1nihwj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ba60d78aff3so911740466b.2
        for <linux-sh@vger.kernel.org>; Fri, 24 Apr 2026 04:06:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777028763; x=1777633563;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wU3oIl6nRCUqqOPSmntV1ljbpDpyxG7BAuTGCE44/0U=;
        b=fraVQcf+iHoeCgZZTvcQznWhU5imKUFS6bUPX8qiaU4/8D+/yp8DZE+VWwOR8tVfbH
         k4MABCL0e/YKKcir98GS0UkBU19p1BEC7nH5N/11AEJ/VuhJ9VjO7qx5jjGaAXfLBNfR
         tSOHrQcoGRzDVNe/VIdqNJVrnROsMZ+QbsvgtKpDKQz+GXJua869RAY+jPFkyEp+9Hyr
         +H+xU00BKi/cILP15700q4YfAZlCpDUHMg7aTY5IxUTbKrbfSo7n2+vij8TUO8z7XZLA
         vfYEY2Z8nUNAu3spJI0sPNr3f8kBScqST6vuWASAUvOUYh4KCBFtTr3jzIh0xJN9v3Aa
         OAsw==
X-Forwarded-Encrypted: i=1; AFNElJ+WwhHQbIphcyQ7xjS3KbC2wuSVOi50lip5Sp78YaMC9I1tlAi6whp5eoU0OY/dFFsb37bnTHJJRw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzqwPSQOu24EcecCTXnd5tvp5rJSSV33pL++0Hj09tM+924w/nD
	wEdhm8+TfAUbbIX4nDcsjSdsREF4eIyDOhWy5f5JT87EK1Ps6Fttovtllws3F3hV+h0=
X-Gm-Gg: AeBDieu5GDyUo6UxLb5NaCqziUc4FqedTvJG+ZFEjonwVnGn++is7ztVDhf0MJYgr1t
	HW+q2Dp3F0Q70zWjWqD7KC3hu3UlAI4cCM+/A+w1mvIzOlSoLOTWaot6A5AjCgIEXRyoczFSDXh
	PSCJOWcG0Pv/DT6mmuur/p4vxm0cLQMoYmekzWi40gXNq7mYNWIJWfsTHPDbrNqZF0rZNLlC9uP
	10gWqEKPu044goQIq1X32+bkbnWlH2c1ZtSVKrLfxXKiqbwwzhCioaSpGUmzlxNZzW/hGI3ekOl
	XYCyDU5ew2SfpeuKK1oQg2Ytgo83B/ap8LGzBuy421MhAMkRkTOYKdzgVejD6XUMWUm9MntW0+4
	e3eCIBBHXAokuZjVfXENdBNC1rRHlZ8fAWOEmq0570VVsHnLPCIrF3yP+VprhN0wDm2mKVP+af/
	d91hyvBrhb4bgwnQ3f8quTlJXa+zp5wnoVKUt2S4l0eI1yDo9BeNsKA8pGhV1UJNNpZtDseVw=
X-Received: by 2002:a17:907:968f:b0:ba7:d004:8f98 with SMTP id a640c23a62f3a-ba7d00564admr1174426866b.46.1777028762852;
        Fri, 24 Apr 2026 04:06:02 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba45553980csm765564266b.58.2026.04.24.04.06.01
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2026 04:06:01 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-baa8c78ac7fso547695266b.0
        for <linux-sh@vger.kernel.org>; Fri, 24 Apr 2026 04:06:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+ptU+JL7H3+ZAv5LA/Xb+/ZqvWa0piDXwxU6XQU21PwqfGd9nJPFnMCySjC/AJMCFyG4B0vKDr1w==@vger.kernel.org
X-Received: by 2002:a17:907:3f9d:b0:ba5:20b1:c13b with SMTP id
 a640c23a62f3a-ba520b1c177mr1459451766b.28.1777028761706; Fri, 24 Apr 2026
 04:06:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260423120441.212278-3-thorsten.blum@linux.dev>
In-Reply-To: <20260423120441.212278-3-thorsten.blum@linux.dev>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 24 Apr 2026 13:05:48 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUzktvZ2x4yVvq6CDXCe8XJ49MAea2krQHGYPEVQ-sqPQ@mail.gmail.com>
X-Gm-Features: AQROBzBWiOlotwMWmm7C5Tbq2GkbTGGlZ1d1Vtn2if8RA9n0bqCT8GCV_2UaAXQ
Message-ID: <CAMuHMdUzktvZ2x4yVvq6CDXCe8XJ49MAea2krQHGYPEVQ-sqPQ@mail.gmail.com>
Subject: Re: [PATCH] sh: use sizeof() in memchunk_cmdline_override
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, linux-sh@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Thorsten,

On Thu, 23 Apr 2026 at 14:10, Thorsten Blum <thorsten.blum@linux.dev> wrote:
> Replace the hard-coded string length with 'sizeof("memchunk.") - 1' and
> remove the comment.
>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Thanks for your patch!

> --- a/arch/sh/mm/consistent.c
> +++ b/arch/sh/mm/consistent.c
> @@ -23,7 +23,7 @@ static void __init memchunk_cmdline_override(char *name, unsigned long *sizep)
>         int k = strlen(name);
>
>         while ((p = strstr(p, "memchunk."))) {
> -               p += 9; /* strlen("memchunk.") */
> +               p += sizeof("memchunk.") - 1;

Can't you just use strlen() instead, i.e. won't the compiler optimize
that into a constant?

>                 if (!strncmp(name, p, k) && p[k] == '=') {
>                         p += k + 1;
>                         *sizep = memparse(p, NULL);

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
