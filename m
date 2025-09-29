Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEC224113D
	for <linux-sh@vger.kernel.org>; Mon, 29 Sep 2025 08:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759134434; cv=none; b=YmUj7oIktYHqIn7W8w6HuRdh9y8Y+FYQwwQfN+lfQVpicpVRhTqb+gfS+QQJHGVBWGr4Q+Ca7l6Fn1V3jxjZtnCiyH+bekJb8xRUxgHqDHHh32v31PsS5zh2emjPibdGrlzZfmvZb3XDAKImDSOK5WiHQpCWzJbadpwtbF3Q2L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759134434; c=relaxed/simple;
	bh=3wEnJJupgz1SJm2E9By0j/0oQe0EV3tSedp0jhNUmw0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iSCEurjc8G4xbhRlKyf1G1CQJzUkMyDaGeG9nGETDfF7yRvJw+rpm5MJ/GiGf3i1nOQ5ZtSM/J5zQPQeh3E20wnLaPQmriBMTXpZp6RFAHNLM8RT97h0HxbXIauZuMg85WkvvBtsIs9jHecT2NfjgrdrSbmYbqvLilz2BC1RcBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-58d377d786bso3101715137.1
        for <linux-sh@vger.kernel.org>; Mon, 29 Sep 2025 01:27:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759134430; x=1759739230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vjEe7O8j7KCrjhzBmS059atyR4bTunLk3aQjDHMi0Mg=;
        b=kMW8CS2K34cTQ93m76b+TLDY9Mo6tkv3A3nVTaGOtS3CUS8+GcXmCbVpeNTFhu5ZUQ
         UickgrV113Oj1Dvg0LcHt6TNFftiAiTYLQXQ6FJFL6Ncml7KEuUZnfPESY0FdgYlyTmz
         pya4bO3xxWxPmI9PKEAgxwjd6PlIIeDggyyWCGBIwdS21wUcMCjnZmPqsw8nplyQGgDF
         uhRlhNKvY5vXLDKxWHqUUyLC5GOStt3Y90EulQW0xvLwpkmHLzTXMTKyQpc6I15fQF9w
         zGI/ixhJKFDkKCt3hV0Mb0o3BLvjFe+KQNRinIn6zIoYGrCN5pkyAcXAb94DpR+96S1r
         CE8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWXJBxp4uH77N3+sFsHeldvlu6/fH/GYjINpeHgMzkIlpZWlkIPASp/vTcSajPBnRnIgaoN15wLWA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwGV2W+2FGojy3iSYzciKJs3WeYXHScQaOQ13VYpQX+8zQmYTPy
	We+3zHnXJsZT4mFU/PYTBXPuKgxOA1fB11XgO3s3D3RAXSz5avhy/fnEyCkXH176
X-Gm-Gg: ASbGnctxWsP1bwc1pkcKwORUsnbI1B3tljaM7WaHLfV668NEFyhepQ5K2cUgPd6n6dR
	jxEAvqyU7aA6Nuim4VdxEHLTxOsrMg89kdE16EJR3t+k2eGqpU5LpHyMAZ1p6Rv1gDrhE+MSyLh
	xaYp0Kpd0ldCNdnjKrCW+p1qBe1a8mDDqoa2cexe8doD35RIDlmMoOBDptn0KhjfGW6ZRz6Hpei
	9mkozcf8w6t6efF6iMpqCebUi5vuZNWro6quPoHoIW1siixtsLL8KJgoWo6hZx2u19OajQCN54q
	B6Cv+XK7Drqgszo4zA3A4LSaAk/4MScGPF8cbDC4JmMefOC48iP7j+iIynehCP9soas9b0z1vd+
	947x9Hs74MDpHP8OuEqRVUqEGNbDdCCHLWPGR14LF38D9grgjWpEja99mYBrl
