Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97AF3ABDA5
	for <linux-sh@vger.kernel.org>; Wed, 24 Jun 2026 08:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782289236; cv=none; b=jzCkWpTkXht+Ya7vy506piLQlIRgr7TB1pErrS6liTaU+5mgGyzrA7hJbnthjmeEsJqps+EmPbE+dsToBAZAptOh3SGDaGrF7eadEH31r41is2uJYL6zPGFuH3+A6BgV1uN1DC0stD1tFitLDvPuUscUOM9i75pDkjizIQoA9Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782289236; c=relaxed/simple;
	bh=3v4khr7bduoUq4FUqynKvbWWJbzkRQYujPd07q95ffA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m4UXVZdDzWyyRWKvyZolq6fu/zvO13mRgHpnLhPrpcgiYd1YHyoOLscOZmeWYaaEJfXhOP8wcLPxMOvCRnXtMh9LHyj1q1K2RQeqsNUzKgHiYH8pT2yZK57doivugEPXvHTi3MUzjA2EmRT3E7HwB3mBycAkzQ/Q/0O1F7/zawM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-59f8a140a51so556020e0c.3
        for <linux-sh@vger.kernel.org>; Wed, 24 Jun 2026 01:20:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782289231; x=1782894031;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=++Q4kIE+3+t7oNuDlCHsgzEioStrRCXuY2iO5kkUprQ=;
        b=UCgqVdFH1Mic7pYKUcu7mpjvS9I4iKVhiqGmn0166fyE8qOhHO2HlB3vWd+2pUbcx9
         0jcCuiaNLtUEuwwoQ03LQPUZOr6LJU8X72CHo/39uYsXq5I/jUYqf6tCqFFJnULX6Ram
         dTxGQT/LRKHIi8PXdajZ/yLL1YG/oTdTQ3l9auSc2pMmBO30Rr8rdDZfnmDUzjy2lu6L
         xDPAOhpm8rw+IlmZn9PGHBtF+idpvVq9AMcc2lExcYmCkwXuHw2E4NMz6yDXZnU5SgS/
         74jb6Wp5L8DbnAbtxvMP7jh3QDdWC/g/NawSWuG5+W+8eCL7w+ZK7NiOaMkn/G1MkKkJ
         HGAw==
X-Forwarded-Encrypted: i=1; AFNElJ/kyn/4BTBNwkhBFzFz8/B/g7fkWIf7TFsfsdSdxoBixU7hxCimydENwBQwrozXZOOc143DzlkUpw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzXFuw9DT/OqHjEGfGqZg+fLlYfhgc133A9PwCqyomcBJzPLccl
	5x28oPdKT+o2F4PUatf7ej+APggFWKWhva6sJxvQzyYGzsEte5GepK8qEyPF8ai7
X-Gm-Gg: AfdE7cnDUw1vuS6n4kiNixpNDjPBRoiGv+Png+w9cVya5bGeGCgu6JKy3PRPjBURFdQ
	1QB6Q3X3UHAPMmFH12YfH4nzLBhvGGazm0YyU0EpF2+xwebPpnyE+iEiR03eWDXZh03143Eq9Y6
	qR3Ngn7dAu13JohPYfl2Q8+4oj+Ja3giWVgMH40T+wUyq6HlCbayOJsw6jlGrg/w7/USjD/t/nB
	WBSHJCJTnfljeI4dtXYmAIIlS4YN/AQo0CiBixxDsX7nl4jbcvxD/q7XTOOzfvsHTCfaOegXIhl
	jMBteeeN4/vEBUOzlU66BhubKcI6kxjAI9UNPSz6a0WRYOuSE1gBh27l2J235plouLXxXy40ETo
	ZRYZoVHlMWvz5088xRtwLwUvHWu7sFb4ujVTNSz8QS4kgSiv/juSFwimNKelXrms19azj6DS/ic
	mH9SijHrhfBwssKdnIsf3e0K0ZakflssDHeeZYcp//xXnnEFX1cw==
X-Received: by 2002:a05:6122:3309:b0:5bb:e4f2:1073 with SMTP id 71dfb90a1353d-5bc3ed5099emr1146492e0c.5.1782289231336;
        Wed, 24 Jun 2026 01:20:31 -0700 (PDT)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com. [209.85.222.48])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5bbfbab451bsm10161783e0c.18.2026.06.24.01.20.29
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2026 01:20:29 -0700 (PDT)
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-96387efc30aso479498241.3
        for <linux-sh@vger.kernel.org>; Wed, 24 Jun 2026 01:20:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9wPaA8vIQ/lzL43x93JeStAhlzs+Z3tzrjxCiq+HpUhxxCRIIT4CTlOwBE1jAvRACR6fIgsiPEHg==@vger.kernel.org
X-Received: by 2002:a05:6102:5248:b0:729:c8f0:76bb with SMTP id
 ada2fe7eead31-73115109dcfmr909821137.16.1782289229026; Wed, 24 Jun 2026
 01:20:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623042800.1848398-1-haoxiang_li2024@163.com>
In-Reply-To: <20260623042800.1848398-1-haoxiang_li2024@163.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 24 Jun 2026 10:20:18 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUyhwj_YZF00ssYt94n9ceHD2s7S+r0kKd9QsBYAc67gA@mail.gmail.com>
X-Gm-Features: AVVi8CeleHUq0cBQ5Q8shQdH2lo-wZ1vo66vFQjtlFhS9beCidh33XrsUDgUQmM
Message-ID: <CAMuHMdUyhwj_YZF00ssYt94n9ceHD2s7S+r0kKd9QsBYAc67gA@mail.gmail.com>
Subject: Re: [PATCH] sh: kfr2r09: Fix USB gadget I2C adapter reference leak
To: Haoxiang Li <haoxiang_li2024@163.com>
Cc: ysato@users.sourceforge.jp, dalias@libc.org, glaubitz@physik.fu-berlin.de, 
	lethal@linux-sh.org, damm@igel.co.jp, linux-sh@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Haoxiang,

On Tue, 23 Jun 2026 at 11:03, Haoxiang Li <haoxiang_li2024@163.com> wrote:
> kfr2r09_usb0_gadget_i2c_setup() gets I2C adapter 0 with
> i2c_get_adapter(), but returns without dropping the reference.
> Release the adapter with i2c_put_adapter() before returning
> from all paths after i2c_get_adapter() succeeds.
>
> Fixes: 5a1c4cb5bc22 ("sh: add r8a66597 usb0 gadget to the kfr2r09 board")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>

Thanks for your patch!

Before posting (or better: writing) a patch, please check if it has been
posted before:
"[PATCH 0/2] sh: kfr2r09: fix i2c adapter leaks"
https://lore.kernel.org/20260508120601.426115-1-johan@kernel.org/

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
