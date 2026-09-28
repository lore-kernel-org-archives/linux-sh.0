Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com [74.125.227.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D769A4F30F8
	for <linux-sh@vger.kernel.org>; Mon, 28 Sep 2026 17:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790614873; cv=none; b=Xb2PiLfiMA6pzD+njeBjKSGLnkv1UNOkATSF5pypP2DHrLfBAPWa5Xj91TuxUXPO+f/1xtwgPJmX9FCqVzRgrvR700JodHzI2JJL6htJK4IyG6pA/4Rq0KC8ns1uvFTItAMh/fgQ4NdoMDATBRmDoEevqV3k/e5U3iPpMzW0YOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790614873; c=relaxed/simple;
	bh=ySAFrXK5MJebKLUCNnYUxwzKmDPTTUZoYnhxcVAAOWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b4LRO++e7wuzfY/fAi3UmeiO360UWI0kvW5hMI1y84RHPlXu+9H5X1s4cRHDw8Go60gbzb6vq12Va4X3VZZRf2q1bb3RO37zFZsXWd5zJTl75eLWMSo5bJdGnVBSlSx1SnxMQaRSdDm8RF4sLJwN/FIoCaGHeTJFJr/O5yH6V8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.227.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs2-f12.google.com with SMTP id 71dfb90a1353d-5c8319dd4a5so1319690e0c.1
        for <linux-sh@vger.kernel.org>; Mon, 28 Sep 2026 10:01:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790614871; x=1791219671;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=duVRFtW40fAmBrIcIBAV/xrW8Vqp7gcMK77vMmwGnyw=;
        b=Cgdp2SFse/nDfNsjOhDALPekjX910kPIqGHC9HFK+xK5ASuzOLfGPt2QE/irKRUEXg
         kjZsMRhFZCJTyX+8316W7zrqhv2XYuBbzwPnryTfhyQxL4Ly/YVmpjQg5pF6sR0ZNbJu
         Pa+GOKiQJF5fHZDj1EGECuJlop1Hh+Xon0sggIRn7P/8vH//5Wf9AfVnSHZpv2X/5US/
         3Q7Jazcbws4m/Xb3yCgy8LWTAj2W2l3VGOtqG7NucccbuBgtbVWf/wKzoTPrm7pMrpdM
         anjVmfXqB0pu3xbctbvwFQbW7bVQwaHlJbxbY7P8v+k6pdTzEpDmmeXaqGkAh2RkBKVn
         m2kA==
X-Forwarded-Encrypted: i=1; AKwUvBy+ywwz1j4xrDg8sKxQtZjI3LIrtNSKWFGm6zb/lOBxcs0tJdcb1F9torv/fWGOvJqo/y8Mt5LEQw==@vger.kernel.org
X-Gm-Message-State: AFq9FYJNyL0ue8LucB369ZrJAS6G3YuRu1Aca93BbqT8WONRnSZCQ1BK
	zzBHyG74LJ5aJ0s0qL52Da+om6jrxpup79j5NAMn2AciSgnEQ/+bxZ74WfhbI7TAMtk=
X-Gm-Gg: AYBFou1N84sspkPvH+7BCGkNQ+ClI9r/7w5fHm0cJxKBe5FJWFwDqTVCWiAKhA309ea
	9h0Bd+iGu7y7p1Fzm8eEnaRW6fq5nH5mlikJdApcDD0recobDAmxRSIdPl8mKRdyAMQDo2ywAc0
	QYxbvtOxxXtA11uF6Ar90W5EByCOGsitl+S6vYOZs1256PF+YSxqbi79AKku6y/Mlogga/LBq2/
	gsAp7qfkPpzjjI/et97348uvoh8tbTAK5FKO3R7O/8rKuK9/akdN5KIhrQj6+lOQ7I2xDZae/J4
	ZBzBU9IXvQOjIa/IwSnKtDcZfLJIoGteVA/Z2MKzdJY+L0jP4BwsHfmOFKzBJFDhpRVtE2EEBbN
	I78sl0jwVDTgCQjgpZ3zJ0D8j8o6cZOszXqInLqeD5rjvOvJ1yoLe7vfTx3A1sAGEcOhrCoyhpk
	EYdWxN/y9AabqFTWulAJNvsEpiNAPG+7NFLC6OzOE0gY5Iq+WxxwEsym16k6toDRWImWPoBUbQp
	L3JK7lYvZDhEqeL/mL0/WYW4ZfTH/f4/acIHVESGb4UU+UO
X-Received: by 2002:a05:6122:4f81:b0:5bc:42be:f758 with SMTP id 71dfb90a1353d-5cb08074792mr4838505e0c.3.1790614867502;
        Mon, 28 Sep 2026 10:01:07 -0700 (PDT)
Received: from mail-ua2-f43.google.com (mail-ua2-f43.google.com. [74.125.226.235])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5cde6650f04sm9521958e0c.17.2026.09.28.10.01.06
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2026 10:01:06 -0700 (PDT)
Received: by mail-ua2-f43.google.com with SMTP id a1e0cc1a2514c-97e7c62dde3so857992241.3
        for <linux-sh@vger.kernel.org>; Mon, 28 Sep 2026 10:01:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzUKSChkYIoZrN/cVeYzNHYY+yhXC1KSb4ZMOLDAEhegFGdpB2yObs6SiTKPMQR9lTnLJ3gL9bgrA==@vger.kernel.org
X-Received: by 2002:a05:6102:1627:b0:7b3:67d6:4d7f with SMTP id
 ada2fe7eead31-7b367d65363mr1528582137.17.1790614866101; Mon, 28 Sep 2026
 10:01:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260927191359.6144-1-kmehltretter@gmail.com> <d4f35d5001924ef9ff4b28ac412a9d4b6048d789.camel@physik.fu-berlin.de>
 <CAMuHMdVRznzGdRwZOHa3=cxhoDNBh1kJqGUoBHqowgj_nzKCRg@mail.gmail.com> <ed4f818f00df446df53a9168054bee1a9a993409.camel@physik.fu-berlin.de>
In-Reply-To: <ed4f818f00df446df53a9168054bee1a9a993409.camel@physik.fu-berlin.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 28 Sep 2026 19:00:54 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW=amt+3ej6+i5TMaO6VUKJt3qqYvSWctFtSt8Tttrk2g@mail.gmail.com>
X-Gm-Features: AclHuK_mE9VxPUVV-lu6iBsW9hr2zre4AZtKTRqpfURzADLjuYTstkf8GGZ2Z-A
Message-ID: <CAMuHMdW=amt+3ej6+i5TMaO6VUKJt3qqYvSWctFtSt8Tttrk2g@mail.gmail.com>
Subject: Re: [PATCH] sh: intc: sort the prio and sense lists after filling them
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Karl Mehltretter <kmehltretter@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Adrian,

On Mon, 28 Sept 2026 at 18:46, John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> On Mon, 2026-09-28 at 18:03 +0200, Geert Uytterhoeven wrote:
> > On Mon, 28 Sept 2026 at 17:10, John Paul Adrian Glaubitz
> > <glaubitz@physik.fu-berlin.de> wrote:
> > > => usb reset; fatload usb 0:1 0x89000000 uImage-7.3.0.gz ; pmb ; bootm
> > > (Re)start USB...
> > > USB0:   scanning bus 0 for devices... 2 USB Device(s) found
> > >        scanning usb for storage devices... 1 Storage Device(s) found
> > > reading uImage-7.3.0.gz
> > > 3649306 bytes read in 2074 ms (1.7 MiB/s)
> > > ## Booting kernel from Legacy Image at 89000000 ...
> > >    Image Name:   Linux-7.3.0-rc5-00001-g8cd915e93
> > >    Image Type:   SuperH Linux Kernel Image (gzip compressed)
> > >    Data Size:    3649242 Bytes = 3.5 MiB
> > >    Load Address: 8c010000
> > >    Entry Point:  8c011000
> > >    Verifying Checksum ... OK
> > >    Uncompressing Kernel Image ... OK
> > >
> > > I also never understood why the load address I used at the u-boot prompt
> > > differed from the one that the uImage build process showed at the end of
> > > the kernel build:
> > >
> > >   GZIP    arch/sh/boot/vmlinux.bin.gz
> > >   UIMAGE  arch/sh/boot/uImage.gz
> > > Image Name:   Linux-7.3.0-rc5-00002-g02d53450e
> > > Created:      Mon Sep 28 14:56:15 2026
> > > Image Type:   SuperH Linux Kernel Image (gzip compressed)
> > > Data Size:    3649249 Bytes = 3563.72 KiB = 3.48 MiB
> > > Load Address: 8c010000
> > > Entry Point:  8c011000
> > >   Image arch/sh/boot/uImage is ready
> > >
> > > Any idea?
> >
> > 0x89000000 is the address where you load the uImage.
> > 0x8c010000 is the address where the unpacked kernel image will be
> > stored.
> >
> > The latter comes from your kernel config:
> >
> >     arch/sh/boot/Makefile:UIMAGE_LOADADDR = $(KERNEL_LOAD)
> >     arch/sh/boot/Makefile:UIMAGE_ENTRYADDR = $(KERNEL_ENTRY)
> >
> > It's similar on ARM platforms that (still) use uImage.
>
> The thing is that it stopped working after 6.5.0 and I never figured
> out why. I did test all kinds of changes and it just never worked
> again while pre 6.5.0 kernels work just fine.

Have you tried to bisect it?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
