Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2BF4BD378
	for <linux-sh@vger.kernel.org>; Wed, 16 Sep 2026 18:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789582688; cv=none; b=FzwXWV5z68Sdu40i8H6y04miwgN3n5FoudD/rLySZkJ/T/umOdjmagA7FJRdYeGShYpZVWR4OjLfg07Gk4uAv2OjiBim8WeDxuyao3A7vbzMI1gc4Vo8nhCEGh2ECAts+eCodUdOsnQ/kaKPuKqmGtpVcKDiPBOtfks2jEl7A+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789582688; c=relaxed/simple;
	bh=qmNHsftrPigc6z9lAhD5TrQ9HA5z1cFLq5Fdk1Pby1Q=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KwM/D7MwkWLeOlWvt+wpHlhsUWKrDDeEMM3PXBZAbplKxI+bmI9IZLK2rsQu8YTMERvtrx4LLsy/SJBAl5HKnLixgggAEzTbFA4lXrVPNnkhibrl6XMbDXamOGZln6uon2k7VKp/6RB0rOqKYJiXm6kFDRXajxN+P5LS2VviAu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sko+BEt2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sko+BEt2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F10361F008A5
	for <linux-sh@vger.kernel.org>; Wed, 16 Sep 2026 18:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789582675;
	bh=NcQe03qyUu7W4K18zVzWNwv6MgOA45mAnb9g7/iXl8I=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=Sko+BEt2LFbYj5uyBrqNncKllB/TfIYZp8yu1UbtOr1MX2tT2luKqQtFJbI8Yaif9
	 2/fhy02KFYLmJA1HOiiVvE5zaIac/cNutH4ZUIEPYzhr165IxP73op4zzxu97KHXjb
	 KteTTMjjeekZqyDd0bOVel1pgR0UOaUd20eDIIQdMsKPozRqTN6ncoo0mizWaG+43z
	 /x6Ac9ASjuTdUaCaHwxZLscg7UWLHVzs9gNs+Z7gPNRvPFW5Q8B2EsqDcmf88kf3pA
	 H29JUcj4XvFp9y8urRjCpmRvD/aFWcR1BtFbvV47F0QVM4wsNNocPS1sEBdThw8GP6
	 jQfsvwHRgAvvA==
Received: by mail-lr2-f30.google.com with SMTP id 38308e7fff4ca-3a318299b38so488081fa.0
        for <linux-sh@vger.kernel.org>; Wed, 16 Sep 2026 11:17:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxHCN9u2IUEbgTSV5d6dGENOCrkdONG/kms7peYSEiIjkaz/UqCtxeSemY1+hAsUgibYZRdybB83Q==@vger.kernel.org
X-Gm-Message-State: AFuF++l+P3rS0BBXG9lYb+aZRRDJgADWTJKF8g8J3Ow/ACw54i41RkCo
	Ker3GpiTDgZmynjf2/gr4mTllxT0Ml10U0SdXaxOHlv99v70LmLS5i97tYm27qyoC2bTHpdhXMP
	3ukaqWubvBahZriP+w25eco63Xk0c1w+p3Ruz3DIgMg==
X-Received: by 2002:a05:6512:3345:b0:5b7:f0b9:ea7c with SMTP id
 2adb3069b0e04-5b8b6605f11mr972331e87.8.1789582673568; Wed, 16 Sep 2026
 11:17:53 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 16 Sep 2026 14:17:51 -0400
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 16 Sep 2026 14:17:51 -0400
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260907090956.2825703-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907090956.2825703-1-arnd@kernel.org>
Date: Wed, 16 Sep 2026 14:17:51 -0400
X-Gmail-Original-Message-ID: <CAMRc=McRc9Aw-5WBipW5QhqqHp4+UKch15ui3E8a0srk2CUN7g@mail.gmail.com>
X-Gm-Features: AcwNN1WT39KCCBGzK8bB5OYELfDMzkO3xawenRbklBZjDzeHGIgp80Nbi0LahYQ
Message-ID: <CAMRc=McRc9Aw-5WBipW5QhqqHp4+UKch15ui3E8a0srk2CUN7g@mail.gmail.com>
Subject: Re: [PATCH 0/2 v7] gpiolib: finish the legacy cleanup
To: Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Kent Gibson <warthog618@gmail.com>, 
	Johannes Berg <johannes@sipsolutions.net>, linux-kernel@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-wireless@vger.kernel.org, 
	Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 7 Sep 2026 11:09:54 +0200, Arnd Bergmann <arnd@kernel.org> said:
> From: Arnd Bergmann <arnd@arndb.de>
>
> These two patches are left from my cleanup series, finishing off the
> work to turn off CONFIG_GPIOLIB_LEGACY by default, and removing the
> include/linux/gpio.h header.
>
> I had originally planned to send these during the merge window after all
> the prerequisites made it in, but didn't finish that before my vacation,
> so I'm sending it now.  I suppose this makes them 7.4 material now,
> but at least the first one could stil be fast-tracked to 7.3 if there
> is a good reason.
>
> The second patch has to remove a few more leftover <linux/gpio.h>
> inclusions that made it into 7.3-rc1 either from new code or from
> conflicts with other changes.
>

With acks from SH and MIPS maintainers, I can take it for v7.4 through the
GPIO tree.

Bart
