Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4FB3438B0
	for <linux-sh@vger.kernel.org>; Tue, 11 Aug 2026 06:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786431353; cv=none; b=HetkXplx8ggrGYkT7An2m0ONceDcNqX2lwlofSrKcAy48/VlPXFs9zCB9KnUOf7O8KxFhVTXF+/tBzh/K6tGq36psWjFg4LW8U3fY8Vchog8MYXJMFQ5xpwk+45GZ6QO6qdCdBpk9p61/VIeOyzvnf6fomXvRlF+WA380Ho+xgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786431353; c=relaxed/simple;
	bh=tZZLV6eyiwcGv5N3oyI6rD0AMUqGK1dWtQ5SUdhqr2s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kaZJPSWoMPvkBD3nw4ITO+gYhaieCMtxIxWvuxymQcbBrz3rWQoNpp6GUW1a+yqcOqISdhdk0De/GeV5UAdvJgaPwaDK6Im7VsykETMtojK9jS9n72UtU6xr76/wl6Y+bG3Lqe0VjiV6ZWNH4qe0u/Vqv1a65nUjIiEiD9gzPpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ce7d2adef4so36286535ad.3
        for <linux-sh@vger.kernel.org>; Mon, 10 Aug 2026 23:55:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786431346; x=1787036146;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0iZRfAdzYvTsaTTh/J3ab87cNtJMKi7JiQC3Jqumorg=;
        b=C8xWoM3kvR9n3lp/wOTpl7TejvCW0T7KDj1rPVtigx2ioWP2wsqGv2EJANnQaKAKJg
         MFYd7EZv7e1mFAtB28kc8kcSmE6yhwGMDCIWM9xauX0lQUT6vQcU/IrZJARB676CblkE
         pp5iQ5U6DNfaQY21lPsNpUGa82lski95HpLskDwlC9DBldDi+4KBznu7E7oUIgmIvBJJ
         S4b5ZJjqT/18ZfNl8FLgQjjRtf3pjMLNnzLJhPXQhXNEZhSpix+U8rr74rnaty1rHt64
         UBhnmgwFboDXVj4sOeptS/KRyMWAashGjm6+Q8aDlK/QdPFLYiMPunPlMp9T0Bth8RGM
         0zFw==
X-Forwarded-Encrypted: i=1; AHgh+RpzdVvEQ03WBeD5H8OiN5YI0wENSpFccuSie2e5CnKZZmDn8sskVYpboDTRxLjLCxdUBlMEbefHUg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7OTLnHuiB2XPsvklmwqK/gxtEFIWZF6Ocw/fiWMNKwoyTLH5I
	2B0TMogbdtPbZwSjt9dJQV8S9Xk/YXGwn+xWSjNweVft/pDZ55VdK8tSYZ348Gqn
X-Gm-Gg: AR+sD12t3damAW4oLHcC/FdbHd81ANg6Zmo9zEZy+ENxgHA9gNDlZrnqNWctOHTREXm
	msy1bz+n5El9fXmxV3P7leFUrCSqP79qke3ezFAKX2OE2mSavDCMmDIYGXdbzXUt5PqGjeHeqN2
	XiBnx18uEfninrm2UNYShKqo89sj7DDLLMO9OV31Ih4DuqGz9bMsOEYGafEeQtrjEYar57lb77J
	8KFAzWuFhE5lWRLoGoMlctAJ/1D283zttx3PNHoiuaXOV8RZY9MrBOS24yKEDP3g+7k6POeZXgn
	EiY98m3stoH5FfMSDLWhvYmcQKNdCYEvN8ALVY6UMAE0f9i3JBOQO6ebfBcvIbIclz3se3Aase5
	Yy5xyPhHTWXW35CpwqfM2xObjrGkzG1BCllh0c75Px+G+y4MRUFwef24vX0fIDOCW7n7kSJ37EY
	0jiD0pOvv5MJOtOYlsVfmZ6/blD4n2DJgLUpKhefhj1PrY2y+17nkRcN/z9YuIKfWEgoXgdwg6E
	vAJJPQdzjmHoupk64dIIjPpHn+tSw==
X-Received: by 2002:a17:902:d58b:b0:2c9:ceb9:865b with SMTP id d9443c01a7336-2d317992f47mr17977985ad.21.1786431345913;
        Mon, 10 Aug 2026 23:55:45 -0700 (PDT)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com. [209.85.214.174])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d315ef024esm2686405ad.10.2026.08.10.23.55.45
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2026 23:55:45 -0700 (PDT)
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cacf197759so47024565ad.2
        for <linux-sh@vger.kernel.org>; Mon, 10 Aug 2026 23:55:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqShO5A5HM2WUSo3oYp+M09aDxUKcN0Ry88107K3YSwwu7kyMwnfLO8D0mYZbibhQHP0KkDhg8c2w==@vger.kernel.org
X-Received: by 2002:a05:6102:c4a:b0:738:ecd7:1984 with SMTP id
 ada2fe7eead31-76b54a7a17fmr283026137.3.1786430995503; Mon, 10 Aug 2026
 23:49:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811042119.3652929-1-anshuman.khandual@arm.com> <20260811042119.3652929-7-anshuman.khandual@arm.com>
In-Reply-To: <20260811042119.3652929-7-anshuman.khandual@arm.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 11 Aug 2026 08:49:43 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXfpkpYzZWGVb0fQrdn3uYHU3pyCkyAX9o2ux_Jj=2ByA@mail.gmail.com>
X-Gm-Features: AUfX_mwgji-OqM2d70As4nCfmG84npBMa5IuhuEcV5XEKzcXYS3fe_Pqx16lD20
Message-ID: <CAMuHMdXfpkpYzZWGVb0fQrdn3uYHU3pyCkyAX9o2ux_Jj=2ByA@mail.gmail.com>
Subject: Re: [RFC V2 6/6] mm: Drop pxd_ERROR()
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, david@kernel.org, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, linux-alpha@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Anshuman,

Thanks for your patch!

On Tue, 11 Aug 2026 at 06:22, Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
> pxd_ERROR() has been used in generic mm just to print the page table entry
> in pxd_clear_bad() before clearing those out with pxd_clear() later. These
> pxd_ERROR() macros have been provided by all platforms which basically did
> the same thing.
>
> Make pxd_clear_bad() use recently added ptval_to_str() instead for printing
> page table entries thus completely dropping dependency on platform provided
> pxd_ERROR() macros which can then be dropped off. First move all required
> helpers in core MM into a header file which could then be used else where.

Oh, the "x" in "pxd" is a wildcard?
Except that is not, as it does not match "pte" ;-)

> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

>  arch/m68k/include/asm/mcf_pgtable.h           |  6 ---
>  arch/m68k/include/asm/motorola_pgtable.h      |  8 ----
>  arch/m68k/include/asm/sun3_pgtable.h          |  7 ----

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
