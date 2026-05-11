Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B577375AA8
	for <linux-sh@vger.kernel.org>; Mon, 11 May 2026 11:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778498998; cv=none; b=EOp9Eafj81g5VUFjh6U9Wi2nkRTpR0/d4ViRbvL5InMfEz2e7Ng1ioq1fPmBlXNk+9l+KCliuj90dTK3RfcclN8P0yoBPdox4G8iptSs5WUasqd2WWGKEzTgGXAjZFX3YR1rsz6e5vLrH33HotGNYK53Q64vDcCJ975h8imFbKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778498998; c=relaxed/simple;
	bh=qMKsZ0iVqwC4Sk4L8z7vxV/aAtOsy3b8hlm2mO9koYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BYgW6Q7ONJTmU+tdYaMmIf7jJrz/b8gpernicy/H9DviQ+VUDDvvj9EqMnz9WUmLsdJE3UpFDoElmiiRmHeHTYUI9NKyGRD2LeYPcRiGsFxBzq4Pp60k8TLVdR0rY4dNiWkbWQocK1uWynj7eQknzRLmGTFZvtwndd2zB//Ung0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-56f72d27e7eso4552193e0c.0
        for <linux-sh@vger.kernel.org>; Mon, 11 May 2026 04:29:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778498995; x=1779103795;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=03+u/psjXBXb8DOEfOshJAGZI0gjXk+3GJfCuLxf8ME=;
        b=jVjJsCOxV5IcExYTf5J3Yv4VW9LDRR+A6lUG3hg0hMeQr6pvjJ7DUNZmSDVNdKUjOx
         bw9rNWCfz6TuGAMVZkjOa2pQxS9ophqwKuwCY3OlPtoViEb4L64FX8b/OttSTqGZT1c5
         iUp629VrrAafGJsM/JximQRIsjH9fptAqlK+SbRwDlzjpvT8sCRM8bg6ET+N70l2pk3t
         kNm/1saegNy19QbNep8N9vR5ZGlVVl7Ff961iUFL7+ZyGXL0tZ96rly3HyMRTBjKaIGa
         tR5uDAqV3uYXNnAnfaI3AABjlmOtokhaL4hvJeN83x6ejlgVwdSs2f0dboBYoEyjZmMb
         +oBA==
X-Forwarded-Encrypted: i=1; AFNElJ8LJL9iMBthb1I605q2sFUUXNGD2DmdSF5Vff1nNeNnB22JaKYr39XJPbaQnwRJEfHUssVoX96QDw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyDfu2ZauRuC9LkaZMYvsGxzlmJ11nuStVlVoyiryLCInMqZI/e
	8B4tYFmuwWcQD0Iz47pOIWM7u/Rmf4QynfyqtYlTX4BaHvkydDCL46yvGo/BS9WI
X-Gm-Gg: Acq92OG7Yb5pTYzIJRDE+j/7xACQcc+7BAovZYCXJFRvovTcttazPgzhs8R1a9S53gR
	HPhsydStPV3EW8Oo3dEI+xYROBdIl9hVjqxoacNUXSr9Gf3k9tUhX1C5NQAI4XB/ub7ifIoTp/u
	seSJRR8z45z3gJ3nbcMnlpf+mpZ1LIpAsa2+wvtjGKk53ED1Vi+UpNXe1M+fQMmuFQjW05z6qNX
	BGrTgRZHdEB2xSGaJnOxiAwh4QBvPq2sk641JgEdvL/QMb7O2CY8aNlCA5mIo2xVi768ze/DZLa
	tmPlOJuTgmogPrkKquoTDoqBjLz6Mq1XnihR3dI3lLaX+B5wQLTJW7ajmIhdY0TgsKhCktABkXV
	U2Pb3pIVPsdbAZdHBgI72XBdjV5q/00Jj6eAVpwguOhVVG0jzV0HJF2ZEL0+Hx0rN6OzlSKg1D+
	oWak/y+gXShHdBMWuAVkUMDXQ4zoBXrshcZ+xfbygc0M9FMzy5OU/jZgxWVtF5Tz3EDgVAsgU=
X-Received: by 2002:a05:6122:1ac3:b0:575:39bc:c6d9 with SMTP id 71dfb90a1353d-5757026674dmr6821603e0c.3.1778498995313;
        Mon, 11 May 2026 04:29:55 -0700 (PDT)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com. [209.85.217.41])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5752425a19csm15326454e0c.10.2026.05.11.04.29.54
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2026 04:29:54 -0700 (PDT)
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-6312bdd281eso2827261137.0
        for <linux-sh@vger.kernel.org>; Mon, 11 May 2026 04:29:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/3TDFN9rv2B31U5r8kjRCrcgF8OFknXWrCT/VEzmwK484Qpvnu7TUUWySKreLTTE9QUPHMAH/ueQ==@vger.kernel.org
X-Received: by 2002:a05:6102:511f:b0:631:a34d:b671 with SMTP id
 ada2fe7eead31-631a34de3dcmr2857599137.5.1778498994636; Mon, 11 May 2026
 04:29:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260510161012.108731-4-thorsten.blum@linux.dev>
In-Reply-To: <20260510161012.108731-4-thorsten.blum@linux.dev>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 11 May 2026 13:29:42 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXGVNOindjH09KZ7h0jV0ct-gbG=pDA0Lko-jZRBv1fnQ@mail.gmail.com>
X-Gm-Features: AVHnY4JL8s50LKs1VM7xn5qStkoaOfB_AEqGkZNsKGAk3CPJagLGhct1LTs5Bm4
Message-ID: <CAMuHMdXGVNOindjH09KZ7h0jV0ct-gbG=pDA0Lko-jZRBv1fnQ@mail.gmail.com>
Subject: Re: [PATCH] sh: dma: use strscpy in register_dmac
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, linux-sh@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 10 May 2026 at 18:11, Thorsten Blum <thorsten.blum@linux.dev> wrote:
> Replace memcpy() and the hard-coded string length with strscpy() to
> improve register_dmac().
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
