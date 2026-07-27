Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535213DD500
	for <linux-sh@vger.kernel.org>; Mon, 27 Jul 2026 07:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785139047; cv=none; b=U0UQmgmfKKvnv+cOqi+AKQDguWI27a/c9sJvO4E+IKRTyn/RHcgbrwTnfA0a3BkL96QkQ5CeT+pF/zzdkmzcXPqS5kiw7Bq88BPD5Cr6v0W4kyhpL16hFbAto+i++GX12KktDRHr9dFswTfdMS05hsvAP6WPakckyjiKv+o7Lb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785139047; c=relaxed/simple;
	bh=tw+AJz4qt4JrBxlZuLNv/Da/UoDzueOZtTUrOcbKNb8=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WDxdolEMLVS4BCtLeZ1PeaUC9culwJc+S8csAH3TOjp35TNyP6szVdZ+n7OtEOpSeaniJhpFyvK1ukt7vmL/07lqIsrKnGrVsmkpZ/vv0rN6jIok0tuOyi108MReIEPnk4QNtiZOoBgdATevINh7zvFErZTx7Kma0ZSPYGb7vqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CqR4UeD9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CqR4UeD9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19B571F00A3F
	for <linux-sh@vger.kernel.org>; Mon, 27 Jul 2026 07:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785139046;
	bh=0arD5IsAvxdDIvrIg+Sev7LHm607DCox2CINoPn2JVg=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=CqR4UeD9ZZM96l5nrZA0/CNAxYUF3vPdzYqxriC5d3Bz9Q5BOoRdDiFR3rLJSrid8
	 Z2kUpQynBSOxeV2iysV4nLxhC6eEbLPLw63K5JkxFS+HDRAstdbCS7cTqDgv006ypP
	 rMHbfvjtJnNcJHciETC3+FCHFbFmmxPYFD0m68ITuKoT6LaG6s8wugZ5KwouhZkfQm
	 p+8AeCtKst//laSAvyeNfxG3+bIpH6kdJqGhOuMQX955fTKPqZpKIbylU9kO02IucE
	 F92n7OUvjdBlS1UJ8kZ06wTqRSyR3kEJACbgZikViADY1tfcCH558uFcXVMRdRdmJe
	 q3Zf7wCWzCxew==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5aeb2bc82ccso2321695e87.2
        for <linux-sh@vger.kernel.org>; Mon, 27 Jul 2026 00:57:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqYVFjwIepKCUNOwpPaT/vaMAnHk0qIlqFJ+BRbosVBS9+Po3kHpalUEwvhqhy2ATjfh+GzqMmQJw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7uFyU1l8q/ksvOMtf1eyA6P9AxtGUBdit9Y+1xjNsGG2rbw48
	y/KEHTl9JRFHVAASDy1dI+Eo0fTV4utDRMe9zTi+zjI3OJmt+c4t8pigSMPqyTtu/5sKnFe9dCc
	GPkhUIVOx9Yn5mCSQT9+b3gTZ5eZR6ialLonNSeD0NA==
X-Received: by 2002:a05:6512:159c:b0:5b2:a339:b3fe with SMTP id
 2adb3069b0e04-5b2c1b26e42mr1332518e87.39.1785139044803; Mon, 27 Jul 2026
 00:57:24 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 27 Jul 2026 00:57:22 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 27 Jul 2026 00:57:22 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <aa9cf4a4-a848-43cc-a236-e8e4b89101a6@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aa9cf4a4-a848-43cc-a236-e8e4b89101a6@app.fastmail.com>
Date: Mon, 27 Jul 2026 00:57:22 -0700
X-Gmail-Original-Message-ID: <CAMRc=MeATQp1nPkQSaJm6Ceo=SrqDbgUO6TF0Y94ox-xP+c2hw@mail.gmail.com>
X-Gm-Features: AUfX_mw0iUUjDFSIh_mXWBBwlVAigNutzQZ_gU1mHhfeYvjQnyk40ypge6OHhTs
Message-ID: <CAMRc=MeATQp1nPkQSaJm6Ceo=SrqDbgUO6TF0Y94ox-xP+c2hw@mail.gmail.com>
Subject: Re: [GIT PULL] gpio: legacy interface cleanups for 7.3
To: Arnd Bergmann <arnd@arndb.de>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Linus Walleij <linusw@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org, 
	"open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, linux-sh@vger.kernel.org, 
	linux-mips@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 24 Jul 2026 20:22:45 +0200, Arnd Bergmann <arnd@arndb.de> said:
> The following changes since commit dc59e4fea9d83f03bad6bddf3fa2e52491777482:
>
>   Linux 7.2-rc1 (2026-06-28 12:01:31 -0700)
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git tags/config-gpio-legacy-for-7.3
>
> for you to fetch changes up to 57f64d52ab5e836a5f3f4ea6fd868941b2d7dcdf:
>
>   gpib: gpio: replace linux/gpio.h inclusion (2026-07-24 20:12:48 +0200)
>
> ----------------------------------------------------------------
> gpio: legacy interface cleanups for 7.3
>
> These are the remaining patches for legacy gpio interface
> cleanup, ensuring that files referencing them are sure to
> have CONFIG_GPIOLIB_LEGACY set, and use linux/gpio/legacy.h
> instead of the old linux/gpio.h header.
>
> There are a few more patches already merged in other
> branches for 7.3, including soc, led, net and media. Once
> everything is in, we can apply the final patches to turn
> off CONFIG_GPIOLIB_LEGACY by default and remove the obsolete
> header file.
>
> This branch is based on the immutable ib-mfd-legacy-gpio-7.3
> branch from mfd.git to avoid a conflict in the rohm drivers.
>
> ----------------------------------------------------------------

Pulled, thanks!

Bartosz
