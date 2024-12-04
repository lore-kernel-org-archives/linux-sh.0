Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89BB1A9B5D;
	Wed,  4 Dec 2024 12:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733315730; cv=none; b=EiZZJdGllhYd/wkGDTKxhp3eHx+Xecj88tvRHeLwU30mKDXnhPJkUKmuMwZ74Ne/xUMjJz0kMQ2SHK3IS+o81oJIcht7cuoC5mGatiBTY0WX49E4TwuxWvdvktBH+KjjOFN75H8xgGx7E6Nsq7xw7vZ8g0pTJm9D64PiF0iltWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733315730; c=relaxed/simple;
	bh=0AXmbb+C5Qu4or3pgi2jtdofjKlnjH5EdZhw1p9hFOI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MrVIcwftrTynk5tYI4JEDtOw8WR71889eVZuVI4aVuIXVrSZtksOwF5v5oTcmEHWWXCzFiPD1TtsPSjJAtCcv3SGYwZz6W7sg+vYZulqUxV19VfK3Npc2VCyiwIrUn3qOy1v5Dn51cBU+AVjMP+ufBpyps9hI81GcWZXiITlpn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-4aef9cde3e8so1723988137.3;
        Wed, 04 Dec 2024 04:35:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733315726; x=1733920526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nBK7i+JvQyy/XcaBcSikFP5SFQdh5G2ypRJFZIxQYTw=;
        b=IMcXsrGdyn9usPJcQRLIoXQcScxFl65mVBYdSrG7nrFHdVXLdTvtpnKyCAkvfKNrhf
         sK1QZEuNl2aTiaLdpXJn/iqALIi/YQcSI688H8UuZ4AIeyCdHbHGqOYnA4KVXv7qZWCs
         d88viy3DtFK8ng3ql49AaNprcKvCM0eb/fa0DCqG6dl4sPy/YsKAc9NE7nD+h8O9LofS
         BArbTYHu6zqUa4EYCHKqW/HfFcqiAcQYibisPBe/8wu90jdNDqo1EeNxB6UVTprJWmF4
         sPO7d7iZCtfYQT1X1y4xJ6z83G1bBQ9uZPCfUHAn325H6Z3r72pZ4S93Kly1Ud3PKsQ2
         Nrag==
X-Forwarded-Encrypted: i=1; AJvYcCXkCUM+490DR9luBPQOWFjeEYz5kcXgZm89WxB3ykcPpZwSV0fz5qaEvY2V2rXWNHD2GwBpTTO5ntU=@vger.kernel.org, AJvYcCXlJ8b9PIvbnPPpcViG9WENfNI17/HvcIrEMDAtnk4lEBIx++xikkOoCFZcHcQaetIahlnzdTxgOW8Dd/w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgSGYG2zjhqqd25gJpsuxiuHpqDbeutP469R4+o797OfFhT1Cu
	ElnZELBU2ZMEkxzmBoCAgvt219MOtQxmra5dTSBwnrZDF3Dz8xVY+uPp1plz
X-Gm-Gg: ASbGncsrw2r7m1kTR8I1uYCrUv0TYISSFalAoZUmPYNLCOX7ps1p1JWoE3PvBRyZfsS
	1Z8OZZlK35gsxOWfx8EWEmcgCS9fL0EVpx7rzy0vKmurE/sFPM4HSirw+4wp0RH3pea7wLqZ1hd
	YljG+BcU9l67786NU9H+hA27BDum9SLChmxc1X74L+sPnwnTJZgcGkrQ4QDAz8b8Kf55QNRNWz5
	+my4xYINiPVz13+Q/DXie0TBsu8yfLDiKfeF37qpg/yHqN1/23Gf0YIkhkZjZ19V0gQgXrJ2dso
	cO5SUV1wIIMx
X-Google-Smtp-Source: AGHT+IH4hSXPJeEYBgk3mU8IEOWGwjf8vwZSOdKfVOqxknXEff3e3w9nvojPdAPDlXznVvvrJbrV+A==
X-Received: by 2002:a05:6102:3754:b0:4af:396f:6a07 with SMTP id ada2fe7eead31-4afa52f14f8mr4784837137.27.1733315725919;
        Wed, 04 Dec 2024 04:35:25 -0800 (PST)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com. [209.85.217.43])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-85b82ad76fdsm2352675241.13.2024.12.04.04.35.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 04:35:25 -0800 (PST)
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-4af32b09521so1695037137.2;
        Wed, 04 Dec 2024 04:35:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUBCbe/UiW9J243SfqI6I+83cvtTTjys/KBaVjS8IE1AJeG6yT+A2bDDCC2zQPWqNoTzqXRdmZRBkA=@vger.kernel.org, AJvYcCXqLLB78qfc5ChUzSWPtdaElZCrmQFpvpRdAa2Ekqnanxzxefz8g9cTU2Vc2xw4PHPp7ZNv6DujK6Ok0jI=@vger.kernel.org
X-Received: by 2002:a05:6102:304b:b0:4af:3de9:b91a with SMTP id
 ada2fe7eead31-4afa51e3417mr5989400137.16.1733315724365; Wed, 04 Dec 2024
 04:35:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204110706.6776-1-liujing@cmss.chinamobile.com>
In-Reply-To: <20241204110706.6776-1-liujing@cmss.chinamobile.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 4 Dec 2024 13:35:12 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXu04CFhkc3E=cA9wi_eigc1q88azb8k5N4UeyMAgKOkw@mail.gmail.com>
Message-ID: <CAMuHMdXu04CFhkc3E=cA9wi_eigc1q88azb8k5N4UeyMAgKOkw@mail.gmail.com>
Subject: Re: [PATCH] sh: pci: Fix the wrong format specifier
To: liujing <liujing@cmss.chinamobile.com>
Cc: ysato@users.sourceforge.jp, dalias@libc.org, glaubitz@physik.fu-berlin.de, 
	linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Liujing,

On Wed, Dec 4, 2024 at 12:10=E2=80=AFPM liujing <liujing@cmss.chinamobile.c=
om> wrote:
> Make a minor change to eliminate a static checker warning. The type
> of port->index is unsigned int, so the correct format specifier should be
> %u instead of %d.
>
> Signed-off-by: liujing <liujing@cmss.chinamobile.com>

Thanks for your patch!

> --- a/arch/sh/drivers/pci/pcie-sh7786.c
> +++ b/arch/sh/drivers/pci/pcie-sh7786.c
> @@ -219,7 +219,7 @@ static int __init pcie_clk_init(struct sh7786_pcie_po=
rt *port)
>          * on. clock lookups don't help us much at this point, since no
>          * dev_id is available this early. Lame.
>          */
> -       snprintf(fclk_name, sizeof(fclk_name), "pcie%d_fck", port->index)=
;
> +       snprintf(fclk_name, sizeof(fclk_name), "pcie%u_fck", port->index)=
;
>
>         port->fclk =3D clk_get(NULL, fclk_name);
>         if (IS_ERR(port->fclk)) {

LGTM, but there are several more cases to fix in this file.
Please fix all of them in a single patch.

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
