Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4BC1E0DD8
	for <linux-sh@vger.kernel.org>; Mon,  6 Apr 2026 00:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775437107; cv=none; b=cb/ydEn9nyJf3LfhFI5fbsSzcRI94s4eoS6cmK9mlHhkUMysaCvLLLOLN5vf/y/fY6+vFCcwmmFK/fL0hYAMEUyDZxepL+XmKmJXX3XS3qYlIi5i21EXqYjjQ8hppK1Bi6+seLqg4u8+22a7bp/d/NBSgiExjZWjp9MLhqUhbHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775437107; c=relaxed/simple;
	bh=+lLRkKpz7DZLcjzW9CyLJ4TaQREwU3YB/fMETLtC91k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CmphFy2a8C1vjHMZT8Xhrr1Z8EnzZDFeQpvuT3A9Fc/f5g0ngjbGlUELJ+Qha+fiSOXFgNa+Vz9qJMtluL/ZLBGmP5Zf5odocqmYuQwaK3e70FOe6c8dMSZ4PGZkWg13ztjG+ke/Hhp6Re8Sh2X/jYs9Tkvb8o1BOr3EZtCY6Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SjmS4eRw; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SjmS4eRw"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4852b81c73aso28638205e9.3
        for <linux-sh@vger.kernel.org>; Sun, 05 Apr 2026 17:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775437105; x=1776041905; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2+ijpIAyuwb4HhRMs2Ky0zOSFcvK4v9jKwCBjOdjQIU=;
        b=SjmS4eRwzKDMla7+dZ3ylD1dc54m2QOXjy2uhyK4vhZZMS+4n58+ot9h/4Rbslf9AX
         P7Kq0oFQtAGfyxURp/CWrohPsmCr8sOjKtfhe9smieFlvWkVKUCrsDiz7UwHa6JXqo4K
         Fhki+RhidsP+muDwN9jzbwrG7XUY5AWCIRmdp3TtTiCPDXpDBopRbjse5Kr2eMqxyhRE
         8ef550lZ6lsmOwb1b92iUR45v688CyqSX5e7IE5BB2pb9yQMisifbu0muOHdLsNdOv5P
         Uh6uG9gCnNUopSOm3kyoEV3TZMSTys+SR84EeeMEq3Tu7QDInuQvfHP0I5JrA9QFlbva
         C8Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775437105; x=1776041905;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2+ijpIAyuwb4HhRMs2Ky0zOSFcvK4v9jKwCBjOdjQIU=;
        b=kc3nMB1pTW6vZ4IVDx7HQeftP7ePl7Oh9jjwUQXI5xHQaEb/7zGWYVP7L/49vO2CeH
         ZvkksIk3LxJXtpExpoXBE55XLFhvILFNWR9VfGFfYZMMTnpNZxI4Msf+8tzakgZWCh0W
         UEjNTk/Htl2F7FsiAKICBa03nSlMKQH6y0LmB0drmoiCBl3ednzVUwPS4OFzxDTKxQQm
         mOGbZ9aEPDshEVLvzlKxygJq7KUiscyH/AlWmbJtM8+Ark0A/gaLReK9B2uGpWLfIQtP
         FLUnpcZ/wonkRmrNzko4zendc8It1DkBBJfHP8qcCJlPbEBOB7IJl4bFD8/1GaGMVcMz
         ptMA==
X-Gm-Message-State: AOJu0Yy7cg+Bdt/frYhimlqdLQ1QhK/a6tluKa+JtU0niDaenRX7vgaB
	RKc7rCF80rnZfrHm3MOkcB9VSHZVqkGISRdnT0iXNr9G8HsykzAYZVQ=
X-Gm-Gg: AeBDietG8/li26aL63pJb5ukTHAibD3HGSFfouqVdtelPs7ZvIujcjMqq+q+NQZLZYz
	zW09LqIViXAuaesNo1DqQryfD6cu1hfEM64JSWjCskhy3btJ63FKzPaPFJO//5XY6AiZsN39T8w
	obMT/rCmNIAXUX3ewDYT5dPW7uIpFaGCyEfPIu7iMjlx6huK44amHLGhsA3TDwkbaXIzlyKgo3X
	vvkm4G6CDI6varcZcW1I4/rfytf9w7pdn4qzcW+XI+QkL3UuTeZRzubnGUQJHQ7gL4rck5ltwbA
	ZOTe1OhndMf5gozAh9cMtxBkZMHziqfzvp2VY3ci8TvlG4T6Scxa9VJ5ICPOvApMjnmPxYp/i6U
	nP72u4oCK6PjN0zcMcTi2TfQDBtRNHkm9X27cO/CAnQXGqKCKkqJ5/BG9F0/KxpmApYKCCxDIWb
	LvFeFp42DvX+Wi3dAh6pWrSVbuv88snlktR8c16k2E6GxIwXRbWimT62cWW76dXNosjIYRojiSw
	ysI