X-Google-Smtp-Source: AGHT+IFIARgVldCIh9c/HXV/KdHhotiNDKB57mDlHWlgI/7HM+IDUBChhnliiSZPt95XbPyOTy0P1w==
X-Received: by 2002:a05:6102:3f0e:b0:522:48fb:9478 with SMTP id ada2fe7eead31-5acd74c7c4fmr7567772137.28.1759134430533;
        Mon, 29 Sep 2025 01:27:10 -0700 (PDT)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5ae305d0c44sm3228409137.1.2025.09.29.01.27.09
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 01:27:10 -0700 (PDT)
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-89018ec3597so2421163241.0
        for <linux-sh@vger.kernel.org>; Mon, 29 Sep 2025 01:27:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUh2X8rg+pd27Vqn+ADN/hYiweb8bVAPVsnqrtg/wBfB1MXbMsYuZkSvZRZnTICzKqEgLLV+pY5yA==@vger.kernel.org
X-Received: by 2002:a05:6102:d90:b0:5a4:420c:6f94 with SMTP id
 ada2fe7eead31-5accbcdfbdfmr6816724137.4.1759134429370; Mon, 29 Sep 2025
 01:27:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1756998732.git.geert+renesas@glider.be> <ee4def57eb68dd2c32969c678ea916d2233636ed.1756998732.git.geert+renesas@glider.be>
 <082d5554-7dae-4ff4-bbbe-853268865025@lunn.ch> <CAMuHMdU96u41ESayKOa9Z+fy2EvLCbKSNg256N5XZMJMB+9W6A@mail.gmail.com>
 <c1f6fb82-9188-48ed-9763-712afa71c481@lunn.ch> <20250905184103.GA1887882@ragnatech.se>
 <CAMuHMdU=Q6AZcryj1ZBGW+5F+iYvZCL=Eg0yPw0B4jnczmA8nw@mail.gmail.com>
In-Reply-To: <CAMuHMdU=Q6AZcryj1ZBGW+5F+iYvZCL=Eg0yPw0B4jnczmA8nw@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 29 Sep 2025 10:26:57 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW7+F-VdNw+LLCs_WPUsFVNnbsCT-wompswecEmipmhqA@mail.gmail.com>
X-Gm-Features: AS18NWC4L73fMvbY7JVbl7jU9THAB7wi-kzKLyAei1Oc0zvFvsC0lPY-ku9gbpA
Message-ID: <CAMuHMdW7+F-VdNw+LLCs_WPUsFVNnbsCT-wompswecEmipmhqA@mail.gmail.com>
Subject: Re: [PATCH net-next 2/3] sh_eth: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
To: =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
Cc: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, 
	Markus Schneider-Pargmann <msp@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 8 Sept 2025 at 16:36, Geert Uytterhoeven <geert@linux-m68k.org> wro=
te:
> On Fri, 5 Sept 2025 at 20:41, Niklas S=C3=B6derlund
> <niklas.soderlund@ragnatech.se> wrote:
> > On 2025-09-05 13:57:05 +0200, Andrew Lunn wrote:
> > > > You cannot enter system sleep without CONFIG_PM_SLEEP, so enabling
> > > > WoL would be pointless.
> > >
> > > Yet get_wol will return WoL can be used, and set_wol will allow you t=
o
> > > configure it. It seems like EOPNOTSUPP would be better.
> >
> > Out of curiosity. Are you suggesting a compile time check/construct for
> > CONFIG_PM_SLEEP be added in the driver itself, or in ethtool_set_wol()
> > and ethtool_get_wol() in net/ethtool/ioctl.c to complement the
> >
> >     if (!dev->ethtool_ops->get_wol || !dev->ethtool_ops->set_wol)
> >         return -EOPNOTSUPP;
> >
> > checks already there? To always return EOPNOTSUPP if PM_SLEEP is not
> > selected?
>
> Iff we want to go that route, I'd vote for handling it in common code.
> Still, there is no guarantee that WoL will actually work, as on
> some systems it may depend on the firmware, too.  E.g. on ARM
> systems with PSCI, the SoC may be powered down during s2ram, so
> there is no guarantee that any of the wake-up sources shown in
> /sys/kernel/debug/wakeup_sources can actually wake up the system.
> I tried having a mechanism to describe that in DT, but it was rejected.

(oops, forgot to press "send" in an old draft)

Discovering commit af8dbf9c6aa8972f ("schemas: wakeup-source:
Possibility for system states") in dt-schema.git, there seems to
be hope!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
