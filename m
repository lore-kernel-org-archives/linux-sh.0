Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FA740629A
	for <linux-sh@vger.kernel.org>; Wed,  6 May 2026 12:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778071833; cv=none; b=ejU6b5cDBEdKrGIKULbWG4OvxxR1IV6VY/qSR2czPxn/edOBmsHTyt421nWLfbYCXtco/qcv8sY66XgmwNVXplYpb//VS80YpUAk9RDzaKdyYJQiQMr+bZwPEuz/OTyqpQH6ZZ7xFxdZKjW/oaCSq1/smSLWfMIGIjy5ZlHpkUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778071833; c=relaxed/simple;
	bh=P7fc9lmuTUzjhUsdr9qur0wqnZkctC6uOGBl/ZL3xG4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O2KMZiwUSJ2QOE+j7+qXD4C7w6SvbymQGvEVj19yHNQWbW9t7c7WrH9mxGNRAl2b/iEQxFJgbySwKGorETDEAOk2CLWDpqeq30NWFj5vlZ4QrUd9rR5QYG5kZAMiNE+vG9YjwY4pNjku2bYKf2IjyJaXalN9aoYcyeMVl90Utvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-575212eb419so663870e0c.1
        for <linux-sh@vger.kernel.org>; Wed, 06 May 2026 05:50:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778071831; x=1778676631;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aOo6lMLccHifJjC2IxVa3ecG3CMUTyXwBFE4QlmBc6Y=;
        b=aoT565el6z76Qj/Di7V9zGV2nCwOpV59Js1ebr1uUKV1yWUfIFyLUC4fQYSsEfNLrX
         3EiVrZH0fHv8NRhNmduok2xBpJprIna7p+mVpdQnASQ2+wCO/MuLxFWdAE6jXVP2KbXN
         dT9jxPndxt7CkGka1Iaq+s9Qy8wyQgSsQQkVC761ILYL1a0bnrKlGC8gzf6pPAd/u66z
         Nc+uxpa1KNyGMhPJqu/8tFTLQqOTbqDBlaJw/lpyDDvcBHUsfvpXr6ud6AbcXEGz6VUp
         ywUdjpV/k/Bk1HapjhcmHxHCX9+rT9K5IGjhfIvHshb3PxF7zSXba0na+E/UHJ3mQlMX
         BW+w==
X-Forwarded-Encrypted: i=1; AFNElJ/Tl9DPVgS9IyKeifoyTYmiTpQDgCZz0N9/wMpY+vwxD3qvBX+HEwKcIJOyUl1i5/+wo0QcvrQeFA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz90GwB/r/QT7G+9JJcBregNXmr6b8D2CTe3X69+FM1dUKE5e8e
	Z0bOm7xRYx5iteCzO+ihwSRgGrxLrihyF8RlfKIa0/1Psfzyymx2QWJXGxLfVeCPuNQ=
X-Gm-Gg: AeBDievDHr8LlGkhnP6UBriYbD0GMHt4oX34IO0JWECepfmGBhuEjfug3UEdkbfgUzl
	wjfI8ogQQyqT2Soe1MvC8dLFwhQYpoWea5pNcZ2ctF2y9wbEtz3ENDMzClOUjY4DlD4XeoKGVzo
	xjys3S/vDRYBiR/ppfjD3oDvmjroSHOTNu0LUcFNbpTpS8814X8lQfI+zEOjpaUTJWBn7GoMS2G
	NYxp9IUbtxdYx3VR4pu6sajdTln5coD0RP4xn9uhkU8zmVVoQsFeizqnZw49zlZbXy6XQBBSQ4V
	Q8dwU0FUQ/nahWY4ds9iYmcTWaYoXUR+eSAk4rUSeF9e09uCYMAw0EjhoEmc96Qw9FG9a4mxRBG
	B7fhc15PKtHE8izTd90260rstk6npQAVOlPUUZGoYGTxK4o8AZMPMEZ05ppcX1dVttmkfl+DVoj
	by9eG8zMPWNsIXjeoBsfhDr8nDU8gBA/4Bo1fFu3EFp1/cXQqsqe2q1FCFzavG8oGrPHVd3O4=
