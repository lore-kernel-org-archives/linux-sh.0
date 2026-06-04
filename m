Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CECB35E1AF
	for <linux-sh@vger.kernel.org>; Thu,  4 Jun 2026 11:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780572665; cv=none; b=AuaCR6f5ainjZ6DFMRV+8EIXUD70quv8wCxngczXAquwJgw27Mx6QEvdw/+Fw4NWGbWTuF+ufzO7+6VFKVE5LHQ4fTrUK0LtD5Gy1R5HvIOeRoHesnkl10pZxxE3SWTe0nEOoGHxO4wigxA9bdQDi2+xVwx7tEYnxI0l2C5k1WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780572665; c=relaxed/simple;
	bh=+7EMauFhpWe1mVTiqk7OymsMhwPkci5znEAR5rmC3xk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rVTSfF9HjD8XtxBJ6OG6bchK2JeAWh91QHreH/XQCJzVkM+5jRbJNXjpsLKEi+HUYCHt/RXOh/0z++OX3xshLlk1wLkXqwTvyNv51NPJPaPSKA8d+jC+vwoWWZqc6/MjPvbkLAjnLIMJ4RMyZ6K2gAL+YbUI2OxgGNG7bxl29BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5ab02fb64b0so141236e0c.1
        for <linux-sh@vger.kernel.org>; Thu, 04 Jun 2026 04:31:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780572662; x=1781177462;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lkYCtuIJOSVTTjjNlly3EZEZe5v1NrPv7H/PUTaoL54=;
        b=ececpkBYFi/VreMC25foLXHJYWXJz0QCPFeA5xnRtxKF7HZnxKaddr9u0UunGgBROt
         3ccJhBMxERmtBAkjLPMNLMbgGfY6jvGaSdSdQzghi8CYSLliDrzbTg9EsOT0cpS9Qub2
         3Na/5uwiesxXT/in/MpKp7X8n+WRcLywdDp1jAYVubcEo+5k5zJGD+NuMN59jxIg8ykD
         Z21Kmx53IL4eHPKUp1BF64Uu5VzEBs8g/OKoo58uf+QRhfdblnMq372x09Cp2m7N/H1y
         0PgvCD/fSaIVI0RakXhfu5a0abrzypnaHQ+VCubJZZbmVx3O4eyqWEIm4biyDkAeYBvV
         qW/w==
X-Forwarded-Encrypted: i=1; AFNElJ8TjLZUPhqnW64i7akZ5bJafE+pmRy0VGWr4fo2mFkFiJKtoLHm4lRy4i/ZcCAEC9i7Ebne8vmdRg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxY8fGCokf+byyL+sVLL6S7IuiQFH3lfAhEZ0nEDelVbuhq3UMl
	BSPcAERPrrkDZNZIRrbUbBaCBMzQCxuO4Pr0bmlkkIIvwzaW74pts0UV52avBgOfb/M=
X-Gm-Gg: Acq92OHvSTAj2GSqcO8ZRVLGbaC7KB+Nc6KFKcSF0/Sou1XLHo5Ei+Mz/VGRxtxrR7X
	y54I6gCe20Qqnbj73nHtP8eUq3W3+wVxUqFCHmXjCko7125Hs9STopKxTsW6+mpjom0didcOfO1
	oWX7tPfJoUKNBWGNfWHe2kkSOyTARqz9D6c7FCINGakFR4kOln6OdkGArP7tOZjrbAwlj3xPwZm
	cg9bHG5onz5TTvO1bZwUdN3v66PVRY7c9zorumJ6taGNR5hUIFQBb4zOyKV4N/4i6PJ3IkfLVrM
	nBwPQuCHdXjghCyMqfDORlZSaRNJSRTZU3Hdt4OeFk5NxbvoqLQLlxfuGQ9tPg/OmTIQqabH2fI
	ND2dJZXFX1GmDj1sqBNi99Iixp+U2W6Hflx8e8mJsdstPTJscQO1K/2oF/GpCct6aVhokNhNEjO
	A7ezMTumvh58etDysPeHcBdWddOXbRQGEDyu6EEZvzyH5QBLzv8vwP8TmQEPVA8JofheS0+3r84
	bk=
X-Received: by 2002:a05:6122:6b93:20b0:5ab:26f:4a42 with SMTP id 71dfb90a1353d-5ab026f5a52mr321284e0c.0.1780572662184;
        Thu, 04 Jun 2026 04:31:02 -0700 (PDT)
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com. [209.85.221.179])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9641414e193sm4205654241.11.2026.06.04.04.31.01
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2026 04:31:01 -0700 (PDT)
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-59e8ededf4dso375793e0c.2
        for <linux-sh@vger.kernel.org>; Thu, 04 Jun 2026 04:31:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+7YOJYHmusyKV14bC1jPPDLl5bObpHfKpd3j+LBBSqDzQnS9V/25skYd86BhnmnF2kpy7q2Bs7uA==@vger.kernel.org
X-Received: by 2002:a05:6122:c95:b0:5a0:e267:cc8e with SMTP id
 71dfb90a1353d-5a6e4280515mr4717068e0c.1.1780572661119; Thu, 04 Jun 2026
 04:31:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604111237.1297783-2-thorsten.blum@linux.dev>
In-Reply-To: <20260604111237.1297783-2-thorsten.blum@linux.dev>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 4 Jun 2026 13:30:49 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUowmbWMrgKVbVSgN02a2RdfAfJ8QK1QdOcrd+LrR4Ejw@mail.gmail.com>
X-Gm-Features: AVVi8CcPbcnhVnvON9rnGwNq5brAXJQOzx8NhWBSZkHlsesK4_Mw0IhMQWopAUE
Message-ID: <CAMuHMdUowmbWMrgKVbVSgN02a2RdfAfJ8QK1QdOcrd+LrR4Ejw@mail.gmail.com>
Subject: Re: [PATCH] sh: sq: use str_plural helper in sq_remap
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Kees Cook <kees@kernel.org>, linux-sh@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 4 Jun 2026 at 13:20, Thorsten Blum <thorsten.blum@linux.dev> wrote:
> Replace the manual ternary "s" pluralization with str_plural() to
> simplify the code. Use the format specifier %-1s to preserve the
> whitespace alignment.
>
> Simplify the map->name ternary expression while at it.
>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
