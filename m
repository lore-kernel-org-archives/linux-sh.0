Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0543C6A36
	for <linux-sh@vger.kernel.org>; Wed,  1 Apr 2026 08:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775033733; cv=none; b=gVqL3JJ6mKJ36f11eosTTnGiekg4W2ACtzUU9eIgAdqtGebQPWOonO6DdbwwHZzgujPn5MCVztBIehJkIwdsJGF9FM9i5MMYPkoi99Em4sUYG75EAUk/9n+bNfMTljCZo9Wp7wigytUckYEZYXfTbnk6KnhqTFTSQgbxrEj16os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775033733; c=relaxed/simple;
	bh=PLwE7ZRL+90SQiNMXF/jgGyBWAlL49+g6LjfNcljtzw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z8ohVgCwvF7uIozxRET7F82Pl201cxL4EWx+rMgX89KUGqTskFS0BZqFqulBEptGb4ZkZ8cyk9F7mgwk859oavFPv810Yfrq3ypMNqpefwqcr4VZULSZwDAOqXYWSWUZ4hDH1gO0z1ew4deB7KkfYDdOnBaUnBkk0pr+gAlSzEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-951a0e3cdabso3672418241.1
        for <linux-sh@vger.kernel.org>; Wed, 01 Apr 2026 01:55:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775033729; x=1775638529;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JovjSUZC1lNxdv0gpf2LIekR3ONpuaO8xMZDQYnx+qs=;
        b=N73uI0PJ+j9rixgJjctLNf+eyepI21A4lP0zt9Alw2mL3TfDIpDf/g4GanpRdNLJwM
         sOmgORpp0vp86zCVGPIIl0v7LkizpA3WZqCWWFb0J1OxX1YhEFER0BFuCMWGzxr1AbfP
         Y/mAzY+QLvU0wjGlian47C7sGMwSykmSY4ILn6uYoFVw45iad8DMWiW6uPfjjtooMxeE
         FIPLmVMnCgPXSvYqZkWrht1zZSiEU8CzrwE358V1Nhw5LM9ZSvZBudm+11bm4y3skqt0
         4DLUThbEhN5cuP2WxQaERO89EA1flRlazOKsMddUYbylWFCQDr1sH3A5IlVAWQtjN6U9
         7Lfw==
X-Forwarded-Encrypted: i=1; AJvYcCXbp43xKuAwgLyChz6byzHqcBdgFvb9Egcf1RncOWpQQQpjH+pdYubfoBwNlyDoLfHQ/sOiJdk+SA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb2adbZiLefRuBAk8CTfTTdmWFzMpZp7Y/lf0JZR7hK30nWg7L
	OxTuRCzqdM9kfbUfohnhFJnUF5EtMvgx9ZDINfLRQUspKTZWp3OMAmexhheOuja7
X-Gm-Gg: ATEYQzwfw7JY5wmq7m0Eiz3puFIlC0P7Svk0w1cpIeh/83v5EQQClYfQxBlludopMVS
	MNShBYQgXOOb7vvDd9dyQ/N8awOjE68YoC9kknB/AnKfo1FqgNjhwlGfn+R0DkD8Nus6Qyi77km
	kap01v6fnIera/1hHsht8jQZ3o1cY15bMpaxGrDQxm242K1QJCMhGQLeH6kyNQiPFlyQv7yjFRx
	qF4wjXGhDy5a5yGWqtje+kwGmA+jZ36sqHZ1XprI4O7rsc8hl16UqDCEk8lsGE1BEz1RAFXlORv
	m1VRZYZk/agOm21LnXPv/Cc+C+IOc7vK7l1EfrQl9LxLvQ3+2b9YiDQeeGJFxg+gjyv2RA3Om6z
	V/IvVQ/jFIX8VN9NYbg/uzvXibBh+p3AxfrctiO06CYDoR/63WU/CY3bqkKyVaeZuL2nKI82I0w
	r0hFaQKBddIS20CgZ4I9kG5LFLWt3ISLyrSoHInTzayWz1xKd1AtcoTE+8memNZVu+59vnfxM=
X-Received: by 2002:a05:6102:4187:b0:5ff:cb2c:a04c with SMTP id ada2fe7eead31-60567db3783mr1071924137.1.1775033729402;
        Wed, 01 Apr 2026 01:55:29 -0700 (PDT)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9539e29ea3csm13313103241.5.2026.04.01.01.55.28
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2026 01:55:28 -0700 (PDT)
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-953a8eed138so2222303241.3
        for <linux-sh@vger.kernel.org>; Wed, 01 Apr 2026 01:55:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV7rLdHQRYx3qRXfNdqGDp722hH9TuxY8GECrwS+tSSjiaDmFScqDnOKChSFCboW3jMyo5IB/GPpA==@vger.kernel.org
X-Received: by 2002:a05:6102:14a5:b0:5ff:d434:b507 with SMTP id
 ada2fe7eead31-6056811633cmr1013502137.17.1775033728220; Wed, 01 Apr 2026
 01:55:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401083242.214492-1-tzimmermann@suse.de>
In-Reply-To: <20260401083242.214492-1-tzimmermann@suse.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 1 Apr 2026 10:55:17 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX5B6LpZ5ffaOc0Et0PK+G=_c8yD5K8JynRwu5T8rHfsw@mail.gmail.com>
X-Gm-Features: AQROBzAaKXfPphxAx92Ddhxtbq8urMrWt59bUWKyg2D17bALeZWDk-W7fhNxXrk
Message-ID: <CAMuHMdX5B6LpZ5ffaOc0Et0PK+G=_c8yD5K8JynRwu5T8rHfsw@mail.gmail.com>
Subject: Re: [PATCH] arch/sh: Drop CONFIG_FIRMWARE_EDID from defconfig files
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: ysato@users.sourceforge.jp, dalias@libc.org, glaubitz@physik.fu-berlin.de, 
	arnd@arndb.de, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, 
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-mips@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Thomas,

CC arm/mips/ppc, as you sent similar patches for these arches.

On Wed, 1 Apr 2026 at 10:40, Thomas Zimmermann <tzimmermann@suse.de> wrote:
> CONFIG_FIRMWARE_EDID=y depends on X86 or EFI_GENERIC_STUB. Neither is
> true here, so drop the lines from the defconfig files.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Thanks for your patch!

Upon first look, your changes match the (current) dependencies
of FIRMWARE_EDID.  The dependency on X86 was added in commit
7e35fc7ab433683f ("video: Make CONFIG_FIRMWARE_EDID generally
available") in v6.17-rc1.
However, CONFIG_FIRMWARE_EDID also protects fb_firmware_edid(),
which seems to extract the EDID from the PCI ROM, and is thus not
x86-specific?  That function is only ever called by three fbdev drivers
(i810, nv, savagefb), though.

I assume none of these work on SuperH, so
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
