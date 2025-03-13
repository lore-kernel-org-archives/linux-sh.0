Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D2F25FA0D;
	Thu, 13 Mar 2025 09:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741858723; cv=none; b=CDxAIVwb3wfgrdPCItX9ZyC5t9kYqGXMziB75TkVpSk/VEU+UpXb2P3edbzejCE7zi3oDqPNJvaeFBSYjgJCxb1wIdw/W4uTcdKLAlO7k3VrVURzvixLry7Y4YoHJmWwmLBQCSccrGkYCo2JNCoEANisF+UXJhD2Mf5ORxZNBCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741858723; c=relaxed/simple;
	bh=GHsyvUrd0wQ1kRjiqzh1FJOGqKa1mgmnz4BUxH2iJ64=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IGNh1bP7C6Sj8Z7YGf+O44qEY+qZ5o0HwF9/5+G+fDxQKYRO3S7pj0A708Omw+82Zvs21wMxPgJEAOG6awYmncRsXF8zlPdn0bB+McFnFOpgKEYZfbAWxuDIAj9tn+cMoS1hC977f0t23kodyLhdASZMmo4+bb0msSjDLmbvpm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W+4jLLm6; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+4jLLm6"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43d0782d787so6392705e9.0;
        Thu, 13 Mar 2025 02:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741858720; x=1742463520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KLT02uxYGs6ZED4UE1FxVdbvpn40AYxBT7QBiZ2e2Lw=;
        b=W+4jLLm6WoVPMqW2Ew+OCe4fe5TeZq4xYR+xYkWeAbI7pPe4MbIHUAzr2GHCfzqhdM
         28p/KfB75zZ4U7RfDGKSzoBbM0v6Vc3eFV2S/GtW2ehacOXe23/maIV/C9tP9JhfK43P
         IZXaJGSS7fbppSz8qtbWSsKkWNMSE5gufaAL3F1Jw5DVbPHrzOLT7lNU7SpPzml6V3L3
         psSLXr2CiSnistFosW/CKcLGCfo8I/wq/6ANcIIBCK418pBCaLPhKMcfqK+p2Fnf0X9l
         VCtMDYvP/iAAmrh5oXKcOw+9c6Qw1d9CIE/2enu7wOxMq1Qoz57YclMc3GPajyaV1QsP
         bSfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741858720; x=1742463520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KLT02uxYGs6ZED4UE1FxVdbvpn40AYxBT7QBiZ2e2Lw=;
        b=xIJK01krUAEUvK+Rs1DbEz1LXWITXPwen+hr6xGJbHJTT3IWcwYJjXPPxBppPbEaFP
         gYkfeGC35AG/d4+GdnepIeEJZ7NLqd/TWs12R3M7hUld8UFcyfnbyik3DIQgpuerhE4p
         7AL9UAAFyiqmPpTmzk2geHsTpYvEzubM9SJ0wh/iJNP1sBeMktAQdnIDaXxk2cNOFWMK
         NSkuVZOJ9PDeBqbB2WCiCDv4l1KGx7L6DcCF3xNwQau5bce7osHrovQfMKu871RZTMkm
         H111l4jUcZ5Kw+NIhz6k0QIZj1bFSCObHL9YreNSrahaw5cyEkB183QE9lRRManOtOXX
         HnzA==
X-Forwarded-Encrypted: i=1; AJvYcCVzlzVo8tuR2tIG9dCAuzoBE6ZIyFBdoUsxgsahV34/5Ao2MEoRLVoX/ELekyNpbeZTFO1BgadAjYdxuYg=@vger.kernel.org, AJvYcCXCFG3VctVnmqyXiD6amw2Yz3x4rroBYiZfoHo9Y3cnTVtMPGmHJot7vkmrLb+hSFmmaMgKE3IrWjk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPOD+I/RBX/dd74Tj2vpxRj4vayRK+l92CamWojucta+LphfhS
	P7e3cyvy+6J7h5b3b3w1Do27tpa6nBxN3wB2FDa57w6iHrCvYAf2
