Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB05828E0;
	Wed,  3 Jun 2026 00:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780445465; cv=none; b=Hq7Kn9E7kIYJjn9VTzd00KGhEHRP9EqBgmfyiXqczv9Ux8ftsmSiTMcLrVf7rD0zRrUcGvW0De26HAS++H4hGpJI0EoH+PaZm3Xfm/amDRV9DgR0aQp/UqUMc0/oN7NYiguoA4/R7lTI1hUKiXFNWSuBI9yEZhxRU6Kai1fhU60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780445465; c=relaxed/simple;
	bh=yKiAnta3ushJNks8hNMO3nO4LMuRnn1kOdtBTWOID+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E/ljB8FMa2vlFXiDzopVYI8BIIcJDLeSHU9dOCp7qn0WKWGD57V+6hW+753q1CmXJtHqkNcMG6fByAWPC+VP/ECFQhUDQ/uSXUoN/FvgrsnRgqnz23JRwHJn6xDPlmua4ZgkH5sh/7WXY//3uIk8jH1uNAMh/nvJ+6LMAE9iMUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gb72eJps; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gb72eJps"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780445464; x=1811981464;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yKiAnta3ushJNks8hNMO3nO4LMuRnn1kOdtBTWOID+M=;
  b=Gb72eJps1DHoCSKK4zLYTRPvT+6SDrT1338VyXO6uNLgZtsCsl7OyiSp
   BXcnoLM5hu6LBuQYMy7Gr/130qSIB7N87ZgVZD8rtjKBa8JC8zokd9cK/
   5kONsLc6Zn3Rchzj7MGpYVyyDyAaZT1kS1xkzxkt0QoLx+R9Lj0HXsTc+
   cJXaTLZFBoB0ez0YvFRphXFmedCm3njWmCqsPPSeFelxDVdWupxfXVRLf
   cNNuYa7F42/RJFTbdnOwpLufOProzvotSvYRCQFKfY/45jRGePpcbxFcL
   ToWBz650SVJTiKRHJnx+BZwlbjPKy7gjWRwoBrNf+QyyejyeoEi4XmOZB
   w==;
X-CSE-ConnectionGUID: 0AirjoTvRmq2hbHuZ0v17Q==
X-CSE-MsgGUID: EYMjGcWHSLGFGSxmIxzldA==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="83826036"
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="83826036"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 17:11:03 -0700
X-CSE-ConnectionGUID: 8vootplVSq+yZtuFs9QP5w==
X-CSE-MsgGUID: q59+KnO1SvWKJWedVeL7Bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="243008529"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.116])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 17:10:59 -0700
Date: Wed, 3 Jun 2026 03:10:56 +0300
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
Message-ID: <ah9xEP11aTiUHNeH@ashevche-desk.local>
References: <20260520-rsk7203-properties-v2-0-465f3308021b@gmail.com>
 <20260520-rsk7203-properties-v2-3-465f3308021b@gmail.com>
 <ah9TEJ_jrfcJwrb9@ashevche-desk.local>
 <ah9TXCcBPNh77Ut5@google.com>
 <ah9rHgAvprCTwEed@ashevche-desk.local>
 <ah9rmXIlZZUHAgag@google.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah9rmXIlZZUHAgag@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 02, 2026 at 04:52:37PM -0700, Dmitry Torokhov wrote:
> On Wed, Jun 03, 2026 at 02:45:34AM +0300, Andy Shevchenko wrote:
> > On Tue, Jun 02, 2026 at 03:06:14PM -0700, Dmitry Torokhov wrote:
> > > On Wed, Jun 03, 2026 at 01:02:56AM +0300, Andy Shevchenko wrote:
> > > > On Wed, May 20, 2026 at 10:13:19PM -0700, Dmitry Torokhov wrote:

...

> > > > > +	for (i = 0; i < ARRAY_SIZE(rsk7203_devices); i++) {
> > > > 
> > > > 	for (unsigned int i = 0; i < ARRAY_SIZE(rsk7203_devices); i++) {
> > > > 
> > > > ...and drop the above definition of i.
> > > 
> > > Why? I do not see coding style suggesting this. 
> > 
> > Linus Torvalds.
> 
> Context matters.
> 
> If you want this to be a universal requirement work on adding this to
> coding style and to checkpatch. Otherwise declaring loop iterator inside
> the loop can be beneficial but in many cases it does not really matter
> and can be left to the code author and the revealing style for the
> affected code area.

From the common sense perspective this makes code shorter and isolated, which
is a good thing as it makes it robust against wrong re-use of the iterator
variable.

Anyway, I replied already with a link.

-- 
With Best Regards,
Andy Shevchenko


