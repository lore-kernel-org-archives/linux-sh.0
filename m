Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF04F367F26
	for <linux-sh@vger.kernel.org>; Wed,  9 Sep 2026 17:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788975384; cv=none; b=RznmncU2Vl9d8ODzfmSbfOqetkp8w/q0KMoPj+IbzI/TPLdI5yNpZySjDI2xfBQAU17VXUmAkYAodokuqBgmi296H1cSH9CtEA3y/DpYy0kA0pfKXoxMvpNCnTES2aJ9JiqMxJROHjHj2moIxvHWjQIZ8LQ/i2X/9hZqnKGb4vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788975384; c=relaxed/simple;
	bh=de2c94jsaMSI3BlsBM6ZrMHN3E6NBtnbTSuL7f6PKL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eyz0SIwOay1+AvXfuWX6mFbOCjcWnImh57grXUWfa8zIIKRzPn5Uj8W5Kr01p9F2Oj0Ro/qPEAE2j6R6GBALvxxS3qjRHxz9oq4F4lmT6vhLLUJHXkouX9BN2+g1iA2MWtI5PPzF98uFxPhNyBBGUORpIv1A+N4vCGWBpqkSUkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iLCB4Gcn; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iLCB4Gcn"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-398e9698a70so5689692a91.0
        for <linux-sh@vger.kernel.org>; Wed, 09 Sep 2026 10:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788975382; x=1789580182; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5ekCRN7odE9ehADxGc5HnpQu5KPcb6xzeMBDX6gZFh4=;
        b=iLCB4GcnlvxhzkUUkgoyKKtpk/lvl7Ti2JE79eKETxu4oTg+NLIvSR2D6uos7WR+h2
         iaeSSLQjH6KhqF5uj7//51YKzcHjKvr77CjXG9oAYiXKYIbeye5ZNqqE3PD+VunTJwKG
         0mvAUtIYKI1fzyTItMmHhMqf1PL3AzIfzkRo8VS+OLP/IWY+wjmoG7CJvXbic/2bMNC9
         6iB1lyC6tiAeDL00ObTOAs36s9jfyQGIHEc2g51Flp6nVKxb6EcaggOefqK0YVrcXDHU
         vd+b6KayswmZA7dYguNqM7nVoJgZHZCPt/S1elAqNy9BGKJmGR1i1RIrpl3/JLmpaHYA
         m4SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788975382; x=1789580182;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5ekCRN7odE9ehADxGc5HnpQu5KPcb6xzeMBDX6gZFh4=;
        b=CEQ+VgMI7M8Cq2BY2Y+KBc/T+hM0a5AkQ3x2/+QjABx6WRZ3WQgmUr8TViY54jb6W/
         d00LVhXcPgMmJoy8gOB35p+7SmMEUyH0CVZzbK/EutVtHCg8gF5KiAkEjta+DNS0Mm1P
         RqkcAXfTcdxAaupcNv5ibr2Dw0taRS0j6m9VkjXr52aeWlLusD3MKZL6xA2ZfkQ0swMg
         QxPV18COwTuyADthPMCTK2dj2qHYultuE0W9qJMxCfbCsbuWCr3GTH4GnRJD4mzeglyl
         JfShoaqlyg2eTbMOqFAOCMy//JDPxjyJPOpGwefF0WjyanGwo0NSez2RBKfmtCBOYWp3
         yLMA==
X-Forwarded-Encrypted: i=1; AKwUvBwbaUctLHD9fTRA8HvhlmOPdsJwhBDeEQnhh3VXxoZPUbk+sGWxzEiT8oFlqQduTRvi27KXNNCoRA==@vger.kernel.org
X-Gm-Message-State: AFuF++nKPcJov8DNs9qp2KNS3Cx6Gnw2SFNDYiyvNXEm7MDIm04M+kOb
	fW239OmhgaO4dXcAgxiQEdB6zF2vXnFQT0aGwvKA2SHULz7pKGYiQ2pl
