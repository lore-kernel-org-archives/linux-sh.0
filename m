Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0503B83F9;
	Wed, 30 Sep 2026 08:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790757437; cv=none; b=QSXt6kYevLXZJBDLX4AgCtNLLTvc3VJYAEyoQF5UwYJ6saGjFgO4XXAx6gJk4isbuqUctXhZ8Zah1VZJb9rrIqGUWYE/qjJEPOfNSMHUgbT7mMFkGqLy3LWIssSrfDw369k2lSJaPXywszGPrTiFZUyk5rh3ZYSHF6ZSrQPD5pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790757437; c=relaxed/simple;
	bh=D36bru2Y09Tqy8UqJ7Z7t2+mwKz/02jpY1pHkvwm0tY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OrjnwHI8+VLtgR4/fRhzxbV8j0FVeE0FR/MobWUfgufI5tQmSGq9xm1P7lR62tyIWfzaj7SN47ZhEcQIGR7CvSUX+Hxs51ZLAU2EgmiRUjLyuvpv6/2B2lqj3RUrRfY30u+1YSEcv5SC5ZDMVTod6kkypjAQVrEMcUN34TmoMP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ll5Oe3s+; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ll5Oe3s+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790757436; x=1822293436;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=D36bru2Y09Tqy8UqJ7Z7t2+mwKz/02jpY1pHkvwm0tY=;
  b=ll5Oe3s+Vs3+HhNgVrvQ0gYjwn/lzY9YVceoKgLb3uzio3RGtzpdrrjl
   M1w2xZgQAmIFyrtWWCAYjIJEpJi/3Odrvji0SGNCrCqavwy4AaTpwnP+a
   PPY6bGvgsqGqeL9/GX9DJoLJPbU8qJrsAY5ENVXTkKmfTWT4SCrfwT3Hb
   GJRPxt+jUs+LSsW0YHcqItv64y0fMhsmiGreQS8uoDxgigMw+tslJxOLc
   MjwnWF26BLiAuEPCdgDl2qRUtWjjuQj7kg09ejKOko0p1OKNY2iBVSV7m
   OdZfodW3Zq/LLuqwDWG9QH2xMNa4Gy0PldPimab+sPlvI182+Ex7Nw4FK
   A==;
X-CSE-ConnectionGUID: MhEOUsg+RZKrOWRrXbHXmA==
X-CSE-MsgGUID: LSIJjc0zTHSMgvdR5bCXQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="79056300"
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="79056300"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 01:37:15 -0700
X-CSE-ConnectionGUID: 7OH+ofCXR8Svb2TdGvNEcQ==
X-CSE-MsgGUID: +csRZVPqQ8a858Yv8CI8JQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="275664721"
Received: from spandruv-desk1.amr.corp.intel.com (HELO localhost) ([10.245.245.137])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 01:37:12 -0700
Date: Wed, 30 Sep 2026 11:37:10 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
	"open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v3 0/5] sh: mach-rsk: rsk7203: switch to using static
 device property, drop legacy gpio API
Message-ID: <arzKNhmoL6yiGrzH@ashevche-desk.local>
References: <20260929-rsk7203-properties-v3-0-02f84aeb8e47@gmail.com>
 <3a51385d-9649-4bd7-87b3-0caf9e462b2e@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a51385d-9649-4bd7-87b3-0caf9e462b2e@app.fastmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Sep 30, 2026 at 09:23:21AM +0200, Arnd Bergmann wrote:
> On Wed, Sep 30, 2026, at 06:57, Dmitry Torokhov wrote:
> > This series of patches converts rsk7203 to use static device properties
> > for its devices, including gpio-keys and gpio-leds, and removing
> > dependency on legacy gpio API (in favor of gpiod API).
> 
> The patches look good to me. I have build-tested this with the snippet
> below and my series from
> https://lore.kernel.org/all/20260907090956.2825703-2-arnd@kernel.org/
> to check that no use of the legacy interfaces remain.
> You can probably fold my one-liner into your last patch.
> 
> There is a trivial conflict between your series and my patch 2/2
> "gpiolib: remove linux/gpio.h", but if yours gets merged, I can
> resend mine without that line.
> 
> > To configure pin functions the board is switched to use gpio-hogs, as
> > doing full conversion to pinmux is too challenging without access to
> > hardware.
> 
> I would guess even with access to hardware testing is going to be
> challenging, I noticed that the defconfig kernel does not fit on the
> 4MB flash any more (even without rootfs), and the USB support was
> never added for rsk7203, only for 7264/7269.

...which induces a practical question, shouldn't we just drop the whole thing
for good?

-- 
With Best Regards,
Andy Shevchenko


