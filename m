Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921D115A864
	for <linux-sh@vger.kernel.org>; Mon, 15 Jun 2026 12:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781526953; cv=none; b=L+x7qPHGp5zx3hbZ7aNx/CopYP+3HqqxgjQSPhNnu62Qj1mgPdPstVo2giQZ/NSoZAuqRHblkINcJBFFMnJCQl70zvW3THPUc4HSpK4KAwxvffef1efoZT03IiwmQ0bVzMdCtmrvmOpbDs9cOdw/SfJKa6S/VuxiElTJjMKSD40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781526953; c=relaxed/simple;
	bh=ZxxbUIAchJR3cP+k2TmINVvV5KvbqL5mo6wnHVLaKKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WLvAo0LcifgBL6au35AtarmR7FLa6MYL0GUL4Bs05L9rffa95oD6/fdD+wMvNKbDefz7qMm1tsUhnwJa0jpgfHm07Ti57eY9zzMvBtNnNVHymSuqmECltmH8Zs41H+owIdszQ2VaA6qxbzzn7+ccMpJgyOIKtcoL7wiY7R3HfuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-59ebcbfb2b0so1142324e0c.2
        for <linux-sh@vger.kernel.org>; Mon, 15 Jun 2026 05:35:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781526947; x=1782131747;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2gxVEv+iNOheSBHEFKvja9Fp92xq6/wCgbx9bqoVAHM=;
        b=AZWu+UTf5+SkNy94fDmHoMmsmZjePlneezGLznr1awmilRmJTBeCLwzW2KT9FTM6H+
         FHEsMuxwuENhpmVvvVlzntDabw/02iOmHupMFAQD0iMRAyEetjSc7Tirfv9zSjnNBbBS
         0+KLir9MFxEdllGZVRlbOP6UBLMHTrxG6s5zYYIDA7hQDrHpLw3YVLsDN7pdEu+fxd0C
         JLkwwmnLVLaPbTc+QdUq2odfxBHm2Qgpc44b7oY1cKFcfiIRUz2nCpOb1Ve6LR9T07li
         jhaiCF3cpmbP/kMGwVf1bhPFaS9/P79VciEgvAKGXooEkmFxpdMiIWYNZ1xavXYDkauN
         akbA==
X-Gm-Message-State: AOJu0Ywls9RljNXaCwqWKvp2pAGw6VaUC7zxU2dM8XIHuJYeRAVt+2YL
	umFoJp4seexFrN9BesZcxyfhQpTmgLXtm4LRj87g4rj5FgzZudIt2pMETr6hCR0y
X-Gm-Gg: Acq92OE/x7fgo+zUaWLDTf0GXSjzVDMFNhBTFiARii2BxpkJkY0IGjlX5J/noBmMFNQ
	C9oce6yDzZA0tQ/8SNmMg2Dg7aQWv16iivFbGeuNMZr2WdwuqvCVl5hcOQdqg/ZynJmedwGKnv2
	3yPgmulXwJ5MwwUDJTj0Aq0RfmzPfzI9nu3THrJSptR5b3dalJkceH1xAfYsP9Hfs2KYxwYOe6/
	YPLzMgiFLftcTEbpQmLGX+DRLcBLwvuEPJwSAUrkx/+4zO1dn+D4A+hNAUcX/cdv3RTjFli87Wh
	TZgrU3lrGCVyjTu9xegJSjG1E5aKdqVtGp4x8NcBKtav+5Gbd4WMKkUNrowCIEYTZTnhiFkmmcC
	WUDJZnCAX6qJLkQuIUJVeZ2i/Tv3C51j4sR+j4WKD0dX/AOKVUPGahp6G1AthuNPMTBJWfv1qSr
	G39F4v+Cm1hWCBCp/K8SX8jKd1Vdpqk37NnwAZZPmBiLuOlHeSQlWgqrTl6OD2
X-Received: by 2002:a05:6122:a1e:b0:575:29ef:7e13 with SMTP id 71dfb90a1353d-5bb79a36480mr4386708e0c.3.1781526946940;
        Mon, 15 Jun 2026 05:35:46 -0700 (PDT)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com. [209.85.217.44])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5bb901b8a45sm3266758e0c.15.2026.06.15.05.35.44
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2026 05:35:45 -0700 (PDT)
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-6efdb57d98fso702610137.3
        for <linux-sh@vger.kernel.org>; Mon, 15 Jun 2026 05:35:44 -0700 (PDT)
X-Received: by 2002:a05:6102:809f:b0:631:4cda:3e86 with SMTP id
 ada2fe7eead31-71f60e104cdmr4374130137.24.1781526944245; Mon, 15 Jun 2026
 05:35:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260613205657.82194-1-enelsonmoore@gmail.com>
In-Reply-To: <20260613205657.82194-1-enelsonmoore@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 15 Jun 2026 14:35:33 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU3Tc54Sr2UOSK0N+=0TC2DhxMzeS7rccBCSNTo1fWJUw@mail.gmail.com>
X-Gm-Features: AVVi8CfwEnwCLUbawwLX3Vm6ScjfNhFWdtwLnJwMWEH_PNxj06WCqI2TFJV0rS8
Message-ID: <CAMuHMdU3Tc54Sr2UOSK0N+=0TC2DhxMzeS7rccBCSNTo1fWJUw@mail.gmail.com>
Subject: Re: [PATCH] sh: dma: Remove checks for nonexistent CONFIG_CPU_SUBTYPE_SH7730
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: linux-sh@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"

Hi Ethan,

On Sat, 13 Jun 2026 at 22:57, Ethan Nelson-Moore <enelsonmoore@gmail.com> wrote:
> Two headers in arch/sh/include contain references to
> CONFIG_CPU_SUBTYPE_SH7730, which has never existed in the kernel.
> Remove these references.
>
> Discovered while searching for CONFIG_* symbols referenced in code but
> not defined in any Kconfig file.
>
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>

Thanks for your patch!

I did some diving into git history, and none of these seem to be a
typo a different symbol.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
