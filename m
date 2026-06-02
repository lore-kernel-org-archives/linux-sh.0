Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2C32C326D;
	Tue,  2 Jun 2026 23:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780444347; cv=none; b=c654tf3iMX1uVjemavWLz/Yk2tWghR/qyN9f8EIxEql9zeCb1dYlvI+i95VWWxo4xouWTtABM7eSYwEMz1Z4jJ15K4nH5cSWlYynog1Gf3N3wJZ/JrNC1W73QcaT4e58Q5vSSS3BBz/uYX1wriIPRk3iT/PzOuU/jwXNeZipVxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780444347; c=relaxed/simple;
	bh=2pM61gANag9UxeUgUTkjFHRngYjQpcHazKMMjoItY3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UXY/ExS4mQ9NdWanuexHMjqSIXyPZMnv6LMf5AUkK3vAyPMnMnFJq7WOYngBi59vnSkjNW3XbigtIoa1G32K2PuV3BzvxGqZGy7j30+vmeIuGj7pp0aHgTKIAySxc2Sa0CF1gdLM6rBg4lIYvbhHLxaCh6hiaLFhFEQ8AgRKooI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ij+ZvkPd; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ij+ZvkPd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780444346; x=1811980346;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2pM61gANag9UxeUgUTkjFHRngYjQpcHazKMMjoItY3w=;
  b=Ij+ZvkPdHAWUG3Dk4cVt62+barM3uhWZw+q24WPPuqJ6+WN5oH7Odiaf
   9LZaXD7CrpBpcq64QXn2eK7QvzuaFSh1W+1nUodLJ/JVcPtoRv3ZgTKja
   QzGaE1hdwfGJiVN7r/kOgWqeh5Gj8n5vQo/HJlVeEv8XQk9hnqspzP4bA
   19aAXaARmILUe4iR3NaIYaH/cjIH0NMriApp3Xq3Y+SLEcF0OZL/RggkF
   TVPXCjH+04okffRtIvfURwdCn/NaQjrgdn/Aox/ao77dxnd29UM2ZqSFC
   FkEPQRxDywqkH4jCVuBCk+3Abe+W4omtxZuiE8UyU8rtXef6t3Ewqbdoq
   Q==;
X-CSE-ConnectionGUID: NsEcQSOGQh6URoZ1xWkzXA==
X-CSE-MsgGUID: Hic2+JlJSAGikHaT+6CrIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="81370895"
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="81370895"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 16:52:25 -0700
X-CSE-ConnectionGUID: Iz7V+Vs1Rc6lHE6yo3ifpQ==
X-CSE-MsgGUID: i9d+zh/PTCyMOtMRwX6JjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="241071225"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.116])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 16:52:22 -0700
Date: Wed, 3 Jun 2026 02:52:20 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Arnd Bergmann <arnd@kernel.org>, linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2 3/5] sh: mach-rsk: rsk7203: use static device
 properties for LEDs and GPIO buttons
Message-ID: <ah9stBekd0TfMnZX@ashevche-desk.local>
References: <20260520-rsk7203-properties-v2-0-465f3308021b@gmail.com>
 <20260520-rsk7203-properties-v2-3-465f3308021b@gmail.com>
 <ah9TEJ_jrfcJwrb9@ashevche-desk.local>
 <ah9TXCcBPNh77Ut5@google.com>
 <ah9rHgAvprCTwEed@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah9rHgAvprCTwEed@ashevche-desk.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 03, 2026 at 02:45:39AM +0300, Andy Shevchenko wrote:
> On Tue, Jun 02, 2026 at 03:06:14PM -0700, Dmitry Torokhov wrote:
> > On Wed, Jun 03, 2026 at 01:02:56AM +0300, Andy Shevchenko wrote:
> > > On Wed, May 20, 2026 at 10:13:19PM -0700, Dmitry Torokhov wrote:

...

> > > > +	for (i = 0; i < ARRAY_SIZE(rsk7203_devices); i++) {
> > > 
> > > 	for (unsigned int i = 0; i < ARRAY_SIZE(rsk7203_devices); i++) {
> > > 
> > > ...and drop the above definition of i.
> > 
> > Why? I do not see coding style suggesting this. 
> 
> Linus Torvalds.

https://lore.kernel.org/lkml/CAHk-=wgy8p4is8ApEQCT5NS7XFb+NXeo-TKz7jRRZVksLLBSrQ@mail.gmail.com/

And IIRC it was another discussion (more recent than that) where he again
mentioned nice of use for-loops with local iterators.

-- 
With Best Regards,
Andy Shevchenko


