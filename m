Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC68278F3E;
	Wed, 13 Aug 2025 12:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755089416; cv=none; b=kq8dEz9pg5wafy84RDXqEb527wM2tPKgYbWWeBZcGUNmsXf6/koPpG7+DgiMaN6hRjUyZiPwYTsQn0Bs1iLeTSM8ZDr3lc1r2e17VYUwcqjzOq18Fzyrs1NY6Bkaf1GxR14n0Af53DRs2LR5288BhjxcKByw3dBbiFmFeb54pKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755089416; c=relaxed/simple;
	bh=h2qE3d1k4zX4J4eMjjnoCt2JzG6oQDrjoGfgN+AZASY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tCLlD6UQl4MhVMiPfe2xwgeRtmH54U3COeSKFRfJafpCc+imxBsGY4XMRs2qP9i8KpIahH/B9tpdgIchgh/+rubvlLZSbjX8VEiLpPy5OthLo9fPI1KfKdE/FGnHRPszjjZBuSySsdgp+LcDHUU1ognJiO7hH4ByS05wM59XyM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jSgkgc8d; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jSgkgc8d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755089415; x=1786625415;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=h2qE3d1k4zX4J4eMjjnoCt2JzG6oQDrjoGfgN+AZASY=;
  b=jSgkgc8dgDRfiJrX5U6Vn9gHZGvIeLJEtIOKi5aoVbvAGgxkcSKXpkkg
   jPi0xxKVkN4B1Tyxzv5JBBAd53y4H23kywPl1smNf5UwYNZvFwphDWBhe
   O0OUNyGUBCKDKfyGh0TpHpWuHj/8YiBibm5vVMdeZ1Rb0LVWl57t5Z3Vi
   nFhrlTS6b5Hn/eLGBfV0k0gqtEQL+g5UNSbbSm4YSLfCbjN18KUSemyDo
   ccLrYMiK3w6bOCT1SqyWnZChU+wCcyN4xJiBQ33XS4IJdJl2mFW2rPR2c
   4fdAInUySeEloBRccurmfMKVCJ0NbUEbVEvl26YMkAIBuOwC+NYnbfJ4t
   A==;
X-CSE-ConnectionGUID: O3ubndyQSwGT5ZIyj2OM3w==
X-CSE-MsgGUID: YLh33sXtR1WljhghmkLFWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="57447265"
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="57447265"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 05:50:14 -0700
X-CSE-ConnectionGUID: sA//6IphQF6LcBtvr79B4w==
X-CSE-MsgGUID: 4WtPgmLCRV+BdQ3OQvaPjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="197462068"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 05:50:12 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1umAvh-00000005REG-1hcZ;
	Wed, 13 Aug 2025 15:50:09 +0300
Date: Wed, 13 Aug 2025 15:50:09 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Arnd Bergmann <arnd@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sh: mach-rsk: rsk7203: use static device properties for
 LEDs and GPIO buttons
Message-ID: <aJyKAQJUG7hmO2pT@smile.fi.intel.com>
References: <jwtdoptatzfo47mbpmmjwhhhjn4mbw6ekp4gtoopca7azbcelo@uvtz4w2ga5qn>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jwtdoptatzfo47mbpmmjwhhhjn4mbw6ekp4gtoopca7azbcelo@uvtz4w2ga5qn>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 11, 2025 at 03:44:57PM -0700, Dmitry Torokhov wrote:
> Convert the board to use static device properties instead of platform
> data to describe LEDs and GPIO-connected buttons on the board, so
> that support for platform data can be removed from gpio-keys and other
> drivers, unifying their behavior.

...

> --- a/arch/sh/boards/mach-rsk/devices-rsk7203.c
> +++ b/arch/sh/boards/mach-rsk/devices-rsk7203.c

>  #include <linux/gpio.h>

Do we still need this one?

Ditto for the rest similar cases.

-- 
With Best Regards,
Andy Shevchenko


