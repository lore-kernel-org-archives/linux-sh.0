Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795478114;
	b=EFM/qbMJw2+V83E6nLSRmf7e/ZbkidCybubMFNyX9txOoTFfnTNj7z+V7WQ7+zkia9az
	 fj53w8fpjMbTxDpLBkLeURXxjALk8eKZLUwQutob1gEqiOjvcH/z2wTQx89HU1fHqIE+u
	 peDYi4bgLYi1xDKUK9tNRRwnWYrz7eNJXfr7GkvmMJpas82eL/x0zVNPX5bICrRKq7Mvl
	 bPUbH/Aem29FofuDkJdakJd9zGk4/4+hHPzf8myocDNH+art/k9hh825V7VgqhsrfnV5B
	 0hiUhS2siyKDI9BtMCBuTs2R/hHuPo1i5vBw4nac8uOxkswYp+8lcMt9RE7dS/I/tbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795478114;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Content-Disposition;
	bh=qHMYy/oSMlkongpCToMb8VA6CvYEq6WBh/L4ubY/+kU=;
	b=Ltin/jxFjvfEh9HTMi89BnFlWoi+S/3igHfxpHqmp5D0DB+i5BrhyhFuSfoT/WaGPGAu
	 xT74RXUgV1Tm9cmmKkQXJ9e2EXHcrImg7AkpqISmuMSWcYdr64Rpf1APOr6GCkm0RlAMt
	 94oC4k6el67Sm0n3QUBnaCeLTJibMtMIYpBIuElGFhTrU5YZ6sjeVIw7FS833BDDF3L7X
	 Ee7UdrOmJWPVvPnBtRfAPQVHOox7qyr8fZWWpofTbTU8vfOPqRmBHtNeHKRkUTPqfphDB
	 0K5vaM/qwkBjC/UC5H7hMOgxDyO9nQAZxwm6xde/hx7hkaRa2d0N0VZpRfabbdYNPgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aur9tjvm;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED9F606A321
	for <linux-sh@vger.kernel.org>; Mon, 23 Nov 2026 23:55:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9ED9F606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aur9tjvm
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-38564b4b017so4140441eec.0
        for <linux-sh@vger.kernel.org>; Mon, 23 Nov 2026 15:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795478113; x=1796082913; darn=vger.kernel.org;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qHMYy/oSMlkongpCToMb8VA6CvYEq6WBh/L4ubY/+kU=;
        b=aur9tjvmrmBWdMGBaCXGgk6MJeEt5iNGa2qSXqZLmaZBc2Kv8JbEJJBt3VS1koB28I
         wPtCKsMymrS7bcRsinSR6Pps6kUG8TlhWYhgGqFtf++305HmkHiwfHMIJuHdF5Ap6cip
         Rljt5/NlIZ9U9mhtnAmYzUhjNT3aCSRb42YABt/qwncHwyKfNii5c0Tmyed+CL6BD4c4
         SNrJeBXEoWkhMvBsdtQrDHPSWrJVVbf385hkj7Mgqs3sqWHZW4zrQQdrvg6+xWHKhuJz
         hAqpP6+B3jdDREVa4WW3LeGkAnl/k+FgkY0rMRFgWfYPg4TMz1LjwlQP9TfhRpV0t22K
         dgYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795478113; x=1796082913;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=qHMYy/oSMlkongpCToMb8VA6CvYEq6WBh/L4ubY/+kU=;
        b=EtUCB1SjWPiGHZ9cr6gjfrShuTV48eKbFEWYFyVm5duiymP73J593ldmTz0RezEKac
         fzU4rvc8Aj83LOLMFrR/j49Th5YldxZskgMFKdlOIELLbZfwHqgaFmU8TKBRhmk3L2Oq
         1pKKakBd+HwINnTH3qFYJZU61wG5VbHXckX422l+o7BCh8vYk1hR3+d8GjM++NR7CNdz
         Y6eSQULzCYjwdfnY2ZkoQXAW62VNj5xNTYc3889PJCOWN7ZB0FXYQCYlKU+dINYPdpkU
         ZLBwHDggnvYzW+sfLPl8dryH3ckq1SmV0iRYX0BlLf7gjW3qf6bRjrJDXfuDFb9MtK/o
         gi4w==
X-Forwarded-Encrypted: i=1; AL+hErHhlFb0zUhGbbQDIv/qGLKosuU8R0ZMO24UXA+yD0o83WVccRXpTcX+RBJn/gtBdm+V0iHv5/lO7w==@vger.kernel.org
X-Gm-Message-State: APuU4Z9ljRBzkruVmuAWBISv08fen4sgeRkGk0m86iZ2PUT6OyYKxu5j
	v1xItzDy4wLjhMTphUJNzBXES/cRhypTpD2JsLA6ZxMWYScRYQH7nRs+muHAFiMS
