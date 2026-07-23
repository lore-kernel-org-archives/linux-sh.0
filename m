Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8275A3E16B9
	for <linux-sh@vger.kernel.org>; Thu, 23 Jul 2026 21:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784843476; cv=none; b=ZuQh+nXHVjWB/9bevzy9nby93Xt0knWIm4Vs0btrjcHE9+LiqZXCwCua8E9K7hTXd+UCtELO76Qa+qNrHU+3Sk6OcAYnpFh6g3VZcBbY0V9pZBl8agH+lmhc7yREp6Jo9F/gr2TkphVXfgcrxCckfoFcRBmeWx7rqhpJ1ttZmJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784843476; c=relaxed/simple;
	bh=Tn9db3Psohc2Vn6vUrjLCi1TrXQ/5hpT556cjaRcoXE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iuSGsWwVwzcI1iLd0Bo9EFLD7xbk7KaTyoH/7oqPz640mBHFZx6GjZLOlWw7fIkkZA1I0pB8+boXbCif7cUNUVRsh3x2dxrVNw2T95Trf2upD75/LtooML8cjURIbmdF4BbsKRwZKcGtzwvd+PVZQA9nv4WQJgkJh5uK33pB0I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PS73xx6g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PS73xx6g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32F5A1F00ACA
	for <linux-sh@vger.kernel.org>; Thu, 23 Jul 2026 21:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784843474;
	bh=Tn9db3Psohc2Vn6vUrjLCi1TrXQ/5hpT556cjaRcoXE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=PS73xx6grw1a1ccZiB7M0JW4YjHIFkESGRljs8NtMG2djGErIx/5mvP/xSo1f8CC6
	 lxzjRoO1yRby/r00gNR0TKtaLe2KidkY509VHt1m9GL8YNJO65vl+7yow15J+wcbkn
	 LyLkNvwJ2Yo7sxENJtQzNdA0tT35xFXiklXzQwMqailG6ulIZ7rFXrh7yPZXjfwcTq
	 w/lM1/RrMgIrXi3JJoA84lHqxmFiXlx/JnONMnfwThTVhbrPub38+APIGIfbeZGwlD
	 uE8T+RJB3q3l9KJpPJBpj8/k6hgX2XdGiMLPRIuH4TOI2D9h3HZEl50idyw5+nN/Hn
	 dUklT+Iyl4lMw==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5b01cb18515so1002409e87.2
        for <linux-sh@vger.kernel.org>; Thu, 23 Jul 2026 14:51:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RowVyTA3C73elMniQ26SY9s/b0WE4O6/UwdvqbzNtOFNEddlIpC6cwjklEkQe+g27GQvEkuIAl2rw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzLWLGieXMo8xmadfSl8b05yommpEZ6cD+kg74gn54yLbK241w/
	ZTyNXM641LY9gqUvV28lqgfyqVXWAPtQm2HvgPKVQfBUYXvm92HgYkIBjwHKMb2UvVtK8U0Jc1K
	VIHGrihTArHCY0c0mtT/Bq64OTscaFZY=
X-Received: by 2002:ac2:44cc:0:b0:5b0:bc3:dc11 with SMTP id
 2adb3069b0e04-5b2b2e59e63mr664600e87.22.1784843472973; Thu, 23 Jul 2026
 14:51:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520-rsk7203-properties-v2-0-465f3308021b@gmail.com>
 <akyJOW79W0xvI-P9@google.com> <CAD++jL=Wx=mHORGDU_=PgGrOCdTSVes63jgSL2xQX+rCE2uaMw@mail.gmail.com>
 <f9fc5cb2ae36593db9db8faf7ebcdc224842f9a0.camel@physik.fu-berlin.de>
In-Reply-To: <f9fc5cb2ae36593db9db8faf7ebcdc224842f9a0.camel@physik.fu-berlin.de>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 23 Jul 2026 23:51:00 +0200
X-Gmail-Original-Message-ID: <CAD++jLnC0eZbJa4hyTQkeJ214miahcAFhH42X+JkxxTbDo=5TA@mail.gmail.com>
X-Gm-Features: AUfX_mw7o27tts3KuJc2fCs-iddo5AVh_y2fbuI1x_FFI7tnJrpKdy_91LnZLqw
Message-ID: <CAD++jLnC0eZbJa4hyTQkeJ214miahcAFhH42X+JkxxTbDo=5TA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] rsk7203: switch to using static device property,
 drop legacy gpio API
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rich Felker <dalias@libc.org>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Bartosz Golaszewski <brgl@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Arnd Bergmann <arnd@kernel.org>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 11, 2026 at 7:15=E2=80=AFAM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:

> I'm sorry, but I wasn't aware that this was an urgent patch. I'm doing th=
is
> as a hobbyist and I'm working on my own pace as I cannot always spend tim=
e
> working on kernel maintenance.

That's OK, I'm helping out by rerviewing and at times like this
also merging code.

> What I don't understand, why did you choose to use an immutable tree? Is =
there
> really a need for such an escalation? I find that a bit rude.

I think you don't understand what an immutable branch is.

An immutable branch is something offerered to other maintainers
so they can pull it to their trees so the patches will share the same
commit chain and SHA checksum in both trees. In this case, this
is offered to the Super-H maintainer, I guess you?

In this case the patches touches both sh and pinctrl and the two
subsystems should ideally use an immutable branch to share
the commits.

The word "immutable" in immutable branch does not mean it can't
be dropped or reverted...

If you see a technical problem with the code or really want to queue
it *only* in the sh tree I can revert it (or maybe just drop it) from the
pinctrl tree.

If not, you can git pull it in to get the same patches that are
already in the pinctrl tree, this is customary, we do it all the time.

git pull git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl=
.git
ib-rsk7204

Yours,
Linus Walleij
