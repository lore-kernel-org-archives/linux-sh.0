Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9CD1AF0BA;
	Thu, 30 Jan 2025 09:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738228411; cv=none; b=LMm95mJB2GcAEC2ZBBFy77u1wSt9N/Xh0xgGQ/OnjzPvyVDRmBnfM0NC2sTpFYXICIPQsusfkSORr5hmoi6eQWBJ8yynsnNnNXoMBG5o+sIeTdDO4BMIbt2Wkhi4L8w42sMW+CDHZXPV1zrlDJlToYXWzuMoNjYCE68sjg+jwaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738228411; c=relaxed/simple;
	bh=BBARpdzmAXyEeRvtw3C32ceJAqofdF05qBhZZsi06XM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o2psRkvvlw9hGTQZ2R25BtkN+f39UY03b3UFx8NLzff2pqF5FwTlbcS0SJ4FLDtLPVT1PTCtmvsjb9I4Hu0X+nq3EAa4EeZGG3GX7PLh+l6M6R5o7Zu0hE38dt6jnJurv/PPEhkANs8FZhCwrYNT2N7I4fGkCzviseIe1rWhOV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-85bad7be09dso359193241.0;
        Thu, 30 Jan 2025 01:13:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738228407; x=1738833207;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ivcQsIRpSjOUdBVXE1lKwsSXj69LtT3pmJiNgTzYFCo=;
        b=PRkEtWOqfDTJl6RtKDndaPU9E1DqWgkZ8n0C3j34DE2/ZCRSS3OTO+qbDgNIz9mO4p
         Apyog2ctupAe29grHnRG2rjvO4AZwWlm4bHUPOR2Vf0nt7B2wfKoKyCwRJIxXZ0cecP2
         gkujqy4eDRH0BfJHAuMSSlRy3F2ftLYOHHSKIymXcgq/z+8hq/qEGskq8lxt0byZjkyy
         78om24ZvaliEziZf/yF8lQlmYrvesfzMY5ri8Z0BnuSQFlx2hHlbfsS+G6LbsPlgIqlg
         OKZlTbxzMD5tudvm1rihyXP9dq7JrSflSKuKWxuj/nVU/IC6kSFBTHIfSy8RaLW9CAeg
         4+9A==
X-Forwarded-Encrypted: i=1; AJvYcCU8PQk/U2S3wdXbfGg+7r/S8N9AKVkOP7Jj0Oel/qQrk3nZ8Q/SquGv4na4qyQaQwi4811/slCx4H/pacI=@vger.kernel.org, AJvYcCXLTamHaY//DCN4yc75/Uysv3QW+EXcbIPZo7OTCbtKMP8W4vqw4DeWldGk/qHmFOw/ZSNAY78Tf6g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+ARsf4hxz7pMx1D3W4pxN/LtCKeAgjkCrsW4FvlB70QNpTCCq
	AU+UVo+5beCOZaN1hG7AFTal3rRkXoG2XdgdA8nLfzIfC3DqWKgRNMCYBBWW
X-Gm-Gg: ASbGncsDebVGUSbGEBLbOSRdWvpK5QOKy9w8dW07y46ClO39qZhY3UShoW8drN+9R9n
	+lYOeVohkOTf2kNQrI7ga0wzOFPe6IottbYcVgw6VAEHv+VHkIWQONxI/mOfREqh1FhlQ2F6dO1
	S6N/NKj3rKXkcaMiNA5oOWy5wfFRqEIL6Zt9C8PKOvz2gxlm/jRI2+OTWiedlo/y7DTXzPEyWmj
	ToH8Ast0izFdtUhj88YhxXxtA9kyPztzz6EktkRVc8rbXXU2PvGbhRZLZSULu2AMq8cpGnyAIBw
	s5/yytdIvk+M8oUraAQF38pn+hfUESpzUMwQHK/xeJIMc/OaUsvl+A==
X-Google-Smtp-Source: AGHT+IHWYrtb9MzgRvC+3DyFrbEtDSxIv64nVppuBy5DqwDjMF7LHsqK3RTqJNHBxeZngwrtCCO1iQ==
X-Received: by 2002:a05:6122:3288:b0:518:8e53:818b with SMTP id 71dfb90a1353d-51e9e27f945mr5236408e0c.0.1738228407353;
        Thu, 30 Jan 2025 01:13:27 -0800 (PST)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-51eb1c12174sm143770e0c.16.2025.01.30.01.13.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jan 2025 01:13:26 -0800 (PST)
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-4affbc4dc74so417627137.0;
        Thu, 30 Jan 2025 01:13:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVG0oktqishK4WJnPJrt56lJQYIBqNbWSwkQMhM0PQ7UafretiNwKfRu/2HJRhzXQb7Oxngw9GEO5QJS80=@vger.kernel.org, AJvYcCWXuW4B2WIh62R5bePdKVKKHxx03lUcv+IxWXgbFU4pZRGulU5VA+D8fsJ1Q+lhJaGYsLBvtGMqj7g=@vger.kernel.org
X-Received: by 2002:a05:6102:fa4:b0:4af:c5c8:bb4c with SMTP id
 ada2fe7eead31-4b9a5272b50mr5724304137.16.1738228406667; Thu, 30 Jan 2025
 01:13:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250128101306.1475491-1-julian@outer-limits.org> <8c4279dd244eed4b1a6ef7e2ea6dafac0b5fc79e.camel@physik.fu-berlin.de>
In-Reply-To: <8c4279dd244eed4b1a6ef7e2ea6dafac0b5fc79e.camel@physik.fu-berlin.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 30 Jan 2025 10:13:14 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXOx2MFDnRm2dxVTE9tFfAud595huEVagnTd8RKp3yQsg@mail.gmail.com>
X-Gm-Features: AWEUYZnquC_eEE8Uvw_FVq9F-XTt0WQ0D-O7i7uM2a8VNjHKtsWlCp0_OM-GXLY
Message-ID: <CAMuHMdXOx2MFDnRm2dxVTE9tFfAud595huEVagnTd8RKp3yQsg@mail.gmail.com>
Subject: Re: [PATCH v2] sh: Remove IO memcpy and memset from sh code
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Julian Vetter <julian@outer-limits.org>, Arnd Bergmann <arnd@arndb.de>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Adrian,

On Thu, 30 Jan 2025 at 09:44, John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> On Tue, 2025-01-28 at 11:13 +0100, Julian Vetter wrote:
> > Remove IO memcpy and memset from sh specific code and fall back to the
> > new implementations from lib/iomem_copy.c. They use word accesses if the
> > buffers are aligned and only fall back to byte accesses for potentially
> > unaligned parts of a buffer.
> >
> > Signed-off-by: Julian Vetter <julian@outer-limits.org>
> > ---
> > Changes for V2:
> > - Removed also SH4 specific memcpy_fromio code

> I'm not sure that I understand the motivation to remove hand-optimized sh4 assembler
> code for memset and drop it in favor of potentially slower generic C code. What is
> the reasoning behind this?

See Arnd's feedback on v1
https://lore.kernel.org/all/ffe019a1-11b4-4ad7-bbe2-8ef3e01ffeb0@app.fastmail.com

> Also, it seems that this patch would make your other patch
>
>         "sh: Remove memset_io from sh specific code"
>
> obsolete.

Yeah, that should have been mentioned under the ---.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
