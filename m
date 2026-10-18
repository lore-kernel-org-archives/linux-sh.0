Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE683DF002
	for <linux-sh@vger.kernel.org>; Sun, 18 Oct 2026 23:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792364704; cv=pass; b=FMInDiubAZMONxHrVnQsmhZCKW6tWCbEpVVDX5CTl0RXbXySm8L6+6VidOHWcJgbPZx036HPdt/pH+ti/37meISgcefOSxvVuYTGNLCVtQY8zpMhoBKV+zbk/lbnU0O4G/Z4MAmLgSolRBx1mh1Rrb86BRz5ODJG0wrKSEbKw7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792364704; c=relaxed/simple;
	bh=5hlKbxxcI0prTGWkY2kVG+ktXHIzZp+G584+bSjB6Ys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tmw9GW8e0yID35kWkbCnFdtQg54TrjyIweGqcGfocCaz7LNiCBUqQTR8tjHCIILipsbaW+vDN0QXJqQnyA7kS3WoKVlQr095qQqYTfPwxOIGdrlDK3++0ozlaHwvGpeb4AHzgs6MKgIu6jLh89XdkBIjFThYYXjFp1wI65IrgYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com; spf=pass smtp.mailfrom=0x0f.com; dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b=YluGgYVu; arc=pass smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="YluGgYVu"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-3535bf8b3e0so3140989eec.0
        for <linux-sh@vger.kernel.org>; Sun, 18 Oct 2026 16:05:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792364701; cv=none;
        d=google.com; s=arc-20260327;
        b=TSs/YA/cEPlXdn7otqFoMDPGVOoqqXfu7z71MhR2BGWg8fm9ijfXjWQUlOC566ymhH
         d1k7uz7jHO68e1rpeDAGyXLDgIxzB5R2AT3Q7CfH3QRsBVduFy/T1ameDjYEp5VDnKXT
         rE5DueEgC9zvOkhd0lDk+w/I7GAjLohUQxUItr1XcsGLJxEkaELcZ3plezwWD9WW1UU6
         x2/BQsk76LTyPgdTdio8AOJr4dqaK1Zxmyff/SEzCDgltMYGf5Sd6XOgtf8ellSmqdO1
         ztt2ai9RtvMtizzRk9HBRVPsvM8NJYsufFiLhOFlY8ALG4yYYgfMgXyYW9BIKy7U3oAm
         V40w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=pdNuBmcWi1wZSwfuz2mNY+kCv6367R1XFhsEmvefW7M=;
        fh=r+hGcJZRFOy0LQvkmqLCkeoEAMTnBJ04kFECBrQwmxM=;
        b=nkcwRxaPnXxy47nWaiRLfBCcewwrJ7R1GrtwzjqMII8jxY45Lc9Tqmss3klU2Esscy
         B3PdSEfoBIKWovaGRNV5mzyol37R0Al0WFYSdT1/m0Ug/Op4H7KhZP0xAGkoVyhvX+o9
         o/V7jTv7NWrCzat8fTGFBoJ6oK6A/dF/m+Cp5msDv4vvAJJVqKKDbmUayyQ6XysL31WR
         ZlY488NB3Equxukp/vtSwcpLLWxzUk8JtSU4QstSQqFAIcNiINzPtgnqSLQXT7/5FCM+
         sAyXddFUiKFYMQRRDvpRuuiM5HSO1xDWWvyw2/QtGtStoooRnJCkjVOqNWaLStK1xFge
         ucWg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google; t=1792364701; x=1792969501; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pdNuBmcWi1wZSwfuz2mNY+kCv6367R1XFhsEmvefW7M=;
        b=YluGgYVuK6zHOtwa050thoQyPTDMUytKyzXG6iz9IeA180HKON9KF/bcCuLfv9Hxex
         Awyw/ODwQBvboxpecUsmiONFiYiiLGS4KxyPia6Qu3bV8neKKJDrYXJVLY1VZ0M7UIWg
         NfBjtfn2PCzdi+kKpZM28Iv3cW69DHN3dUTR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792364701; x=1792969501;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pdNuBmcWi1wZSwfuz2mNY+kCv6367R1XFhsEmvefW7M=;
        b=RDmLw+0QdIjZlEvRYJJ3mBVbuTXFwpQ+sRRCV/x8ttXmJHoJim8fP6ZGTzcxrGPR3F
         fwxUE+JuUutTM2zQIr0LTbujk9PbjWmhAUzqD1e5xFLvc683DszSdDicilzCgimxHg/a
         wRqHZgcmzqAjJY9mlceHJrUobCK+zYEl5N+USl7wf1q6+oJ4lFg6FLtPHb/k1g5m8tfI
         T9qWoKfgAnGE2KazkRHEsOGoLtd5xpepi8oZfuHPkjAhbHHURmg1jvOcU0oc8cICY1be
         6TtUnKiQD3ck+2ABvinTLT8uAKx7xkgtpJRibDQ6UVuS0Z0X8W5b8qzb/3kzqA8CzDcC
         tFww==
