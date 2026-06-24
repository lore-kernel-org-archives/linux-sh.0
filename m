Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172513242B2
	for <linux-sh@vger.kernel.org>; Wed, 24 Jun 2026 18:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782324997; cv=none; b=GqBgbsDXWHB6N8Pei+2XBoEvPiNXhZoDudVWCJnMzQ/3PCAes2VuXozm1V24ya0hc65OvixReqYF+poe2NDey2zym+qORZR6ouWFOqVaruFCTAA7UPggzrgyNmXxHEkEAJUSEfrJsFwrpCEnBPlKSLaWSDeiqyNp88X/qbdMOrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782324997; c=relaxed/simple;
	bh=si2MsK86RKsAVxCGmSGxaqdFuqqha87EfQYHc/flpzc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EXW7RWxm2+ch69+vqGZOwqJVAlJwmXOSfZbzwqXBg3COKnvs++NpravMoW+h0ffz6oE9FU1p9ub7+WkxKfSzdvs1pyIxe3wqy9F74e4TOaQxrPcAR/viN7+RfrNJtVIH0uo1dWt1EeWwb3fu2e+cHABGuhOw1uvgZQAFzV9BxrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-96757a30368so233285241.3
        for <linux-sh@vger.kernel.org>; Wed, 24 Jun 2026 11:16:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782324995; x=1782929795;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OxSrwJpDjC3/fB6S9qNc2EAdtDOl/HY8Vjw/qQYpH8k=;
        b=WebVAgnoYQ5j4uIMqeM33Bl1COHyZF5B7EPleMl68xLAMpZcsji7DcNlFMJaBC2WcY
         J+eJ70+CTFUA2dgGoaEpfoekJxxdy9UBSwtctfYtjwjFwDjF/Qy1Vk1MqhesJx4FUa9U
         imV7o6CcEgOHJZ2pKAaPj1B1rPLrKA7zdduKWVX084r4u1AoB3oUVeQ19ZD6bUb24r9A
         Nx/PPpkp60jQFsOBHsAlMLV0wzBFdbwAy8SCJK2oylKCtZmduxV4dx/Lv0gCYU1hwjO9
         eD8M6/13DC4cfgn7lsKMBP3jAeX51ZLp1uZO3MnORSKGPUuI8InZcrS2nx9p76Jz3llM
         /T7g==
X-Forwarded-Encrypted: i=1; AHgh+RrCeuM/RJKyeGIGnMDrJFRs3MkyIa19FP4FtKCd/H2F6LqhWgXmtCIehIpQXclBBSLQVy6anYU0rw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwG6HTXQ9Co2Cezv6siK22TpLyig+SFJz79gj1I7lrWu7HmkOkp
	RgAfcvBXo5SQ/BGbIa5fzUF54U6P00CKx6++K6eTX9R1KrYnl5HZKQcfz8oVkkIt
X-Gm-Gg: AfdE7ckocuWDN/XUGnKquvtobLZlVybz7rLGXr9cq3VPOMmq/yiEsjuPFoyczCwtmUJ
	nvAY7mZdHa1R0m2iel9KXHCqIpD6hjpUDYSYrVyW9PiPY/2cNw+HH5+Q6v8HSQnyimLqWWuSPnm
	tvKqMQ2PrEa4XLklrSYdO5x6brM4vWNMC24Db4kkaCQN2Qailgx27qpcV/cgjYoYqo8hvXpCjag
	ccwdn2ZogYGA5t9mnbh6sZtub74kfwJww/MDrrJfspbaxRqKQ/T5U+i7B7ep+T1v39UDOefMJQ+
	QJ+WTAjUJDH9kiHQ1ENB4njZ5EKM07aX7fBs/e9IyVglrMiiIa7hjwOOedfIhxk+qDC9er53S+r
	dw8oHJOwYW5ucKREAbJTVAp5sYmP5JmfMEppQ5AIFJ9tiTUbw8Hd8fXWEc9wVZ+RCmfd0N6bOTJ
	IPqERAalyKM+n6PwOb+rvMA3WHnCmyWVf1Hradfs18dHixNtAvIa79HAp1S2oI
X-Received: by 2002:a05:6102:4bce:b0:6cc:f252:6929 with SMTP id ada2fe7eead31-73114d070d4mr2714239137.16.1782324990051;
        Wed, 24 Jun 2026 11:16:30 -0700 (PDT)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com. [209.85.217.54])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-730e0090ef7sm1881104137.1.2026.06.24.11.16.29
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2026 11:16:29 -0700 (PDT)
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-730ac3bec38so492895137.2
        for <linux-sh@vger.kernel.org>; Wed, 24 Jun 2026 11:16:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rox7A7TcR06msnsJPaDsBrb0wqT3YwAtfjFhJg9EPc3Yie5TmvkptEDIz/e80oODuVvJSuEEp+jUw==@vger.kernel.org
X-Received: by 2002:a05:6102:290e:b0:650:94b2:3839 with SMTP id
 ada2fe7eead31-731133d26e1mr2822267137.7.1782324988834; Wed, 24 Jun 2026
 11:16:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260624081926.12426-1-pengpeng@iscas.ac.cn>
In-Reply-To: <20260624081926.12426-1-pengpeng@iscas.ac.cn>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 24 Jun 2026 20:16:16 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVkL629ps2mmD3XRXM-BYWXZ-6GQGM7tKf6vEvhK--LBg@mail.gmail.com>
X-Gm-Features: AVVi8Cf3W_4FbqpF_JVxZghC61csTLgIbd27NjlVAgMvdm19aiC1higi1zSH8ts
Message-ID: <CAMuHMdVkL629ps2mmD3XRXM-BYWXZ-6GQGM7tKf6vEvhK--LBg@mail.gmail.com>
Subject: Re: [PATCH] sh: Use generic OHCI platform provider symbol
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, linux-sh@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Jun 2026 at 19:56, Pengpeng Hou <pengpeng@iscas.ac.cn> wrote:
> The old SuperH-specific `USB_OHCI_SH` provider symbol no longer carries
> an OHCI provider object.  The current platform OHCI provider is
> `USB_OHCI_HCD_PLATFORM`, which builds ohci-platform.o.
>
> Several SH CPU subtypes still select `USB_OHCI_SH`, and the
> sh7757lcr defconfig still enables it directly.  Switch both the subtype
> selects and the defconfig to `USB_OHCI_HCD_PLATFORM` so the intended OHCI
> provider remains reachable when `USB_OHCI_HCD` is enabled.
>
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>

Fixes: 4f6dfc2136fb2e8d ("usb: remove the dead USB_OHCI_SH option")
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

It's a pity people sometimes don't take into account review comments
before applying patches...
https://lore.kernel.org/CAMuHMdVM3BpvVD3c4gp1OidnwF5zFd4MJecij7zWBnahzNaSNw@mail.gmail.com/

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