X-Received: by 2002:a05:6122:510c:20b0:575:20ca:573f with SMTP id 71dfb90a1353d-57544846b34mr2567137e0c.8.1778071831107;
        Wed, 06 May 2026 05:50:31 -0700 (PDT)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com. [209.85.222.45])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-574a6ee065asm9917606e0c.15.2026.05.06.05.50.30
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2026 05:50:30 -0700 (PDT)
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-95ce7b777ccso475207241.1
        for <linux-sh@vger.kernel.org>; Wed, 06 May 2026 05:50:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9w5dfbYZBt+VbRvfhmxE9RjNjm0icrpHm8hBWEdhKXgFS6W8nJqSZoERGoiFA/kkjJU19XIMohcg==@vger.kernel.org
X-Received: by 2002:a05:6102:4a8c:b0:5ff:ea89:449a with SMTP id
 ada2fe7eead31-62f5598ee1emr3912391137.13.1778071830384; Wed, 06 May 2026
 05:50:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260506121606.5805-1-john.ogness@linutronix.de>
 <20260506121606.5805-4-john.ogness@linutronix.de> <CAMuHMdXs94k3-7YD-yO7p2=+u8waYGAz8mpP5LDbMf3szt4V-w@mail.gmail.com>
In-Reply-To: <CAMuHMdXs94k3-7YD-yO7p2=+u8waYGAz8mpP5LDbMf3szt4V-w@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 6 May 2026 14:50:18 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWH5eH48JkS7phxhgVxAqC_8x1Z=GSxgAVF-eb5Xnt=yQ@mail.gmail.com>
X-Gm-Features: AVHnY4K2Y8QFvbNKiXgndIgGKPZBfZhbzm7AI2XgjtB-KEbHbRZBoZmutt17w3Q
Message-ID: <CAMuHMdWH5eH48JkS7phxhgVxAqC_8x1Z=GSxgAVF-eb5Xnt=yQ@mail.gmail.com>
Subject: Re: [PATCH tty v4 3/6] serial: sh-sci: Avoid deprecated UPF_CONS_FLOW
To: John Ogness <john.ogness@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Andy Shevchenko <andy.shevchenko@gmail.com>, linux-kernel@vger.kernel.org, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Thierry Bultel <thierry.bultel.yh@bp.renesas.com>, linux-serial@vger.kernel.org, 
	Linux-sh list <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 May 2026 at 14:39, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Wed, 6 May 2026 at 14:16, John Ogness <john.ogness@linutronix.de> wrote:
> > Avoid setting the uart_port.flags deprecated UPF_CONS_FLOW bit if it
> > has been configured in the platform data. Use the new cons_flow
> > wrappers instead.
> >
> > Signed-off-by: John Ogness <john.ogness@linutronix.de>
>
> Thanks for your patch!
>
> > --- a/drivers/tty/serial/sh-sci.c
> > +++ b/drivers/tty/serial/sh-sci.c
> > @@ -3369,9 +3369,12 @@ static int sci_init_single(struct platform_device *dev,
> >         }
> >
> >         port->type              = SCI_PUBLIC_PORT_ID(p->type);
> > -       port->flags             = UPF_FIXED_PORT | UPF_BOOT_AUTOCONF | p->flags;
> > +       port->flags             = UPF_FIXED_PORT | UPF_BOOT_AUTOCONF |
> > +                                 (p->flags & ~UPF_CONS_FLOW);
>
> This seems over-cautious to me.
> The last setter of p->flags was removed in commit 37744feebc086908
> ("sh: remove sh5 support") in v5.8.  No platform data ever set the
> UPF_CONS_FLOW flag before.  I would rather remove plat_sci_port.flags
> and this "| p->flags", so we don't have to care about UPF_CONS_FLOW
> in this driver at all.

I have sent a patch to remove it:
https://lore.kernel.org/20260506124643.128021-1-geert+renesas@glider.be/

Builds on Renesas ARM/ARM64/RISCV/SH, and boots on QEMU
(rts7751)r2d.

>
> >         port->fifosize          = sci_port->params->fifosize;
> >
> > +       uart_set_cons_flow_enabled(port, p->flags & UPF_CONS_FLOW);
> > +
> >         if (p->type == PORT_SCI && !dev->dev.of_node) {
> >                 if (sci_port->reg_size >= 0x20)
> >                         port->regshift = 2;

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
