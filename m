Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C633876D0
	for <linux-sh@vger.kernel.org>; Wed, 24 Jun 2026 08:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782289795; cv=none; b=RlY58rPo+1/rsr8sU12vZ04jqHdK8FddTN83LU+6O4QWSR4KXiElgUGHo2PV9LdnDGDYHyowKdRVBE+TEK7n3NikoX6jUXZMfRW6iYxmHyySd7WTM52jedmbKBeNEoUuDvjEEdq/OHfHKQnkLqhGCaIxxbizxcXpDAEJB7myi6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782289795; c=relaxed/simple;
	bh=DzQURGJ/90KydpVOB8aXhed+8UqIRqbhCdJtOFZaMLE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MxFpbvDBVvUSsx9kIXJINCsF3tA41ztrw9BSeTDROyqnIOBwzUlNlClc+QCp4GdbHhCdEQa+j8pDacO1vixJqiKn1lCJ9zPjZE9+LxJIrIta/vUu1jKfAL451e8Wi6cRGaOZk1ZFJXUGcUCsahBjTSvh9/iILg9APNfVObZYTAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5bbd26a2729so648509e0c.0
        for <linux-sh@vger.kernel.org>; Wed, 24 Jun 2026 01:29:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782289793; x=1782894593;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GA19CstQFiQHAhnj5MSb+kW6nAx7O7omGKi1TaxN/BA=;
        b=ZJTDzo2A7ZjNY3jkkDKtxXIwpjvfMKJ/bzhyTKVzlg2Nh/Ug2dmcTjTdHi24gKp4d/
         7oHEbNmFs189q76PV8xUtdI3AdO+Zx/N0TvLkF+TsPT4s61V4bY0LZhlqQEJMZQiDYei
         idI5YONbO7QlYs9nCGeltxptC9PCHQ7etUjTkCZ3kxciFlPbLCyEfHsYSVR1W3LGjh0v
         eGn0OSCGeKM8X1G/Fp29ealiGItkld1sJMg/zjjJO5CV7gexQx9wC+Q4vKsLP/LNGBMk
         ELXrs5668BJccHPVtg3dRWTuq0ru+G0eGomdLJy1bpir+4XUGFlX6Bg3qnP3hj9hbBwS
         wJZg==
X-Forwarded-Encrypted: i=1; AFNElJ9JD+tKzgbAruo7To65FkwhoDZLuxG/sW1vLtHjlRc+lOKTNsGkpXQZb0Nu4hD0PMun0yjeilJUfw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyIUMdzWwEoE40QRLBVszT+0aV6YHfBVQpMeEbGFRDsQPEYorcQ
	Y2GEBTZ2EC1wuq8RONQQkj1F0IIPf54VTh4V3qPQ2dbTHSzDdWEGbE4PVbUdxMHK
X-Gm-Gg: AfdE7cmqgNzFnCdWJPKdrik2ydKdUg4ja+a4zaKJvX8c4fEudIGQg56pELKgRj58rby
	EBJaUyxvC5l8r4iIEpyAAYtjdfmDFpxAOgzZOcBp8xGnijpqYSmf0HOTeaNF1/3Ppggr5yzDQ93
	NM3NL6Br+zOxTjcggujf22JFJ4AaJZwyxWT3XvnpXSv6wfp+aGjQRRVHyA5joqaPoYBUwTJsTac
	K4FCt9IstmtH+BQiPkVoSNz2i4RiOZjuuMuMYHYGH1LqWBR35+guVGYuF0l8tLXvJwiCYxkM6Ca
	ZQqsbk8LAuXVSzExle0MPJYrGd4ID6Cs6sipBI+t2gL4oUHxAuIMtuEppa5q0DGqQYm3as033St
	BDZ9RAYv08Ma/lNZ/nCCey+yPB4JXixLNG+vsjanIKi/Om1w6dqrq1zlzW7yBr5/cozpxZJy6k0
	doy/Cp2CTnxUkzmWExlh6gfAryKg392Gzfrvp0MSNd9RHV+nNv37ZylA==
