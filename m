Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61ADE352C2C
	for <linux-sh@vger.kernel.org>; Fri, 10 Jul 2026 18:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783709434; cv=none; b=mjVYpadkj3O136RgxVhtyxgQnJY5AnozBzf/e+UiY0LXsqiheZNejQ3mkFCbUgAm2q+3z8CpaWRef8eucv/JC8Hf3U6GxVfAP6T5FAkuijny87IcnIzXqwkUYoUVE0z/jl+7i/CJDyybGkKHVU9miuHAUxnL6Ob9fpWD22mqYmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783709434; c=relaxed/simple;
	bh=e8r554PKQEMa0LukCYtTJHrE37158lRUm7GBcEu5DYM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KGUYMmY8zIaPPganp+yup8X3kRyUt1+4phBwVvck7WGi0YSLFDUo10wrf1C4weMk/r+8519+VQP/AQJsQpdbRL+XVNqzuIF6KlhAsMkyX9oGTaDGO5iVa27SLojIow2KuH6YL2B7wsUZ94MGnPKyJT08tMpE2UtJM4oxVV+xT9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B9qGzrQQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B9qGzrQQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1866D1F00ACA
	for <linux-sh@vger.kernel.org>; Fri, 10 Jul 2026 18:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783709433;
	bh=e8r554PKQEMa0LukCYtTJHrE37158lRUm7GBcEu5DYM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=B9qGzrQQrYvPrH/tl7IZvQrYCOTHnaCvh0OSU54hrmWHxWdoCA+SUJh/k05yRh8ar
	 J74ERpGPGkjzRzvEPFReQC+WZWEZ6X58MBNXsSmksz6KaHUetsZrC0PbBavfiWcHRb
	 HOyYan4QE4DNQbFIERykCg4v020PuWCRLxr1K8B/WQT8pqB3OWanqHGFYPw9VUmKc3
	 nvdPn/1dQwjTquJrOMwCWj6WuzFgef9pebNPdN1njv9ezunJN9b8QCIVh00D0dk00x
	 4Vcqebpd/YbjppdiM9kcpKi57GsagTtaeMqsvOLH5QlANLJZQmAn0dKyAIkLSz4S/r
	 SMVyq622OMheA==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5aec201b582so1021792e87.1
        for <linux-sh@vger.kernel.org>; Fri, 10 Jul 2026 11:50:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Ro2ryrimHzDsBnWNN74BmMeLaFqgd2BX+DkQwAhyMP3DcnkFDkqaoYSHuDtZ84Oc9ocxqQHTAF3Bw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxOf1tVH7ExjbEz/Y/uFdAFTrtzW4zkTBphAzhK3CWwba5PMmij
	eBr1gpVIYml0slCJQImWRH4qYnB2OK6vWX5qd0e2T64ueBLJ1hO1knJiaiJ9qehavHD01dN7wxh
	cIKU2woNOHjafJSH1SWUJ8Ax5PkFIKFI=
X-Received: by 2002:a05:6512:128b:b0:5ae:b0ec:b024 with SMTP id
 2adb3069b0e04-5b0236be053mr67117e87.53.1783709431858; Fri, 10 Jul 2026
 11:50:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260704-sh-x3proto-swnode-v1-0-0c039549dc46@gmail.com>
In-Reply-To: <20260704-sh-x3proto-swnode-v1-0-0c039549dc46@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 10 Jul 2026 20:50:20 +0200
X-Gmail-Original-Message-ID: <CAD++jLkFmHqbOMp5SjiS5FiS4YbkQPbwYFcwEQhP_BFXrd47dg@mail.gmail.com>
X-Gm-Features: AUfX_mxf19wSM9jPNvh5Uqv6zRKwPqLxaXsht7YZeklgUQ5RNtzdolY9A7u05Wo
Message-ID: <CAD++jLkFmHqbOMp5SjiS5FiS4YbkQPbwYFcwEQhP_BFXrd47dg@mail.gmail.com>
Subject: Re: [PATCH 0/2] sh: mach-x3proto: convert gpio-keys to software nodes
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Bartosz Golaszewski <brgl@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 5, 2026 at 7:04=E2=80=AFAM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

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

Wow putting the AI to good use here!

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
