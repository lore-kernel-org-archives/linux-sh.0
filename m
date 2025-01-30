Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFC39475;
	Thu, 30 Jan 2025 09:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738229730; cv=none; b=l532MhTZyqid1TyDe7ijO/+ldzCNVIXb/wdXYMtLP+jhqdrA6n4t4q66HHwzHTirgPs9QCQ3IQNxOY2dRp3+6pJrGCY2ImTpZZPIQ2UuB2wqm5cphbWRbFnKde38Z4DPfNk1jXfoUgMas4pFBEYEiIk5ry39p3m6NgSd4mdedvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738229730; c=relaxed/simple;
	bh=HAR2DMog5s0FhCJBdn/nYAixI5q/dFpLHyxKPYx9mpc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=acKgkJ88sfFqPHoreMLF3rGKZceml0A1BIhqtVQImwDRIBBmL8O3eTylHxol4s+7sJlmxL3DuxyhlYM9XWxu15S1WSlnFmyMMZtN0JAJ3lh/9pBM6u9WPCbub0oCcFkgErWkUZ4fsj5ud9Zkc5c3Zw6lhghoahkqkDaROElRD0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-4b2c0a7ef74so363003137.2;
        Thu, 30 Jan 2025 01:35:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738229726; x=1738834526;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PRh1c4qaRZvmBHlkRJB22gts+5lQHNWx8qsznKWq64s=;
        b=aPqACCbWV6x0Na2zRdmf2/T6i0+/m+u8IEYur1eHMHhyo62QvngRYHV29wtQM5rVT5
         bpe77KoRRfyvFmW+5KkeCD3EMopuOQYMSyVW6nAbi6dyBg6pWL3Hg/ZqvLaBe0wPwLPs
         HGkiKK0OArmgZXdoBK50glvywO6FsiJpkft0E9EBk/1GRyDm3yCr4mikZivbPEe5MbIR
         8oUJhy2zoVTv7l6+eEWfPPMajDcyxMoOz6ojqPcSV+YNsv1wLrrBSau5kS8T0XDntxiC
         xSSQzde0GBCZMSp+PaGI3D0Elhjzd3tGGZqIVitAY4pK9CgXOdKaeDUk5WpP5PDHe/jq
         fbCA==
X-Forwarded-Encrypted: i=1; AJvYcCUJaaGctaJe4hq0iWyTTah0wBRqlhkgzpg6yAxx49Lxqzh5cZ8lcsMex3iLTeKkjrBv2nfgAtSKk/cEz1c=@vger.kernel.org, AJvYcCWTGR5upJZCsbaSBvQNH7/zHtCovm117a8YWGoCkSSALc6+7mIHH1kxDWjAV7riUEqnGMQQJg15jdc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/0+h5nJrHDNl1UdQBTz53WPiJQLAOU9Tg+JEQ9KckQ72nt3Wx
	ItQ6SA+J4xZu8iMjYAbXqVzrwbrG/OJ4zo5oBKVT4NHlerSbQDi5oFhhwI0V
X-Gm-Gg: ASbGncs5yXCFDOViK+PeBSU4iNbWpsYNOT3Pqi1KFEJnifxDgOk6I7n+CXNthBc/zwt
	RURra+fTxgINfHxiea6GZxQj+2ZXP/e4kaZC6CVgDumCHtDoKZUfmpLZeL9PYoqEtPwI0pM51Gj
	3dHdI4TxjsJQcHA9LaxjD09ajRfZ7pzyvQI8AVjN05erI8ZzzRfZyVGLyOsbTiiwt5DvZidjHRt
	jLqg6oJLXhYoJcE334FI669Dt4Gb0HWxO98kvyUROoToYvPPsOQwfq8WL9I1KCTqCqaGX+GxnDI
	Ag7qmCfZHYGyO6rANaWjh9pujQ9bTRu9l+ZuZt5gsiCnL2SScgCDPQ==
