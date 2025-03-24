Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1DC433A6
	for <linux-sh@vger.kernel.org>; Mon, 24 Mar 2025 08:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742805263; cv=none; b=LlZrJiZ9jUBDUsGo5pm2UKjE/s1XJnkcv2VIGyU8JWzf6VvAzwcy/jY1+FM013BDpOnQ6W9bO0MQGqXJxOZbHGFGf7k8AxbrLkFzwzDS5yZdFBxCLBVD/r+HTgeO9TQvRPTa0vU0EXZlzLdmOhPnEVttS7nv3/zcuFFytuvrb68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742805263; c=relaxed/simple;
	bh=Ikyk8tEGyVYJtfl6CoeuEGpX8IKaOePD9yRbwbFjehc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E0E6Gb3iVTklBVF+qVTJObmnVeNZTv1/wrX1ac6DI0Pj1DZPpxEpIGdwrTR4J1PCo/RxSVTZxbrHuus/yODyuS09A9Q+HXHZQnrvVGLaRk0tEkOKU525ZU0jBB4vbb2FhBmNVNVioCRB9sqByAyOxnq1p/KrekpsHKqlVmZSDMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-86d6fd581f4so4642318241.1
        for <linux-sh@vger.kernel.org>; Mon, 24 Mar 2025 01:34:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742805260; x=1743410060;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yCOWr5OVgRs94kTbQSYoiNiaJHkAjmdjIZDDP7OCb8g=;
        b=gh/an3ABDlqJisPC7UaF+FT6DsoNDoaaoiUITh15dcCe2QFIR0X+44QW190YVbxDcE
         Zej7t41/nD0JJqof7b3pzTxyapZjz6d5Ni81z38syTBbJjxj2lVIdCOSyRR6mQKk7BMd
         jDYlfMRe/izjCkdSwp9kQGQtopKDeIL7+MMonMjZbZft1jLFv64krv7Vs4+rtUswLopv
         TjlfmW/nu1V2wfWWWC/5jElDGLvFOefqUF7j2jpwZN8p9A12glh5p4AuvngX8fm2f4sA
         lLGq037PZtAQVg6geo12y+l0fSjbKmKYhontaJkWhKfeFfLo6piLbYlJnXsKslbSDjp9
         x4MA==
X-Gm-Message-State: AOJu0Yy6+IUYPctTHRvyqukSeqJLNk1BFKdlsRUkG5v30ipghz/znBkp
	88SZ40+Xk/CH67/86To/UiY6igcrnK0PrzoiBnBE7BvXsKrOCvHv0YAFkgy0
X-Gm-Gg: ASbGncupKwvQkok7JnhtcSACLuu4DqGeT5mDcjhdaJHwK4nfRkTffVHtYlIw5wlPlG/
	8To55HfSwUa6k18GSpGIUPAmJZVye2qnIIoq5UxEosRvIsaZHl9bOu90qLa3iejQIh8hlckimlD
	g/Y7WaQJOcGkQpKcSotF0xUeZho7LJC2fzGjdUPJjstOIAnHwQrBmm6ZHkX6ZeoFl0eliq86jSy
	ciRA1uFi2HTeS7uGAHNDsIbZiqA7YeRq5vWYqRzhW7IRb2DgkB8MEtostyVB5WMFyDV7HArcCU0
	YoaHiBcPoGeQDD3ahdOkQJWHY41szHMdVBPLj6B5TLXQqAW8hMXDLjtggkrmkZF0XFdDof4ou4T
	WmJSkCE8=
X-Google-Smtp-Source: AGHT+IFJt6e0AxACq5sEds5Z6nY6s7WKuZuMCwK+K+iEWVpHnQsa2HFUrdBf94C1ZxjIxztBBmdP0A==
X-Received: by 2002:a05:6102:f11:b0:4b5:aa91:f29f with SMTP id ada2fe7eead31-4c50c89e088mr7855069137.8.1742805259926;
        Mon, 24 Mar 2025 01:34:19 -0700 (PDT)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com. [209.85.222.45])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4c50bc4b7e2sm1491136137.16.2025.03.24.01.34.19
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Mar 2025 01:34:19 -0700 (PDT)
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-86d30c329f2so4079973241.0
        for <linux-sh@vger.kernel.org>; Mon, 24 Mar 2025 01:34:19 -0700 (PDT)
X-Received: by 2002:a67:fb89:0:b0:4c1:8ded:2d66 with SMTP id
 ada2fe7eead31-4c4fc1ca0b4mr9802209137.12.1742805259317; Mon, 24 Mar 2025
 01:34:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250323191330.114640-1-johan.korsnes@gmail.com>
In-Reply-To: <20250323191330.114640-1-johan.korsnes@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 24 Mar 2025 09:34:07 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWYTaFda-=JVcArb0fTKSMQVec2HrG2WRE0pAUWPAnp3A@mail.gmail.com>
X-Gm-Features: AQ5f1JprRGG8t7K9LmBdqF-_PmOk3gxeg9enBozcalhjgm4SXvT0Uth-WYGm4i0
Message-ID: <CAMuHMdWYTaFda-=JVcArb0fTKSMQVec2HrG2WRE0pAUWPAnp3A@mail.gmail.com>
Subject: Re: [PATCH] arch: sh: defconfig: Drop obsolete CONFIG_NET_CLS_TCINDEX
To: Johan Korsnes <johan.korsnes@gmail.com>
Cc: linux-sh@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"

On Sun, 23 Mar 2025 at 20:14, Johan Korsnes <johan.korsnes@gmail.com> wrote:
> This option was removed from the Kconfig in commit
> 8c710f75256b ("net/sched: Retire tcindex classifier") but it was not
> removed from the defconfigs.
>
> Fixes: 8c710f75256b ("net/sched: Retire tcindex classifier")
> Signed-off-by: Johan Korsnes <johan.korsnes@gmail.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
