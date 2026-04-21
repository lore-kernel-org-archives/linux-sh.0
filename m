Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D572628DC4
	for <linux-sh@vger.kernel.org>; Tue, 21 Apr 2026 07:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776755085; cv=none; b=obXT1Ei6FC4/Be0PwyvVxHJ596h9VTue3zR4A4fMnatHM6ffPTXnsUmE0zwwt20crq+ADq1NlZZ2u8YRRfEjCb6F1XUatSftRyMfMEDIBDk0BMcCRiThsJhHK5zLJbPITAvKJLY8YwHgFW26kvq9czI4IDYQVYGqa7u3v2XwNv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776755085; c=relaxed/simple;
	bh=kWJAr10tHpXLhQOEEGs/gvgljIZM18Xc/BDXsAUsZEo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qhF9til8HAZx6qnrT1g/thip5wVRaicYEYrrBa7IZYM6BEgD9V4xXu/OBaDcWtOXK/gglR39YQLkE1ocPby6XXX9duQCtHW8QHOl1tEZ8TNNNSRtS8yqeJlLx+lyVj6dx1nBk4ZWeWXyPvzpRARonLJZWNbEvj7SKuV55K893VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-56f3e6bbecdso1251271e0c.2
        for <linux-sh@vger.kernel.org>; Tue, 21 Apr 2026 00:04:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776755083; x=1777359883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fRrz4Oau/N1e0QCh08hyWqHUIMEyC5o4eVAp+iar7AQ=;
        b=lo1Vxornog/nMWDC9PIstTOWo3tVuuaoYAXG9GBlOirH/P+uHBQK8Bzu7jRSjqqmbr
         j84sRayCfz4OP4KeyI3Fj0UnOBs85+iwggFsnO72WoCu2bRY51p7dmZuuzmDPEk0s4S7
         vc39DNWDq9hyjK/QuTyFOnfcekAOEXWkCaziIsf51uHiVNtdSqcXwTDsmTBPmXxUBJQ/
         231h/j3RRRckkqpMtYxz8jKJpex41gBupUzmEFlagjRunbEmPdoQNDDxz7ZiJ7CTyxzO
         ZMFYzmBG2+TJ3SflvWRqgH9NXwdjgO0ycC/8T6Yk2/64wXbNtCdQlNyrp6IBlnTcyoFY
         jeMA==
X-Forwarded-Encrypted: i=1; AFNElJ8q0UxIXhbc91fONJIz8LokZgFmMkFBcor7wDqAcOkp52Cg1Q3soc4QAUgb9F9OKC409AHEdoiLzQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwPYYHa7xrNqFG/+RpfTbMd+0R8kMc9AQy+8t5G2awyjRLkuse1
	XIp+fG2xhG74PR7A4X8xLXg6oGVIxZdcF6XVmJNO/q2/BCuhSIt+l2FDzTwIrQIRPC8=
X-Gm-Gg: AeBDietT50X7MJAAJ/Ejy9a+OyLjkEF8roxYptiSC4FZF1mqJf+le4/HXU3vjaZNm8w
	vpKQAePl5wnIeP0TYzGB3a4HU9jqYnXXQJCjjlbJTEHonMA2B1u6mYBgEBqBazw57mOIndYQYfg
	lZqUo8thtGytZZYtt5RUFYwucijHSdNS56kcBXvbSmqgRqVpfRqMm77lr8eQDzN3uUVvMjKabu1
	p/r0tuK0cVQ/M7Pcr6OnxFL94Vcoif5AmkMDrwBNtxYPVj7j0l7Le0cOU5IDVTZlS0T7bAhJ5uG
	j8jT3lY1ujSwnK1vOoJN2nziww3WK9+48Vw3ZisnmRNhE6wkzBFfgM9QCm9zqUECDGP/iMZ35EA
	sUtFCIbMmVTVk7chMCeWXx/x6WndU37RNhf2ZFdlfN7JuBSaYQerXhSywrGjR++dY5QFa/s2CsV
	bA7t6k6ysK3FSjoI38Si3Kteals9T6DatVB0Ndeli39zUhWBECWp3cqLllxqiU1bzbeBp4EDF85
	dFlpTNYRQ==
X-Received: by 2002:a05:6122:608b:b0:566:23dd:19b9 with SMTP id 71dfb90a1353d-56fa57f8ec1mr6593805e0c.3.1776755082761;
        Tue, 21 Apr 2026 00:04:42 -0700 (PDT)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com. [209.85.222.54])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56fa920f0b4sm7684305e0c.8.2026.04.21.00.04.40
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2026 00:04:40 -0700 (PDT)
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-948029fb1f2so910924241.0
        for <linux-sh@vger.kernel.org>; Tue, 21 Apr 2026 00:04:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+V1BIt8rG43rWSCaiGyaXau4VyKdBavsVrIaZc8BixfHJ7bCU+bkS+SVvvSUmsll306XiO/QV8Gw==@vger.kernel.org
X-Received: by 2002:a05:6102:5122:b0:608:759a:53bc with SMTP id
 ada2fe7eead31-616f1c595b4mr6639739137.0.1776755080346; Tue, 21 Apr 2026
 00:04:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260420150958.17072-5-thorsten.blum@linux.dev> <20260420150958.17072-6-thorsten.blum@linux.dev>
In-Reply-To: <20260420150958.17072-6-thorsten.blum@linux.dev>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 21 Apr 2026 09:04:28 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVDnQAzXO+ZBCD5s2SRTsw31x+QuRVwPvQRbJgCtdmU-w@mail.gmail.com>
X-Gm-Features: AQROBzBa2CMpD8Ke6onXUDyzNhqmRN98DnEPJCZVXv1r9oZptIPM3WHFEwXXU1o
Message-ID: <CAMuHMdVDnQAzXO+ZBCD5s2SRTsw31x+QuRVwPvQRbJgCtdmU-w@mail.gmail.com>
Subject: Re: [PATCH 2/3] sh: dma-sysfs: use strscpy in dma_store_dev_id
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, linux-sh@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 20 Apr 2026 at 17:28, Thorsten Blum <thorsten.blum@linux.dev> wrote=
:
> strcpy() has been deprecated=C2=B9 because it performs no bounds checking=
 on
> the destination buffer, which can lead to buffer overflows. Replace it
> with the safer strscpy().
>
> =C2=B9 https://www.kernel.org/doc/html/latest/process/deprecated.html#str=
cpy
>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
