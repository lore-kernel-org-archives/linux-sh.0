Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794510501;
	b=PQM5dX3O6doalT4z2TvZNgqm1tJ6IoXAENfCD5Fe73zysDPg1tRTB31lDtYiENP1gf80
	 j0g/c1i2cH66k+3TsljYslpR/n71jDY5epFs+vrVYSCQtVRn5/OqIsAw/rmXWh6nyWlK1
	 OlbThuFo/z/Z3XWE7XebIanoGvp6m0AQZLPrn36lngQleABVzW92ID0elk2JLtaTxOpeS
	 8Gw4UtdrltS2Z8q32cjY/GDtm9fSJ/+Zt/69L3x6NfLfx4rLCNzkJoKwhu0zIEdHmzZp1
	 JvoEnbN2wHmHgqKmPYuHDDsqt/lu/skS9WQyPXqJgEPq4PfJh4Gl29p2WSrxrW4a1Hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794510501;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=x7avfF8CE7MQkedzx8waSCJsEYoj4qczcsv6b4mLDHA=;
	b=a6L9oPMeLUORYrvDaw6Zw7l/E9xuBKWJfmMdp99Jj6NG0rn64u6l2CWxY01sXzHLmHJw
	 60BLWFh6+HZ8UebyRHXC6P/5tNn337Zt6kdUZZG0qR2jXiyKDPqIt27xiaPcoUQSd/ogu
	 YH1JwTfdmCrmPaA4qOauiHohYOCK1l+h4zrtwvDFS7pWysTKgGaAQTh/f8ZOMkhd3OaMp
	 dGBpZiwmTRLnyzJk4rxrLzyxKECcfFUmG1f++W6oCXiNpk+hzHJLyO71MoPKlZnrqEV9Y
	 OHwoWgsg0cXJIoS8zNNiJ4HCfoo/wfyam62LWmT2ozASe3QUNooKy5Y+w1vjkeigOTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.217.53
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86F9606A32D
	for <linux-sh@vger.kernel.org>; Thu, 12 Nov 2026 19:08:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B86F9606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-7cc53938a8fso59194137.2
        for <linux-sh@vger.kernel.org>; Thu, 12 Nov 2026 11:08:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794510500; x=1795115300;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=x7avfF8CE7MQkedzx8waSCJsEYoj4qczcsv6b4mLDHA=;
        b=qE1FXhECExUKNwCBwBlUe4yLW7Gb5DbXyoWtBahYDlqcX9h8OdHM1/iq68Nkn+bjBq
         1habkSVrL6+l8VVQRekJl7fea6uDk0mgx616tf9aMPUlkdgBXqdE8FIKrrU29e0SAFNB
         5u41UbDTGfVbuLjW0wQ8bOdjiqAP9J1vFPdae5cxuFgASI36WjP6vI3pEP450D/Zn+2s
         OpIdnAjLv1KXdSRjECe8eheZGsTnFl9eWrYOhAzMZl7JgYK/9AO2YK1mBiIkhB02Y+BM
         HfnaSIWoxbc4fX2sAdgc8kd8PJG/x/mC6RaSEvDhXyQys2UYaTVJooMUQLWbu1M9nPU8
         GFzQ==
X-Forwarded-Encrypted: i=1; AL+hErF4FD1/16KeBHLWZEwHdx3tqqDtX3w6C942ORUALLnhbkL7HSkVTuM6M9NZjUJV4sQZB38DFAI9VQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z/f92s7L1mJOUNyO3inAS/sfpOBlE9SRoLKKgt46guCnlEQc6sA
	XJI4hNdHUocKgKOp9q6VWV8QBxCLu5Rwg2Zt0TifZrvH4uAm5xCiZjVEOe1GqTME5lU=
