Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D6A36F916
	for <linux-sh@vger.kernel.org>; Thu,  8 Oct 2026 05:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791438913; cv=none; b=jjHHsaaRPHo810/hzkO/Z+CUz3XYASYuoO9jdUjnH6e9VPxsXTYCvSUqpuoJ/ytlsXB6q6A2oR6ok1KjB6+MCQlnAvCkDl9xKvI7T9ntKl0CVsq++xQJxajsW4mmX/0vk5ZbR8bS0H5F1DtaercXIf6Q+7tx7HQ0B362SlqQzO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791438913; c=relaxed/simple;
	bh=lYl7dYMrHOnk56pwG8UsYxEaGVd4Hqw4FGFqFupd3ew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bQkH2aJ9LvIbcA4/f00liGW6bOHr4OOHIAMQYEA/RQsXXSDoadtWBW4JZ4adOt+WYvmPyyalh06wcdBekRnTIsf5w0IU9xz/vxXxj7GjRWkpTs47QzRwUJV5wOOuMhdq42KbUf9OFgC8DidV5K8P7MWwXMg57dCpwTCRujXH4MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J6l6T/G5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J6l6T/G5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9F521F00899
	for <linux-sh@vger.kernel.org>; Thu,  8 Oct 2026 05:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791438910;
	bh=d+dRBYUod/fcxf5Iqkdq4xO/QoiSyB4U5wDhK8pZlUw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=J6l6T/G5e+D6fTKENQSW1IbzzSblV3BheIph5N9an6pxKneuaxd0nnOGDBNY4Ljgy
	 qSMJ6NPF8itY9e/UHVOQFiC5npIvIxt8XZKwDbqMpJsB3nNjKO/VIahmLvhIF2gYFY
	 I9VXHpRlQm++++JR5vtRksGeLO2XsL4UakgiNUczs8zu68OXXTUXd0m9o0A17RdAmM
	 uoN1UUIFjwqgwAQczOJpETM7S06ugufdKjBAe445dHJZ9RWCxYdhnLS2QivL9YVxnW
	 zuMmkkzviLTIu3tIZrS7afxPqN3GvdPkisXlGjgyX1M7LXC3Ny32oAaVNfkxjRNQe+
	 jv/VqC2gACvpw==
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48441a2ba1bso2801125f8f.1
        for <linux-sh@vger.kernel.org>; Wed, 07 Oct 2026 22:55:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBy43Bea+t5oTC752UIAGIvawKA8FAHXG9gB571LqAMdxAueLVfMm7NqLD0ynUfqUgG5xS8ip66j1A==@vger.kernel.org
X-Gm-Message-State: AFq9FYKKgLDBGgvAmV4j4GQQ7C9SMocuuO9AvRFfj6VUEBZQoiiqLCav
	yGzED0deKtUn/HNDPTmtQEaskSkLOFw00jR7FXYGUHzJIFoL3+YGHgFgHiwkB6OI6uD47zFycxW
	CbuDxgAMklv41SYxLov26qDMAgVQdMtE=
X-Received: by 2002:a05:6000:2886:b0:48b:fdd:fbe4 with SMTP id
 ffacd0b85a97d-48c72889c8fmr7729946f8f.21.1791438909215; Wed, 07 Oct 2026
 22:55:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7f398d4a-7fae-4382-9cc4-8627e8aa912b@paulmck-laptop> <20261007203636.1982188-4-paulmck@kernel.org>
In-Reply-To: <20261007203636.1982188-4-paulmck@kernel.org>
From: Guo Ren <guoren@kernel.org>
Date: Thu, 8 Oct 2026 13:54:57 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQbbPAdjS3p3oMoCGdkBWFM3Hx5+JnCu=9hdXuPQaM5Zg@mail.gmail.com>
X-Gm-Features: AclHuK_i3yfeFM1Mqj1_rFbFa07SZwIrjJoViyoWe8JhZO_JNtdsTVGKx8Q49n0
Message-ID: <CAJF2gTQbbPAdjS3p3oMoCGdkBWFM3Hx5+JnCu=9hdXuPQaM5Zg@mail.gmail.com>
Subject: Re: [PATCH 4/5] csky: Emulate two-byte cmpxchg
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org, Bradley Morgan <brads@mainlining.org>, 
	Vineet Gupta <vgupta@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@kernel.org>, 
	David Laight <david.laight.linux@gmail.com>, linux-snps-arc@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-sh@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 8, 2026 at 4:36=E2=80=AFAM Paul E. McKenney <paulmck@kernel.org=
> wrote:
>
> From: Bradley Morgan <brads@mainlining.org>
>
> C-SKY has no two-byte atomic compare and swap, so the __cmpxchg()
> macros let case 2 fall through to BUILD_BUG() via default, and a
> two-byte cmpxchg() fails the build.
>
> Route case 2 through the new cmpxchg_emu_u16(), which narrows the
> old and new values itself, so all three orderings, relaxed, acquire
> and full, keep the (uintptr_t) casts the case 1 path already uses.
>
> Signed-off-by: Bradley Morgan <brads@mainlining.org>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---
>  arch/csky/include/asm/cmpxchg.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/arch/csky/include/asm/cmpxchg.h b/arch/csky/include/asm/cmpx=
chg.h
> index db6dda47184e4..6f3ca79e54acf 100644
> --- a/arch/csky/include/asm/cmpxchg.h
> +++ b/arch/csky/include/asm/cmpxchg.h
> @@ -64,6 +64,9 @@
>         switch (size) {                                         \
>         case 1:                                                 \
>                 __ret =3D (__typeof__(*(ptr)))cmpxchg_emu_u8((volatile u8=
 *)__ptr, (uintptr_t)__old, (uintptr_t)__new); \
> +               break;                                                  \
> +       case 2:                                                 \
> +               __ret =3D (__typeof__(*(ptr)))cmpxchg_emu_u16((volatile u=
16 *)__ptr, (unsigned long)__old, (unsigned long)__new); \
>                 break;                                          \
>         case 4:                                                 \
>                 asm volatile (                                  \
> @@ -97,6 +100,9 @@
>         switch (size) {                                         \
>         case 1:                                                 \
>                 __ret =3D (__typeof__(*(ptr)))cmpxchg_emu_u8((volatile u8=
 *)__ptr, (uintptr_t)__old, (uintptr_t)__new); \
> +               break;                                                  \
> +       case 2:                                                 \
> +               __ret =3D (__typeof__(*(ptr)))cmpxchg_emu_u16((volatile u=
16 *)__ptr, (unsigned long)__old, (unsigned long)__new); \
>                 break;                                          \
>         case 4:                                                 \
>                 asm volatile (                                  \
> @@ -131,6 +137,9 @@
>         switch (size) {                                         \
>         case 1:                                                 \
>                 __ret =3D (__typeof__(*(ptr)))cmpxchg_emu_u8((volatile u8=
 *)__ptr, (uintptr_t)__old, (uintptr_t)__new); \
> +               break;                                                  \
> +       case 2:                                                 \
> +               __ret =3D (__typeof__(*(ptr)))cmpxchg_emu_u16((volatile u=
16 *)__ptr, (unsigned long)__old, (unsigned long)__new); \
LGTM!

Acked-by: GUO Ren <guoren@kernel.org>

>                 break;                                          \
>         case 4:                                                 \
>                 asm volatile (                                  \
> --
> 2.40.1
>


--=20
Best Regards
 Guo Ren
