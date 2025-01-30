Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC4515382E;
	Thu, 30 Jan 2025 10:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738232329; cv=none; b=T1pcDQjwyLXXzoqo6RlHtiZn5hebsYIkjBxrOYJm6T19umk5kO3ZjMoW38TKYsWb0hhK17iqF2BxIv3CBuBuQA7WZl5GbbqjKGhnYeUzjXbQgC6bDhjuHy+2s5B4IuIoh93BRiybgfayl9afxfL1sgZkIZU8qsbxs8OOocv2NYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738232329; c=relaxed/simple;
	bh=+s4r1GvbxlRMtbGSoWce7lF5k148Yo+ZaRKH/SzNE1U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HDxNyR0NqxIegou+ZPc+wcsje3MWG14uTnRH40pAFMlRUyqtERTio0bFFwTFYdXBISCIcWuxL9Vg5xaSZxy6TRLCjoOcSNPRjKr8u07j1bsFs2y3bccdUR0TKX7S28Ef1fdA1W44WPg8aAoDVtisSzU9hunXOzRSMicZ0POQAFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-4b63d564e13so405326137.1;
        Thu, 30 Jan 2025 02:18:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738232324; x=1738837124;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z4hq9DpTUck7EropQITP0m18mFkp0fBnMhAtlqVjjrw=;
        b=sCpGyEiwz+49MM7b997CAZ+xgJRCzRiTXxg0czmXCyzxE4Rgg8BK5l/UvzXHipa5gD
         VELzzgMg+r946u7cMIVLK2Anqc5EsSHYaPJAUtUD3TL7TK3fngQ4/w+RaydKRM9gL4Qh
         MclDsFwjlncSYm0rQCxw2FL+RQxQCMX11+H8SgJcH5z4Bn/k1fFPrlQ58zXQTRzujL1X
         gPwgABXEdr4str3zIzfwEfkZXTQnwqAZfBpVCKjg2jhhjIbacSWXjrz162OWNtN70ziw
         wjAIhFUrBFrpRwi2pzpO7Y9NCEnT8EFyG6iC3VNiZ6tim9c4Sx9/XlA1Xyz81Dr8Q6LO
         Lw3w==
X-Forwarded-Encrypted: i=1; AJvYcCUhWck7gyezVAq08BYq6YG+kUVGzBv+ErmnvPUyw/18hS0Dwgu4UAYp4RHEZzmgjA6GotqZW5JlmfTKgxw=@vger.kernel.org, AJvYcCW6s6F9qBYVkgsaDHa0IgYxPZSvwn7xT6loDgjhzwrGU0s0mgr7Neswx+Ek4xU9rR+p7Lz4AgF79iw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG5gvmy6FyK3ZMv1vBrEgH0sXOiUylohokWxaDz0X3zfz+WbYN
	HmPHLiai2+rcifFr3yvJxwswFWX7DJ0MR3iaK2JwH4FAtvwPZ4bkjZKyHimF
X-Gm-Gg: ASbGncutI3K2nbjHPhcUsIu215UwVs1ReIKXNZ2g6uIAB5R9AEEmEIQXdUj6m5Dbebo
	3kimLQViltPW+2fa44mqvV7r4uR/uvIwNuyMsXPZ4/5M//Q6QdrYae74EBJBI3nrW6l8Vw3ySoQ
	jpYSN3LCCFi0iEFROP70JPT4x4oSJcUi4ILMasXlNJHzgoLF0WB169FwT1CfOQ4OMXSqHMnyVq0
	QcJ+D4lECC3yBkVHAvr4jqSD3yTCFzLFY6rXcseKICK7iV0LBb8gaXGzj+OgpnLz/GNsgWem6vZ
	bHCS/zK/lJ8GgFv1aS1rPz9jliJ8yqMnAcdehijG7n7lWPEuOY8lpQ2dmA==
