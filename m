Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48593B8405
	for <linux-sh@vger.kernel.org>; Thu,  6 Aug 2026 22:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786053918; cv=none; b=Cs2tG7vcAtX9mqeRLrsxrxx9CINz6xn5SvsuH5fGvELLYBhForSEjF5By5GhVEZXAsTKkiu0kTt8A7oRnRl26BjV5F9Cl9L5scMIobTWfz5bCo4eMWJZIF0VHkMQPHWjbJk4Fq1uXqgzM0lvh3N290i+SwRymtZKjeiMlkwu57k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786053918; c=relaxed/simple;
	bh=/DUQg8c6yvMLURhog5kv7549+Mj/93DgsOSzPhHnpIE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=unke0xABhZK2ID17f100LDPP0NShZnykIZyMhRhGHdVhWGbQvc/gu8Snp/cB81yVe11HYKLWfo8WGpKJnqTp3Ceel14GT/TCJU5cDR8gCbBNqW11gFze57L3Y5Lxr0IHBXoYVE43xEeoiAVecF05vtaoItbaWc3Ofj+wFjwI4gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fey0za/8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fey0za/8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58C101F00A3A
	for <linux-sh@vger.kernel.org>; Thu,  6 Aug 2026 22:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786053917;
	bh=/DUQg8c6yvMLURhog5kv7549+Mj/93DgsOSzPhHnpIE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=fey0za/8T+V0gNFRX87InBshk9VmFAgHWgZR/9QIp+Ez9VedNq66pd8JUsYfUk56L
	 oyhzgsAwg70zNOB/cfGEosst6cn1fIhzrNDBuWkgZmuKVusQeYHFMHwUzOmoFzqqPC
	 OBlsEY2JtGjum7VP4ytm2JSPOGg213tZdBYIdDgPQc52HYr1fKEGFx2VgkO+Mk6DAp
	 sd6w/bfeZfuM8H7MP1kqu074NamkF2jrVvcM6Q/IbreXcLgbX4XwocXIrIui8CSYT9
	 Klj6etIB0YywM7GAUHN2snFcf63HL4QvjdDTZfCH3WlIntAjQeegp1Xxm5TwenZRXd
	 wVWQDBXGKQ1bg==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5b29599b81cso3485073e87.1
        for <linux-sh@vger.kernel.org>; Thu, 06 Aug 2026 15:05:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqwY/rbra1z1U/XcM4jkvlpYRbrkc+cNWTSHT5KkGWxrkT0eTf2xuqi4A83uycSfwKTMcZBN1Exsg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzDVstyXiqx9+ogyplJqxpr9J87TCmG9HiS7CTLwSWXBPZs85WL
	t+n2m8JlqxWVPTczEF6OfXnjS6yRcDheCdE2SuLlYuPyfVV9OYJx47xBsXWY03T9Ze5G1HyrraA
	Bt2NrPnHwOjjkmoU10Or9Odp/EB0o8FU=
X-Received: by 2002:a05:6512:a44c:b0:5b1:56c7:5753 with SMTP id
 2adb3069b0e04-5b2f4cc6d94mr1726634e87.47.1786053916161; Thu, 06 Aug 2026
 15:05:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260802-sh-rsk7203-swnode-props-v1-1-7a790cbac9e6@gmail.com>
 <32a0d810bfc56029453aa72cefa49cb40466f64e.camel@physik.fu-berlin.de>
 <anAvJM0u_TIgL4ck@google.com> <70cb2e4d8a6fd11cbeb534dbf269f67148a00a8d.camel@physik.fu-berlin.de>
In-Reply-To: <70cb2e4d8a6fd11cbeb534dbf269f67148a00a8d.camel@physik.fu-berlin.de>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 7 Aug 2026 00:05:03 +0200
X-Gmail-Original-Message-ID: <CAD++jLkxXYfZadV26956yMAaCtZYr7mRGPA8_kixufbXFW1B=Q@mail.gmail.com>
X-Gm-Features: AUfX_mzTpQi6FMlmVcEk5v1g6rrlpQZgR8kFOjflLvfhE35EbVuHHCM6BJTKH80
Message-ID: <CAD++jLkxXYfZadV26956yMAaCtZYr7mRGPA8_kixufbXFW1B=Q@mail.gmail.com>
Subject: Re: [PATCH] sh: mach-rsk: rsk7203: avoid using inline compound literals
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, linux-sh@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 3, 2026 at 8:20=E2=80=AFAM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:

> > Also, you seem to be hung up on the notion of immutable branch. This is
> > simply a branch that creator promises not to rewind/rebase so that it
> > can be easily shared between different subsystems.
>
> Well, it sounded to me like he wanted to make a point that there isn't go=
ing
> to be any discussion about this anymore which I really thought was not ok=
ay.

Not at all.

If you read my previous mail there are many options, one being for
me to just revert this out, all you need to do is tell me you need
more time and I will do that.

https://lore.kernel.org/lkml/CAD++jLnC0eZbJa4hyTQkeJ214miahcAFhH42X+JkxxTbD=
o=3D5TA@mail.gmail.com/

There are 3 practical options:

1. (easiest): tell me to just revert this out of my tree.
 Deal with this whole ordeal later.

2. Pull in the immutable branch into you SH tree and
 apply this patch on top.

3. Ask me to apply the patch to my tree.

Either works for me.

Yours,
Linus Walleij
