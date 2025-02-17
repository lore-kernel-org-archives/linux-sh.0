Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF45A4C70;
	Mon, 17 Feb 2025 07:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739776493; cv=none; b=JmYf/lveqL6biHE6MbzUwZrqw2FWDRjsNOGnfS3pZUlmN73fTSsvHhgIURrijnkLHHr4t1Udm1KFRHNfDDuIWoYK5ES9pi4Rz4HiS/XtYZLFmiQ4KgqQr9SIoFXohYTe6zuS1idiB87tOsAuqRV0CsjNouYVIyZ+FIQXUEfw+Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739776493; c=relaxed/simple;
	bh=3BBH+0FD3pQb4pgxgXqMlcauOpqkrMegngHaAUymooQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ASohcaEaaObXhB+arWqGWGQvq/Htej6nvqSrB3/VHANGYNmGoW14An3/1vPDP/K01AvFLV6WZmCU3AwHiDZcpMfAad9wUigF3zXezuElx0EM7jekNCRMtgd+RDTV7qi9WV00xPgL0whwYRhYpcE9lW0AeYUncuvyrSY4+YeGoIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jPclo22H; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jPclo22H"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-309311e7b39so14513311fa.2;
        Sun, 16 Feb 2025 23:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739776490; x=1740381290; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Nbsiyr5bOZ3PX1jLb4RTv2UU01GxYWWCIaJm4lNcU4=;
        b=jPclo22Hkr+z0w6lUltvypkvfRB5eBJ30j9w4oYtKeYVc9XCCLXQ+3ifDs11ZHzLCX
         33Zn2BoVPBCALMlwIOO/15e7VeUMGWgIe4enGh9dDOLYqB6ioQrSOHh269Fa9/15bkZe
         wy8rmsttnJrUy+lagREREVXSvr70H8BSMIzIh5NpPv7Z58jRA9a7rygysAWkuzmEvcmS
         qQBPak6MSK78LfSgJXJya/rqAqP1gGOVDoCR4Ag6DIvopSVmRBU+UAvIbTLjZsSS2MmQ
         Suf2xIz+7VW6tmU7s8Lw6L2k0vOE7jSuhBDn6e4Y/f+YAbiC+2ZN8YeULsp2u8KJhCam
         ldjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739776490; x=1740381290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Nbsiyr5bOZ3PX1jLb4RTv2UU01GxYWWCIaJm4lNcU4=;
        b=MvN8oPZrni+KRjkbbCphOn5y21Gjv+8zW6TxglkFoaupwFDIh5HM3BWAGyX0AXO8Ow
         l8eG+rMMTbw+Bf4rWrc1TsJm2KEnxWwvJtSWfJ4lMb5RuiuaOPVIyeWfdqoXjgLrcUo1
         2Zy3cr2iURyZ1PLN78Yo/WJiNLnKUJWN05Pa1iULYhgomMlEgeziKO5Ntet9D/xErD4h
         4h/J/uEMi5X4aRhdWQrJ9KQVFQpIfH1UJAPsA4Kaf/o7VgEr6nyUdYgSAYzJZrQULi8g
         Y9/nKcWKL4boq0hGk9YWsO0VJIZlvWoD39ivGXZbNA5xnIEXGu6Ovr/sR50vmvg2BFlw
         hPOA==
X-Forwarded-Encrypted: i=1; AJvYcCVTUOPhGwd5/qALQa94IbsQ7KfwxZue2K5XQGUPBaETlfJhQhPCzJqgq+4r9kECGjH+FH6/ZWcas5M=@vger.kernel.org, AJvYcCWowiwAw2gliNyosRDnOo8BObKYsZPCVVBxLKXGhrfWHlYnwkKWxRM2DkUfUmRh5Bjaa7Rig3KBSmZPIDs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOQlelPA7MbHgqTj7630asfs0YoppbOtl30Udq6a0rtAvviRUO
	sgKSh9Kh5vAUBzwccgGBNdHkT9H84c7zg/Z2PuhZrwi6X1kIChZjalz5dJDgWuoUFZFrfQ1ZUL5
	jpq1Jw+WkcgZC8zuq2nqfb3e/2Qc=
X-Gm-Gg: ASbGncvVxkHRxVujtFBoln90NnAUVqvgchfDiThoUtrvpNrl0z+GfR8UdHb+AxVWosh
	83CHcZlOUP4MPCVjlv/nUmXdBsCWO6kyyg48nJnEHi/3IhxtV2XVP1c8bMa3gexiXtI8j8OJ0
X-Google-Smtp-Source: AGHT+IGsJ/M8+5KUBGZd8m0z8Yy28IswtYu20vhbK1pBr6h2zX1r9DL0XHZA33H38C9rH24ZNN/C+TQvA2ALtFK4fY4=
X-Received: by 2002:a2e:9ad6:0:b0:308:fd11:7705 with SMTP id
 38308e7fff4ca-30927a2cd9fmr20968201fa.2.1739776489641; Sun, 16 Feb 2025
 23:14:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250216175545.35079-1-contact@artur-rojek.eu> <20250216175545.35079-3-contact@artur-rojek.eu>
