Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABEE33DEFE
	for <linux-sh@vger.kernel.org>; Mon, 15 Jun 2026 12:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781525502; cv=none; b=GPPFOXrozBX9LwACgWoEuPKQbxMl2AtovNqZ43XFnS1PyM6y+TbWAm0uG+w2AxHVmwsuRP/28Ba9VR5rVfndjpS147faWVCIcLaJq9tXEqSfk6pgOqHuc4DzbiK+zTZX0x4U32yyLubpCeVQL+R/UbtB9UwPGCD3XxnZ7xtMN6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781525502; c=relaxed/simple;
	bh=jZvYBDf0hpKlLvPmh1qTNuRTx/MbX90ShPJngn4pfNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kye1jK6IQJMIc4oVCiLTqPt6M8koZsNA4IQW/rMjfUlJmNYrhdGQ/T72Cq3uSp3A+iM3t4yKhYVBYkaqAbD/cvTSj1vg1TwKioS226inzm19SqUxju7/2Oq1GQ+JfI9m8myN4buX2GS1a74cEDTxCXzAS0za1la3TedFZimg0eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-9639130b20fso1911340241.3
        for <linux-sh@vger.kernel.org>; Mon, 15 Jun 2026 05:11:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781525500; x=1782130300;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A70Lx7eHG5NCuEI+HZwo+n6NlMnmUWhISm0pWxK5k+c=;
        b=LRm3KkNfVX9wjUPK3pYaDI+90J/wS0Ay8eJS9Fp8+ip7D2p47Gfu218BJMhMRE255x
         rtPk/A/OC8C1FbSL9+Hba3w1oakqsfJB6sQFScfMrYI5QIy+bKqInkT8wNLsWxiHBjA4
         LYh7FDzRAjSYe/8+QMxab+RQLZZ9KlfBlbWMHtwzVlimq4z6aQa1ez3i7PCyo1aGu0ci
         GEw9IBdz8o4HqtwiZPYI7neVIlKqiffZD4/ww9SCbJVPMyA/jS5wfiDzJu2CEVPzDnz9
         k55+aE9HjZSAi/orApolbWaIiTO1vKcXmEvwFes1mXrGC3GLFzfd61T6+l8wMvRGZmQk
         BWgA==
X-Gm-Message-State: AOJu0YxS9ijYwc+VVNYC47dduXBjx8+6fUS1w+zZbcv4ahA1guaj5xWQ
	Xp0GjEEbXZE+DalCBQRDNCLC+2iHg/XfM9Zj2h93HSmIrjj3u8oOGVUJBepTjtIj
X-Gm-Gg: Acq92OEwT7L3ga1CUr31O1K/fzNVnZkZhbnJptdmoe3PEee6tn9LSpu8vs62iL/qdOs
	plSekSJRchfTFTR7/Q/tAu5icdIp3a+1kXvcu5sCqgCsltemFgqyutnd6nuTlmfvtsNrs92JAmM
	c+IkXgTW8vzkBYfACjJXasLLITDdqbcoLznMWVYwvEamn6/12IPCW1yGioplqtCREPJ/iqFcovI
	vZtkQnxvaM23mkzn+gWLAp2PfcykLngRMfcnp0IkLv0blCscJppjMZrT8u/Buqrspz8vts7EB6B
	/cEDLmc9TZBJicOtk0sS4UPAYd9/4ju0hgYYj5j5eyt9O7Vlpp1OuBQKXGQJeROLgsL6YBjk4OW
	KDI6UcE2hS6ntXzmewgVbkeELq5Y3Nh7aPYRLPb0DE2+hAo4bJWL3IHKZFn8KgQIczuVrXbOOW0
	eYLIT34yMKwn5dHTFXL+Yf3L2jlF7kF7zR66AaWGZBYAHDlK+GmsHPyPJYrOQ1
X-Received: by 2002:a05:6102:330d:b0:631:ff40:22b2 with SMTP id ada2fe7eead31-71e88aba506mr7264030137.2.1781525500286;
        Mon, 15 Jun 2026 05:11:40 -0700 (PDT)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com. [209.85.217.41])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-720847c15a5sm2328108137.3.2026.06.15.05.11.39
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2026 05:11:39 -0700 (PDT)
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-6c28cd29891so1846634137.1
        for <linux-sh@vger.kernel.org>; Mon, 15 Jun 2026 05:11:39 -0700 (PDT)
X-Received: by 2002:a05:6102:8019:b0:6d9:a889:13b2 with SMTP id
 ada2fe7eead31-71e88b20971mr7648335137.11.1781525498598; Mon, 15 Jun 2026
 05:11:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260613210507.83434-1-enelsonmoore@gmail.com>
In-Reply-To: <20260613210507.83434-1-enelsonmoore@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 15 Jun 2026 14:11:27 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVhY3iMDsTt=ab+aXmqKm6ZCzBvHYBNO6bFK+rxiEKt1w@mail.gmail.com>
X-Gm-Features: AVVi8Cd7nbZjfOQFZbsRf3DqpwwVmdULC97-iOkSAMA47UzjjAN4nt82CiC3zlY
Message-ID: <CAMuHMdVhY3iMDsTt=ab+aXmqKm6ZCzBvHYBNO6bFK+rxiEKt1w@mail.gmail.com>
Subject: Re: [PATCH] sh: mm: Remove checks for nonexistent CONFIG_CPU_SUBTYPE_ST40
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: linux-sh@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"

Hi Ethan,

Thanks for your patch!

On Sat, 13 Jun 2026 at 23:05, Ethan Nelson-Moore <enelsonmoore@gmail.com> wrote:
> The CONFIG_CPU_SUBTYPE_ST40 option was removed in commit f96691872439
> ("sh: Kill off the remaining ST40 cruft."), but a check for it remained

s/remained/was added later/

The ST40-removal predates commit d02b08f6e8b184ff ("sh: Clean up places
that make 29-bit physical assumptions."), which introduced the check.

> in arch/sh/include/cpu-sh4/cpu/mmu_context.h. Remove this dead code.
> Also remove the definition of and references to the MMUCR_SE bit mask,
> because it is defined as zero on all CPUs other than ST40.
>
> Discovered while searching for CONFIG_* symbols referenced in code but
> not defined in any Kconfig file.
>
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