X-Google-Smtp-Source: AGHT+IHAvhvRA52S0gPf9PBRG4rGNwc0TlWvRRw87ZDN1j2f5iQXErS0503Gw1iNLA9QRna64wL2Tg==
X-Received: by 2002:a05:6102:3709:b0:4b2:adce:bcfe with SMTP id ada2fe7eead31-4b9a52ac141mr5816255137.22.1738232324654;
        Thu, 30 Jan 2025 02:18:44 -0800 (PST)
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com. [209.85.221.181])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4b9baa9aefcsm188395137.12.2025.01.30.02.18.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jan 2025 02:18:44 -0800 (PST)
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-517aea3ee2aso383233e0c.2;
        Thu, 30 Jan 2025 02:18:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUSsaiROm1huPZ1yvylWRzhhfNzsJMENHaEb36hOzhWapx7MrzSCe3KLjBS/yXGFp7yGWuU9v7p6GRn4dM=@vger.kernel.org, AJvYcCV7YFBN2EINvlXlHy1GTBlfHddkqpruae+t4KO7Py0muHwcuVLHP4zTTsMbgyUmhaB5Vpf1vEzvmXU=@vger.kernel.org
X-Received: by 2002:a05:6122:3541:b0:516:2d4e:448a with SMTP id
 71dfb90a1353d-51e9e33abdcmr7318300e0c.3.1738232324074; Thu, 30 Jan 2025
 02:18:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250128101306.1475491-1-julian@outer-limits.org>
In-Reply-To: <20250128101306.1475491-1-julian@outer-limits.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 30 Jan 2025 11:18:32 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXnfsJ9K=6q5YzTUS=etjQvAWQqbNksaMkysX9bJtMRwA@mail.gmail.com>
X-Gm-Features: AWEUYZmE-D_hg7XFYZP9LcWIVqhH4NIG3_Qqc19_4CWpxiayhWNZDUaX3vYh_g8
Message-ID: <CAMuHMdXnfsJ9K=6q5YzTUS=etjQvAWQqbNksaMkysX9bJtMRwA@mail.gmail.com>
Subject: Re: [PATCH v2] sh: Remove IO memcpy and memset from sh code
To: Julian Vetter <julian@outer-limits.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, linux-sh@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Julian,

On Tue, 28 Jan 2025 at 16:22, Julian Vetter <julian@outer-limits.org> wrote:
> Remove IO memcpy and memset from sh specific code and fall back to the
> new implementations from lib/iomem_copy.c. They use word accesses if the
> buffers are aligned and only fall back to byte accesses for potentially
> unaligned parts of a buffer.
>
> Signed-off-by: Julian Vetter <julian@outer-limits.org>
> ---
> Changes for V2:
> - Removed also SH4 specific memcpy_fromio code

Thanks for the update!

> --- a/arch/sh/kernel/io.c
> +++ /dev/null
> @@ -1,111 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * arch/sh/kernel/io.c - Machine independent I/O functions.
> - *
> - * Copyright (C) 2000 - 2009  Stuart Menefy
> - * Copyright (C) 2005  Paul Mundt
> - */
> -#include <linux/module.h>
> -#include <linux/pci.h>
> -#include <asm/machvec.h>
> -#include <asm/io.h>
> -
> -/*
> - * Copy data from IO memory space to "real" memory space.
> - */
> -void memcpy_fromio(void *to, const volatile void __iomem *from, unsigned long count)
> -{

[...]

> -       mb();
> -}
> -EXPORT_SYMBOL(memcpy_fromio);
> -
> -/*
> - * Copy data from "real" memory space to IO memory space.
> - */
> -void memcpy_toio(volatile void __iomem *to, const void *from, unsigned long count)
> -{

[...]

> -
> -       mb();
> -}
> -EXPORT_SYMBOL(memcpy_toio);

LGTM. My only worry is the removal of the mb() calls, cfr. the
scary warning at
https://elixir.bootlin.com/linux/v6.13/source/arch/sh/include/asm/barrier.h#L13

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
