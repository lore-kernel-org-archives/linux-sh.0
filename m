Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B85718E1D
	for <linux-sh@vger.kernel.org>; Fri,  5 Apr 2024 12:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712319703; cv=none; b=UKq2gRJ06ELYcSTpPi1ovnmTQctlikQjheuet5MOn0u51gzU0Ox1W/uO3HHA/Koa/YA8CTnNgLOw8m8kelQSxNEuK5lfeYIroABHNvuB2fr6UNvUArrhWQSQOY1OoBtGwQjuNMzGv/4SLkbhBFQHhDa8YjqzpHGrdt0fvPvekbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712319703; c=relaxed/simple;
	bh=Bq7o5USuldxgBk0/nu7y+KKeWelhogpyuCIcxVp+8QU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BXqEVjxhEJkvgQ4AfPA2Ekew8v1Yc7YKPgWZ4UKfghVsftAOexC//6aXkp+GEhkyfQgEKTPXVed68a0VryF8uRH/pDqNwEPeuhPkQ8xTFrSn2HDfoNZ28AtrOuPE2IMoJLam1kNKSuY2mookuKCEZOqbw5FN2iJvzOon4VQ8lxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-617dfcf80aeso575887b3.3
        for <linux-sh@vger.kernel.org>; Fri, 05 Apr 2024 05:21:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712319700; x=1712924500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1qkJorPFjt4lvfj6l7hOuCIgouJoo7FbR7pUP8VKifM=;
        b=mpvXAdLiuxkW+n9nlMorLcqVQDHKbgobyF0I4F8ORyCcAZ/fGDnpj71ZUBaIk7iHw0
         1yRQAelQl+DXtAVn2d6NrcU1181bS2rYlck7+JNZMozoMAyi2Bb0v4Lt5vI/0OlAhRwl
         pTgWqWFB7PiGyMll/3X7I5oDsED2AXxwFIdlZx38FZN6yEIfb6smo1l/sIW2/cwvPXW/
         Ub1kEwFY6XEymMsEcPv0zwdZl4XQqyk+c8LiD7CtG5sSVNjMb2MpN2k9PaUBF+5v5qtq
         ZPa0hlEpb3TEMlbgF3a3/gMssPRUb59zUTv363uqiFdyxFHHPR6v3o6Uxkq23fYavfyO
         T+Eg==
X-Forwarded-Encrypted: i=1; AJvYcCUUAEkZwJMoEEU0EfvNk4ieD4WlLP7JLgxI0MB8sGNTs9PDwZEsCrVNPvfojTpdL0/cbQl4wkyg2iP9TZYhaeoRGC3Rfd8QSbc=
X-Gm-Message-State: AOJu0Yzd1qj+FKIrr7NKsbhF4dWtV9Df7e6b9dVaAua63GuK2Z4MxySs
	ZDfPSTaZoEcRr+AX8D5VqvC3GHKJu6phiIRgOMqgh9KZDGtQofZFs240iXC2BeA=
X-Google-Smtp-Source: AGHT+IGba4aqGgtffUXCVxZivDBZKC+MkOkO4hdlD1IfgHaJ6TRumPkoBuOyrhjBEAey/dHZbqF3DQ==
X-Received: by 2002:a81:5fc6:0:b0:615:1375:af0c with SMTP id t189-20020a815fc6000000b006151375af0cmr916688ywb.26.1712319700177;
        Fri, 05 Apr 2024 05:21:40 -0700 (PDT)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id hr9-20020a05690c640900b00615227e92bcsm327029ywb.94.2024.04.05.05.21.40
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Apr 2024 05:21:40 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dc6d8bd618eso2095477276.3
        for <linux-sh@vger.kernel.org>; Fri, 05 Apr 2024 05:21:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXJWldT8U7lZ+p1AAUkV9AKatPMJolY5NMcy8XBm+HMUtIaspzN0N4zbYn4I0HENpLZYe4+MnkaTkogIYlK9sLsx2ulwg6ondU=
X-Received: by 2002:a5b:983:0:b0:dcc:fe97:f899 with SMTP id
 c3-20020a5b0983000000b00dccfe97f899mr1079755ybq.24.1712319699784; Fri, 05 Apr
 2024 05:21:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1712205900.git.ysato@users.sourceforge.jp> <e5f6a857-1296-e110-a3b2-c05d08522371@landley.net>
In-Reply-To: <e5f6a857-1296-e110-a3b2-c05d08522371@landley.net>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 5 Apr 2024 14:21:27 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWL0aHmZS7NuZO5AUhn=zmNDG+fPZzmG--DyZr-LFwZ-Q@mail.gmail.com>
Message-ID: <CAMuHMdWL0aHmZS7NuZO5AUhn=zmNDG+fPZzmG--DyZr-LFwZ-Q@mail.gmail.com>
Subject: Re: [RESEND v7 00/37] Device Tree support for SH7751 based board
To: Rob Landley <rob@landley.net>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Linux-sh list <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Rob,

On Fri, Apr 5, 2024 at 2:09=E2=80=AFPM Rob Landley <rob@landley.net> wrote:
> On 4/4/24 00:14, Yoshinori Sato wrote:
> > This is an updated version of something I wrote about 7 years ago.
> > Minimum support for R2D-plus and LANDISK.
> > I think R2D-1 will work if you add AX88796 to dts.
> > And board-specific functions and SCI's SPI functions are not supported.
> >
> > You can get it working with qemu found here.
> > https://gitlab.com/yoshinori.sato/qemu/-/tree/landisk
>
> I was hoping to get a device tree kernel to boot with static device tree =
on the
> existing linux-sh qemu. (The main new features I want from an updated sh4=
 qemu
> are a working battery backed up clock and more physical memory...)
>
> Is there somewhere I can get the kernel patch list in git or something? I
> haven't got tooling set up to conveniently fish 37 patches out of an mbox=
 file,
> and would like to test this. (I moved last month and my physical sh7751 h=
ardware
> is in a storage container.)

b4 am fe69e328ec617f91a09fa2d00506ba1a664085d8.1712207606.git.ysato@users.s=
ourceforge.jp
git am ./v7_20240404_ysato_sh_passing_fdt_address_to_kernel_startup.mbx

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
