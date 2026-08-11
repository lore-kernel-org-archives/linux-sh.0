Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56793EC81B
	for <linux-sh@vger.kernel.org>; Tue, 11 Aug 2026 07:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786434697; cv=none; b=HEPtwqS7ZRphPvhv/cWQAN25AJk3uLm2GwlvTtc8nilvtAn/AsKASB28C2N3i63rADYFVXx5kJNGtiHszycQ09C1t7U0TqVZV0PC59Gha+uSSPmR4yRcFso5/EujbWpodOD6+Vh6H23V5hz7A9Bl5lkhaAfP+wCSrZ4mOqcxq6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786434697; c=relaxed/simple;
	bh=0qxxrXYVSEfWFzbuHGJKRBL9EjyYN+jDS6A6yAibSn8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NxOsXIU1VuHHKfm702fbu9mN+92NSmbnW2g8i0WiN9Yn0wGffhO7YP6Z2jCNq711N5NOdscBGfnBcYm2hFxCVhQksXX0C4OuWQYbqzhspAKgPjR2StiWrNXi4uiA+fyLECJOWvuTWhOSbpSP22tHdn/UPZjAluK2dsyfbNPCqas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nMIeja9M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nMIeja9M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 539C71F00A3F
	for <linux-sh@vger.kernel.org>; Tue, 11 Aug 2026 07:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786434696;
	bh=KHnZR25WmWegesrPwzg1l6hMq9EwqrehsZnY2Ik2coU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=nMIeja9MXe40HkmBGLsiX8ExFBEDEq7BtvhCb7AjhPsTX2oMJ6BnTCJoaAQ3kAEF3
	 cUBcG63AyOXSEM4JDwH7ODTqTHtTRl8xaIkcnYxt7mRvHpHLrRAKckp8BjII+Hc625
	 2w/H28a3ReqDvzwh5KsS0M9FS6Lqsg+kNdczY04pbFswYw78VrixLY/Wed0H1R0J99
	 rifJT6OIWkZuXmKyeEHqKWdONhIoM1+Vk2k7cGuk6LkMnPGizPPAiM1hPP9+gtZiAh
	 V0aKBloPejrMTidY/quKO/6DTfHBuy7LW6NzmCE7TjhheCBswiLsv+AXKcSSVWhBDl
	 49uSdjkNq4GkQ==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5b28c91fba5so915912e87.1
        for <linux-sh@vger.kernel.org>; Tue, 11 Aug 2026 00:51:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rr1pONEDGnE2TcT/tA4r0GINccFBBh0D5Jsh8nUBO40tR2j0oeHie61mNlfSkN3uIInpiMnr1WflA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzHKL60713Qpdo5cyfDLgQI3XRGq+rGps/6cmxS2MGfj/c6onnR
	kVM29PHHTwtWyOJVGyD6CzcUoFblmb/LuselAigcrDdKQzBGyqKMxkao6jUusb1fmeNmtU2lVvT
	uZJrS4NUKmqu8hr27MZtBByCLcdFTmuA=
X-Received: by 2002:a05:6512:230c:b0:5b1:5f9a:96bf with SMTP id
 2adb3069b0e04-5b448a288c0mr236907e87.8.1786434695088; Tue, 11 Aug 2026
 00:51:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260802-sh-rsk7203-swnode-props-v1-1-7a790cbac9e6@gmail.com>
 <32a0d810bfc56029453aa72cefa49cb40466f64e.camel@physik.fu-berlin.de>
 <anAvJM0u_TIgL4ck@google.com> <70cb2e4d8a6fd11cbeb534dbf269f67148a00a8d.camel@physik.fu-berlin.de>
 <CAD++jLkxXYfZadV26956yMAaCtZYr7mRGPA8_kixufbXFW1B=Q@mail.gmail.com>
 <CAD++jLmNry6DwjDm490_n1Z2AmBb7viaOTEv_Ntnsc77dBHmJQ@mail.gmail.com> <b9b5a0c24433c4a191a504f652127ef1fb9b1731.camel@physik.fu-berlin.de>
In-Reply-To: <b9b5a0c24433c4a191a504f652127ef1fb9b1731.camel@physik.fu-berlin.de>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 11 Aug 2026 09:51:22 +0200
X-Gmail-Original-Message-ID: <CAD++jLnh3GX=Sht9e1C1nyb0=cxCXembBwBf7=Gq0wLsV74KmQ@mail.gmail.com>
X-Gm-Features: AUfX_mzu-6sIF8gqi3eOPlyzOFd1tR-W8Z7dsTWBChEfDRBkOF5SgZs_RRwglVs
Message-ID: <CAD++jLnh3GX=Sht9e1C1nyb0=cxCXembBwBf7=Gq0wLsV74KmQ@mail.gmail.com>
Subject: Re: [PATCH] sh: mach-rsk: rsk7203: avoid using inline compound literals
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, linux-sh@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi John,

On Tue, Aug 11, 2026 at 8:59=E2=80=AFAM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> On Tue, 2026-08-11 at 08:52 +0200, Linus Walleij wrote:
> > On Fri, Aug 7, 2026 at 12:05=E2=80=AFAM Linus Walleij <linusw@kernel.or=
g> wrote:
> >
> > > 1. (easiest): tell me to just revert this out of my tree.
> > >  Deal with this whole ordeal later.
> >
> > The merge window is coming up and I can't send a broken tree
> > to Linus so I went with this option now.
> >
> > John: the patches are all yours, I have dropped them from my
> > tree.
>
> OK, I will pick them up this week. My workload has settled a bit, so that
> I have some time for kernel stuff again.
>
> Did you revert Dmitry's patches in the kernel as well?

I took out these:
106dc49414c4 sh: mach-rsk: rsk7203: convert pin configuration to using
software nodes
c5b962b6023d pinctrl: renesas: gpio: support software nodes for function GP=
IOs
6905cdac0e51 sh: mach-rsk: rsk7203: use static device properties for
LEDs and GPIO buttons
62067bc0a083 sh: pfc: attach software node to the GPIO chip
4c870bbaba1b pinctrl: renesas: gpio: isolate function gpiochip from
parent fwnode

I have added my review tag to 4c870bbaba1b and c5b962b6023d
so you can just apply them to the SH tree. They don't conflict with
anything, at least not this merge window, so you can safely queue them.

Yours,
Linus Walleij
