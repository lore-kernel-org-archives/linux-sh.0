Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792739756;
	b=YNi2OJcmMbuG3MK0BHbWYRUOJ3L5uwcchjv/DpZzY9nDdhh8e+yrEhZEfs2C0WdCZkpw
	 YgSc+QeQqB1V6Qsgp6mGGsiD1rgr51b+vvM5ni5x4HYUafNIKcAD9+f2xRFPHsF/ARZ6l
	 eIHwZFA4bf/tBoQzUHNnef0M69F42SOLI4Ny8bskOJmEoUeFppyTnfhFl/mcIs/V7VQZs
	 NkVJ3Hu1728XmqJmcFZ9qJVME497atGmpEWELMt3vfjzwPsjl1VAX2QxuYd28iogRkBx7
	 5NbIZXlTzMknMvyKBFgHcel0Nh7zRduqMfOyLQ/PtnOpZtXohJ85pN++rRliPEXhDFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792739756;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=ZwAW7Da56DRhrTemOd2l4KjznnRsg70oBngmY04ZvYQ=;
	b=pneXdjFPP7AoeYhVGIKnrPJbZtI2f6JICSPxFL7nSNi5WrvzByalfpLSl5Su/DNcGSw1
	 LAPEFABhB2TwpL/PnuBEHB6J6Dqo/Hi9LmQGUzePZF9Jiq5Z5iyQwNk1i4NPJ9XyK/RrA
	 pyM9AZxLltbuJnnL/5AMiyTVhgz7WInQwmD6oFKT+VMgkpDoM2UFqm3fAD8TSMRiSuS1V
	 IaLZMSs2uo2JBKlMkn37WpCf2vH52bSCJqghuuYzI1EfpmP+dWJCoa+zwogDqXbCG5dA4
	 SAZO6uwL3XTa2Y15EPU7x1Z4Kko87cP4rgnCYjA4AT3YjyU2T6ichmOZ7p77K53EZAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.221.179
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360DF606A31A
	for <linux-sh@vger.kernel.org>; Fri, 23 Oct 2026 07:15:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 360DF606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5eafb65e169so467686e0c.1
        for <linux-sh@vger.kernel.org>; Fri, 23 Oct 2026 00:15:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792739755; x=1793344555;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZwAW7Da56DRhrTemOd2l4KjznnRsg70oBngmY04ZvYQ=;
        b=WRAZjhUGC4inp73Of41meAeUUrCJ/Pi8OoJaQrelWHuKD4Qx/W0TTKHE2bSOK5Gklr
         XugR9fEvuC32rdeK3Vx/2GzwIVUiMV3JP0lV/t19UJ91+CUZIhyNm/aiF5asXKH9rI4z
         okqhxACtqxocdwDQfZndMh6HIOiOk7RijcVpZrIFkWKtOsvsug306A0v1eBt6Z4aaVAh
         tmJpygvWBnGjwXI4+9yGGqKZu6lEuNbA1CAp3OKWxjgfvule+R2SqEa0zpuUPD20r5Z/
         NgtebgjjOeWRvQe/Le7p3lEMtQwNIVuZtTrCKpTy41a+sNudYRTwP+HHttl64H35A9DN
         QKqw==
X-Forwarded-Encrypted: i=1; AKwUvBy9ew5KslQniDjFBNWWMiQThMaCL7HHE/8Q66PkBORfST40NH6P5G2nRY2pqUPzAHWRqPvHtH1qYQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYIMiBemMPKpo8BhLQ7TPi9Ms9HYTBarlwKodp7GGd0yiscUXEJE
	1ci0vC/+yC/XwKGwRxXmZLBYY2m6wMWDApYabA1eVxTD2+XrxwL2bqQwkjiuRdTCiuQ=
X-Gm-Gg: AYBFou3X/6YH0BGrSjT/HZoakt0fP9+1fi6z8vaEizNml5eGoBtqbetMExLe1p65Tol
	RfKKxI3bhH2c4AVZEl121LQTO6cYpT9i7FJ/AOPwMavET/C3bbbaA+AltuXsw6j7ZiEIB6S9vcQ
	ytzKS9BiBrdNv1/c60Pte6rXNfL6/C3BYBILG8WE+XQkM9U8NBTnNDsYonXpwRV3tp5aToN1UyL
	LWTS1Bg78IKDrGfoE+bjjo9tJRsqgY7fUKZxoIuyQXEvhtVT6CI7zXcfQbBb1lcDxFHoj2teXvv
	SldkTGkptF45MZYuB9zLtFXUqW+KHwHM05nfrRStVXZoqXDkSuBBcnXoQaWB3/ZvTWEdtCXeOcq
	pMpvHN54BRskpGzyZebpRGEiQR8ghJdeKJOUFTnc2WHjcfd1De3TmWUDUxgAgOEjrA/RnIjjaj6
	/H9FfYqbAuFlk05dt7QNtpuQPC6ficLhkXZR+s46qBPdVhDXKgfqwpobVFu7Ne5rtecfbqfydYr
	JPPijXCuowC2oy73SMpCaAi/R/ecahJ0trzdqJHPxLdoPLAFK6LXY6hu9FjsSyBM+s0xtBsITFo
	pD56bIkgbqA869u3s4duxpDkJz4/NTTHSpa9cNE=
