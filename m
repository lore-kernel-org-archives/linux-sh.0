Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BA04218A1
	for <linux-sh@vger.kernel.org>; Tue,  9 Jun 2026 13:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781012285; cv=none; b=bfRrlQslWIZqfPvMGuNWaSt9v5gKgc4Y9c3zfDV7gjagEHhxeFxTbmTUgSYj7pE7dHbXQueTeQLnh9z50TSaxIcpWaKX+MqeO0yPNKpEzeFkX5iybBbpdsG/jg13s1PvF/diIqeEFrQxBD96mINNzWX0+q85zAfngQb09meUEuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781012285; c=relaxed/simple;
	bh=zNk6pJWd+v88a+9NOUGNQabXaXiV9hjQTgWFhpjOWl0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L4R6uHC0L7W6PZxrWzcEL1wGdz1HDFJsArVCiauTVxrl2nRHNIuIxxr0yAX/JvmtizDCOnETxOU22MQfpwV0kdb5eEwwENOoce2QzOgIQCufbQB9rWo0ssIyTl449XnT8xUAaroBKdHqR9iIdYXtv6Fu6emFYj+nk943UpVNxvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-59ccf81e6feso1864830e0c.2
        for <linux-sh@vger.kernel.org>; Tue, 09 Jun 2026 06:38:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781012282; x=1781617082;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t/PRbin0hiFf0sv0V65HKQzKM0CIanlyTiYsPPuNvzs=;
        b=TC27wjmpffStmIYBOSv+wzYC+AJeQMoKVII/JySTH1pT5rGzbRwk+PvWYubEZ283ez
         8AhYGosB9huZegmN9nFsWdficseRw+5uVlHzoLC+qfrs2QWJ2w5dk1N4zjqYEsIMZX1y
         2UCFJCMECXLEGRm7O0fqbxBJgJgSiMVFAFOidVsrTUo3TD2XX/v/CoIE+4lVlR0UrcjS
         6LXQKI5pCMIqIhVder/aMUqBDbqDtbwMQ2XONtskqNZPF1XTVYIaB67TGCqjvSPSZnbN
         zYJZSp+YDnDoUaaHz/e4GPhwDsNIYIWtS7iLN7dz1BkceZzb7MgL7/gFZr/pp3YjNOHP
         wGuA==
X-Forwarded-Encrypted: i=1; AFNElJ/UbJLQKNhmPyWsJtc4kne5NzTqnCz8uq7vIByB8ZVt3aiyQB1mFfPe0xlVXJGUQehrEpmy4mt0CQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxE9C5kVqC8ks/Zj2dWrmDzdlwqJXmvjDCImJMBo4xjMf+Qldjc
	Ee91fdzMmJpJwK5oxFtHduJspSzw8eyYTRxpdMKLFcvo9FQA8/i2V9hBgQ5iOypWcYM=
X-Gm-Gg: Acq92OEuTPMck/K0b7o4Y0H+2yALdXoIAuk+TCUZy7F1Dlw7gUn9CfCjCpn49lj/lrL
	GZWFgfRuNVkoHibYt6i/j1uuulKZa5blmYFkFWqvmlE/4Hu8pBVUM/Xn2oVyldYn5B66gAGbY/9
	bvBvTHGuJeFCkWrAGcOUS6YuIa+FAZ+ev4hCCxs7Ola+a5itrpuk2PigVCek8VMQDxXpjI3udbW
	yVeDDHkd+G8Ahll5v+a5GU0iRnhZDUTFMovVKwtvd0wqZDdV0AATxGpOXJCs/3zYPqEaNhlqtrT
	R6O2qBuzib30dzKVS4lqzoc9aJDpMiikeI8a0RO/WowqtXF1MpmTA5qxCsM9utr2NPBuR8kanTl
	IHcFjYMUOe/L/6NB41MBpZiug6NT2YkjKEUZfEO9GP0vztChVlM2LE0j5VRlvX3keuutJ5Ty3U7
	QeWZxrgDykc2Ch57HeP5Er5cRALpScfkTWm/rSet2JvsWSkC+Brk5gig5hu3BsMP9HzCq7o85vt
	GRtD7f+5t5GnQ==