X-Forwarded-Encrypted: i=1; AKwUvBw0ijgl3eVDV4v3kZCvfTRgQZW27gaqO8XX5NRaDPDtE52o9K6XpaBpvUx7El5yTUuG9xuL7JM52w==@vger.kernel.org
X-Gm-Message-State: AFq9FYI+4DJaGmQWobibV7IXYxByRKLCzX09sEJCpgFU9BSfXb8mmvu9
	0vgDCnLN/efW3iM5DC4zkltr8t+NpMvb5TPpP6dYlU8nHinZCPwVuq3zB59b9S95O9KwL09IUee
	b/FWjCOAxKYSU4Dhw4EoaTl6AKzRlhw2mN3+HeJJ1jA==
X-Gm-Gg: AYBFou0vLZbQS+jerKFm7DxZxKG2CHYPUnpzSkRJAFG/xuisOR/Ii99beNhJmYaqDMv
	eEFinHVaHHzm+4uFbuP0+KOeXb8HTavxvZ8AWVXVltcPA1B4BADWojDnHUUtEkUBLETGYWyNnye
	Zv0wM9Pjpk1QmcTz5iYIDX9e/Xfw3rmZnT6TXwhi1vQv4qmdbriA8dvCPJ/srbDNqfJD+aj52kg
	OqwmAwhXdq+KiHrnHGr2AOrspvWoBb+wKXG/joCqXdicXmaSuPLx68knYrwP2aOs3InFXGRpREG
	TwVARzqyhFozb+gnxvKa8aoP4nVRfcj+BYDxUD6fUccfI2+8SbcnZeHdshnQWqYIYP9FBOuDyWT
	q1DHujCtWwuCvr2I=
X-Received: by 2002:a05:7023:a84:b0:188:e51:e86a with SMTP id
 a92af1059eb24-1880e51e89bmr6391719c88.2.1792364699526; Sun, 18 Oct 2026
 16:04:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261017041419.311921-1-daniel@0x0f.com> <4cdb2939264e0b7d767f44289fddffd40fddf504.camel@physik.fu-berlin.de>
 <CAMuHMdXmZash+8PmfSVrT=Wwob-mkq0x4umyRgX2-yikV9kaVA@mail.gmail.com>
In-Reply-To: <CAMuHMdXmZash+8PmfSVrT=Wwob-mkq0x4umyRgX2-yikV9kaVA@mail.gmail.com>
From: Daniel Palmer <daniel@0x0f.com>
Date: Mon, 19 Oct 2026 08:04:46 +0900
X-Gm-Features: AclHuK-LLYBKws1C5cc1iDE2Bj1jC73GLJaKrThGJoscsEcvrzPj8IjxBlev-5I
Message-ID: <CAFr9PXn4henL=rQ3n73H7Mjwd7v6XX6Jt63h=Sywu-boOPggKw@mail.gmail.com>
Subject: Re: [PATCH 0/2] sh: Fix IDE on landisk
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, dalias@libc.org, dlemoal@kernel.org, 
	cassel@kernel.org, linux-sh@vger.kernel.org, linux-ide@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yoshinori Sato <yoshinori.sato@nifty.com>, fuchsfl@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi Geert,

On Sun, 18 Oct 2026 at 23:48, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > I hope Geert can test and review your patches and I'll pick them up
> > with his Reviewed-by and Tested-by signatures.
>
> Sorry, I must have different hardware, as mine doesn't have an
> ATP865 PCI device:
>
>     # lspci
>     00:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
> RTL-8139/8139C/8139C+ (rev 20)
>     00:02.0 USB Controller: NEC Corporation USB (rev 43)
>     00:02.1 USB Controller: NEC Corporation USB (rev 43)
>     00:02.2 USB Controller: NEC Corporation USB 2.0 (rev 04)
>
> My CF rootfs uses pata_platform, which is enabled in my working .config.
> landisk_defconfig lacks CONFIG_PATA_PLATFORM=y, so it hangs during
> boot. After enabling that, the boot gets further, but it still hangs:

I guess you have something like the USL-5P that uses the SH's onboard
CF interface.
Since Florian has confirmed their hardware has the PCI IDE controller
like mine and reviewed the change I think we're good.

Daniel
