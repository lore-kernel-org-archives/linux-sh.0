Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com [74.125.227.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4B34078C5
	for <linux-sh@vger.kernel.org>; Sat,  3 Oct 2026 12:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791031387; cv=none; b=DjAqatV7M223zE5MAz1W/iZ1dfQLmyafmqQfEdaq1A6DsTQBfete0YU9GZ81loTLb1t3B4KtnZDSESGLmzHxZo7RysZxzHwwf4mrlYnNjQmrjlHMMYlp23bBUjk0yZwoUdCwOTe+eQOu4L9alijgzfZq2SjBp7zrIbMbq7drDtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791031387; c=relaxed/simple;
	bh=H4I5nvKjgXUix9M58KBb6gNKwEf1DF9zOhFhla9DTMY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uz3W55tsc2IsUmc5TdFMa1d9EYJx7NWFuJjq13FDZ0w3MO3jxwrkiI5cjNI3X7siuFngznuGB2Q52rTq9cujtgO1bfMnw8+1Hs5z/BmKeJkDRBX9Sr6RPOI582lDZB4m7TsSnA+HYkfzjHLyot0dk6pcQFngH1/Bo5rO08g8/L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.227.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs2-f12.google.com with SMTP id 71dfb90a1353d-5c67e529da9so100162e0c.2
        for <linux-sh@vger.kernel.org>; Sat, 03 Oct 2026 05:43:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791031380; x=1791636180;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rd3NWbdX+3ZLAQ53roUb71tmzpnlllnH0Ay1BTCnKio=;
        b=dYzO/NG0P/cbkgPIQe28zZvadzw2cAHvM3eTfu/NgRRbTUmjCzzrRQKB3h5xqprkP5
         gaNcsEHajXe23zoK+BTHTBTpncgKGzNSvm/zdmaXcxZcqxqq8GaOvmOv0nE5rj+f5GU9
         kNFq+lNQuSZ0UIORnBlgbb9+kx2LGUHDekpoYnVkT7g5SMdxbu7Nxbo+eg6w869qluS0
         pzRwUzprLzQYMk1gNi8xoWq5QF/vLrQ4oqYKOvkFk1YfiYaqYHXOXaPEueED6fdjgJGw
         wfMlPszJtMh/Vi0vE/hKYNZk+fOrMwwnJ/U7d8LFfpG+yd3kXYa3gtoL//S391345kZw
         Q6lA==
X-Forwarded-Encrypted: i=1; AKwUvBzq2bO8BhArxFaFyZPc0e3V3RE75ylAXzaZFOV5gD16r4VwQkLIEQUGKkGmGSfQuW7bSqPmnfwTkA==@vger.kernel.org
X-Gm-Message-State: AFq9FYLSHHhwyBr/aOvIgsYgNbR9BVSl3u9W2/F0rFsEsAarB47KKqui
	hogCvOdClVRhiYq8DqnuDZOCHQ4K/ttNzqs7Pf7mXgmKYN1qyERELASXwgAhrCyFbBA=
X-Gm-Gg: AYBFou2FWV2KuC7FijtDvYI7HHkK1zEbUt5dDuK3E0WMBTV7ZOubjmQCtXVTTSAvOfU
	/d8CzTbM21RpP5XC343h8+ZQ4oY3lv6qCVsImurHP1b5WtSRxlUNg7Bf5oSYfFlKkrstha6CzPH
	xjRwjWnfgaW6j/lboeZWgiCGWsmrSJurTN0Q7gd5Axue1gSD3SA+MsOPh8hV4gKjO2r36/ZWSSF
	0kWLg8ok/Xhv92eEET3dXX92/9U/etPX0prDK7uzZr7zpuWGF1BGIZiKvn4fh3UF62RgsE2zOE4
	RZAiTdBPS0zZtOwaxkosh2AcI4pOlKHjwSXU/olYP07yXupJRGKyq7RQheV03JowrUbfAwW31rN
	1Ar7t93DOUFvrKKg7M0Z9gSxifS6BN1fCRtEf0uaCmg5FygqV1Ass/HEvJhGA07bCM6WfVVC0KQ
	QXyX+6f6bpGopLOU6ngXwo1GpLg3ylcLL9t7weJi/0xSipZyPpeWct3R+b1zaxQThZ8/rOqb7o8
	79nYZnH9ez1rP0jGFQekQt67W8ovjJgRkzvC0ofCdxX2/lBKw==
X-Received: by 2002:a05:6122:4d02:b0:5c6:81c2:5496 with SMTP id 71dfb90a1353d-5daafc58f40mr1544128e0c.4.1791031380041;
        Sat, 03 Oct 2026 05:43:00 -0700 (PDT)
Received: from mail-ua2-f41.google.com (mail-ua2-f41.google.com. [74.125.226.233])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5da61f8fe4bsm7035201e0c.8.2026.10.03.05.42.59
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Oct 2026 05:42:59 -0700 (PDT)
Received: by mail-ua2-f41.google.com with SMTP id a1e0cc1a2514c-98c54a0acdbso35644241.1
        for <linux-sh@vger.kernel.org>; Sat, 03 Oct 2026 05:42:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwVpZ0SdfEt0uUmSfpsSBRPhkV4RpO+/fHtbU8WosEzi9Z8EnVly7wEXv58+eFBLW5y5gk/x/4D9g==@vger.kernel.org
X-Received: by 2002:a05:6102:4189:b0:7c3:3c75:db89 with SMTP id
 ada2fe7eead31-7c33c76064dmr62144137.25.1791031379330; Sat, 03 Oct 2026
 05:42:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261002213225.27834-1-kmehltretter@gmail.com>
In-Reply-To: <20261002213225.27834-1-kmehltretter@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sat, 3 Oct 2026 14:42:48 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWEYkBra+3G_+-TfT23BAWPxG5o2KHqGRuHcdp8x0Vskg@mail.gmail.com>
X-Gm-Features: AclHuK9ncaDVCxBtGuESNZ4CSuuG_w1P2OqCJXmqUhxZJrmtDAEjoWxMFSEEOIw
Message-ID: <CAMuHMdWEYkBra+3G_+-TfT23BAWPxG5o2KHqGRuHcdp8x0Vskg@mail.gmail.com>
Subject: Re: [PATCH] usb: r8a66597-hcd: fix buffer overflow on odd-length FIFO reads
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, linux-usb@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Karl,

On Fri, 2 Oct 2026 at 23:32, Karl Mehltretter <kmehltretter@gmail.com> wrote:
> For an external R8A66597 (pdata->on_chip is false), the driver accesses
> the FIFO 16 bits at a time. It rounds an odd byte count up to the next
> word and passes that word count to ioread16_rep(), which stores both bytes
> of every word in the caller's buffer. The final word therefore writes one
> byte beyond an odd-length read, past the end of the buffer when the read
> fills it.
>
> This is visible while enumerating a USB device on an SH7785LCR. The USB
> core allocates nine bytes for the configuration descriptor header, and
> the controller driver stores ten bytes in it. SLUB reports the first
> redzone byte changing from 0xcc to 0x09 in usb_get_configuration().
> Odd-sized HID report descriptors trigger the same overwrite.
>
> Section 2.8.5 of the R8A66597 datasheet requires software to discard the
> excess byte after a 16-bit FIFO read when DTLN is odd. Read the trailing
> byte through a temporary word and copy only that byte.
>
> Fixes: 5d3043586db4 ("USB: r8a66597-hcd: host controller driver for R8A66597")
> Cc: stable@vger.kernel.org
> Reported-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Link: https://lore.kernel.org/all/3bd32eaf159db61ed1d423e1d52a869b3689c682.camel@physik.fu-berlin.de/
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Thanks for your patch!

> --- a/drivers/usb/host/r8a66597.h
> +++ b/drivers/usb/host/r8a66597.h
> @@ -178,8 +178,15 @@ static inline void r8a66597_read_fifo(struct r8a66597 *r8a66597,
>                                len & 0x03);
>                 }
>         } else {
> -               len = (len + 1) / 2;
> -               ioread16_rep(fifoaddr, buf, len);
> +               count = len / 2;
> +               ioread16_rep(fifoaddr, buf, count);

Or just:

    ioread16_rep(fifoaddr, buf, len / 2);

> +
> +               if (len & 0x00000001) {

"len & 1"?

> +                       u16 tmp;
> +
> +                       ioread16_rep(fifoaddr, &tmp, 1);

Seriously: a *_rep() function for a single iteration?

> +                       memcpy((unsigned char *)buf + count * 2, &tmp, 1);

Likewise, this is a just a single byte.

> +               }

Oh, most of this was based on r8a66597_read_fifo() in
drivers/usb/host/r8a66597.h, which has to handle 1 to 3 extra bytes.

>         }
>  }

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
