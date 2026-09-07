Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD583F12CB
	for <linux-sh@vger.kernel.org>; Mon,  7 Sep 2026 09:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788773995; cv=none; b=IuHSZyhLwAxzQBMk55WIEXjPxYUOdX6CWw1TSsydVi/ujDbVAn6vpYDwdDSLlf5I3So70CJ88SN24LOWjrNg/eHsrXol3sPB+uX2CK+JHdIOmMTs2ZSLxgT45Kb+WYzdIjI0zFqja1k/2joieRTxoBdn3y1yBY1jgw7j/mrWGRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788773995; c=relaxed/simple;
	bh=WlL+j/Ie6m0Twd+B1P3rICow2WcfWKryEoGQ+1VVbBo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g0YVEISKE9I4OO47oKiH/UZId0AznnhzoOe6T3tCWVry5s3ZLfUCFDZU/805mtGL9NSgYQvcTAvkiNo/H7o5kieAsh8Dm2hT9L9V9SOKLMILNwkUVPcJ4YxHaA7tN084UIkVLrf6X7YOAXISDEMtzTfgjqmt6tXrr4z9tUwzpSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-977258a75d9so2474498241.3
        for <linux-sh@vger.kernel.org>; Mon, 07 Sep 2026 02:39:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788773993; x=1789378793;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=idsP1neYZsT92lOTYUcwf/RINlIKDTK8HxAaGpjV2+8=;
        b=lk8fRSRGLlQybD70Ljef7Pi37f1F/oC1rHAxB3DMbTVbaiMg+IJA2mQYZ0WEMFxJde
         e1qTcBtcUZxESbRCJMTdcwdN8GLdeCzHJ/CtZBqKpMGbomakqqQAv466EOV0jDMb9Wat
         g/XfKteZlkvHV9QGcws+qzSrsIYGflQ9syt/PiZT2KNpAhjWukWRLSBwmn7m43J7clhC
         /DlatqOejfCHIA2NitgH0HLjEv7o+H/K/MbiIToMzXGs0qniU/Ogk7bu6ikVZXlIaqhD
         tHjCHlP4amISbvoBdTzX8I8NX3MzIqRlDPxcWPZo3Z+iEgizwMVKODJMTHgaJdvC5Ol9
         2Auw==
X-Forwarded-Encrypted: i=1; AKwUvBxbcQzQiW4/Mc8u7LCOTDScaznHzA78aI/jIRM/jxqQoqUALQ+4r+uP3hvBbqlzyGVfjUHlJ2B42A==@vger.kernel.org
X-Gm-Message-State: AFuF++n9z1OlRxGZUA3yYvguS4MKZ6IHhhwhAtPJKK1DJWnRP0N78yEc
	b9oZ0c/RXzjbhR4HLWfqf5chiPA7uCF7ODHpqrUjhr26XAdAND/6B5g1hHWHmqom
X-Gm-Gg: AYBFou2uhnwgDXUm3j+DQDOm4dGYV3toQjOhuLAdijZC3IlhPSXYRMGmLsHLo/AdaGG
	AjlCDZ0L2P9AdfFD74dYZ6jhuvYDyKBPmDNE6C4CuNM504bQ2QUgoxDNSFATxsP9zhl+yhrs9I7
	sDXcyBDAsKwTXuINhDWQVeVyzrgGbTgjemH+cNvV/ZR+1aGToHuEm6X3TzlRcC6+/Vzh5zF6aFL
	8Jb5mQ7Q7lxBElyQXI2qleto+wCa/mZ1RKBRBNhNsiaw9gtr36U+slC5E1gp1YLVopdNp5nBCGH
	k7hb4Y8NnHI03bLqyM2ARMrtkQJ+duOhSTunvo9JhiMdL6cA9QMwbDiQOI5RPoxcJzS5C8hsFXJ
	3l1GprEG5frElgFlyFT2o/nfwilqrNgXeK62oP4RJLPXnNSPGQqEWAiKLEzrvQiGoy8r/SGxvFl
	Ldp0eIJaI4D/rm6nTJqJL4P9nPuvhcJPFR7CsY5zk6F6TYP2XXIwNOUUeHO8iFZQoPKkuB//f0Y
	ilzKi05kYzRkH2ibv0cIe5KwvIaeLVDSZXqxBZO5g==
X-Received: by 2002:a05:6102:5487:b0:738:1ef6:51b9 with SMTP id ada2fe7eead31-78a4a96d8c3mr8583677137.5.1788773992720;
        Mon, 07 Sep 2026 02:39:52 -0700 (PDT)
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com. [209.85.221.182])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9808ee8039csm7051440241.11.2026.09.07.02.39.52
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2026 02:39:52 -0700 (PDT)
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-5bfc5b77c02so3134747e0c.0
        for <linux-sh@vger.kernel.org>; Mon, 07 Sep 2026 02:39:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBx0v0oQ4ycy+QPjLeT01bO4GKiTxCSGiP2lHCTuyROH+Y1dNmU0543e8q4DF9j8C8/LYBtW9DpqSw==@vger.kernel.org
X-Received: by 2002:a05:6122:c8f:b0:5c6:4bab:4cb2 with SMTP id
 71dfb90a1353d-5c7ed80403dmr10646528e0c.6.1788773992044; Mon, 07 Sep 2026
 02:39:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907090956.2825703-1-arnd@kernel.org> <20260907090956.2825703-2-arnd@kernel.org>
In-Reply-To: <20260907090956.2825703-2-arnd@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 7 Sep 2026 11:39:40 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVc=ntgrDDqdNUzEbeQ=qjh7Pw=B3TSN+qOD5bRY4_i+g@mail.gmail.com>
X-Gm-Features: AcwNN1Wp7dWP-FBPz6xYVraXlAq6_uFTgT8pt9uLR2DvecmC1uG2AIElIe46m7g
Message-ID: <CAMuHMdVc=ntgrDDqdNUzEbeQ=qjh7Pw=B3TSN+qOD5bRY4_i+g@mail.gmail.com>
Subject: Re: [PATCH 1/2 v7] gpiolib: turn off legacy interface by default
To: Arnd Bergmann <arnd@kernel.org>
Cc: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Kent Gibson <warthog618@gmail.com>, 
	Johannes Berg <johannes@sipsolutions.net>, linux-kernel@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-wireless@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 7 Sept 2026 at 11:10, Arnd Bergmann <arnd@kernel.org> wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> All users of the legacy interface now select CONFIG_GPIOLIB_LEGACY,
> so it can be turned off by default and only get built on platforms
> that still have one unconverted driver.
>
> Allow turning it on manually for compile testing, in order to keep
> the build coverage of the legacy drivers in allmodconfig and
> randconfig.
>
> Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com> # for input
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
