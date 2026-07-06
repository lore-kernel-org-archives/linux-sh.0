Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA01A414A3C
	for <linux-sh@vger.kernel.org>; Mon,  6 Jul 2026 09:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783331233; cv=none; b=NDex/ddT5giGlDQFS7CNGV3n0ummQdhJzsWQ2jLD+yVNj0Ke3mLGk9llvz7u41/g7Gq8pFlzJeEJH9a899I5mNFbizbKhYNTLizWwGgiPlgrYfwg8pEIleingIcSQEO+b7oJwVhWfjn/esx/3tvPI5jAxGmi+PIqpqN1TRqjQ38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783331233; c=relaxed/simple;
	bh=OSoepFB3CL15zDtIzwiQJiFZj3DV6MBt/+aT707oPW8=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WJgx5AuVPtz35cnQ5Y6b03Rin3v48cdvlv9gYSJi1vX87iFYusNEqS++b33a8xSwkSvA4q6sYY7pkOn6YGfB31NbEeJHNYaZnkuOQyBPPsyBU0RsMMpxWOvDqxpgS2DBxjwwQlkz+/HZ0ddOC3d2K28ELervu7x3cAv5Yo6Toj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mo2iP8W3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mo2iP8W3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07D6E1F00A3E
	for <linux-sh@vger.kernel.org>; Mon,  6 Jul 2026 09:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783331229;
	bh=qLG8iX9W6V2Iy2nb8HIO4P2imou3LBEayXhgOw/KOUc=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=mo2iP8W3Zv9uysjTN4ktMn/WyhjTO2qoGrqHI+ur955MAPC2o+e4l5SLvXOuogm7S
	 xGbDnYjVXoT74wRy3uI6dX1FVwI5H5JdVwu8IV0YGPzMxH4RX1Apo/VIwzY6fWYhFH
	 /7/eM0I74DsyK3awye6rWQbuPddu/6GspHge/2VH172h9Nv0LesqJKJUPQr+F8+y3v
	 djM8/ZnYxCSOHckg3veK2LQbBZUPG+3hrHkW0bGW+ccf9+SZItu+4x+2Ia0CiDAHq2
	 NT4dNVkUOMlwkQUyeHctq3BZPMbxWNKB2YQ6F5cRCcsjhpMgaCh9Gs62xQ/qlK4wov
	 /VRh3gM13DGhw==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-39b217f54daso28557421fa.0
        for <linux-sh@vger.kernel.org>; Mon, 06 Jul 2026 02:47:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rq3Nsgio1jX+cVPgEcGi0Xs2iUUMS+AVvimCnqsT/H23GWmQSNo0Y1YE7KkUFDhjTOsU+26XPflLw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbn1aKBWiu5xgDNrGn8XfGKwuBQz/fhdi3r+qBt5eImMyEV7dc
	kUzlUZkszbvdl6nIhF7NxDYXufzXSM1MsP7wQ2IPISiIZJHMu1I8vyeZre+XrF3EGOsePTNAPBb
	4s3cNc5sOMpWulUU7OysC6NUI/1sEM0uNzak8LZxooA==
X-Received: by 2002:a2e:b8c6:0:b0:39a:ffae:4e6c with SMTP id
 38308e7fff4ca-39b53dbd06fmr14354701fa.10.1783331227732; Mon, 06 Jul 2026
 02:47:07 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 6 Jul 2026 02:47:05 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 6 Jul 2026 02:47:05 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260704-sh-x3proto-swnode-v1-0-0c039549dc46@gmail.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260704-sh-x3proto-swnode-v1-0-0c039549dc46@gmail.com>
Date: Mon, 6 Jul 2026 02:47:05 -0700
X-Gmail-Original-Message-ID: <CAMRc=MdKviXBsGDVat0NsJ-H4AzY7Mr7QLfu43QgCgF+4w5C7Q@mail.gmail.com>
X-Gm-Features: AVVi8CcdNhpPSntbVYEaVK9OYPPangEuxy9UIVF6ZKupSx0HeM0g10rAHdGfJA8
Message-ID: <CAMRc=MdKviXBsGDVat0NsJ-H4AzY7Mr7QLfu43QgCgF+4w5C7Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] sh: mach-x3proto: convert gpio-keys to software nodes
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"

On Sun, 5 Jul 2026 07:04:36 +0200, Dmitry Torokhov
<dmitry.torokhov@gmail.com> said:
> This series converts the legacy gpio-keys platform device on the SH-X3
> Prototype board to use software nodes and static properties.
>
> This is part of the ongoing effort to remove platform data support
> from the gpio-keys driver, allowing it to rely purely on generic
> device properties.
>
> The first patch adds the software node to the GPIO controller, and
> the second patch performs the conversion for the gpio-keys device.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
> Dmitry Torokhov (2):
>       sh: mach-x3proto: add software node for GPIO controller
>       sh: mach-x3proto: convert gpio-keys to software nodes
>
>  arch/sh/boards/mach-x3proto/gpio.c           |  15 ++-
>  arch/sh/boards/mach-x3proto/setup.c          | 165 +++++++++++++--------------
>  arch/sh/include/mach-x3proto/mach/hardware.h |   2 +
>  3 files changed, 94 insertions(+), 88 deletions(-)
> ---
> base-commit: 3d5670d672ae08b8c534b7beed6f57c8b44e7b43
> change-id: 20260627-sh-x3proto-swnode-3feadf472a92
>
> Thanks.
>
> --
> Dmitry
>
>

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
