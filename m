Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392AD44E656
	for <linux-sh@vger.kernel.org>; Mon,  7 Sep 2026 09:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788774638; cv=none; b=BKBd1SnWIwLXUStdOekU/MHnfCNMJNlJw15J82ynHgsvoazwQ0iEWPQ1zeCt21t1SDWzwbpug06yTNSLIzgG/EwXh0VpnjvH4NAn85B0o2n/ZZ8lZJ4R5k95TcHW+xf/VBEcx4cdyaJtJOIZyahDd1Em5ed9vEO+FKdltGDu3fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788774638; c=relaxed/simple;
	bh=EJi4g5va8T1f1BIn66h2FvU8Mw088XXg+dMLppSZj+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CN9orNHonrvys/uaCmrPugvOZODDifYX9U7w/jvQf7V2QOkr/r1xCaezAiI+XxH898IeJ+2Tq06aPQ/jLpjouBJucS/4dSic/f5KafvZq6I6uBBhP1Cg3ZxE650AZnqdNfMvsobzUydLZZi9GsSwO6QM+A+0X9/vk/Q8+Chx544=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-789fef9422fso918483137.2
        for <linux-sh@vger.kernel.org>; Mon, 07 Sep 2026 02:50:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788774631; x=1789379431;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jpyiT01uqi3z67FMkXpZRYNDQ41NByhvT2i+cHhX0n0=;
        b=FW4uSlivCuJSSVKZSwzE8jiPgWkM1GP2POwGMmFcQapNYjOIPm+Ponc+6dKFeONtJZ
         g2Lxqg7v9tHaJ7Ev8R24Q6DRwqOFPVtZYfCG7RgucwH8ELoK0pQbe2CkpLGk+lstuuzz
         VkE+HaGuIe+dm3ho9N9OTst8QJEEv+2TcKfEUUlRe7oYLSOuCJyyTrDk17hcaG0YpiLg
         85Lun4FR8F3C2LmSlTPhOOwL7cBSg6mL4myDXA/REWJwinglRNlYiCI8dA9WhmSBwEp8
         Fgmb3xzKddlH6kAn14vIBAInGkVMHcWY1sQF9HfwbmEx9G9/mvAZDeHMtIbs7+LST1BX
         0gYQ==
X-Forwarded-Encrypted: i=1; AKwUvByi4U+XYCSiIhNjXRM2TbVhVli4UM73pgnWOfPUPHNFW/ekFXbLjN2zicF8+1lypilT0fRBCv+OKw==@vger.kernel.org
X-Gm-Message-State: AFuF++m0di3zP2Aqb0kTRbw/tAonYf97qgBykXUT2z1Ja85LZBltoC/D
	+FnuQXs6dVRvyO8f74dNd+zbFbmNUYvbjxkr5bTbdFKuMatBZuGU+tpNkuSIroV2
X-Gm-Gg: AYBFou0fCzexw6MoqiJV2wDjov7UYvBxWoPgx9c6i5IkoWHwtkTFSzAAnzGd6arjrMm
	67NiU3/mU7EEig+nnz0jhBYNFn8xP99Cv42EySf3r356hNdMDf/GdEjtRMR5qr8IMabahFDWnqR
	SMSCGf+c/7x69+lPK8BRLcDNI0zYXjL5qxOETTRy30v/FtIfr/zhTcpYrntpbLZSwKDZZru5sli
	XUz7hTegtX7qxJwinHg/1MT2fDsJKGVS2VG+zsHjRTQGuiGcBgdA9iTAb+lpoaLXyDNz4CzoG4y
	eh1Xvt2cdW3XfMN43mUVqlAYzpvVAEGkpY1l5aEb3xRs66/PZJXPUpEkAPHOMwowbUKGh1DVQdf
	MX5CvgVyfpXt9jgl1C6NiR6nrvLxRv9sNzlroq4qw+yaxu1ncaNF+jhtWd+944RVMeAo/bklP+p
	449bprHUJakhBZ6QhTewavyLFSW9oxzwcjSrpidOWXW9z+nqxIk8TXBX8qw6y4JbAWkNguxUTvH
	7hS5yQdhq0L54nUAic6/BqkFw==
X-Received: by 2002:a05:6102:554a:b0:780:5605:743f with SMTP id ada2fe7eead31-78a4a8bb311mr7033730137.3.1788774631140;
        Mon, 07 Sep 2026 02:50:31 -0700 (PDT)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com. [209.85.217.41])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9808edd3d81sm6912507241.7.2026.09.07.02.50.31
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2026 02:50:31 -0700 (PDT)
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-784980b88acso1051575137.0
        for <linux-sh@vger.kernel.org>; Mon, 07 Sep 2026 02:50:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBz5Wps1qDWT3P5X6tOirfQyZLawE0b7B/nxjpCo+oCrddTbaVZmeaP5OqzK+CbXHybUDevuCxNzvg==@vger.kernel.org
X-Received: by 2002:a05:6102:2ac4:b0:778:30ee:f44b with SMTP id
 ada2fe7eead31-78a4ab31a99mr6505412137.13.1788774630709; Mon, 07 Sep 2026
 02:50:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907090956.2825703-1-arnd@kernel.org> <20260907090956.2825703-3-arnd@kernel.org>
In-Reply-To: <20260907090956.2825703-3-arnd@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 7 Sep 2026 11:50:18 +0200
X-Gmail-Original-Message-ID: <CAMuHMdULSA1XeuyNR2oM0m3bGt6HzKMZkYYKEchy49nztpgNww@mail.gmail.com>
X-Gm-Features: AcwNN1VEYucUOC047DGmcAJRGb8pjtBq2r0j3GGqGyncqZYd9LFOaI3FEXXAmV4
Message-ID: <CAMuHMdULSA1XeuyNR2oM0m3bGt6HzKMZkYYKEchy49nztpgNww@mail.gmail.com>
Subject: Re: [PATCH 2/2 v7] gpiolib: remove linux/gpio.h
To: Arnd Bergmann <arnd@kernel.org>
Cc: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Kent Gibson <warthog618@gmail.com>, 
	Johannes Berg <johannes@sipsolutions.net>, linux-kernel@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-wireless@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 7 Sept 2026 at 11:10, Arnd Bergmann <arnd@kernel.org> wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> After all other drivers have converted to linux/gpio/consumer.h
> or linux/gpio/legacy.h, remove the final leftover bits here.
>
> Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
