Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6243D4AB1D3
	for <linux-sh@vger.kernel.org>; Mon, 12 Oct 2026 16:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791822176; cv=none; b=pp8e14V3hYJwS1sIJTyI18JY3XufgzxF3aMQaCX3ssUBsk+3iH6RuZo6jUiNd1kmgRRz0ld3tJf5p3jZedHriKdAIKZ8Y/LlU+xtIGmsW1snpnUjN9h+B+JJeXdU/sl1ixKYP2u7oRUm70qRZvg03ULoGRc7l2cRZeIX8jqKPfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791822176; c=relaxed/simple;
	bh=na/SWdzUd8e3s7Zx9+08OULjEoTlvLyyETaBrZgmPlw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CfbRl2xV15g5b+qltDu1wmIDzIGn7bM0t2lmrDoP+2B5k37hg4UQktAv+m1PBY9yNQZuQqiYEhZ4ybXTUlRxm6dyfwHo9OXMsJChxP5lZ/Rx+naaTCI24Kjn/1joAc0GkuVZ0iDvF9YnHpNo8HdsKTZinvsiBMidQ/3AZc5Ho7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-5e9488480cfso424327e0c.0
        for <linux-sh@vger.kernel.org>; Mon, 12 Oct 2026 09:22:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791822173; x=1792426973;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=X5FLZdPf6RJVfwLd6QiWyg9HD5zORQA0u10QEMu3ZgY=;
        b=rhOtpyJAGEk8vMAevw3BwpCmkOrgZT10bOdhvRyTAk6awhxrfNlkfS8u3+qYgvZjck
         fnSlbnEcjCxnDT5iKLM9qvGXiHecCp4J45MVKiEsfcfdYwPrRMAM7zkHQTbMuPu6dFoV
         9w9F269Yknp0AqzPPsNXACLY0cYsqtgKee7GIJa6kcHncc/J0U+ZHowXVLw2YDhIfWg5
         yI8nNa9aV+ahUyPgfWQ9SuUuGiRJsB5yzMqbAt5P8TygtTZiK8k4PZPFbWYLjvf/XXn0
         C1GwR04zSFJksn9N8TArFkTD9jdncDcyixv97CTOLzznm3HGUsuykE3C68Vpvp1G+XJ9
         XSNw==
X-Forwarded-Encrypted: i=1; AKwUvBzEW83rDxtveLC4Rs+63E7Bc8e4Qy0GUwP/8xjAMWyeThuW8zvD9linBhuOuxWB65RFlIg9amxozw==@vger.kernel.org
X-Gm-Message-State: AFq9FYI1uFAdSmaHPYxxMgqfHOYuBARp/vOVB1jplG04SCztL/N6DD09
	/b6ILI1H+tI8pXvltPl9leNgfvp1c3TzrXi+4hJH7yw9eNrLAEmoZZFVtLfqX1w8
X-Gm-Gg: AYBFou3eM3m7iK7/ziAd2tZ/EsOKCTJWyC2pzcMJ5dhdX9Gqu7ZDckoH54iQrzXjRNf
	26LKKqiJDzaUfK9Ixa144l36xNwkTLpAq8/9g2kERbfIPvfkR+llPVAF1wEvXpwDbsTPEMlB1Nc
	02EH/LDxy8r2t187FbEf6nWiNKqOSy/AuLpUr0GcRakpGNHyA8dcRx+RuAItY/EbgLanlIlbuNM
	kjRbWE+ZXc4O9BAHNYTXROrq2LDEJ1AY3V6WPtkmQBVbJbsk6UliQIIr/luG/Ed6kC1/D3sRio1
	HveEkJLt9Ir2yjkmfyoDbR+xyIIPhxrv1rkc5dVYz5U1/AKIqFx8hjwcOzWdnFSwsjlBjiIhJoS
	KgKdWU1OqN7iFtPHDHq4rh7Q6Lgicytrji4HJ7iDK1rfYjLtzKS3314BkeDdJy9/EaZguzmTQEZ
	geWdG6W4Vch7QLu2w2pncB73umViTbYfN2qNXYRlMNBNkqNAZGwmK5s66I+WSmSDX+GsjO+OsvP
	RY4XRm2uF0OGRfrNNBKnSi+yK0wwwYKYcG0
