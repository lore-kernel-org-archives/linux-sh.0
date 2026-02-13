Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E39233A6F0
	for <linux-sh@vger.kernel.org>; Fri, 13 Feb 2026 08:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770971543; cv=none; b=tdSwOpEIXaPCXMKLes/iSbdloHe/HfG+72Qjd4S97EBOtNV1YoZ5/1Fk4C0Ezm62IEorq5rI6M6gogTLkhpryxnWBCofIO5Gi+cx7Ti3c+wR9Gu0jId8uNXxsK+GDBa609j3ky5GY/lNmoRQJxI0jBQub5jcrxBHsQSS6tmJZE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770971543; c=relaxed/simple;
	bh=Yv6PGqWQMTcJuTAJUZAwYH9GWvC8/G5Z7nKADXqOwp0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z71ixcrNGRhFLEL2Wa6AwL/H5b4/6FRLosULa8JRcpCg/dF+fNYCVQxNGshioWlN19wFnSvlUi1dcmn8BuJLC6tmaHzMp8rjPqH22XAP5gPzKJm8Wuj4JMn/N4uDv6zPysZuIiy+8o7pJI/NUqVoYXhgMGnG3XTTAqCO7800Uh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-5fae038b5fcso190253137.1
        for <linux-sh@vger.kernel.org>; Fri, 13 Feb 2026 00:32:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770971541; x=1771576341;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j+BJlc9YwTSkwAH0qy/UiUUwI7R3N6kL2b2OaPe4ufA=;
        b=snejeGBX8kzWb6TXf4CyfhPeCzTJlEL+YUf8mAD6s2eUlObdK547GLXm8qBaghoEiV
         BhtEoO5VihQUjOcOxD3IOd8SnnjKzpjpbiNfPF/hcqKRJq8uJMr4DJrJUtR8YL1b3D8Y
         r0s69vbWfJQfX7Ccgfvo0ivZWld5C/BmOjeMiAT/n0lSGFwSq23o4u2AURl25x176At+
         r/D08d578/jo4XLpvQ5SnvPIgrnYICe9GGELRuyo0iyLfSOW+4pAYz0KVo4AA/7UkaYt
         ODFwlYIK/wIc8biatXVw33wu9q12fjC1wQb3gGC/B3+ih5jfaiVoGo7mAv1lfzXIeDy/
         IMtA==
X-Forwarded-Encrypted: i=1; AJvYcCUP3dH1BORJfSwhsA4IhgKyqYL1HxlG09JulKNTsZfE5UL3MrafjgeOvKfszVoePUlBlMC91jqw6A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+8+Qmyfy5yNiqgiCSlDyeqw9gPj4JdDowUbD5knwZv9p8FwQi
	e5Q7vFh7OfVTLfRmE6AdjCMVI/B/MgmUAyH9VbCTTjY7VtHj8dN4lD9aT6MJ2loA
X-Gm-Gg: AZuq6aLZEKDkovHQdGgXlLg96m0DmmtFuttzplhwh7JXgFmkA8jhi9pUTsB7++sqquw
	GnBlb0Y+WmgXL8ATauerO4vI575ejUZFLvdMJrEeE4YKqn5wmUC6a30GzQkptwhmtHPIC0jv3LE
	hV64HVcarRdRql26VFPEGtfehq/Im0ayju5/sIyObH5TE8USoNp51RCmoJQloV7euFsJ+h6e29h
	MUGxSSCJJ5UQ2rLpAp/SAvnwe+ElyAP/AwLWJoUC1z6XJ+kxiMdMPb33+XVzSe8F1rZATqzTQ6S
	UY+y1msUw9SkA/HJ5RsSyEN/hmQ5k2tmROX9r+9y/3zh1e/Cg8YwrQjrr33Vaw7uSZtoXvaCQJ8
	9GW6eMiLNBDcHCvHFkG5EhZ1b6jJ6ILpKADaB2hvtlwQw2FOtHNphOy5lVQo7vnCDOz9OBNMxDE
	hkTrx5M9OBTEYRYgL0vU3wGqQxL5DyEjtKkht2pHDobLnUGv6L19WV+xgtPTLB
X-Received: by 2002:a05:6102:d89:b0:5f5:32e2:5ea2 with SMTP id ada2fe7eead31-5fe1aeaad0cmr230159137.37.1770971541151;
        Fri, 13 Feb 2026 00:32:21 -0800 (PST)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com. [209.85.217.51])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5fde87fb7f5sm3077638137.2.2026.02.13.00.32.20
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Feb 2026 00:32:20 -0800 (PST)
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-5fcbff4f670so261374137.2
        for <linux-sh@vger.kernel.org>; Fri, 13 Feb 2026 00:32:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXFfxH4pnxuC3t3OXuPl6sQqlU523uOR0oRvWBFKUFXUqz85d1i74IIc1CoN2x6rzmnV+oSyZ/IKg==@vger.kernel.org
X-Received: by 2002:a05:6102:508f:b0:5f5:2e08:bbab with SMTP id
 ada2fe7eead31-5fe1ac8e72fmr248105137.6.1770971539770; Fri, 13 Feb 2026
 00:32:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260212192845.3724287-1-tim.bird@sony.com>
In-Reply-To: <20260212192845.3724287-1-tim.bird@sony.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 13 Feb 2026 09:32:08 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXpAJpvhY2Ws+JQboj8B8TFSVKNwWNFtXkC-8epd4ZgeA@mail.gmail.com>
X-Gm-Features: AZwV_QhjW2Ua7mbYTghseib27blEdGAr-pNC3bmHXn0FqCEYe1v_eVZxfsEmrsE
Message-ID: <CAMuHMdXpAJpvhY2Ws+JQboj8B8TFSVKNwWNFtXkC-8epd4ZgeA@mail.gmail.com>
Subject: Re: [PATCH] sh: fix typo in SPDX license id lines
To: Tim Bird <tim.bird@sony.com>
Cc: brgl@kernel.org, ysato@users.sourceforge.jp, dalias@libc.org, 
	glaubitz@physik.fu-berlin.de, linux-spdx@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 13 Feb 2026 at 07:06, Tim Bird <tim.bird@sony.com> wrote:
> platform_early.[ch] have an extra - in their SPDX-License-Identifier
> lines.  Use the correct (single-dash) syntax for these lines.
>
> Signed-off-by: Tim Bird <tim.bird@sony.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
