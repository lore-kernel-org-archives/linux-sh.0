Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F0D1E51FF;
	Wed, 12 Mar 2025 08:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741768350; cv=none; b=IrGr/saNHkdPEAdqrzpfmM3j++MYrb37ZlnbjzbGV4Z7u4edeZe0Wy/fhrKgzJvN80NFn7UgxaRuJDQ675v259gha+x3j/e8y9AoqvM74HXnVT0X/lmfFjbMNIRMoa1KB1isHmwaj+RkdpqSE+B7nhAvy84dMtxG8tK+V51Bzd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741768350; c=relaxed/simple;
	bh=t9CYB8U5Os/bGYTSKRMxXDSQepk6By7ZinPPl4aXtz0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nh04h7z39Yws0gnPG42mdgTkVvlthhDxxPER27+t8UdguK+Xw+HjNVPI72F0B/5y81y+/Pd6uE59E+HpuDDzW7QGVHAKjEXZOh9F+dlrozfbxF0dQCvTUgvMOUc3kkZHzbvleUZEvCUga0r15zqImtTdQK4fvP/Jp+LAd2nk96c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=csE6gA/u; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="csE6gA/u"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30bf8632052so49755981fa.0;
        Wed, 12 Mar 2025 01:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741768346; x=1742373146; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aQ7pWITWpXwP4dEm+H67RimJByEFVAXCVOS5uvWUZRQ=;
        b=csE6gA/u2WuBBWKNghONaJ31mfaWfzT1Ljwb62/Kk1uczWNnpFHfX3xuQGnpVheuUp
         rqhN27FHcWIryLDFBfK4SXD8MRQjXrEEN5fhMhYxmZO5DiOjlIzflHUGrsjQ7c5rceeu
         CwRCQkqSol6QGDti+bYhlmbAM8jMRzAHGYQUtXNXZof1n023sngMzSQPa4df/ZRhDpFk
         U0QzA81RjTMjr6MePnrUWyQ2t6WtuM8ncZ7m2AotmV/AY9F/EWVAoNx+xQO0QnL6oY6I
         CbB8KwmTLHP+1SgqeXcurYa/zC6jA3cL0mIsNCgHKuSK8cKbwggPAl+Vt8wCmY9SSAqG
         e82g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741768346; x=1742373146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aQ7pWITWpXwP4dEm+H67RimJByEFVAXCVOS5uvWUZRQ=;
        b=k1XjovDuroEnQr8F/eMmpzRw2y04+RlOUyOMp6vCUQFwrZ7m8iTcGgeVCqb2ukUKoe
         SzMlPiU2XkP14AjUvmXz1MJMAGyVzsZFiDOG/9HLhPavo37fbj/McWlaD7ZCJvFz7WEW
         HwFKmXqYXjlwwHnuua28xzgTZQVFXmuxtMWCI28JwY+sFLMcX1C+n9ZnuJekpZU/dMUm
         xwQPPJnd31/WbYIdeCkK09ow/9u72jdyH0OCE14IE7cjBfXVeIqGEhyQnIImp1b2fzFp
         ODgjsbxBfMoqBwacT72a4cIktXQ0AAJ9wG6cKeGdviMxRbcS2t383sYV9Hmgi53Z99Tr
         uv6A==
X-Forwarded-Encrypted: i=1; AJvYcCVpjt2+3KxNJem1CfCMseaRqVhP1b7m+xiuEyrve+Px+BX3fgf5cQ2W+T6qLW9X7o8Iq5x2KtmlzZ66KnI=@vger.kernel.org, AJvYcCWcJBW/hz8Cp+T4EChY4NLwl2/d8UX6PDawXJbnUq5tuWdeMJ7nr9PqrKDwQDk4sG1sNlCkUaiKrRA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw96GR7yUus28I0FL4Tq9uwFabnHt9s7vWTVmA9ZtykvREnnhFE
	1I36m9FIiLuBtCiHDRtW23hGPV5TlRUZTob1ty6xJNqVTmU45TO1JPM8aEJTeNysLTYK4cT5SoT
	KjKDxYbCdie8abn7vJwNK9xXdrVK2rYu3