X-Gm-Gg: ASbGnctkSbQpUiN0/+z8qhCD0i79F4stnXnFJMlxvhd2zFeJWw0WhQQFSGVFU+gNh06
	11kO4U5EyNnMZot5YX3k3IKqk1W+OT5u1uYTRqrFvkBmAytyXWEAaTfhgHsN69Kd960AyfO1peX
	nPQ6LDDtfaPRHDkQH4idI4qrErCPj49FPpQNWs0r9T5u2fnKiRud1PK18d07rkoTHwmJaNu/J4L
	+5Gb6r493kVE0JREjSlqvftMlVqGQIKHwPtbyr74iXDJCA/cSS68pZ5zqRmcVXSOj4QwZugroxw
	A3FB0tcJlp5LIDPJqJCE1hEF66qfpygKWVXRmNwMijanPe+tvKG+dk8ljDgEgXHLNN1jJOjfbWJ
	XxVUVD58=
X-Google-Smtp-Source: AGHT+IH7AXjc76BgsJI/jdBjV7ovqJeF72QTMgXMNVgHVzPMh2K8NYbPAJZYstDicKtX5ZnYGSL0Qg==
X-Received: by 2002:a5d:6d8a:0:b0:38d:d371:e04d with SMTP id ffacd0b85a97d-39132dacb85mr19161436f8f.34.1741858720176;
        Thu, 13 Mar 2025 02:38:40 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c82c23ffsm1498503f8f.22.2025.03.13.02.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 02:38:39 -0700 (PDT)
Date: Thu, 13 Mar 2025 09:38:38 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Uros Bizjak <ubizjak@gmail.com>, John Paul Adrian Glaubitz
 <glaubitz@physik.fu-berlin.de>, Artur Rojek <contact@artur-rojek.eu>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner
 <tglx@linutronix.de>, Geert Uytterhoeven <geert+renesas@glider.be>, "D .
 Jeff Dionne" <jeff@coresemi.io>, Rob Landley <rob@landley.net>,
 linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] sh: align .bss section padding to 8-byte boundary
Message-ID: <20250313093838.10749599@pumpkin>
In-Reply-To: <CAMuHMdXaw117mimN_7UgwbfbG9grVg09WfjKa2Lz4eGqM24EvA@mail.gmail.com>
References: <20250216175545.35079-1-contact@artur-rojek.eu>
	<20250216175545.35079-2-contact@artur-rojek.eu>
	<5365422a9715376c76a89e255c978fc39064e243.camel@physik.fu-berlin.de>
	<433bc8a0732bf8a63c64c4bf0e6ad4a7@artur-rojek.eu>
	<967e29681c8bc39edfdd9c645d943f17d341c2ae.camel@physik.fu-berlin.de>
	<CAFULd4b8+HsmJC2XkW50pxtw=fHNrL9gH1_WM90jh+rfLCbSHw@mail.gmail.com>
	<CAMuHMdXaw117mimN_7UgwbfbG9grVg09WfjKa2Lz4eGqM24EvA@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 12 Mar 2025 10:47:00 +0100
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Hi Uros,
>=20
> On Wed, 12 Mar 2025 at 09:32, Uros Bizjak <ubizjak@gmail.com> wrote:
> > On Wed, Mar 12, 2025 at 9:22=E2=80=AFAM John Paul Adrian Glaubitz
> > <glaubitz@physik.fu-berlin.de> wrote: =20
....
> > > OK. FWIW, do you understand what SBSS is for? I couldn't find any exp=
lanation
> > > for it. =20
> >
> > Small BSS section. The compiler can put data objects under a certain
> > size threshold to the .sbss section. Looking at GCC sh config, sh does
> > not use this section. =20

The .sbss (and .sdata) sections are used by some architectures (eg Nios2)
for data that can be accessed using a 16bit offset from a fixed register.
(Although using the register as global register variable generates better c=
ode.)
Historically they may have been used for data at the top/bottom of the
addresses space (for the same reason).

There is no reason to just use it for 'small' (eg 8 bytes or less)
data, that is just some empirical default.

I guess they could also be used on cpu like the strongarm for memory
that used the 'small data cache' (useful for screen buffer memory!).

	David
