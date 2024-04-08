Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023F2481BB
	for <linux-sh@vger.kernel.org>; Mon,  8 Apr 2024 07:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712562263; cv=none; b=hP3nPgtonLMp36f4/xPBqEtCGzVcP9CeD4x8qAIZnK8Cyw5T3ffPCshixpMozc5TjQCGkI9kWRlQTNf2H1dJUqPXQmqod+oKrfid4ne6loHMt7NFTcgKwssRqmOwUCkefI/6oM4P9Ox8MWPEeWBSwCAD+vyRAQmdHF6LGmpZgiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712562263; c=relaxed/simple;
	bh=NKOyuTOFO2Ip7hPK4miU8ovrPcpVW2od8nkLvP0ZGHE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=psg9EBC35933FE3tCr8iBefz/2XAYs7MwXnsqx+XDkRS2xhu5Y7ixmDhYODbVqS18Ed/RC2V5O/9mP01ASG6SwfqenG0Yey0b9ZJtoEDgMUqmHrfiwolIktzGdylX6B/JDE8fsz3dTGYGKKe02dv4R3oP0tIVe0wwSVBSPQH5Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dbed0710c74so3553591276.1
        for <linux-sh@vger.kernel.org>; Mon, 08 Apr 2024 00:44:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712562259; x=1713167059;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SWjLfAvK7LBDoj1DUexsPMsaeg3ahCpT9JwAuTz7mow=;
        b=tFLTGXNZ89msGveb4KBmRCjVNCADVkJiP3yraDpkGWD8cmv5MuXVlbD/xzhlxQ+gQn
         zHEKSPR658wG9Ble9zeZKjWXSkNZSiQxBdleMKyUiOera7v5yDzCQOo//0Gr9Em7hKXv
         mQs42CP+znfanoMiZWttkhOtSxSyR/glc1j/bZU3CMr5kPQpDjOWCrn6qtmC42JU/Cr7
         /qELQ5GRR9dQfF7QnMH+vY4zR6z2pvBBtY/1g11mMW1Q2+GXXhwoM3PorrHtS2VP6tI2
         G01IH2FBE08iA4Pf3aMYPFiAaFZnUomflKjLKN0L3TN37xX8BBIR/VewglqUOzjDTsZ8
         lD0w==
X-Forwarded-Encrypted: i=1; AJvYcCUI7vj91AXbUlnN7Jvy4CRiV0498SrVny+ylzHgpI9Fl53H7I4SUDkBKTmC5LCLaSJ6DEv8b1B8RdHAx7jiRAJ53/Zdum3ecT4=
X-Gm-Message-State: AOJu0Yzq/R+981TIxHdyKKVhblEncMacpWUJFnOW1kLH9UQGY31MJNfQ
	fhEn9Wbz/kXb9j/826lfqp83DaNKQhANkDgA3Dq5oghwjtWcxWVXlnsnIoOLrHY=
X-Google-Smtp-Source: AGHT+IG/0b1/F3ljrRl7PJTC9u0Hl6Ogr2k8Vypk9Qzmk9L4YoEDY+1CZMjrZxnuIj0SHru2Z20scw==
X-Received: by 2002:a25:9390:0:b0:dc7:4b0a:589 with SMTP id a16-20020a259390000000b00dc74b0a0589mr6060208ybm.55.1712562259225;
        Mon, 08 Apr 2024 00:44:19 -0700 (PDT)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id 187-20020a2515c4000000b00dc7622402b9sm1329177ybv.43.2024.04.08.00.44.18
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 00:44:19 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-61587aa9f4cso41681177b3.3
        for <linux-sh@vger.kernel.org>; Mon, 08 Apr 2024 00:44:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUJrWDL5IDqQ8B07qJVB1EMHFWg50+w1zP+ufOVibm527uSvm7lUc5IgAh4+okS0rkdDfAzsSLgZL9gmbEAUGgroiAmcFeAv68=
X-Received: by 2002:a25:8008:0:b0:dcd:5c7:8466 with SMTP id
 m8-20020a258008000000b00dcd05c78466mr7471603ybk.44.1712562258728; Mon, 08 Apr
 2024 00:44:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1712205900.git.ysato@users.sourceforge.jp>
 <e5f6a857-1296-e110-a3b2-c05d08522371@landley.net> <CAMuHMdWL0aHmZS7NuZO5AUhn=zmNDG+fPZzmG--DyZr-LFwZ-Q@mail.gmail.com>
 <aebc1db5-5c3e-dafe-0c35-7d0a4ed4d885@landley.net>
In-Reply-To: <aebc1db5-5c3e-dafe-0c35-7d0a4ed4d885@landley.net>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 8 Apr 2024 09:44:06 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXM=c+utDZRYYjaUACiN-XEc7=x4MtKvMnMRN6pSnYtUg@mail.gmail.com>
Message-ID: <CAMuHMdXM=c+utDZRYYjaUACiN-XEc7=x4MtKvMnMRN6pSnYtUg@mail.gmail.com>
Subject: Re: [RESEND v7 00/37] Device Tree support for SH7751 based board
To: Rob Landley <rob@landley.net>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Linux-sh list <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Rob,

On Fri, Apr 5, 2024 at 8:48=E2=80=AFPM Rob Landley <rob@landley.net> wrote:
> On 4/5/24 07:21, Geert Uytterhoeven wrote:
> > On Fri, Apr 5, 2024 at 2:09=E2=80=AFPM Rob Landley <rob@landley.net> wr=
ote:
> >> On 4/4/24 00:14, Yoshinori Sato wrote:
> >> > This is an updated version of something I wrote about 7 years ago.
> >> > Minimum support for R2D-plus and LANDISK.
> >> > I think R2D-1 will work if you add AX88796 to dts.
> >> > And board-specific functions and SCI's SPI functions are not support=
ed.
> >> >
> >> > You can get it working with qemu found here.
> >> > https://gitlab.com/yoshinori.sato/qemu/-/tree/landisk
> >>
> >> I was hoping to get a device tree kernel to boot with static device tr=
ee on the
> >> existing linux-sh qemu. (The main new features I want from an updated =
sh4 qemu
> >> are a working battery backed up clock and more physical memory...)
> >>
> >> Is there somewhere I can get the kernel patch list in git or something=
? I
> >> haven't got tooling set up to conveniently fish 37 patches out of an m=
box file,
> >> and would like to test this. (I moved last month and my physical sh775=
1 hardware
> >> is in a storage container.)
> >
> > b4 am fe69e328ec617f91a09fa2d00506ba1a664085d8.1712207606.git.ysato@use=
rs.sourceforge.jp
> > git am ./v7_20240404_ysato_sh_passing_fdt_address_to_kernel_startup.mbx
>
> $ b4
> bash: b4: command not found

[...]

> Oh well. Good luck with your patches, hope it works out.

If you cannot/do not want to install b4, you can stick the Message-Id
into lore, and download the mbox from
https://lore.kernel.org/all/fe69e328ec617f91a09fa2d00506ba1a664085d8.171220=
7606.git.ysato@users.sourceforge.jp

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