In-Reply-To: <20250216175545.35079-3-contact@artur-rojek.eu>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Mon, 17 Feb 2025 08:14:38 +0100
X-Gm-Features: AWEUYZlf0vM-isOPtM5qNzp5eM91T6CjTg4E_qciJlatvYI7xPL5JyLIhYSQw3k
Message-ID: <CAFULd4YWa_-kgOLC=_+6ALTFAedNZ2Cs3SQXgguqmrMVrWZaBg@mail.gmail.com>
Subject: Re: [PATCH 2/2] irqchip: clocksource: fix jcore-pit irq request
To: Artur Rojek <contact@artur-rojek.eu>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	"D . Jeff Dionne" <jeff@coresemi.io>, Rob Landley <rob@landley.net>, linux-sh@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 16, 2025 at 6:56=E2=80=AFPM Artur Rojek <contact@artur-rojek.eu=
> wrote:
>
> The jcore-aic irqchip does not have separate interrupt numbers reserved
> for cpu-local vs global interrupts. Instead, the task of selecting this
> property is being delegated to the device drivers requesting the given
> irq.
>
> This quirk has not been taken into account while migrating jcore-pit to
> request_percpu_irq(), resulting in a failure to register PIT interrupts.
>
> Fix this behavior by making the following changes:
> 1) Explicitly register irq_set_percpu_devid() in jcore-pit.
> 2) Provide enable_percpu_irq()/disable_percpu_irq() calls in jcore-pit.
> 3) Make jcore-aic pass the correct per-cpu cookie to the irq handler by
>    using handle_percpu_devid_irq() instead of handle_percpu_irq().
>
> Fixes: 69a9dcbd2d65 ("clocksource/drivers/jcore: Use request_percpu_irq()=
")
>
> Signed-off-by: Artur Rojek <contact@artur-rojek.eu>

I can confirm that this change compiles OK with strict percpu address
space checks on x86 [1].

Acked-by: Uros Bizjak <ubizjak@gmail.com>

[1] https://lore.kernel.org/lkml/20250127160709.80604-1-ubizjak@gmail.com/

Uros.

> ---
>  drivers/clocksource/jcore-pit.c | 15 ++++++++++++++-
>  drivers/irqchip/irq-jcore-aic.c |  2 +-
>  2 files changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/clocksource/jcore-pit.c b/drivers/clocksource/jcore-=
pit.c
> index a3fe98cd3838..82815428f8f9 100644
> --- a/drivers/clocksource/jcore-pit.c
> +++ b/drivers/clocksource/jcore-pit.c
> @@ -114,6 +114,18 @@ static int jcore_pit_local_init(unsigned cpu)
>         pit->periodic_delta =3D DIV_ROUND_CLOSEST(NSEC_PER_SEC, HZ * busp=
d);
>
>         clockevents_config_and_register(&pit->ced, freq, 1, ULONG_MAX);
> +       enable_percpu_irq(pit->ced.irq, IRQ_TYPE_NONE);
> +
> +       return 0;
> +}
> +
> +static int jcore_pit_local_teardown(unsigned cpu)
> +{
> +       struct jcore_pit *pit =3D this_cpu_ptr(jcore_pit_percpu);
> +
> +       pr_info("Local J-Core PIT teardown on cpu %u\n", cpu);
> +
> +       disable_percpu_irq(pit->ced.irq);
>
>         return 0;
>  }
> @@ -168,6 +180,7 @@ static int __init jcore_pit_init(struct device_node *=
node)
>                 return -ENOMEM;
>         }
>
> +       irq_set_percpu_devid(pit_irq);
>         err =3D request_percpu_irq(pit_irq, jcore_timer_interrupt,
>                                  "jcore_pit", jcore_pit_percpu);
>         if (err) {
> @@ -237,7 +250,7 @@ static int __init jcore_pit_init(struct device_node *=
node)
>
>         cpuhp_setup_state(CPUHP_AP_JCORE_TIMER_STARTING,
>                           "clockevents/jcore:starting",
> -                         jcore_pit_local_init, NULL);
> +                         jcore_pit_local_init, jcore_pit_local_teardown)=
;
>
>         return 0;
>  }
> diff --git a/drivers/irqchip/irq-jcore-aic.c b/drivers/irqchip/irq-jcore-=
aic.c
> index b9dcc8e78c75..1f613eb7b7f0 100644
> --- a/drivers/irqchip/irq-jcore-aic.c
> +++ b/drivers/irqchip/irq-jcore-aic.c
> @@ -38,7 +38,7 @@ static struct irq_chip jcore_aic;
>  static void handle_jcore_irq(struct irq_desc *desc)
>  {
>         if (irqd_is_per_cpu(irq_desc_get_irq_data(desc)))
> -               handle_percpu_irq(desc);
> +               handle_percpu_devid_irq(desc);
>         else
>                 handle_simple_irq(desc);
>  }
> --
> 2.48.1
>