X-Received: by 2002:a05:6122:e22d:b0:573:a779:62cf with SMTP id 71dfb90a1353d-5b63552db9fmr1179158e0c.7.1781012281858;
        Tue, 09 Jun 2026 06:38:01 -0700 (PDT)
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com. [209.85.221.175])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5a6dc44d233sm16793369e0c.10.2026.06.09.06.38.00
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 06:38:00 -0700 (PDT)
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-59dc1714d44so1723109e0c.3
        for <linux-sh@vger.kernel.org>; Tue, 09 Jun 2026 06:38:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/tjp0sMKn5nl2qPWpgBB2e8OEx/fjFaxPprXsW/26+aqwPzNA3F95LUUy9hmB0tArRMhgic1QDTA==@vger.kernel.org
X-Received: by 2002:a05:6122:2a47:b0:59e:f988:51a with SMTP id
 71dfb90a1353d-5b634763bc1mr1142689e0c.1.1781012280533; Tue, 09 Jun 2026
 06:38:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87zf1le4fu.wl-kuninori.morimoto.gx@renesas.com>
 <178094130630.20828.12708103059145547835.b4-ty@b4> <fa7d7af8a780c27f85e29c518ba45e39ab18abad.camel@physik.fu-berlin.de>
In-Reply-To: <fa7d7af8a780c27f85e29c518ba45e39ab18abad.camel@physik.fu-berlin.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 9 Jun 2026 15:37:47 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXVWPxu-5BXAgWOBoWdNXxZ2zeAfTovXxftXsKuCUUDww@mail.gmail.com>
X-Gm-Features: AVVi8CdJQ9opFjMVwtIPNGUt6qVgHAl8SOhR-UuJZWuU9CAlreT_77PbJOB7tNs
Message-ID: <CAMuHMdXVWPxu-5BXAgWOBoWdNXxZ2zeAfTovXxftXsKuCUUDww@mail.gmail.com>
Subject: Re: [PATCH 0/3] ASoC: simple-card: remove platform data style
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Mark Brown <broonie@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Jaroslav Kysela <perex@perex.cz>, 
	Liam Girdwood <lgirdwood@gmail.com>, Linus Walleij <linusw@kernel.org>, Rich Felker <dalias@libc.org>, 
	Takashi Iwai <tiwai@suse.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-sh@vger.kernel.org, 
	linux-sound@vger.kernel.org, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset="UTF-8"

Hi Adrian,

On Tue, 9 Jun 2026 at 14:21, John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> On Mon, 2026-06-08 at 18:55 +0100, Mark Brown wrote:
> > On Wed, 27 May 2026 06:45:26 +0000, Kuninori Morimoto wrote:
> > > ASoC: simple-card: remove platform data style
> > >
> > > Hi
> > >
> > > SuperH ecovec24/7724se are the last user of Simple Audio Card as
> > > "platform data style". It is mainly supporting "DT style" in these days.
> > >
> > > [...]
> >
> > Applied to
> >
> >    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.2
> >
> > Thanks!
> >
> > [1/3] sh: ecovec24: remove FSI/DA7210/Simple-Audio-Card support
> >       https://git.kernel.org/broonie/sound/c/9cc93ebc85e7
> > [2/3] sh: 7724se: remove FSI/AK4642/Simple-Audio-Card support
> >       https://git.kernel.org/broonie/sound/c/deadb855b694
> > [3/3] ASoC: simple-card: remove platform data style
> >       https://git.kernel.org/broonie/sound/c/325fea33e141
> >
> > All being well this means that it will be integrated into the linux-next
> > tree (usually sometime in the next 24 hours) and sent to Linus during
> > the next merge window (or sooner if it is a bug fix), however if
> > problems are discovered then the patch may be dropped or reverted.
> >
> > You may get further e-mails resulting from automated or manual testing
> > and review of the tree, please engage with people reporting problems and
> > send followup patches addressing any issues that are reported if needed.
> >
> > If any updates are required or you are submitting further changes they
> > should be sent as incremental updates against current git, existing
> > patches will not be replaced.
> >
> > Please add any relevant lists and maintainers to the CCs when replying
> > to this mail.
>
> I actually wanted to keep the driver and convert it to using device-trees,
> not remove it. We have an out-of-tree patch for switching SuperH to device-
> tree support.

1. The sound driver is not removed at all.
2. s/SuperH/SH7751R/.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
