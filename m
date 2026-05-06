Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22ADE43D517
	for <linux-sh@vger.kernel.org>; Wed,  6 May 2026 12:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778071201; cv=none; b=Mya/lrqRJcw+YnZfp+oxWuneuUNA096JIZorl5Tf0QIJfCoGjRGi44z2hMqyzdUq37+S85P03iApXPk4pOyqHwDceVhCCBnhRpoVsfG8d734+G2W4Bo7Th0teMNxUWwkZ0G8vYPLlgpxeE5F//Kk7h6Vili4kuoXSPS8OTVxoZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778071201; c=relaxed/simple;
	bh=a0i9PcKMdWANqaB+IUJUTJNOSFa7mwJ9bIwX2/ZqpK4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mCkPCExHOCtCpvL5h28yTkFNShRlrK2KQZISrXjASakzPIvtSKtw/w8pvemmctiPvUYC9Q6JuWPHsc6JpAUzt3Rl4mjyt+Z0sxEyEHMVNS6+4KSCcT1lWkNQkGCvj0G3TyeiUAWzEtqeNRYnuU06EqX5EQTLoPj+XgNKym/TLIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-bc188a20e0aso437075866b.0
        for <linux-sh@vger.kernel.org>; Wed, 06 May 2026 05:39:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778071198; x=1778675998;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rJXDoBoMNXZBdaFZ5fzB7q32zHx8RAwwhrvDhIPA51E=;
        b=L0qSVbry5f/eoy4e3TNk4g9w+h7QGhnY0ho+XBs8eb7mO3Y2uHjXZabO+F64qQ+uqj
         Fbsx89I+UjCCKsMZQHEBa/sPK8izkHt/9Nerd5xIXi0QWdDZLB7Z2vznATIKfBxDxy2P
         x735+XRyij1YhKRM4t+LhV+s4uv6DFtVQcTrCtEGHbmPjig4SmjtIv23FTHrGPJAIH5S
         9DUjJtCvQTf3Wo6/pX0h9CpmglZQy41JfzFLGWvhXkicObOiVPtezw4KnKEg1eEZ3cDY
         6svGFx7oAH7ocR/mTrnEVF4se4jx2EdesqdyzgU+YgkJ3P4b9A4t/5NtBoE0J6VOUoNw
         DX1A==
X-Forwarded-Encrypted: i=1; AFNElJ+gRe2yMQi6knP3zFICSEwAuuHNhnnh3VVJVxYXdXmUaBRUu25cUgo1wXIMAUIKCmNel7qpWlYJ5Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/ehN8DyJOfYCu3zzbWX3EebxUjmsYcG5alpwxD+8yj4XvWlyx
	8gLXkf1TaQivTEaLeWE5Y7U5KaLj3apxzmY7lJGCIGo1iuUma2HgvNiYeTw4Yb04ybs=
X-Gm-Gg: AeBDiet/0c7m6onZHR1/uWl+bXdPJtk9v9BYPj/pbi2RNpBXDKvdvpMLvDMcMHqkhIA
	JT7m+i9al1FyQrnHqE9ZI6npG7wdSx6PiKV5SLG4IQKo0fVm3LmhHLxGygoQfBuiMwT0fUEtsDG
	8SL2XruDxZk+bBj9tjuCp8b9J+7I491EyVoV6hwa//AUkLUhKbyPA/xGJH2KB7YzaSJ2n77ohNn
	X/VHr5AEOqGAEgEWUG5Bzyu1a10gioh4d2flYW3qSVGIQWypi65/uoTuaJRwhG1QV55ZQjniS1b
	t+91OE9LIGNfbQ2MeiwrlWtyiStqNJ9vgru4VNNZ9DtVzpED8DhuBSjT8R8o/lu/fRmTxvqYUT9
	IX5+w1NKMtqcfs8az3x+MltA9sCnZJBfqC9lesfFZjGGwOuIPkwofeyflq6pKWTHCgyqE8+agaT
	Tc5nNPGdJnTfkK4FbqkmCJuPmTZk4mH5DLrq4uVVx97tGCmejcdFYX/HgjrXKibCREKgo9Jdo=
X-Received: by 2002:a17:907:c19:b0:bc3:d9a7:37e3 with SMTP id a640c23a62f3a-bc56d90f797mr150241766b.36.1778071198266;
        Wed, 06 May 2026 05:39:58 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bc55f00d170sm78220466b.49.2026.05.06.05.39.57
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2026 05:39:57 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b9d9971d059so892947466b.2
        for <linux-sh@vger.kernel.org>; Wed, 06 May 2026 05:39:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+1xN73fxG9sB7X7+AukLrBlZ6/+8nWQZ9RyiNff4D8qtwS66adZKxUF+xO+WPkvbBygWYL37UTfA==@vger.kernel.org
X-Received: by 2002:a17:907:fd17:b0:bba:3cf3:2ba6 with SMTP id
 a640c23a62f3a-bc56d32b942mr158973966b.29.1778071197425; Wed, 06 May 2026
 05:39:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260506121606.5805-1-john.ogness@linutronix.de> <20260506121606.5805-4-john.ogness@linutronix.de>
In-Reply-To: <20260506121606.5805-4-john.ogness@linutronix.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 6 May 2026 14:39:44 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXs94k3-7YD-yO7p2=+u8waYGAz8mpP5LDbMf3szt4V-w@mail.gmail.com>
X-Gm-Features: AVHnY4KCjVaMYpPMvAk_XF6WniARJldzRzB6DCs_7WQ0a9A0J7Jk1ZecnxRKgW4
Message-ID: <CAMuHMdXs94k3-7YD-yO7p2=+u8waYGAz8mpP5LDbMf3szt4V-w@mail.gmail.com>
Subject: Re: [PATCH tty v4 3/6] serial: sh-sci: Avoid deprecated UPF_CONS_FLOW
To: John Ogness <john.ogness@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Andy Shevchenko <andy.shevchenko@gmail.com>, linux-kernel@vger.kernel.org, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Thierry Bultel <thierry.bultel.yh@bp.renesas.com>, linux-serial@vger.kernel.org, 
	Linux-sh list <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi John,

On Wed, 6 May 2026 at 14:16, John Ogness <john.ogness@linutronix.de> wrote:
> Avoid setting the uart_port.flags deprecated UPF_CONS_FLOW bit if it
> has been configured in the platform data. Use the new cons_flow
> wrappers instead.
>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Thanks for your patch!

> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -3369,9 +3369,12 @@ static int sci_init_single(struct platform_device *dev,
>         }
>
>         port->type              = SCI_PUBLIC_PORT_ID(p->type);
> -       port->flags             = UPF_FIXED_PORT | UPF_BOOT_AUTOCONF | p->flags;
> +       port->flags             = UPF_FIXED_PORT | UPF_BOOT_AUTOCONF |
> +                                 (p->flags & ~UPF_CONS_FLOW);

This seems over-cautious to me.
The last setter of p->flags was removed in commit 37744feebc086908
("sh: remove sh5 support") in v5.8.  No platform data ever set the
UPF_CONS_FLOW flag before.  I would rather remove plat_sci_port.flags
and this "| p->flags", so we don't have to care about UPF_CONS_FLOW
in this driver at all.

>         port->fifosize          = sci_port->params->fifosize;
>
> +       uart_set_cons_flow_enabled(port, p->flags & UPF_CONS_FLOW);
> +
>         if (p->type == PORT_SCI && !dev->dev.of_node) {
>                 if (sci_port->reg_size >= 0x20)
>                         port->regshift = 2;

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
