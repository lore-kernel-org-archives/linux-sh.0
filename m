Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03EE937C109
	for <linux-sh@vger.kernel.org>; Sat,  5 Sep 2026 13:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788616573; cv=none; b=B5ZfJ2oGST59qNDkDwA5A8BGvRchJaRtGm9jNv9Aak4zdI2brIhRlXFfrb2W9VHkfgJK1Tmwxh0cWl6VEdagnNZIlYHKV2zpgeBcVprtHYpVD1VB48sH8tc0rTuyo2YcK+HVxotPywT1C6VPn8lHK+Ffqi9TCNMmQhx7/lnUX+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788616573; c=relaxed/simple;
	bh=SQlONFKT/BdnEOkT7VS/7tS09F8vfEOhV8Vx6SBTjyg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IWw6nPDHmGonUwUJYd8YH9YbsVSn6+F2OxuLoGEwjEkiX0lS7UHxUyc6sD0asjN9VXklozQ78EW5ekx5GBHm8MFMhurCxnfaWaP39Wp+9e7iDWuC7ND6a/NMKMh8TxqB5T9Sgo49G4Wp8cgiXewuKuwCLXyUwLsCJv95Eo/px4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5c79c9f7b54so1013285e0c.3
        for <linux-sh@vger.kernel.org>; Sat, 05 Sep 2026 06:56:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788616570; x=1789221370;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=G9qnspLMcFh9CpejGwf9CHUvtPpft8pRzy0A5TU5xf0=;
        b=Qli910JtDxi3mjvCSyKJlwFQCb/40+NeHVJfrNgcjll3vBDrbyXHVP73/XHiMHlgSW
         eChU5nS4hzhF9RztmkLY1z+n4YeFnKwPMX+x0QCkNAFY439ikJGOyNIQLtGBNPFbfFn1
         RV5ytq4M7qXbe+3BmCNjuBe6bWoBRum06RcmzfjJndwKAq5GaUixCAaz07Wz1a1Oebfa
         UbS/lBzCNqZQkMokfpP4Db87CjDPcpRBMPsunUJtbPU1M4K4gpLBQr7fQ7bKEHyFbsDM
         epnXzlMYXTB8D4d1Og+J2oGKnhkzQiEkAIVNns4s7GtOxqcMYtOKw0Np8mlUbQrmpul3
         IXxg==
X-Forwarded-Encrypted: i=1; AKwUvByE4y4Yw7jQDC1BjQZsmfZ/1lJKgjwOrYFAcg3aSKhVJA9s+KzxyONKTe6aI39znnZ9Jnx18BKvBg==@vger.kernel.org
X-Gm-Message-State: AFuF++lBvBo/50SDQ1QOkoU51QRheHfKRarTmQ25I3kegRtSTzYK7DDK
	G/sBWrmAS/14lrPBh96LojM5096nZGtPUcgXQ44PDTycK1KPyAOQWlEo3dMmd/I6
X-Gm-Gg: AYBFou1b5iFLvo4FKNhxSD4Qf5OW6Vx25lewC8RcHHywobfAlsPYpH+8DE6G/fumNXu
	uwXL8bug0ZamCCdPRIPWqsmpAs02QIx6Vsfg4Q2/kcAkyvqXAGLdQAGTRliLa3DtURjV39CWlR2
	Jyu0O4ljt5nEyEDxVLUTHNlS56SPuof9kYDisuzBJCk9XTwxDUOHq3vgnQXq32qc7NXqhSj6Kdb
	bul/S6vW3A5jcuRZUPw8i8Qip6Vj0ApMSDcoZCEo/Se3J0xI9EbS23/2pQjLOoB8wfEFY+Sq0PR
	cb/6alxedwX5YDrSNSKpOoVQORqyRsZ6YMLav7ZiNxZ0e0oL4FJZD6vD6zUBS/cWMejHAUmiLPw
	imjKEDpzJOwx035qLe2oIw8cpG2Mrpg7A+YJ/SBJDe8ON6uW/2bCYDD3mfwOUH4vzTMHLM5q7us
	/Xl6bkWP2gHmEG8sdLbqBQ5HulSw3nPggQfdmtRy7qgWA/VCLXUCrJEnqrVLQt0sVbDNt5I9WxY
	WBQh3uqIwqXu+7lp/msaxWLKg==
X-Received: by 2002:a05:6102:b0f:b0:784:b9ec:910b with SMTP id ada2fe7eead31-78a4ab294c6mr4473849137.12.1788616569646;
        Sat, 05 Sep 2026 06:56:09 -0700 (PDT)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com. [209.85.217.44])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-78a47b56bd3sm3667508137.12.2026.09.05.06.56.08
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Sep 2026 06:56:08 -0700 (PDT)
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-785d603efdeso734076137.3
        for <linux-sh@vger.kernel.org>; Sat, 05 Sep 2026 06:56:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxorV0RRykoVbW9FeDH5l3pbXEDjUGvxH1+e5an8wcqEaBLEwnDz/mxnHPVlNnB4eBVR772ByUkuA==@vger.kernel.org
X-Received: by 2002:a05:6102:41a9:b0:784:4d38:ef58 with SMTP id
 ada2fe7eead31-78a4a57f683mr3957733137.0.1788616568356; Sat, 05 Sep 2026
 06:56:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260905065340.24932-1-kmehltretter@gmail.com> <20260905065340.24932-2-kmehltretter@gmail.com>
In-Reply-To: <20260905065340.24932-2-kmehltretter@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sat, 5 Sep 2026 15:55:57 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWYBp0d7m0Q8rWva+EA=4nOezm1os_6ZVcrh43aPjCCPQ@mail.gmail.com>
X-Gm-Features: AcwNN1Wpd95mu0QNPbX-AyHyQSqKqseOIaQ0KFjJzQVop80Df68OBhPehSqmFTg
Message-ID: <CAMuHMdWYBp0d7m0Q8rWva+EA=4nOezm1os_6ZVcrh43aPjCCPQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] sh: Drop the selects of the removed
 CONFIG_USB_OHCI_SH symbol
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, linux-sh@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"

Hi Karl,

Thanks for your patch!

On Sat, 5 Sept 2026 at 08:53, Karl Mehltretter <kmehltretter@gmail.com> wrote:
> Commit 4f6dfc2136fb ("usb: remove the dead USB_OHCI_SH option") removed

So you (or the LLM) did look at that commit?

> CONFIG_USB_OHCI_SH, but four SH board entries still select it under
> CONFIG_USB_OHCI_HCD. Selecting a symbol that does not exist is silently
> ignored, so these lines do nothing.
>
> Remove them.
>
> Fixes: 4f6dfc2136fb ("usb: remove the dead USB_OHCI_SH option")
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

> --- a/arch/sh/Kconfig
> +++ b/arch/sh/Kconfig
> @@ -331,7 +331,6 @@ config CPU_SUBTYPE_SH7720
>         select CPU_SH3
>         select CPU_HAS_DSP
>         select SYS_SUPPORTS_SH_CMT
> -       select USB_OHCI_SH if USB_OHCI_HCD

This is wrong, it should select USB_OHCI_HCD_PLATFORM instead.
Someone has already sent a patch for that[1], so it would be great if
that could be picked up instead.

[1] "[PATCH] sh: Use generic OHCI platform provider symbol"
    https://lore.kernel.org/20260624081926.12426-1-pengpeng@iscas.ac.cn/

>         select PINCTRL
>         help
>           Select SH7720 if you have a SH3-DSP SH7720 CPU.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
