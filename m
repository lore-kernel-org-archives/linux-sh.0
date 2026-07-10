Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6175233260F
	for <linux-sh@vger.kernel.org>; Fri, 10 Jul 2026 19:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783710355; cv=none; b=d7bn0LC7Zd5U5CO3FbE/49muULObg73nBBEYaMSWUj08NTIBA3LwmXozY0EZS23LO/gSn7moL4G6gL9HNwMpLnmcij73bK4UG+AwRb1JE2+7jcUsDu6klneXdkvFbZAW5IgDVQCYMWFzZhWWg4D3xtvSkrl00miassTRtXm1Jyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783710355; c=relaxed/simple;
	bh=OWz//aDmsOdKf87gyJz/K1yUNKWSM8ynRcUgh9u615g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uulrt6yr1Z9YlTYMz5l4k8Q2+b4XiR2Y9qqWqSkc2DPPAvJTtQ6VUOD8lmvyoL0jMFUovlrhGN7YMm1AO9Lbg/OfxLlyjci4/yhYah0pvY7vk5ZWVHp5U/D4U+1ZmxcgVDP77aCfXMguY36VQqgYMQ6xdQDsYFVV2C8LDCFuzCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QL8lidcy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QL8lidcy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 344B91F00A3A
	for <linux-sh@vger.kernel.org>; Fri, 10 Jul 2026 19:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783710354;
	bh=OWz//aDmsOdKf87gyJz/K1yUNKWSM8ynRcUgh9u615g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=QL8lidcyh5+abCZxDTVG4/Gehk8v5tLKDdLJh25SnKbV1AO21ehqjqRHYvUtktx9A
	 XX9UBPCjsJitbICGA5Ha30KEC514en7ilSzwibYr8B7ybo+FrOKAbjF8EsTRmynYus
	 H2d/0Wvqi9mindJDXb4g3MGtdEwVWZjQm2e2BD0ps+Gujvbs2m7XhPpcV0v2inmBQT
	 LgFbV/czwxcX8bps4URygCbBRKHeiP06tLWuycT5l8qJq4R9r32+fTRs02MZVzm1Fz
	 vQlVwsfuDxm1g+dk7V/xC2mKal40Z9H9jLvUND5gJrry32cberSHYTu4eO5ThkH+rz
	 h9bN8ZpIQ3g2A==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-39c8dbf4ef0so12231191fa.2
        for <linux-sh@vger.kernel.org>; Fri, 10 Jul 2026 12:05:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqKsSLIqMnDHWip8lYUN0WEJmznOFZ40Hj7wQrII4W9OVu8EbIl6bRIeFelFDJwal4BdUG6I5d4hg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzcFF1v8HI7JRUgt4433RMl85VKz4SY2VMp4+0KB5km4JqGoAjc
	l/qSf+QZRdF/56cTf6El0FjB6Kvpj4tmaWVuxdl4qwTpxmljO7bdtleL500YLetmUN+yAEfjtRW
	qZzNOlroL0Nyp2J8jMaDw7MYvv5DARXM=
X-Received: by 2002:ac2:4431:0:b0:5ae:bb35:c956 with SMTP id
 2adb3069b0e04-5b0236b2a45mr62737e87.56.1783710353043; Fri, 10 Jul 2026
 12:05:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520-rsk7203-properties-v2-0-465f3308021b@gmail.com> <akyJOW79W0xvI-P9@google.com>
In-Reply-To: <akyJOW79W0xvI-P9@google.com>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 10 Jul 2026 21:05:40 +0200
X-Gmail-Original-Message-ID: <CAD++jL=Wx=mHORGDU_=PgGrOCdTSVes63jgSL2xQX+rCE2uaMw@mail.gmail.com>
X-Gm-Features: AUfX_mxirnvBsYL4mzPImU7j47NPxAkPAgq7Mm-tNJlHHsQ0Fi4vPKqXX9cB5Es
Message-ID: <CAD++jL=Wx=mHORGDU_=PgGrOCdTSVes63jgSL2xQX+rCE2uaMw@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] rsk7203: switch to using static device property,
 drop legacy gpio API
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Bartosz Golaszewski <brgl@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Arnd Bergmann <arnd@kernel.org>, 
	linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 7, 2026 at 7:08=E2=80=AFAM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> Gentle ping on this series... It still applies cleanly and we need this
> to be able top drop legacy gpio interfaces from gpio-keys (and
> eventually from the kernel).

I lost my patience and queued it to the pinctrl tree on an immutable
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git/lo=
g/?h=3Dib-rsk7204

Then I merged this for v7.3.

Yours,
Linus Walleij
