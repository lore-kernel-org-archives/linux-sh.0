Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795504633;
	b=BS8L9Ku+6XjynfQI/w32u4P+uynAi5GF4LDp7ESzCEKYcX/mWJWvGr52PXsf8RGuzJkJ
	 mm0+27iaIBSx/jcrNm45Po9wTHqzegcjYWcLFGUZChbg6z6aQk2yRRN2tFh3nHUe0w6QS
	 DAlAGdmVYUp1JAhF1SdzWHea1v/daiwN1kx40aMfm0J9iR7xPVAmPSjwGktLr+EXAiPEk
	 YLJDB5o/E9In27No2PWs4DSlrnpTBFQtCV7j8vdsJ+RzouTQvLO3+3GMuQ5cMS14xjrSv
	 M0Bb6krveY1gx9k0HO4V6SkxoG30S9wi6KLS+aaw43a+gnI58/RZdpGD8vAOhnuHqwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795504633;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=RQcDNanpw//dbaaaimKQPYZVp7hL9J0JtvEqkrn+7kE=;
	b=BOoOZkUcB4o7oH13kqIcdf3JkqZ8WC9tY77Cjyro76y8dvH4MDhClG28olZ96iFYQE7G
	 1FprZyhCbqhYkD8K7PKv3e+JosrnqBC27Q7+AFGtSD7lalcfrPB3oVpArGOEQSR0dPlx1
	 zUPNIbGW5vo+VM7ehSz6ZhAwEQnnuP//wuJdV5J2imneoaaLBxvW0zCY1HAql6kZSZArJ
	 UkXST7Z0Sr42FRBCK9MfkYlvAGED3+RTbChpFiNRqfMeATvxSogUAsSxJHArDsN+QkDgh
	 1Fz+UbnsWLE/XqEBbuaw0F9Ifx91oLPBwq0JRF1lev828YWAbg25IbUaN5QvzEDcb/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BwaWYyVN;
	arc=none smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE250606A31E;
	Tue, 24 Nov 2026 07:17:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE250606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BwaWYyVN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795504633; x=1827040633;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dugEFlR4OXZrsWQLYSz0uPzA+ZdKgtgmNmQXvziDeew=;
  b=BwaWYyVNbzgwvkgIbvGE5I+QjCmO4sK6FZu8apeNCrSXP3fSuppyCvML
   UbhXQE8I2mV0la4KPEcvRAjPm4MXhsw7gibozJdwc8/NJ0+bcNzZlyvBI
   bwVA+t3qpZd7tNHwTiBEdJrvP+rDPP5eGPUSJTVS9E0yjry5EFwsXQ9dr
   vRjH9bFzkVijnIJmbCfoPFIHWiotoQHoGDYbgrJTY9oIkgaF9Nfs8AUWR
   BMNcIwK8GzOfDsCyEBl0embReSxGNilxev9azG+QZ29rc8H7NGHDhv+FQ
   yPw8c5au9u2Xyqn/M3DWkXFEa6Jq77XJusO3ZNcgLQcmUCg6siUEtfluI
   A==;
X-CSE-ConnectionGUID: 9Q2mKrrjQJyvoLDuoe9oVA==
X-CSE-MsgGUID: ejq79uhrQlK8pCLiCUukkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4183791"
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="4183791"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 23:10:40 -0800
X-CSE-ConnectionGUID: QQVnudcPQpGWfCNIBVElPQ==
X-CSE-MsgGUID: GmZfKkh+SM6bye3Wjh6v/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="13284049"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.125])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 23:10:37 -0800
Date: Tue, 24 Nov 2026 09:10:34 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Arnd Bergmann <arnd@kernel.org>, Rich Felker <dalias@libc.org>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	linux-sh@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/5] sh: mach-rsk: rsk7203: switch to using static
 device property, drop legacy gpio API
Message-ID: <awU4aqWbKEs4Qhyg@ashevche-desk.local>
References: <20260929-rsk7203-properties-v3-0-02f84aeb8e47@gmail.com>
 <3a51385d-9649-4bd7-87b3-0caf9e462b2e@app.fastmail.com>
 <arzKNhmoL6yiGrzH@ashevche-desk.local>
 <dea00f90c205f8359baca729d8b0f31a@gmail.com>
 <ce838102be497ee6eab490b4454095b96e16d015.camel@physik.fu-berlin.de>
 <2e4f0d32c05d841feb367741bf8802fc@gmail.com>
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
Content-Disposition: inline
In-Reply-To: <2e4f0d32c05d841feb367741bf8802fc@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 23, 2026 at 03:55:09PM -0800, Dmitry Torokhov wrote:
> On Mon, Nov 23, 2026 at 09:12:37AM +0100, John Paul Adrian Glaubitz wrote:
> > I have been super-busy with CVE fixes but I will try to get into kernel
> > stuff back again later this week. As I mentioned before, kernel maintenance
> > is not my primary job, so I cannot act as quickly as people who are getting
> > paid for it.
> 
> I completely understand; upstream kernel work is not my main focus
> either, and I appreciate you keeping sh maintained in your spare time.
> I did not mean to rush you; I mostly wanted to check how you would like
> to proceed before the next merge window.
> 
> FWIW, I took a closer look at the current state of rsk7203 on mainline
> prior to this series, and quite a bit of it is already broken:
> 
> - Ethernet (smsc911x) has been silently ignoring its platform_data since
>   v4.13 (commit 3708184afc77) because device_property_read_u32() returns
>   -EINVAL instead of -ENXIO when there is no fwnode. That drops
>   SMSC911X_SWAP_FIFO, corrupting TX/RX packet byte order on this
>   big-endian board.
> - The RTC (sh-rtc) fails probe unconditionally since commit 689602e0609e
>   because sh7203 only defines one IRQ resource while sh_rtc_probe() now
>   requests IRQ index 2.
> - sh-cpufreq fails init because sh_cpufreq_cpu_init() never populates
>   the per-CPU clock.
> - Enabling gpio-keys-polled (disabled in rsk7203_defconfig) clobbers
>   LAN9118's IRQ0 on PB0.
> - As Arnd noted, the rsk7203_defconfig kernel no longer fits in the
>   4 MiB flash, and USB was never wired up for this board.
> 
> Given how long some of these regressions have gone unnoticed, it seems
> extremely unlikely that anyone is actually using mainline kernels on
> rsk7203.
> 
> Rather than worrying about hardware testing here, I think the simplest
> way forward is to just apply these patches (with Arnd's Kconfig tweak
> folded in, or I can send a v4 if you prefer) to unblock the legacy GPIO
> API removal,

I'm agree with this.

> and we can resolve any bug reports if they ever arise later.

...or even remove the board support completely (would be interesting
to see somebody investing time in this HW to fix all what listed and
not listed above).

-- 
With Best Regards,
Andy Shevchenko