X-Received: by 2002:a05:6102:508d:b0:7a7:196a:84e7 with SMTP id ada2fe7eead31-7cb373cc827mr2358090137.31.1791822173236;
        Mon, 12 Oct 2026 09:22:53 -0700 (PDT)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com. [209.85.222.48])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7cb39d6396asm6711967137.1.2026.10.12.09.22.52
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2026 09:22:52 -0700 (PDT)
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-98c7353395fso443347241.3
        for <linux-sh@vger.kernel.org>; Mon, 12 Oct 2026 09:22:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByIaLb2BQqEVK0Li1HXnJehjFqwPtkyyyWZjSiay8FUaRKiQPWo6hvvAXoHVaMuKyhpSL5X06nA7A==@vger.kernel.org
X-Received: by 2002:a67:e706:0:b0:79c:99ea:2c9a with SMTP id
 ada2fe7eead31-7cb37255716mr2460381137.11.1791822172375; Mon, 12 Oct 2026
 09:22:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261005212823.55737-1-kmehltretter@gmail.com>
In-Reply-To: <20261005212823.55737-1-kmehltretter@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 12 Oct 2026 18:22:41 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXr+2=wvRQyXMj6LoyevvZ1wSWGsgMzbajj0OGqJRnLsg@mail.gmail.com>
X-Gm-Features: AclHuK91kK71gtIrwgy9MEJ3x0a9HocKnRnE0a0NaQiVQriI1uAFOcMNBTCeXz0
Message-ID: <CAMuHMdXr+2=wvRQyXMj6LoyevvZ1wSWGsgMzbajj0OGqJRnLsg@mail.gmail.com>
Subject: Re: [PATCH v2] usb: r8a66597-hcd: fix buffer overflow on odd-length
 FIFO reads
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, linux-usb@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 5 Oct 2026 at 23:28, Karl Mehltretter <kmehltretter@gmail.com> wrote:
> An external R8A66597 (pdata->on_chip is not set) is read through a 16-bit
> FIFO port. r8a66597_read_fifo() rounds the byte count up to whole words
> and passes that word count to ioread16_rep(), which stores two bytes for
> every word. For an odd byte count the last word puts one byte more into
> the buffer than packet_read() asked for. When the data ends at the end of
> the URB's transfer buffer, that byte is written behind the buffer.
>
> Enumerating a device is enough to trigger it. The USB core reads the
> configuration descriptor header into a 9-byte kmalloc() buffer and the
> driver stores 10 bytes. An SH7785LCR board booted with slub_debug=FZPU
> reports:
>
>   [kmalloc Redzone overwritten] 0x820c4229-0x820c4229 @offset=553. First byte 0x9 instead of 0xcc
>   BUG kmalloc-32 (Not tainted): Object corrupt
>   Allocated in usb_get_configuration+0x12c/0x11d8 age=51 cpu=0 pid=10
>   Object   820c4220: 09 02 20 00 01 01 00 80 fa 09 cc cc cc cc cc cc
>
> Odd-sized HID report descriptors are overrun in the same way. Without
> slab debugging the byte ends up in the unused tail of a kmalloc() object.
> A transfer buffer that is embedded in a larger object has the byte after
> it overwritten.
>
> Section 2.8.5 of the R8A66597 datasheet tells software to discard the
> excess byte of the last 16-bit FIFO read when DTLN is odd. Read only the
> whole words into the buffer. Read the last word into a temporary and
> store only its first byte. Use ioread16_rep() for that word as well, so
> that the byte is taken in the same byte order as the words before it.
>
> Fixes: 5d3043586db4 ("USB: r8a66597-hcd: host controller driver for R8A66597")
> Cc: stable@vger.kernel.org
> Reported-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Closes: https://lore.kernel.org/linux-sh/3bd32eaf159db61ed1d423e1d52a869b3689c682.camel@physik.fu-berlin.de/
> Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
>
> v2:
> - Simplify the handling of the last byte as suggested by Geert: no count
>   variable, len & 1, and a plain byte store instead of a 1-byte memcpy().
> - Reword the commit message and add the SLUB report from Adrian's board.
> - Add Adrian's Tested-by. It was given for v1. The FIFO accesses are the
>   same in v2, only the copy of the last byte changed.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
