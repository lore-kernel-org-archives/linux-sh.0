Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0A7249FD
	for <linux-sh@vger.kernel.org>; Thu,  4 Jan 2024 16:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-5f3da7ba2bfso6754847b3.3
        for <linux-sh@vger.kernel.org>; Thu, 04 Jan 2024 08:01:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704384119; x=1704988919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JqLXF43/y/cGG703r0ZGYc5chYL4nV7NLhFxrFt/DI4=;
        b=sDtHI9cyWnjs9N4TRpCNwaAxyptzmAVZIldqzBLFGXJatA+nBW9EDMlOe2lZ6u4uWw
         3jmwzBULHiNna7H01QguPJPfsAu3Y6anZMVsdTM4oy2KwFH8QlPbWBJIntUnICuK3sX1
         q/PeK1ybdwBS1DybMWGUk+LEVOdn36a1ylsUUPJhwA6KiptXg+Z0faqlbRiP806SMAof
         69wifOiNEYfNS3AylmgU8dQfnpc3+iWs76Q6rohgczy7B/5LeVJrATd+4wBy0b7/SAmZ
         k11AMVS2WjB3JLiwVJ2wOjrbqxA9tDl/vqkLtk+ITM5ZySnm0s1aNBDudSJSxB0G1Dyu
         xd2A==
X-Gm-Message-State: AOJu0YzVb9Y/vyNuM4CDwGRotxfqYCySwnaK18GiczFZpfS4+h88o38Z
	EKnGHoc+OfHRh/wEtwb0NYweXLIpCokFhA==
X-Google-Smtp-Source: AGHT+IGsizOwKOp8iyH6MUdVYQVt5lFQYSBeHQTj+mpVAwkaOiipLtVvQvei33m2ZfPa/L6rlNgCyw==
X-Received: by 2002:a81:df10:0:b0:5e7:c9de:1ae3 with SMTP id c16-20020a81df10000000b005e7c9de1ae3mr738292ywn.47.1704384118679;
        Thu, 04 Jan 2024 08:01:58 -0800 (PST)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id e203-20020a8169d4000000b005b37c6e01f9sm13860949ywc.90.2024.01.04.08.01.57
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 08:01:57 -0800 (PST)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-5f2d4aaa2fdso6810527b3.1
        for <linux-sh@vger.kernel.org>; Thu, 04 Jan 2024 08:01:57 -0800 (PST)
X-Received: by 2002:a81:8041:0:b0:5e7:dd98:da0b with SMTP id
 q62-20020a818041000000b005e7dd98da0bmr783184ywf.39.1704384117384; Thu, 04 Jan
 2024 08:01:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2024010439-cauterize-trash-b603@gregkh> <7bdec121c0ce916f4589dd4247f9482704373aee.camel@physik.fu-berlin.de>
 <2024010406-country-entire-262d@gregkh> <810666aa13f5309d52d47109d20c4cf511a628e7.camel@physik.fu-berlin.de>
 <2024010428-crank-snap-8ff8@gregkh> <8652ad54d8d15dbb52f8feec69bde939409ae18c.camel@physik.fu-berlin.de>
In-Reply-To: <8652ad54d8d15dbb52f8feec69bde939409ae18c.camel@physik.fu-berlin.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 4 Jan 2024 17:01:45 +0100
X-Gmail-Original-Message-ID: <CAMuHMdW6rhSBD2JQrS6nE=3xEQk7nCJW-TEH8Nw64BPtjzoqEQ@mail.gmail.com>
Message-ID: <CAMuHMdW6rhSBD2JQrS6nE=3xEQk7nCJW-TEH8Nw64BPtjzoqEQ@mail.gmail.com>
Subject: Re: patch "maple: make maple_bus_type static and const" added to char-misc-testing
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Greg KH <gregkh@linuxfoundation.org>, dalias@libc.org, linux-sh@vger.kernel.org, 
	ysato@users.sourceforge.jp
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Adrian,

On Thu, Jan 4, 2024 at 3:41=E2=80=AFPM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> On Thu, 2024-01-04 at 15:20 +0100, Greg KH wrote:
> > On Thu, Jan 04, 2024 at 03:02:36PM +0100, John Paul Adrian Glaubitz wro=
te:
> > > On Thu, 2024-01-04 at 14:57 +0100, Greg KH wrote:
> > > > > I was planning to start reviewing patches for arch/sh the upcomin=
g weekend,
> > > > > so you don't have to take the patch through your own tree.
> > > >
> > > > No worries, this way it gets into 6.8-rc1.
> > >
> > > But the merge window for 6.8-rc1 isn't open yet, is it?
> >
> > It has to be in linux-next _BEFORE_ the merge window opens.
>
> Well, if I do the review on Saturday, it will be in linux-next before the=
 merge
> window opens. I also don't have to send the pull request to Linus the day=
 the
> merge window opens.

If Linux is still in FI, the merge window may open before this Monday's
release of linux-next ;-)

> I don't understand the hurry.

You really should aim to have your for-next branch ready by rc7, so
testers can find and report most issues, and you can get them fixed,
before the merge window opens.

I do admit my (tiny) m68k for-v6.8 branch was created a bit late, due
to covid and Xmas holidays, but it is part of linux-next as of today.

Thanks!

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
