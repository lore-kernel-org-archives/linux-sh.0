Received: from mail-ej2-f43.google.com (mail-ej2-f43.google.com [74.125.228.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79DC26158B
	for <linux-sh@vger.kernel.org>; Mon, 28 Sep 2026 16:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790611452; cv=none; b=JjftQZyExCisejF8xjI4xnup9p1W4ioYCgDZ+c+ygpCH43RXfA5tOk1N2jEZE9Gs8DbdgnQynn5x5p1SRpq1hITUZ9md372w9Lm9vDxDEONYnaYD3hs5h4JUD6dyHCBzj7GilHez9ujN+OT9wR2F/8nbNe0DycvZTGR6Dpv/rqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790611452; c=relaxed/simple;
	bh=+OUWtMoUK/80tt3PXrNgtl9ROxd0swRJbu8F45E/dw4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YTwyIUH6uy50jjtAdDFUMfkMKRMn0rtKMw3F4YzxZCffiD3AwEe3g2njRhO5zQm49Fs4WBixTc+Oi/SiPTbFTBZjMuhCiuFOqQAuZxwPqWnvYvWcRpCOcYxajkqJd9Td0ULc1YgUxJEp35ujGGVlRBifBsV8pEo5OHQpuS5qeAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.228.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej2-f43.google.com with SMTP id a640c23a62f3a-c2af876539fso334001866b.2
        for <linux-sh@vger.kernel.org>; Mon, 28 Sep 2026 09:04:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790611448; x=1791216248;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hBvDF6H9cPXn+plsHym6ckje44L2FB2HOjwEBmwuAlk=;
        b=XudhwDvnRZMNjlNWjFHcZjWbjNvgxz/0B+3kRVJv2lQLGkn+7Zj6Nwx6z767wuRqWm
         aUu1/T5+rsrjNuPEg5RTPzlK0OFEmLEeWXA4CKLmREln4aQYZZ+l1VBgybaK6lskZVcM
         EKFHhrz1jGu/u+TTWuXpTMwVtr4yAOiio+KWtJMJi3BXFhUF6pEP2n+QnEvsuobnBNi9
         dgiS+cc0I8xBFXCHOHCsdE9+Xx7CxGIxPZUQMLnZkPsu8fP3lrrq2xA45qIyQo4XCTvg
         /yUz0aHW970FCIqNW+PpGKNKGISV3aPYVgX4kyuw4JXeZnhJonRxFU2jlJTC3P/DMRp8
         lMsA==
X-Forwarded-Encrypted: i=1; AKwUvBx76iQusn+sQT813+l82O+G54uom7u0JZ9pXi2FtuEH0mqR8yIW8JT+jd3WLEtFb7E8nJH2HhRfmg==@vger.kernel.org
X-Gm-Message-State: AFuF++lCJ9zjM4fD+qcYZv/Fd0lQfwBLhcHL5bpctIzUGZNntFcilHxx
	TEbPTea3esk3IamLzCSKaLEz/HtBHoe/t3Hf521ELjgTAefHXy4LE2/CXX+MUmyNDv4=
X-Gm-Gg: AYBFou1ZojNhxXCIFWpO5LX2wRbyLvSLgF2ZOzM+7YquyVKrAaZ7OAGs90IL9dXAJjI
	DROU1kiLJqLVA5i1w80a6wfuCQL0umSRbrXsQ1UsmH6cDksFam2fTPtS/NWk/UGAWRDvPuUCANv
	QFwVQmMK8lf9SGQBQrJDrgtOoj2ramRsA/2PaaUhGGjzCMI+gaG7FkJuAHbIwZK2MToTKhNQ7/o
	MsGOnCA4/NtARMmm6O9p6B3fxMrro5spdBB7qX3MlGnoMUmSUKMfoMDaVXgIKjFzZWpNWNMwbRC
	crOaQpSZDa1XALYJQQz7NYR9HeaDwMSNB0K4/IoWcB25pxXpqs3uu9yD6FO6co855dmE+FFGJcF
	VFWyQ0Hr7Yx7CWtrYx2/KnYcrecLO3MR61t4CgSHciN9+W91+md9RFO2MLDjLJC3WaR+swzBbXM
	I9H++dkdPRGt6T1ho63pzk3FHb7RclKWCuDDCjpBf0fSkhgVCh/KlzkuPqPTLB+dQH/XakblyXT
	YsXpkD4n4VYoC8hS7xPFI9wnfc75zPwiXPm
X-Received: by 2002:a17:907:6c10:b0:c2d:bcf7:37f9 with SMTP id a640c23a62f3a-c2dbcf74374mr450445466b.26.1790611447489;
        Mon, 28 Sep 2026 09:04:07 -0700 (PDT)
Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com. [74.125.228.76])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2db959aa33sm324839766b.61.2026.09.28.09.04.06
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2026 09:04:07 -0700 (PDT)
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a99cd5115bso5369594a12.3
        for <linux-sh@vger.kernel.org>; Mon, 28 Sep 2026 09:04:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxkP7SV452JsFdRZwtOfyJ6CYJB+DFOvKVyooXM5wES2Hexg47DP49t4cVySmwGYu8I0v521cSmpA==@vger.kernel.org
X-Received: by 2002:a05:6402:3209:b0:6aa:129a:1f70 with SMTP id
 4fb4d7f45d1cf-6aae8f768ffmr7805248a12.43.1790611446738; Mon, 28 Sep 2026
 09:04:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260927191359.6144-1-kmehltretter@gmail.com> <d4f35d5001924ef9ff4b28ac412a9d4b6048d789.camel@physik.fu-berlin.de>
In-Reply-To: <d4f35d5001924ef9ff4b28ac412a9d4b6048d789.camel@physik.fu-berlin.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 28 Sep 2026 18:03:52 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVRznzGdRwZOHa3=cxhoDNBh1kJqGUoBHqowgj_nzKCRg@mail.gmail.com>
X-Gm-Features: AclHuK-d8jrRoBM8kbq6kTOBOZdCkT4ExdxlaV1GF77pQxLzcRpmuQKgygoql24
Message-ID: <CAMuHMdVRznzGdRwZOHa3=cxhoDNBh1kJqGUoBHqowgj_nzKCRg@mail.gmail.com>
Subject: Re: [PATCH] sh: intc: sort the prio and sense lists after filling them
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Karl Mehltretter <kmehltretter@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Adrian,

On Mon, 28 Sept 2026 at 17:10, John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> => usb reset; fatload usb 0:1 0x89000000 uImage-7.3.0.gz ; pmb ; bootm
> (Re)start USB...
> USB0:   scanning bus 0 for devices... 2 USB Device(s) found
>        scanning usb for storage devices... 1 Storage Device(s) found
> reading uImage-7.3.0.gz
> 3649306 bytes read in 2074 ms (1.7 MiB/s)
> ## Booting kernel from Legacy Image at 89000000 ...
>    Image Name:   Linux-7.3.0-rc5-00001-g8cd915e93
>    Image Type:   SuperH Linux Kernel Image (gzip compressed)
>    Data Size:    3649242 Bytes = 3.5 MiB
>    Load Address: 8c010000
>    Entry Point:  8c011000
>    Verifying Checksum ... OK
>    Uncompressing Kernel Image ... OK
>
> I also never understood why the load address I used at the u-boot prompt
> differed from the one that the uImage build process showed at the end of
> the kernel build:
>
>   GZIP    arch/sh/boot/vmlinux.bin.gz
>   UIMAGE  arch/sh/boot/uImage.gz
> Image Name:   Linux-7.3.0-rc5-00002-g02d53450e
> Created:      Mon Sep 28 14:56:15 2026
> Image Type:   SuperH Linux Kernel Image (gzip compressed)
> Data Size:    3649249 Bytes = 3563.72 KiB = 3.48 MiB
> Load Address: 8c010000
> Entry Point:  8c011000
>   Image arch/sh/boot/uImage is ready
>
> Any idea?

0x89000000 is the address where you load the uImage.
0x8c010000 is the address where the unpacked kernel image will be
stored.

The latter comes from your kernel config:

    arch/sh/boot/Makefile:UIMAGE_LOADADDR = $(KERNEL_LOAD)
    arch/sh/boot/Makefile:UIMAGE_ENTRYADDR = $(KERNEL_ENTRY)

It's similar on ARM platforms that (still) use uImage.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