X-Gm-Gg: AYBFou0fYI9ZU71CpxsjfDrzMa4AjvXBYeU1rFjeNUhGyu4oERMUH/+WdZWHE32MSg1
	CNtTeucYv6w5F8Tfwsn9E8NdkvMzs+zeCzBHPkw3mJTLsyNNm5+1b54UL/qyRlOb/cKCNxp2LIr
	dQ7a0xTPcKvb4rOrnCNQlOa8+Xlr+FRrA3sk3u/DHZZu9NQBSGBSIsPcXSt0a6BHH8PlkF6c7HW
	YWaxMqF4fMmJ+W9/zfG2670gO6a/iOwFVrTcVkBeaUE0bkYFzCoUPHPW2YHJgem0mWNUraHoJhX
	br0u4CJXA5SpK8GGKmMcOhLPGI3mQ2OORpQV/lI65Q822+78pg9mlvZ/LFsO9KUV5tnghQYoZLF
	FMhKoIDPyobN6FG06MPfEu1fI8mETGBtvEZJczhEivJKIEGPplNtY2U4/aWf8QaTxsmowbpT03P
	iSuJ6EaI9gGWAkwnVDO5V0WPjQ2N6Lez7rbYzvoEHWJUYYF4vytdY1cPgsPGMFZTFVEHzUJqe2v
	cPLIc8pa/gyeU1BmCAWXQr1prBWHZFeOmW0LQ2r
X-Received: by 2002:a17:90b:5826:b0:38e:7168:281 with SMTP id 98e67ed59e1d1-39b261b07b6mr55962764a91.10.1788975382029;
        Wed, 09 Sep 2026 10:36:22 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:2d43:5153:5c50:643e])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-143243bfbe3sm42267002c88.11.2026.09.09.10.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 10:36:21 -0700 (PDT)
Date: Wed, 9 Sep 2026 10:36:18 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Linus Walleij <linusw@kernel.org>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] sh: mach-rsk: rsk7203: avoid using inline compound
 literals
Message-ID: <aqGYVMQlskhA60Na@google.com>
References: <20260802-sh-rsk7203-swnode-props-v1-1-7a790cbac9e6@gmail.com>
 <32a0d810bfc56029453aa72cefa49cb40466f64e.camel@physik.fu-berlin.de>
 <anAvJM0u_TIgL4ck@google.com>
 <70cb2e4d8a6fd11cbeb534dbf269f67148a00a8d.camel@physik.fu-berlin.de>
 <CAD++jLkxXYfZadV26956yMAaCtZYr7mRGPA8_kixufbXFW1B=Q@mail.gmail.com>
 <CAD++jLmNry6DwjDm490_n1Z2AmBb7viaOTEv_Ntnsc77dBHmJQ@mail.gmail.com>
 <b9b5a0c24433c4a191a504f652127ef1fb9b1731.camel@physik.fu-berlin.de>
 <CAD++jLnh3GX=Sht9e1C1nyb0=cxCXembBwBf7=Gq0wLsV74KmQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD++jLnh3GX=Sht9e1C1nyb0=cxCXembBwBf7=Gq0wLsV74KmQ@mail.gmail.com>

On Tue, Aug 11, 2026 at 09:51:22AM +0200, Linus Walleij wrote:
> Hi John,
> 
> On Tue, Aug 11, 2026 at 8:59 AM John Paul Adrian Glaubitz
> <glaubitz@physik.fu-berlin.de> wrote:
> > On Tue, 2026-08-11 at 08:52 +0200, Linus Walleij wrote:
> > > On Fri, Aug 7, 2026 at 12:05 AM Linus Walleij <linusw@kernel.org> wrote:
> > >
> > > > 1. (easiest): tell me to just revert this out of my tree.
> > > >  Deal with this whole ordeal later.
> > >
> > > The merge window is coming up and I can't send a broken tree
> > > to Linus so I went with this option now.
> > >
> > > John: the patches are all yours, I have dropped them from my
> > > tree.
> >
> > OK, I will pick them up this week. My workload has settled a bit, so that
> > I have some time for kernel stuff again.
> >
> > Did you revert Dmitry's patches in the kernel as well?
> 
> I took out these:
> 106dc49414c4 sh: mach-rsk: rsk7203: convert pin configuration to using
> software nodes
> c5b962b6023d pinctrl: renesas: gpio: support software nodes for function GPIOs
> 6905cdac0e51 sh: mach-rsk: rsk7203: use static device properties for
> LEDs and GPIO buttons
> 62067bc0a083 sh: pfc: attach software node to the GPIO chip
> 4c870bbaba1b pinctrl: renesas: gpio: isolate function gpiochip from
> parent fwnode
> 
> I have added my review tag to 4c870bbaba1b and c5b962b6023d
> so you can just apply them to the SH tree. They don't conflict with
> anything, at least not this merge window, so you can safely queue them.

So can this be applied please?

Thanks.

-- 
Dmitry
