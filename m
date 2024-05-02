Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE39219E0
	for <linux-sh@vger.kernel.org>; Thu,  2 May 2024 07:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714634719; cv=none; b=rulGN/5KfcWTgBNaZ/knbixxRqea3QKYcKFhGnDwQKLEvZNzCWAqUueaqB0Vdbao0JZrUUEKEJi+zOzXhspZ3OE3Ew8tn2UKwebWcJYAU3BUekaOT6YLaKTD72NFv4KpePtIZMia/R2E36ktnGikTF/pvqLQqYCe45lLVUroiDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714634719; c=relaxed/simple;
	bh=TP3va45x4QY+OV6NjW5+KS/IsMA1qJjMdCsU4Bp19RQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=envgm4NmJbIq+ZCS88pkOURydpsG6DGz3MtUHwcA6iB5uZdmQ6M8DSUFNolTn2zhDaBDyQGp5QKDQ4z/lci29ardbR1QXG6JWMG/YcRYNp7Y1Y/PlNgbLrJKnBlm7yJojjGgmKgv+ZxqbVrfn0t7dNDvrX2mMMH8eKqiciIavmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6184acc1ef3so72001257b3.0
        for <linux-sh@vger.kernel.org>; Thu, 02 May 2024 00:25:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714634717; x=1715239517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OT9FS/UXs/iWfdEqBl7HAH+BnM/4LI3EcroieAKeZiI=;
        b=QdJtHu7Ae7kDa6JSVBXE229vPB1FC82655z94pDwPrCi1s/IsRcybSrxQI4l6zoZSQ
         HpWnhWI3vRuIiE7fdYvpBwC/+f3FDN2nvJdTfJMSYsXSr7GpRryXWUe9YYmVMQIvjSC7
         nBcgIFagPV70BW0W20srvtrMY4y1QBZZokBPgXO7vgY36wz8HSsIXjxUGqi6vpqRrvKf
         J62HSBbsjuIm32XMDdNeMG7E9WFzlVTIuT0wZcjL04Hd5BXTK6ScQ5SoM19opoUANKzN
         n00dmR6R7Fvvi27SV1YPw4VTzAL7wd4PV68wuDqjuKPj3qPycGkgZiXCuN4AEcoQj6PV
         LlHg==
X-Forwarded-Encrypted: i=1; AJvYcCWR5l2Wo6BdIqfyDayqVqL5GULVzFsztN9q/ZHkbGWcWGkVuG7daUk7PgaNS8tKKvSCFBqvB5Z6CRv7pFdISzUKyA3NOa1r1dc=
X-Gm-Message-State: AOJu0YwDTV5ZXm03c/C/pBdImwS7YB82cAiV/NLToeBn21NxunMBijjD
	n6YbMT5Q6G/8NX9ldZ3DWxKAH6nsceaCjb1Iv+JM5jX5ZuEBG9DWT8GCag87
X-Google-Smtp-Source: AGHT+IGX3l5NXfhzSlm3o4zSLTXc5fnYpQO8In3Pupt19WiQQXCHZFbwyMAfHTDb5KQ3/Bj7Fk11yg==
X-Received: by 2002:a05:690c:7090:b0:615:4e88:c02d with SMTP id jg16-20020a05690c709000b006154e88c02dmr1581669ywb.23.1714634716784;
        Thu, 02 May 2024 00:25:16 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id d205-20020a0ddbd6000000b006098a21f7ebsm86805ywe.135.2024.05.02.00.25.16
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 May 2024 00:25:16 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-de60a51fe21so3386430276.0
        for <linux-sh@vger.kernel.org>; Thu, 02 May 2024 00:25:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVYorqkMjDX5cSEDYr606Rf5fvbtcOBQbeEj3CucKVqK+1D0+BOShVf4jlJuz6ACMkaJ9Ew0Wvmyd3GSMDEJyVOQoE8RhMbnbA=
X-Received: by 2002:a25:ce85:0:b0:de5:5aaa:7881 with SMTP id
 x127-20020a25ce85000000b00de55aaa7881mr1425854ybe.49.1714634716275; Thu, 02
 May 2024 00:25:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <23e9b3fd0d78e46c9fc1835852ba226aba92c3ca.1713959531.git.geert+renesas@glider.be>
 <527c044218bfe2da6d6c8c63e29131bff7984c10.camel@physik.fu-berlin.de>
In-Reply-To: <527c044218bfe2da6d6c8c63e29131bff7984c10.camel@physik.fu-berlin.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 2 May 2024 09:25:04 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWR4x6F0yFoMnVPUYihNdhuGT-TA_91jozOn=vUHT8HeQ@mail.gmail.com>
Message-ID: <CAMuHMdWR4x6F0yFoMnVPUYihNdhuGT-TA_91jozOn=vUHT8HeQ@mail.gmail.com>
Subject: Re: [PATCH] sh: boot: Remove sh5 cache handling
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, Arnd Bergmann <arnd@arndb.de>, linux-sh@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Adrian,

On Wed, May 1, 2024 at 11:26=E2=80=AFAM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> On Wed, 2024-04-24 at 13:54 +0200, Geert Uytterhoeven wrote:
> > Commit 37744feebc086908 ("sh: remove sh5 support") in v5.8 forgot to
> > remove the sh5 cache handling.
> >
> > Suggested-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

>
> Could you maybe send a version of this patch which will apply on top
> of your first series "sh: Fix missing prototypes"?
>
> I'm asking because this patch conflicts with patch #8 from the series
> which still fixes some missing protoype warnings for the following
> functions, so we can't drop patch #8:
>
> - void arch_ftrace_ops_list_func(void);
> - void decompress_kernel(void);
> - void ftrace_stub(void);

As Sato-san objected against v1 of patch #8, I did send a v2 of patch #8
https://lore.kernel.org/all/b7ea770a3bf26fb2a5f59f4bb83072b2526f7134.171395=
9841.git.geert+renesas@glider.be/
which applies on top of this one.

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
