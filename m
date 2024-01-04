Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9FB22EE6
	for <linux-sh@vger.kernel.org>; Thu,  4 Jan 2024 14:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-5e7c1012a42so5413607b3.3
        for <linux-sh@vger.kernel.org>; Thu, 04 Jan 2024 06:17:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704377823; x=1704982623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7nfKlfGODp+TruA+H2IIbhJYKgpuLZ7MawwqhDE0MkA=;
        b=bVbHdVEIelurX1TuyIVpTujSGg+JxnA/GCGgc1L8dtl7Dd6vgd+4p02APFvPnuy2fG
         n6v3MwlWEsxUJrm9oqDybZ22SHxq+xPvibEOTJlIcdDvjogcNy1kEMzjS/x1R/C/Z0Tn
         Fek9lhVszcm8d8cHzC557GJMztno4rYGBGj9T6YXS249ULDB3yTLGnQH927VeUpWBSII
         /TGib3t155Z5uCf2KUBgxT6E/Xp/2rASPqPHk+EV7UiSqz91VeRcCpePwRT+qkOL7LgN
         XTMxsZQHrQULzua3ehER3lBEYxEECGpHLlU0D/pETSpvmoppNMmK346URqDYsMs5KLET
         2/Yg==
X-Gm-Message-State: AOJu0Ywq9u3O1SWh/cEYs/lH5MShjwwBI9FC3/fSpFUejnW4aIQQk1Lw
	6gSXKav1mM7iHlnxqQeqEWVfi3SBtD16gg==
X-Google-Smtp-Source: AGHT+IE2qiOiWz1SMf2LUjGfs01o8WFCnCfSckIwXd11J8TXBTS4myrdnhY3BCbwBQsTFqiYG4C9zg==
X-Received: by 2002:a0d:dd02:0:b0:5e4:8583:b52d with SMTP id g2-20020a0ddd02000000b005e48583b52dmr613839ywe.58.1704377823087;
        Thu, 04 Jan 2024 06:17:03 -0800 (PST)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id z125-20020a816583000000b005e8fc1e90e8sm13864573ywb.111.2024.01.04.06.17.02
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 06:17:02 -0800 (PST)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-5e7c1012a42so5413317b3.3
        for <linux-sh@vger.kernel.org>; Thu, 04 Jan 2024 06:17:02 -0800 (PST)
X-Received: by 2002:a81:71c6:0:b0:5f3:6024:53c with SMTP id
 m189-20020a8171c6000000b005f36024053cmr689970ywc.32.1704377822394; Thu, 04
 Jan 2024 06:17:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2024010439-cauterize-trash-b603@gregkh> <7bdec121c0ce916f4589dd4247f9482704373aee.camel@physik.fu-berlin.de>
 <2024010406-country-entire-262d@gregkh> <810666aa13f5309d52d47109d20c4cf511a628e7.camel@physik.fu-berlin.de>
In-Reply-To: <810666aa13f5309d52d47109d20c4cf511a628e7.camel@physik.fu-berlin.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 4 Jan 2024 15:16:51 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX2YA8-_4mMM5Ck4deiN7nsjysPghQOguxrAzaNtP5Czw@mail.gmail.com>
Message-ID: <CAMuHMdX2YA8-_4mMM5Ck4deiN7nsjysPghQOguxrAzaNtP5Czw@mail.gmail.com>
Subject: Re: patch "maple: make maple_bus_type static and const" added to char-misc-testing
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Greg KH <gregkh@linuxfoundation.org>, dalias@libc.org, linux-sh@vger.kernel.org, 
	ysato@users.sourceforge.jp
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Adrian,

On Thu, Jan 4, 2024 at 3:02=E2=80=AFPM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> On Thu, 2024-01-04 at 14:57 +0100, Greg KH wrote:
> > > I was planning to start reviewing patches for arch/sh the upcoming we=
ekend,
> > > so you don't have to take the patch through your own tree.
> >
> > No worries, this way it gets into 6.8-rc1.
>
> But the merge window for 6.8-rc1 isn't open yet, is it?

The merge window will open this Monday.
However, everything should be present in linux-next before that,
which means it should be applied today, before Stephen (UTC+11!)
wakes up...

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
