Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC2E330D27
	for <linux-sh@vger.kernel.org>; Fri,  9 Jan 2026 10:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767955898; cv=none; b=BgGjm6tOPfoGMxnu+xFckO+OiW7qUdR13F6dvXUNNR6dXIgcHhA7H1+ajJ70Cm7EHixT3gDXyRPKEhQHe070/nKr6By3P2AlCCE5GLEpk08ghqdaqQKJufEiWeitSj/l1mGvslNvB+BY2z5VeBv9S+WUT1IKKe8z3KU5UzHzT+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767955898; c=relaxed/simple;
	bh=KdToO14tef5GSir+chabd8B6NEOIpxi61cdldG3NByg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CuRKdh/3DNl0NA/A/x5N6oDWWOOb+T60nhYPRvgCTWns0TGA8YqB7Pq3YUqpdX4eazWf3kQFVYtNfUsPSMzkwrTIzz9mEq5yDUeA7nYR8v4Sf0TX+WL3l0n80Re0urGtjalXOjaJXG/XtFtQ8w5Jm2jry3/e6qxbwhCcodpQ4/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-5eea31b5c48so952898137.1
        for <linux-sh@vger.kernel.org>; Fri, 09 Jan 2026 02:51:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767955896; x=1768560696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+PrHggOm39VeVydYN6TMkB/guB5c9Xengt3pqY0OQgA=;
        b=HXNcR8nUU6OQ60ipO6FDqNRmEq8C9/RwF7SCScbvQpVME83PUOEE3ywLhmrH3P3G90
         0xnBeq+Po6AhzaWnhpgvR1G7YiP2aS7HHjjojIUyEJpInimgUH6NEkWjXrbsrWHSRm82
         Yk7+qZMxgN909T7wQUEmTt1RzOB9B5VT2IUTvvPlnyeVu+yVCUEQP1eTnrktseR5uAA4
         o91pqtMKcRaPK7c63YiaoWOP97htrkBeYwtEEICsnozgnfUMFRqwlaFBIwma/InP8Mvk
         vdWuaxjUNFucHd+mtcsbppW3ZSJR0pyHyXqoYN1OWJ62wIlAw1SyPG0ef87pLP0fhe1O
         8xQg==
X-Forwarded-Encrypted: i=1; AJvYcCVCub+RhMsj4eJZMvVFvHaA9EHlGZcjBhlppHRKxaIqurzzaOC9KpsNgB1mVzNHz/1lgkdkZYmmiA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu56Mv24/VUy4ANf8std3F9o35OWBZPwuQKsRzUfNeXvP59zrZ
	f/S806YgULhouIhYAcsyC/oOT00LP9lIEGSIkLaDwq3lqvQwLWs5aqz38rF1ke4N
X-Gm-Gg: AY/fxX4HW03+/Va5eRedNRivelRyTGprPuIZBchcmNWJawM5wTeIG+Wf0WnsQLsA/R9
	sugUxWYlJLUKUgSlkMj53Yjx2as1b2WK5fRjsYCteuuBYEzOqAiajqFHGtyD/BhTCBKt3ATFIEj
	Y4Fjx74BLCO/fdNc3gjNQz2gbkr1cZ+pzcUZlRbk21KJyg4ubXDr29gY0x+NSStvut51+6gqbmh
	JA261vfHv6yUSbImogB6f4GujSCnHtEj1ic4PF0iCmHNTpyJZtFECRFRFG0SFRXeK0gs/ZazeYg
	+ov9BnV6E6DYCR/2Qdi2EIf2p8S7INQqc2Gwo6hS36/js7GoTitkKRYT/3uZ2r0q0ZzI7EI/8PN
	pW95pHAbyAq21/yjyKQbS7+v4T76sMn+ya4FHLVQpKYAop+qE7XKA91ZQvXrUx7boWdQYD/C6aM
	rtwPldzKWfW6I+saQQuO8ESBm9VWHNj1h3LCDhIymeszzlLbwC9eC2
X-Google-Smtp-Source: AGHT+IET19EYhTPIiv4NPOcc/5ZH8rwNkbzsId1cnvBNlRbAgzQQJwwim0QQFOrr9P4wfMYJPJL/GA==
X-Received: by 2002:a05:6102:162a:b0:5ee:a76a:8513 with SMTP id ada2fe7eead31-5eea76a8724mr1755980137.33.1767955896539;
        Fri, 09 Jan 2026 02:51:36 -0800 (PST)
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com. [209.85.221.171])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-944121ef3fcsm8571642241.0.2026.01.09.02.51.35
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jan 2026 02:51:35 -0800 (PST)
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-55b09d690dcso1454655e0c.1
        for <linux-sh@vger.kernel.org>; Fri, 09 Jan 2026 02:51:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX7EZKJUNn9kXfr5IvNyNSIcRGpW+Tp+Uq1J8AFxgWG5V2TV5s1MWVHASi0XKw6VFHCmKtst5SdSw==@vger.kernel.org
X-Received: by 2002:a05:6122:18b5:b0:563:4a88:6ebd with SMTP id
 71dfb90a1353d-5634a887159mr2995245e0c.3.1767955895564; Fri, 09 Jan 2026
 02:51:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108-custom-logo-v3-0-5a7aada7a6d4@kernel.org>
 <20260108-custom-logo-v3-1-5a7aada7a6d4@kernel.org> <CAMuHMdX04g+BfEuBt_0iCvmZiyCLp58d0QwnFtu3bM1Cv59TzQ@mail.gmail.com>
 <4e75acf9-2e04-4ad4-9241-d8fd36462404@kernel.org>
In-Reply-To: <4e75acf9-2e04-4ad4-9241-d8fd36462404@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 9 Jan 2026 11:51:24 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUM3JfgDCri0=rq8L8e+bvhZ0EhMvyFD_0v7NJ-Z7v6og@mail.gmail.com>
X-Gm-Features: AZwV_QjshkTYtV04MygmILu94BM_s12nNFHOxgxtfb9evPWzSLQreqflAdgzCzQ
Message-ID: <CAMuHMdUM3JfgDCri0=rq8L8e+bvhZ0EhMvyFD_0v7NJ-Z7v6og@mail.gmail.com>
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

On Fri, 9 Jan 2026 at 11:48, Vincent Mailhol <mailhol@kernel.org> wrote:
> On 09/01/2026 =C3=A0 09:40, Geert Uytterhoeven wrote:
> > On Thu, 8 Jan 2026 at 20:06, Vincent Mailhol <mailhol@kernel.org> wrote=
:
> >> The kernel has no actual grey-scale logos. And looking at the git
> >> history, it seems that there never was one (or maybe there was in the
> >> pre-git history? I did not check that far=E2=80=A6)
> >>
> >> Remove the Makefile rule for the .pgm grey scale images.
> >>
> >> Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
> >
> > Thanks for your patch!
> >
> > There newer were grey-scale logos. Linux also never supported
> > drawing them.
> >
> > Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
>
> Thanks. Just to clarify, is your Reviewed-by tag only for this patch or
> for the full series?

For this patch.

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