X-Received: by 2002:a05:600c:8216:b0:488:ac01:72b6 with SMTP id 5b1f17b1804b1-488ac017468mr47554365e9.21.1775437104592;
        Sun, 05 Apr 2026 17:58:24 -0700 (PDT)
Received: from lithos ([2a02:810d:4a94:b300:4382:4d9a:caac:a8d9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e952b0bsm425706545e9.12.2026.04.05.17.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 17:58:24 -0700 (PDT)
Date: Mon, 6 Apr 2026 02:58:18 +0200
From: Florian Fuchs <fuchsfl@gmail.com>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-sh@vger.kernel.org, Artur Rojek <contact@artur-rojek.eu>,
	Adrian McMenamin <adrianmcmenamin@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] cdrom: gdrom: fix block I/O and capacity setting
Message-ID: <adMFKoMDmwyDWyTB@lithos>
References: <20260405082330.4104672-1-fuchsfl@gmail.com>
 <8ba12d4bf7836ae11cf48e25bba7db6625687291.camel@physik.fu-berlin.de>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ba12d4bf7836ae11cf48e25bba7db6625687291.camel@physik.fu-berlin.de>

Hi Adrian,

On 05 Apr 16:09, John Paul Adrian Glaubitz wrote:
> Hi Florian,
> 
> On Sun, 2026-04-05 at 10:23 +0200, Florian Fuchs wrote:
> > Hi all,
> > 
> > This series fixes a gdrom driver Oops due to bad MMIO register access and
> > fixes the missing updates of the block layer gendisk capacity that
> > prevented ISO9660 mounts from working.
> > 
> > The change was tested on real Sega Dreamcast devices (PAL-E, NTSC-J)
> > with physical CD-R discs and with GDEMU emulated discs. Before: Oops on
> > mount and an unusable drive. After: Successfully able to mount and use
> > the inserted medium.
> > 
> > Thanks,
> > Florian
> > 
> > Florian Fuchs (2):
> >   cdrom: gdrom: replace port I/O with MMIO accessors
> >   cdrom: gdrom: update gendisk capacity on open
> > 
> >  drivers/cdrom/gdrom.c | 39 +++++++++++++++++++++++++++++++++++----
> >  1 file changed, 35 insertions(+), 4 deletions(-)
> > 
> > 
> > base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
> 
> Thanks a lot for the series! Can you give me any hints on what's the best method
> these days to boot a Linux kernel on Dreamcast these days? I have the hardware,
> but I never tried to boot Linux on it. An emulator might be even better.
> 
> Adrian
> 
> -- 
>  .''`.  John Paul Adrian Glaubitz
> : :' :  Debian Developer
> `. `'   Physicist
>   `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

I haven't found any DC emulator that can boot linux currently, sadly. I
analyzed a bit with gxemul/lxdream, with the goal of booting it in the
future, but, currently it traps in the pcpu setup. (might be some
kconfig related, missing features of the emulators or sth.)

On the hardware:
You can either burn CDs, emulate the GDROM with a hardware modification
kit "GDEMU" with sdcards or push the executable over serial cable (or
via network).

 - fastest test-iteration is via gdemu/sd-card or via serial-cable, that
   may take just a few minutes to transfer
 - via serial, requires a serial console "coders" cable for the DC/USB and
   needs a CDROM with dcload-serial [1] CDI burned on it, then the
   executable can be pushed over serial to the DC. I currently use
   sh-boot [2] as the very thin bootloader which might not be necessary,
   but I haven't got it done otherwise, yet.
 - to boot an already built CDI (Dreamcast selfboot image), you can burn
   it on a CD, either with helper binaries [3] or manual using wodim, it
   needs special crafted CD-layout [4], but there are tools for it [5].

There are different tools from the DC homebrew community, that help with
creating bootable CDs/Images, please ping me anytime if I can give you any
further information or a test CDI.

Florian

[1] https://github.com/KallistiOS/dcload-serial
[2] https://github.com/foxdrodd/sh-boot/blob/main/tools/dreamcast/Makefile
[3] https://github.com/alex-free/dreamcast-cdi-burner/
[4] https://mc.pp.se/dc/cdr.html
[5] https://github.com/KallistiOS/KallistiOS/tree/master/utils
