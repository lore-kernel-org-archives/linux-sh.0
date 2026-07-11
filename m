Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4144F239E7F;
	Sat, 11 Jul 2026 08:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783759484; cv=none; b=PtsQfxpRBp2TOfIzUFMS3pEMZ44B75l3CYDZQnNxU/TUvYX6DhUMw292gze+yt+AXt1FJ/EFzH9nt0hX1cGGIybxyhmgtRQABoShMCAQZFE2eMiL9vnKTOy3VmFBCRVIJhWbTpCDYRgLjrVqkjWcPjw5HUptL5YP9F29Y5yz4fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783759484; c=relaxed/simple;
	bh=oV4niTZ2Ii67O+QvvUkRW5HxiGVnilwQlup0VtSDcog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IadttvvFchqGrxl69ATxyCODuUse27fcJYt1dQa04uODrKy3dzuYsXM8UiBQ0AndHy0kbUtpJV3ZAcweAkiLAkfAgQBzUSFixBZ+u0K7Mrasvt+e1LqNIqpFMpMMjwWAtJBPOqCkOLLxKB44ji1x1eJkT47G0o7WHpbzT9HaGnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KqD1CqtX; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KqD1CqtX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783759483; x=1815295483;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=oV4niTZ2Ii67O+QvvUkRW5HxiGVnilwQlup0VtSDcog=;
  b=KqD1CqtXfg9/dGnArHCGcSnQaPpl/VbJjuw/50/mKiR+KBAYeAZ3tDFz
   JrNLXxDo20yfk8aK63pEDuFGcPJ/ukeZ/OgvRjSjSK9ZkWUTixi+pXcrX
   NkPYQXHJw9Wub0StqD5eOrSNwhr4DArNhrpjJj0cV7b77uFx46WJn1ycP
   1H27qC4tl9g6S5hT23V3lJ9ORrU916aBfME+UcyOYpZxxbfSXPiXj3BjE
   +eLyuRhyAgXHy3AItFsJB5kPeihwtmxCm0lwwIRxMjOW9/DETFifXHHQf
   bZb5GLsg15cwWe23wK7tqqrrq75KAknVK2Z6R7T1tVGo1wVW2MKWZhc/q
   w==;
X-CSE-ConnectionGUID: p87UPW7bSTqFFtKYfEG3zQ==
X-CSE-MsgGUID: v/bdBJpBT8eozOQoP0PwEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84465588"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84465588"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2026 01:44:42 -0700
X-CSE-ConnectionGUID: gnBGeX6MRHKdJVQguoopjg==
X-CSE-MsgGUID: KhKBUYNSRPew8W2lbbZOHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="248708660"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.254])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2026 01:44:39 -0700
Date: Sat, 11 Jul 2026 11:44:36 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Linus Walleij <linusw@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rich Felker <dalias@libc.org>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Arnd Bergmann <arnd@kernel.org>, linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2 0/5] rsk7203: switch to using static device property,
 drop legacy gpio API
Message-ID: <alICdFwIg91NOZzn@ashevche-desk.local>
References: <20260520-rsk7203-properties-v2-0-465f3308021b@gmail.com>
 <akyJOW79W0xvI-P9@google.com>
 <CAD++jL=Wx=mHORGDU_=PgGrOCdTSVes63jgSL2xQX+rCE2uaMw@mail.gmail.com>
 <f9fc5cb2ae36593db9db8faf7ebcdc224842f9a0.camel@physik.fu-berlin.de>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f9fc5cb2ae36593db9db8faf7ebcdc224842f9a0.camel@physik.fu-berlin.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Jul 11, 2026 at 07:14:48AM +0200, John Paul Adrian Glaubitz wrote:
> On Fri, 2026-07-10 at 21:05 +0200, Linus Walleij wrote:
> > On Tue, Jul 7, 2026 at 7:08 AM Dmitry Torokhov
> > <dmitry.torokhov@gmail.com> wrote:
> > 
> > > Gentle ping on this series... It still applies cleanly and we need this
> > > to be able top drop legacy gpio interfaces from gpio-keys (and
> > > eventually from the kernel).
> > 
> > I lost my patience and queued it to the pinctrl tree on an immutable
> > branch:
> > https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git/log/?h=ib-rsk7204
> > 
> > Then I merged this for v7.3.
> 
> I'm sorry, but I wasn't aware that this was an urgent patch.

We are at the finish line of getting rid of legacy GPIO approach that was
marked as a such like a decade ago. It's not that it's really hurry, but
this particular series prevents Dmitry to finish his part what he maintains.

> I'm doing this as a hobbyist and I'm working on my own pace as I cannot
> always spend time working on kernel maintenance.

Right, this is fine, the problem is that we are not working independently on a
project, there are areas where it's possible, but in many cases one's work may
be crucial for the other's...

> I'm usually collecting patches from patchwork [1] for review and then merge
> them in batches if they're fine.
> 
> What I don't understand, why did you choose to use an immutable tree? Is there
> really a need for such an escalation? I find that a bit rude.

...that's why it's good to have it being moved forward. And having an immutable
branch is actually *to help* you, and not the opposite. Now you can simply pull
that branch into your tree as a whole.

> The v2 patch series was sent first in May, so I didn't think this was already
> a long time.

Pace of the Linux kernel development is 1 week with the release every ~9th week
(with a gap ~3-4 weeks due to end of cycle and merge window). Currently is the
first third of July, so... make conclusion yourself.

> > [1] https://patchwork.kernel.org/project/linux-sh/list/

-- 
With Best Regards,
Andy Shevchenko