X-Gm-Gg: ASbGncud0DjeHbgp+X/GZ2VG73DVHWsFpm/sYP8QCoQE1sjCIZDl/w6rU8L0aol6fzI
	QZfXFuEOl+Ti85Z77oF7PAPxF12sMmd0mEmp03a89nkc0OFApbmGKOymrhDSrx8fK8V41YsZh7x
	GAMgKLoGfrVH0CnkZof2o88ruLpg==
X-Google-Smtp-Source: AGHT+IEMghVBMsvYxOQMaSAkUCPF5bF/h1DiGXhdVu3Z6yfwYlHoNEYp8M8LQVrLaqAwhw2ziPmEfKx0v0w3+Aodjwc=
X-Received: by 2002:a2e:b951:0:b0:309:bc3:3a71 with SMTP id
 38308e7fff4ca-30bf4615855mr49337871fa.31.1741768346151; Wed, 12 Mar 2025
 01:32:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250216175545.35079-1-contact@artur-rojek.eu>
 <20250216175545.35079-2-contact@artur-rojek.eu> <5365422a9715376c76a89e255c978fc39064e243.camel@physik.fu-berlin.de>
 <433bc8a0732bf8a63c64c4bf0e6ad4a7@artur-rojek.eu> <967e29681c8bc39edfdd9c645d943f17d341c2ae.camel@physik.fu-berlin.de>
In-Reply-To: <967e29681c8bc39edfdd9c645d943f17d341c2ae.camel@physik.fu-berlin.de>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Wed, 12 Mar 2025 09:32:33 +0100
X-Gm-Features: AQ5f1JqnAQyBOtz35IOkl2Urm5_Ic9EueI3kLaA4FpN2SSqzBtjC3Jdras_yycU
Message-ID: <CAFULd4b8+HsmJC2XkW50pxtw=fHNrL9gH1_WM90jh+rfLCbSHw@mail.gmail.com>
Subject: Re: [PATCH 1/2] sh: align .bss section padding to 8-byte boundary
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Artur Rojek <contact@artur-rojek.eu>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	"D . Jeff Dionne" <jeff@coresemi.io>, Rob Landley <rob@landley.net>, linux-sh@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 9:22=E2=80=AFAM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:

> > In the original BSS_SECTION(0, PAGE_SIZE, 4), the last argument inserts
> > a 4 byte padding after the closing brace of .bss section definition,
> > causing the __bss_stop symbol offset to grow, but not the .bss section
> > itself:
> >
> > #define BSS_SECTION(sbss_align, bss_align, stop_align)                 =
       \
> >       . =3D ALIGN(sbss_align);                                         =
 \
> >       __bss_start =3D .;                                               =
 \
> >       SBSS(sbss_align)                                                \
> >       BSS(bss_align)                                                  \
> >       . =3D ALIGN(stop_align);                                         =
 \
> >       __bss_stop =3D .;
>
> OK, that's really odd. So, the __bss_stop would be moved to the desired
> position but the section itself still remains small? What exactly does th=
e
> linker fill the region with? Sounds very strange.
>
> > TurtleBoard loader is only concerned with the .bss section size - it
> > doesn't care about any symbol offsets - and hence this seemingly crypti=
c
> > change (you can display the section size information with
> > readelf -t kernel_image).
>
> Looking at the actual kernel image with readelf is a very good suggestion=
!
>
> > The rest of the changes are simply to "inline" the BSS() macro (as I
> > needed to access that closing brace), and the former sbss_align,
> > bss_align (that's your PAGE_SIZE) and stop_align arguments are passed
> > accordingly, the same way they used to be passed before. The only
> > visible effect should be the move of ALIGN(stop_align) inside of .bss
> > section definition, and the change of stop_align value from 4 to 8.
>
> OK. FWIW, do you understand what SBSS is for? I couldn't find any explana=
tion
> for it.

Small BSS section. The compiler can put data objects under a certain
size threshold to the .sbss section. Looking at GCC sh config, sh does
not use this section.

Uros.