X-Received: by 2002:a05:6102:5e96:b0:6d9:a889:13b2 with SMTP id ada2fe7eead31-731133d2078mr964305137.11.1782289793206;
        Wed, 24 Jun 2026 01:29:53 -0700 (PDT)
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com. [209.85.221.176])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-72ba4f2926dsm9473181137.7.2026.06.24.01.29.52
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2026 01:29:52 -0700 (PDT)
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-59c9b666822so549480e0c.3
        for <linux-sh@vger.kernel.org>; Wed, 24 Jun 2026 01:29:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/jnsDwfaQuuSYAC935Et5vn7SBMornO4hL9lLu0m67NRgWJcbPwvKTSLl5K4MBR82lmq0X7tuplA==@vger.kernel.org
X-Received: by 2002:a05:6122:21ab:b0:5a0:9ad4:700e with SMTP id
 71dfb90a1353d-5bc3eccb520mr942158e0c.3.1782289792438; Wed, 24 Jun 2026
 01:29:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260508120601.426115-1-johan@kernel.org> <20260508120601.426115-2-johan@kernel.org>
In-Reply-To: <20260508120601.426115-2-johan@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 24 Jun 2026 10:29:41 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXAoZ6+Ch-qUhwbV=47PDHfgkARnZpo4h8y0h_uZP73Qw@mail.gmail.com>
X-Gm-Features: AVVi8CeS-ve8tL-XyxKs66sVTyPqvMhCGD7V1PRdEzsnO6Z7eg-th0wbj2JBfFg
Message-ID: <CAMuHMdXAoZ6+Ch-qUhwbV=47PDHfgkARnZpo4h8y0h_uZP73Qw@mail.gmail.com>
Subject: Re: [PATCH 1/2] sh: kfr2r09: fix i2c adapter leak on USB gdaget setup
To: Johan Hovold <johan@kernel.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, linux-sh@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Magnus Damm <damm@igel.co.jp>
Content-Type: text/plain; charset="UTF-8"

Hi Johan,

On Fri, 8 May 2026 at 14:06, Johan Hovold <johan@kernel.org> wrote:
> Make sure to drop the reference taken to the I2C adapter (and its
> module) when enabling USB gadget mode which prevents the adapter from
> ever being deregistered.
>
> Fixes: 5a1c4cb5bc22 ("sh: add r8a66597 usb0 gadget to the kfr2r09 board")
> Cc: stable@vger.kernel.org      # 2.6.32
> Cc: Magnus Damm <damm@igel.co.jp>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Thanks for your patch!

> --- a/arch/sh/boards/mach-kfr2r09/setup.c
> +++ b/arch/sh/boards/mach-kfr2r09/setup.c
> @@ -368,7 +368,7 @@ static int kfr2r09_usb0_gadget_i2c_setup(void)
>         msg.flags = 0;
>         ret = i2c_transfer(a, &msg, 1);
>         if (ret != 1)
> -               return -ENODEV;
> +               goto err_put_adapter;
>
>         buf[0] = 0;
>         msg.addr = 0x09;
> @@ -377,7 +377,7 @@ static int kfr2r09_usb0_gadget_i2c_setup(void)
>         msg.flags = I2C_M_RD;
>         ret = i2c_transfer(a, &msg, 1);
>         if (ret != 1)
> -               return -ENODEV;
> +               goto err_put_adapter;
>
>         buf[1] = buf[0] | (1 << 1);
>         buf[0] = 0x13;
> @@ -387,9 +387,16 @@ static int kfr2r09_usb0_gadget_i2c_setup(void)
>         msg.flags = 0;
>         ret = i2c_transfer(a, &msg, 1);
>         if (ret != 1)
> -               return -ENODEV;
> +               goto err_put_adapter;
> +
> +       i2c_put_adapter(a);
>
>         return 0;
> +
> +err_put_adapter:
> +       i2c_put_adapter(a);
> +
> +       return -ENODEV;

I case i2c_transfer() returns a negative error code (the other
possible value is zero, right?), you might want to propagate that to
the caller. However, the single caller replaces it by -ENODEV anyway,
so I guess your patch is fine.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

>  }
>
>  static int kfr2r09_serial_i2c_setup(void)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
