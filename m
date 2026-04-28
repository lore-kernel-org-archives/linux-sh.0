Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1861041B36F
	for <linux-sh@vger.kernel.org>; Tue, 28 Apr 2026 12:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777378727; cv=none; b=lQc8T6r8wPghH1wWny78BrXeMOMijADCRHlE5O//OO2H7yLJyR6Q3BvgGHmB/mxQ5vlFivpXP5y4fvQvkK3PsLd1oE5bWIuVuOXBjlJ7/jhRGX2QnB6zsyR+U8ikgQ4HlLO0V1aN7A2OUe9k5gQUdFTrrOSyDN24CZ80i9RQwFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777378727; c=relaxed/simple;
	bh=mAYBk7IVYBZU3e6fxKl78gfSRMFD64gauo2tJTycVNk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f6bLaVd1c/XNnpJ5Lv7y4+oq/harebdaRFFXfb697NeeXk8EqQlHahSpeLQTX/9hCvFDINvpr2uLTghPgXYsqZbK9cEh2VR5K2atyF+0HbgAJSMpvKh/ZuCkEOZAmPbMYXguoRwuz/d5pxhps8oxzh92nTuikmHBaKvtK9nMCbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-678a526f374so7715014a12.0
        for <linux-sh@vger.kernel.org>; Tue, 28 Apr 2026 05:18:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777378718; x=1777983518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Xp4jGbwCZArFgffiq+4QxYjGGxrhCK+NNbNdmSETOy0=;
        b=A/P+jCIP20kPv6RCXpka2ltAjISLr9sqCKylFTQb7VX1oNN9Ef7w0bbV6Ii0xxl0Ms
         CX82uOLHkpAadVcrP51cMjvilig4akG61aAu1UaKsfcWiW/vrAMT2UqI2SU3Gzj5/JUk
         py4vDfngtjhE1m9pItC88Q1J/dM6Jdm2VKR650vD0i9eQVnbD+PB5OdJLOdSjwf0NAwP
         enrVMZudt93rRkz9tKbLvUSVggLvutPqXOOEH5STONB1inI/HkhO0umsDHMD7/jD7EQJ
         r42e1MdPiSOXyyF1G+6Nfe1DxHzt5BW56/ps1qFOLX9A0uDs2vZRjwQ9KhSReMYTOBoi
         jz0A==
X-Forwarded-Encrypted: i=1; AFNElJ/JtNTmskyn37flwFZ1U4PcXF+PL3xGmLntiETQYOnoxnYS9uVvvFd0RVlEACuB4qZwii7V/pk8fw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxiHtS8A6aiPm0ofcUvZECfDTUUx/Gh9TOxa3fLDsHO1waROu0b
	2XsiSu1gzuJDu0YYIessvrHzGqXzspa22qLpsefGzyvrdIy2sPPdU6n5c4ItqUP+m5w=
X-Gm-Gg: AeBDievC+HO1GLEihCeAXNFHEYMYV1AsB7YTEsZ5xlEzBpAJrhexP+H9Fw9odLg0/hb
	Kk8S1ajSHsPCRESh4fDbJpPoXFhlp7MOUmHypgHbQhoB6I8oyL1wmwSg7/rplvcpwvaftbRLfsq
	eLo3B2s6MZKa+DwwVxBvR+TOY15PTjZMD/tSTWq3tVwhWSyZAfh9pJpmAtIA0GiIMvqMLUtLebV
	vRDeoW+OYAiCjXT5Bzplp/DZlGDhm8afBt20/KJdvOtc2SJGZR/shvMEwzY3PxVhspBcJd5pFbT
	W4sPWU2Y/bgmasJUGRi7VXK1mLiWevQ/4o0gm5z7SOHHAY+XEPOiLXUgTEaVlulwfKE+Bo2ptj1
	TXeY3VTwJj0+7PQvTgtQtY1Lt7d1/hHvuV3j4ciJ0CDMuuMxB1OQsFXs+2z5d0SsOJGme41/IGs
	dqYsIFl7r3lB5Xva4DqiOvY6HasT9mJahnO3naWN9nap8YS08pEDtodqHN/bSqisFaRbkg1k0=
X-Received: by 2002:a05:6402:2815:b0:676:20c8:5420 with SMTP id 4fb4d7f45d1cf-679bb0a3952mr1405838a12.25.1777378717577;
        Tue, 28 Apr 2026 05:18:37 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-679b68543d7sm688771a12.25.2026.04.28.05.18.36
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 05:18:36 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-678a526f374so7714948a12.0
        for <linux-sh@vger.kernel.org>; Tue, 28 Apr 2026 05:18:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8ZCx/cllksldh7P2XetmJFv5adOE/xdUSeVEC7YTzVuVMfbRr2ZPv50TTkEYrkwNCBz9TQTKmvoA==@vger.kernel.org
X-Received: by 2002:a05:6402:324e:b0:679:223c:d17a with SMTP id
 4fb4d7f45d1cf-679bb08fdf9mr1042821a12.16.1777378715907; Tue, 28 Apr 2026
 05:18:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260417103208.1217010-1-rppt@kernel.org>
In-Reply-To: <20260417103208.1217010-1-rppt@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 28 Apr 2026 14:18:22 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWhesrzzT7a9dAiKFWVeTzNykj+_StBDSSRRb=TjqOzJg@mail.gmail.com>
X-Gm-Features: AVHnY4I95xasDtp_nEvMMu87riUHz823DmdWcQ56__mAwcdckqOmuhUacLSdFHQ
Message-ID: <CAMuHMdWhesrzzT7a9dAiKFWVeTzNykj+_StBDSSRRb=TjqOzJg@mail.gmail.com>
Subject: Re: [PATCH] sh: fix fallout from ZERO_PAGE consolidation
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Rich Felker <dalias@libc.org>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, linux-kernel@vger.kernel.org, 
	linux-sh@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mike,

On Fri, 17 Apr 2026 at 21:16, Mike Rapoport <rppt@kernel.org> wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>
> Consolidation of empty_zero_page declarations broke boot on sh.
>
> sh stores its initial boot parameters in a page reserved in
> arch/sh/kernel/head_32.S. Before commit 6215d9f4470f ("arch, mm:
> consolidate empty_zero_page") this page was referenced in C code as an
> array and after that commit it is referenced as a pointer.
>
> This causes wrong code generation and boot hang.
>
> Declare boot_params_page as an array to fix the issue.
>
> Reported-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
> Tested-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
> Fixes: 6215d9f4470f ("arch, mm: consolidate empty_zero_page")
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Thanks, this fixes booting on Landisk and QEMU rts7751r2d.

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

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
