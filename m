Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F91350A06
	for <linux-sh@vger.kernel.org>; Fri,  9 Jan 2026 08:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767948023; cv=none; b=pwwrPo5bXtjJNRHOED5Jn165CAOVVWOW/AG2ZU2HI2+YH5Aalftk+tdwteS0m7uUo2Tq86a9QhWyhQYbH7KvJS+tZbS7Gv3tjBkBsH66Qcl6XP2RbOoI3GKYOVDmu9y4NavjnqwOxjzK+VSggz9RgGBK1XlAqCxg40cm+8RX/gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767948023; c=relaxed/simple;
	bh=4aCwjP/3aetiY+Pdvnezx+dDqcFJcvkgbunGRgECQRw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uWhBlFaxxrml9pDLaepye5Hlwpgrrpjb/AFJPjl2L/ld9SgU58/HixcU77RvleAmjYkGsSI6wtE0d/KY4Ffz9AWxzBQhag8hGBEi+oRUacMQnZOFxROLFjEUHMkWh2RGVHy/9FAvli77GsLhFSIDrA5gIX0xYPtATtC7OhC/G7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-563497c549cso1792211e0c.3
        for <linux-sh@vger.kernel.org>; Fri, 09 Jan 2026 00:40:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767948020; x=1768552820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WuAsW8sPlBb3HXHQgJVVkI+Y7zt+NEPceHiguDOxVbc=;
        b=M6G4XIcbNLGteISjqzwG05RuysH+eBuj7yK58xC1zK2uk+rTejepnswy1fR6fUNttg
         2NUtGB+ME5tPPvhUSePf44WVtxvzGGJXso6nNMlPW/9gg4+exxhLv9d2klVLCA8M1Qba
         DAnqRfVQD0bvv3NyA0B58ygH7Rl1A7YctjBbLMzkYbhCUb4tXi2aB+D/nTPD3xOPtFYq
         oCxf7v+2UHro05dJP+ukwRv3w6ygyZm4FOMe3KdGAZSa/Kq3LepUN0eG/PmyI5Z0i1BK
         +1BKoHEUJYO7UlYqpdvWlx/z8b84tcwgLMt+nxunleX0uOg9nJeKBgYQmV3fclBmQHck
         pmOA==
X-Forwarded-Encrypted: i=1; AJvYcCXbpWlr5qzeEHZ3UlScbJarWY6Q6vEAHTY1Qe1R/db7XGbsPTTMi6B7gCAtshywYofvNZKf8Einxg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3Gq6TyF2ZkxQsYhBXQHmr2VKMSnJkQ5ZI5YywyBrzJL1piEzY
	V7N4VyHSsEX8LzwftrRjiClfgQM4374iwq0xhQOOoWuI7urUO1gLac78GGg+QJor
X-Gm-Gg: AY/fxX5YhQZrDmAmOsuOiuNT7Ap1HiM7H1YZWr4mex+ub+/xoIqSfJ22OYo2KOmieOL
	npxu3hyu0a3qbPQKH1rKNLHtC3xZxwhZ25OmdP0tKX7ivzK59J5Q4YaA00cBY4RQv83vkYkKDJG
	kmqItzO0HzwjdAkj/BJ0v19coQtVZk4/OqS724X5tETQbKvTaielcY7+WDd0S4pRPupIN2YhqUZ
	wWwIcg4JP/0H0NgpjluNxJ1ERSk6yYgksiDOLL6dbzPnxzQIQyOJkPv54AOAhECUFxB4uCo9u12
	z873C2c475yH4WVcwCehJL6LD82lGymI7A2It/2tRpt3ZodfYiUITp72cd2zQdbRb4k2tmzHzWR
	tw3AovQsZyZ6ob5HEr81QnBfPvWQ/HO6hfn0vJX3BPj5m/JO2r/K2cPwooU2K4rME7CA6LyMkFC
	EUIXZzWKHY9h6JJ+yn8vmOyzzJNYQt1kJafXDOfq6iIh0/EtV0zcbPg+9Ihz53UuU=
X-Google-Smtp-Source: AGHT+IE3JcAJz+FaCDys4JzMz6UybI7hnyvFV0dWLEzlQD18MMJHF1ZtjIqKM3gbLOJPI5cWuooGuQ==
X-Received: by 2002:a05:6122:2887:b0:55b:305b:51b4 with SMTP id 71dfb90a1353d-56347ffbd4emr3088434e0c.17.1767948020627;
        Fri, 09 Jan 2026 00:40:20 -0800 (PST)
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com. [209.85.221.179])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5635bd72c7esm3428801e0c.12.2026.01.09.00.40.19
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jan 2026 00:40:19 -0800 (PST)
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-563497c549cso1792199e0c.3
        for <linux-sh@vger.kernel.org>; Fri, 09 Jan 2026 00:40:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUbFEa7t8m+Skyno2kOw9n8qVusSUDMbYhlsCkfR12s7jYmxKY+ewHe34X5tlxeA3hO7DjSWLY89w==@vger.kernel.org
X-Received: by 2002:a05:6122:2887:b0:55b:305b:51b4 with SMTP id
 71dfb90a1353d-56347ffbd4emr3088425e0c.17.1767948019706; Fri, 09 Jan 2026
 00:40:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108-custom-logo-v3-0-5a7aada7a6d4@kernel.org> <20260108-custom-logo-v3-1-5a7aada7a6d4@kernel.org>
In-Reply-To: <20260108-custom-logo-v3-1-5a7aada7a6d4@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 9 Jan 2026 09:40:08 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX04g+BfEuBt_0iCvmZiyCLp58d0QwnFtu3bM1Cv59TzQ@mail.gmail.com>
X-Gm-Features: AZwV_QhxZ4-tEsGEnK584clI_hiMcF81rYfU7L-GCTH9ANG1oGbPxo_i7btpNjs
Message-ID: <CAMuHMdX04g+BfEuBt_0iCvmZiyCLp58d0QwnFtu3bM1Cv59TzQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] video/logo: remove orphan .pgm Makefile rule
To: Vincent Mailhol <mailhol@kernel.org>
Cc: Helge Deller <deller@gmx.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-m68k@lists.linux-m68k.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Vincent,

On Thu, 8 Jan 2026 at 20:06, Vincent Mailhol <mailhol@kernel.org> wrote:
> The kernel has no actual grey-scale logos. And looking at the git
> history, it seems that there never was one (or maybe there was in the
> pre-git history? I did not check that far=E2=80=A6)
>
> Remove the Makefile rule for the .pgm grey scale images.
>
> Signed-off-by: Vincent Mailhol <mailhol@kernel.org>

Thanks for your patch!

There newer were grey-scale logos. Linux also never supported
drawing them.

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

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
