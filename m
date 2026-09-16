Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D863B3891
	for <linux-sh@vger.kernel.org>; Wed, 16 Sep 2026 16:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789575943; cv=none; b=jPbpBiyNH+ExpLppJ4tmsqpk3+pVpdO/1CQFwWguIrNfAVJcRnUOjbiPinZZ55Iaiph0qTHUovXkgoCLcQjxYSmc84DBjnvmCjG87KY+xf7PXEQpvwoT8S7gpesdu3RVDofOeK3TCqZqkZ3DcDd1/Jwpfvqu9+WuBp6cP/DaQwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789575943; c=relaxed/simple;
	bh=fn0Gpjkf8crw2Bh7cFIXVZyGh0QHt2q0NzUxpkXMKFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uqNbm80mP31GcqCnYFpsOefgUofx4pUw/4JveF2sKamXtqBnrGVJeF9gAPkJ6r9uieus1svyTCnaVwgsJlKqSjXDTYyCZBql/kRiq8Tq7u7cUpp5dtUskfGAOTwG2xuO1Sj3keup6/eBPx5kjVOVwLPEmklpj/VzTwa3bRjonCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WVneGbr0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WVneGbr0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7B161F00899
	for <linux-sh@vger.kernel.org>; Wed, 16 Sep 2026 16:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789575941;
	bh=fn0Gpjkf8crw2Bh7cFIXVZyGh0QHt2q0NzUxpkXMKFE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=WVneGbr0wtKe5kuzvnaAbtOGujlVUEQGd1te6qm7vZW3TYeHaQtVAm6uE59XgRrpR
	 6BhLgl5C9LCqzTDZrKEdjZuZ20AjTpTdeTluK5JqmqDnBe5vwhUaDlsBQdjrpR62yO
	 1ruR0PZhQXyWQrFMJSZXw7WbYJy70hpJYaR4a2u5r8unePKdZZwR8Z/07U63ZOVJv9
	 ZpXXp/zv4pnUOvP6R8bV8XMOI117ltVRuDEWgmfbJ/1I810tZ4GgpA/r6+Y2I/8ipr
	 HHu9Glr4P9aIB52H0+Ja2t//3M6Aa09ciXm1rijDWUzL7dSWxWZMzMW5PuaLtwY9Wm
	 3T0RheWIvelwg==
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b5e4f16c72so1142347e87.0
        for <linux-sh@vger.kernel.org>; Wed, 16 Sep 2026 09:25:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwtlx8u0ZlruypuIxj3DRUrBmhNup012sMk0VqkdxmCE8vUKlyhSxVzYChNSa5kVDzqTwZjiCTmUg==@vger.kernel.org
X-Gm-Message-State: AFuF++l1Qmnjg5fVsastMgXr4iEATfBsGosZ2k0pmi/SEw3CnA0956vH
	bs3t4qODQkJI5yNMuQ19I3UXdqHEcDxilKGFcXb81Sus921eF3QeF7TqdYau7+Qfc+m1k42DCEF
	HtVR99J+rZHa4IrtXE6OWePFHybLwT3U=
X-Received: by 2002:a05:6512:3e1b:b0:5b6:1a7c:fd7f with SMTP id
 2adb3069b0e04-5b8b6652b42mr949614e87.37.1789575940579; Wed, 16 Sep 2026
 09:25:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907090956.2825703-1-arnd@kernel.org>
In-Reply-To: <20260907090956.2825703-1-arnd@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 16 Sep 2026 18:25:27 +0200
X-Gmail-Original-Message-ID: <CAD++jLn_Dfzj9ME8Vc5fv8cwATENBRw=Dx9aSwt65JfqoeywKw@mail.gmail.com>
X-Gm-Features: AcwNN1VuMUBHDE_HWXIYdZ8fFYEMsF2Ou_4jA1zeXX1dDAPFhRFN9qr5QZmK1N8
Message-ID: <CAD++jLn_Dfzj9ME8Vc5fv8cwATENBRw=Dx9aSwt65JfqoeywKw@mail.gmail.com>
Subject: Re: [PATCH 0/2 v7] gpiolib: finish the legacy cleanup
To: Arnd Bergmann <arnd@kernel.org>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Kent Gibson <warthog618@gmail.com>, 
	Johannes Berg <johannes@sipsolutions.net>, linux-kernel@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 7, 2026 at 11:10=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> wro=
te:

> From: Arnd Bergmann <arnd@arndb.de>
>
> These two patches are left from my cleanup series, finishing off the
> work to turn off CONFIG_GPIOLIB_LEGACY by default, and removing the
> include/linux/gpio.h header.

The series:
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