X-Gm-Gg: AZFdTZftlsVSBzlA5E54JjgWOFrnXGtnDoD7ffDmoAvw7ghUo2BABW37scXn2vPpiIf
	HqJimkGCUeMxQTybwkVuzs3SxNLVUIqfov3uRVpSYqp2HhszcwUTRKqOb9taKYz5oY0P68prZaO
	2rEBEmjGKgsX36cXoD9IVfDf3Y5lPiYe/F174d/xHePKeNaYVlLSvLu8kGu2mbiMYOAtPzIVAh5
	wZ0S4oH2DSylBjp058+2jDu73+z7wOZ2AMpe1EKYMrLbhj9kAVnzpCn6PUjeY9UqDpsyqiwOBqQ
	upWQW+Iem6Znk8Ol0riqoH1KqpePaKW68IPXlMw8Z5VEGdteQA/TmaHXFhTK9l+KEAfGb9I7yIV
	IF4Sqqi01Gie5A/fBB/4zheyQoF0GyqVMBKYQx2ba/OkN/hid4R9O/j+iQGbSEMMOZUXj19noTx
	cc7Hls5xPwx8yR2lX3sLwlyrD9Jx+vJ7iPWCjgjA7bZOTVA1ve6gcYfdLnbB491V4Hjnk9MH7g2
	W9HV7rpEc9560ZhaAIBvkWb8hixJT8oT+BfMtghBQ0lgKC+NXKS3Yjnvxn/dTAPe6f8LYGRlRPx
	g+JVwArojPP+UvzX3X6FDqnz/fbF8JKed8NakiBh0vgF0Sgp6HBC0SUk9FKAtaMTon74wOA4j/k
	Ak+pUnbYXoGenZ9U=
X-Received: by 2002:a05:7301:6a05:b0:386:a0dc:2e2d with SMTP id 5a478bee46e88-386a0dc3082mr11090356eec.16.1795478112647;
        Mon, 23 Nov 2026 15:55:12 -0800 (PST)
Received: from localhost ([2a00:79e0:2ebe:8:4121:d698:201c:9274])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385646633d0sm68245062eec.3.2026.11.23.15.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 15:55:10 -0800 (PST)
Date: Mon, 23 Nov 2026 15:55:09 -0800
Message-ID: <2e4f0d32c05d841feb367741bf8802fc@gmail.com>
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Arnd Bergmann <arnd@kernel.org>,
	Rich Felker <dalias@libc.org>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	linux-sh@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/5] sh: mach-rsk: rsk7203: switch to using static device property, drop legacy gpio API
In-Reply-To: <ce838102be497ee6eab490b4454095b96e16d015.camel@physik.fu-berlin.de>
References: <20260929-rsk7203-properties-v3-0-02f84aeb8e47@gmail.com> <3a51385d-9649-4bd7-87b3-0caf9e462b2e@app.fastmail.com> <arzKNhmoL6yiGrzH@ashevche-desk.local> <dea00f90c205f8359baca729d8b0f31a@gmail.com> <ce838102be497ee6eab490b4454095b96e16d015.camel@physik.fu-berlin.de>
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Post: <mailto:linux-sh@vger.kernel.org>
List-Help: <mailto:linux-sh+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sh+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Adrian,

On Mon, Nov 23, 2026 at 09:12:37AM +0100, John Paul Adrian Glaubitz wrote:
> I have been super-busy with CVE fixes but I will try to get into kernel
> stuff back again later this week. As I mentioned before, kernel maintenance
> is not my primary job, so I cannot act as quickly as people who are getting
> paid for it.

I completely understand; upstream kernel work is not my main focus
either, and I appreciate you keeping sh maintained in your spare time.
I did not mean to rush you; I mostly wanted to check how you would like
to proceed before the next merge window.

FWIW, I took a closer look at the current state of rsk7203 on mainline
prior to this series, and quite a bit of it is already broken:

- Ethernet (smsc911x) has been silently ignoring its platform_data since
  v4.13 (commit 3708184afc77) because device_property_read_u32() returns
  -EINVAL instead of -ENXIO when there is no fwnode. That drops
  SMSC911X_SWAP_FIFO, corrupting TX/RX packet byte order on this
  big-endian board.
- The RTC (sh-rtc) fails probe unconditionally since commit 689602e0609e
  because sh7203 only defines one IRQ resource while sh_rtc_probe() now
  requests IRQ index 2.
- sh-cpufreq fails init because sh_cpufreq_cpu_init() never populates
  the per-CPU clock.
- Enabling gpio-keys-polled (disabled in rsk7203_defconfig) clobbers
  LAN9118's IRQ0 on PB0.
- As Arnd noted, the rsk7203_defconfig kernel no longer fits in the
  4 MiB flash, and USB was never wired up for this board.

Given how long some of these regressions have gone unnoticed, it seems
extremely unlikely that anyone is actually using mainline kernels on
rsk7203.

Rather than worrying about hardware testing here, I think the simplest
way forward is to just apply these patches (with Arnd's Kconfig tweak
folded in, or I can send a v4 if you prefer) to unblock the legacy GPIO
API removal, and we can resolve any bug reports if they ever arise
later.

Thanks.

-- 
Dmitry