X-Gm-Gg: AYBFou06VZoalIGg8kIFjiL2swLUr8VM8IrUdQOXACLZhg5Zt1rVlPObONFq9lgCxv6
	H8vm3dIWJ3vj8PET4a6R2jTM7KA+icDx96bNfxg2JGoNxJIv6u6cuMfOzH4Znp1FJvkAChM2BzW
	tm7k+N/yPcb2RM9nSdSAbBY2dLboZbA2DB706Sju/edmrhOc/bOzqDIQT1MWn0LL1wzlXrqnxdI
	T3FYjBQembiuItf77pestMMSmkE54QY9wI+jXpfqObU7j7rTOz40udT1c9hxJX9GcKVKtTO4gZv
	DwEk7V5P6+QtcM6Ka7k8wYlrVYtVZlUaRAxu4/Rjg3m6MeNuvBU188OzNXVCihJm/1F+eut39eG
	SbDnOPxWa97JW8fzZFlDLtHTFqvGaNPb34S2HwGjKYz3aVnqePx5CFCD99sR8H13VcWcL0eXLob
	Lcwxfc9f3CNmkIGLap/PKuaAa4j4js+lkZvAhKMJjREu/evViszMajWZ07iY7rSGRW5vAUTr02g
	UqJVuVKDarfbivBXdSqFtuQd3OyTzEChEHYHJxONLPxQehh4yY7yzccesobpUjVmrtByI0LUJt3
	BWmgHvrWVvjP8SaoOhzN1x5bS9VP436miXOWQ6a4A0bjP9vUDb1L8VIytJ7nR2/TLLI=
X-Received: by 2002:a05:6102:2d03:b0:7c3:f36:c7b with SMTP id ada2fe7eead31-7d64d769e5dmr72392137.14.1794510499695;
        Thu, 12 Nov 2026 11:08:19 -0800 (PST)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99c8425d142sm234115241.5.2026.11.12.11.08.02
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 11:08:07 -0800 (PST)
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-998749fe872so137571241.0
        for <linux-sh@vger.kernel.org>; Thu, 12 Nov 2026 11:08:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFz9jBvKzupTKgmnzBqyqrOLsTjZxQ6KdwnoET7DZpMM4Y7M+czm0OLfptjH2gicgSPaB9BhhmIcA==@vger.kernel.org
X-Received: by 2002:a05:6102:c15:b0:7d2:8dd0:2eb with SMTP id
 ada2fe7eead31-7d64d6ed886mr73919137.8.1794510481935; Thu, 12 Nov 2026
 11:08:01 -0800 (PST)
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Post: <mailto:linux-sh@vger.kernel.org>
List-Help: <mailto:linux-sh+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sh+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112-work-procfs-oldmem-v1-0-ecdcafd99265@kernel.org> <20261112-work-procfs-oldmem-v1-2-ecdcafd99265@kernel.org>
In-Reply-To: <20261112-work-procfs-oldmem-v1-2-ecdcafd99265@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 12 Nov 2026 20:07:50 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUgOGjwOUMxSabUgtaVeKZW1wx78XOJL8joGKkZEj7RZw@mail.gmail.com>
X-Gm-Features: AclHuK8l5OcVstuPYNpoHJ657hIuMQK5i9ySH9sE9lHb16H-lVuh0fnzCqi0JCs
Message-ID: <CAMuHMdUgOGjwOUMxSabUgtaVeKZW1wx78XOJL8joGKkZEj7RZw@mail.gmail.com>
Subject: Re: [PATCH RFC 2/4] sh/crash_dump: check ioremap() in copy_oldmem_page()
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Breno Leitao <leitao@debian.org>, 
	Chris Mason <mason@kernel.org>, Thomas Gleixner <tglx@kernel.org>, x86@kernel.org, 
	kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
	linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Hildenbrand <david@kernel.org>, stable@vger.kernel.org, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"

On Thu, 12 Nov 2026 at 17:43, Christian Brauner <brauner@kernel.org> wrote:
> copy_oldmem_page() maps a page of the old kernel with ioremap() and
> copies from it without checking whether the mapping worked. If it
> didn't, the copy reads from an offset into the NULL page.
>
> Return -ENOMEM like the other architectures do. read_from_oldmem() turns
> that into -EFAULT like any other short copy.
>
> Fixes: 4d5ade5b29c6 ("sh: kdump support.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