X-Received: by 2002:a05:6122:240a:b0:5ea:aedd:6087 with SMTP id 71dfb90a1353d-5ec14a5a824mr401197e0c.4.1792739755161;
        Fri, 23 Oct 2026 00:15:55 -0700 (PDT)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com. [209.85.217.43])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec13eab957sm1582422e0c.6.2026.10.23.00.15.53
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Oct 2026 00:15:54 -0700 (PDT)
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-7c322cbc998so95719137.3
        for <linux-sh@vger.kernel.org>; Fri, 23 Oct 2026 00:15:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxAPuqcr6BG1D48UoHJT+6G7ly0rHPcQdIiwQbfhutQ2pTEdluQsbasJGkoixKj+H7TJsGa1Yv7yQ==@vger.kernel.org
X-Received: by 2002:a05:6102:570d:b0:7cc:3eb0:6ef5 with SMTP id
 ada2fe7eead31-7ccc31aac14mr607848137.11.1792739753776; Fri, 23 Oct 2026
 00:15:53 -0700 (PDT)
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Post: <mailto:linux-sh@vger.kernel.org>
List-Help: <mailto:linux-sh+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sh+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261022233410.2959823-1-fuchsfl@gmail.com> <04cfcbc2-0021-4ba2-b3bf-0da3cc82d046@app.fastmail.com>
In-Reply-To: <04cfcbc2-0021-4ba2-b3bf-0da3cc82d046@app.fastmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 23 Oct 2026 09:15:42 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVOA2bo2NTz7L=+W_h_eTmXJY7JeuFdKbh-uB3n-23SDQ@mail.gmail.com>
X-Gm-Features: AclHuK-JE0Oy0Krmvte0ZqAh67zqeVG8GqiC5fJJsd3p3KSKuJHCR4RReR7XRO8
Message-ID: <CAMuHMdVOA2bo2NTz7L=+W_h_eTmXJY7JeuFdKbh-uB3n-23SDQ@mail.gmail.com>
Subject: Re: [PATCH] sh: traps: Fix kernel unaligned access fixup in branch
 delay slots
To: Arnd Bergmann <arnd@arndb.de>
Cc: Florian Fuchs <fuchsfl@gmail.com>, linux-sh@vger.kernel.org, 
	Yoshinori Sato <yoshinori.sato@nifty.com>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Arnd,

On Fri, 23 Oct 2026 at 09:09, Arnd Bergmann <arnd@arndb.de> wrote:
> On Fri, Oct 23, 2026, at 01:34, Florian Fuchs wrote:
> > Commit 75d4d29549e5 ("sh: remove CONFIG_SET_FS support") converted the
> > callers' set_fs(KERNEL_DS) sections, but missed copy_from_user() in
> > handle_delayslot() which relied on the caller's address limit. This also
> > broke delay slot instruction fetching through handle_trapped_io().
> >
> > Since the removal of set_fs(), access_ok() rejects kernel addresses, so
> > the fetch always fails for kernel code and the kernel dies with:
> >
> >   delay-slot-insn faulting in handle_unaligned_delayslot: 0000 [#1]
> >
> > The initial instruction fetch in do_address_error() already uses
> > copy_from_kernel_nofault() for kernel mode. So choose the matching
> > instruction-fetch accessor from user_mode(regs) and fetch the
> > instruction.
> >
> > Fixes: 75d4d29549e5 ("sh: remove CONFIG_SET_FS support")
> > Signed-off-by: Florian Fuchs <fuchsfl@gmail.com>
>
> Hi Florian,
>
> The patch looks correct to me, but I find it a little confusing:
>
> > @@ -287,8 +287,10 @@ static inline int handle_delayslot(struct pt_regs *regs,
> >       insn_size_t instruction;
> >       void __user *addr = (void __user *)(regs->pc +
> >               instruction_size(old_instruction));
> > +     struct mem_access *insn_ma = user_mode(regs) ?
> > +             &user_mem_access : &kernel_mem_access;
> >
> > -     if (copy_from_user(&instruction, addr, sizeof(instruction))) {
> > +     if (insn_ma->from(&instruction, addr, sizeof(instruction))) {
> >               /* the instruction-fetch faulted */
> >               if (user_mode(regs))
> >                       return -EFAULT;
>
> The "insn_ma" pointer is always the same as the 'ma' argument
> you already pass, as both are set based on 'user_mode(regs)'.
> Why not just use the pointer you already have?

That would also handle handle_trapped_io(), which passes
&trapped_io_access, right?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