X-Google-Smtp-Source: AGHT+IGpwdQOqIV4sn8hZXv6tSuHvQaEUaAAVTALhYPkpo+EJRC7DTYeQjFCsGYqH23nPKNgAq65EA==
X-Received: by 2002:a05:6102:1504:b0:4b6:1a64:1c95 with SMTP id ada2fe7eead31-4b9a52dd9famr6081203137.22.1738229726051;
        Thu, 30 Jan 2025 01:35:26 -0800 (PST)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com. [209.85.217.43])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4b9baccd5c0sm165293137.22.2025.01.30.01.35.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jan 2025 01:35:25 -0800 (PST)
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-4afeccfeda2so356174137.1;
        Thu, 30 Jan 2025 01:35:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUUCOwDpWsPDK8JbwSoGu9M+VE2463OQfdKf3caLTE7TRIZ/nUt+ksLdrYxJwT3eDHIQDoOJclPvoLDgao=@vger.kernel.org, AJvYcCVVvM9IL2QE5+uVIdvbUzn0BNXabrQBB7I83AukKb0N/Za7rvbMDS5GE6pA73N293lisk/ckUdmiOQ=@vger.kernel.org
X-Received: by 2002:a05:6102:3ec2:b0:4b2:cc01:6a8 with SMTP id
 ada2fe7eead31-4b9a4f88252mr6370014137.9.1738229725217; Thu, 30 Jan 2025
 01:35:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250128101306.1475491-1-julian@outer-limits.org>
 <8c4279dd244eed4b1a6ef7e2ea6dafac0b5fc79e.camel@physik.fu-berlin.de>
 <CAMuHMdXOx2MFDnRm2dxVTE9tFfAud595huEVagnTd8RKp3yQsg@mail.gmail.com> <57243d0602f768e6d87842008f0d2c76a1e7dc8d.camel@physik.fu-berlin.de>
In-Reply-To: <57243d0602f768e6d87842008f0d2c76a1e7dc8d.camel@physik.fu-berlin.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 30 Jan 2025 10:35:13 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXfiqM2Weoeq-PRw-p9wqMrBwMBcSWjFF8f_uvmVrRS7A@mail.gmail.com>
X-Gm-Features: AWEUYZln_btTpDtdT0QSzlZYXXqj534EZJOCH7DLFQIrCtIMk_mpyYiX3I4HYBs
Message-ID: <CAMuHMdXfiqM2Weoeq-PRw-p9wqMrBwMBcSWjFF8f_uvmVrRS7A@mail.gmail.com>
Subject: Re: [PATCH v2] sh: Remove IO memcpy and memset from sh code
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Julian Vetter <julian@outer-limits.org>, Arnd Bergmann <arnd@arndb.de>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Adrian,

On Thu, 30 Jan 2025 at 10:31, John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> On Thu, 2025-01-30 at 10:13 +0100, Geert Uytterhoeven wrote:
> > On Thu, 30 Jan 2025 at 09:44, John Paul Adrian Glaubitz
> > <glaubitz@physik.fu-berlin.de> wrote:
> > > On Tue, 2025-01-28 at 11:13 +0100, Julian Vetter wrote:
> > > > Remove IO memcpy and memset from sh specific code and fall back to the
> > > > new implementations from lib/iomem_copy.c. They use word accesses if the
> > > > buffers are aligned and only fall back to byte accesses for potentially
> > > > unaligned parts of a buffer.
> > > >
> > > > Signed-off-by: Julian Vetter <julian@outer-limits.org>
> > > > ---
> > > > Changes for V2:
> > > > - Removed also SH4 specific memcpy_fromio code
> >
> > > I'm not sure that I understand the motivation to remove hand-optimized sh4 assembler
> > > code for memset and drop it in favor of potentially slower generic C code. What is
> > > the reasoning behind this?
> >
> > See Arnd's feedback on v1
> > https://lore.kernel.org/all/ffe019a1-11b4-4ad7-bbe2-8ef3e01ffeb0@app.fastmail.com
>
> I read Arnd's feedback but I don't really know whether GCC produces better code than
> this hand-written assembly. Is there any compelling argument?
>
> I'm just worried we would slow down something as fundamental as memset().

it's not memset(), but memset_io(), i.e. clearing (slow) mapped I/O memory.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
