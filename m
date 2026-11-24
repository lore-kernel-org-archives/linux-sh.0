Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795509403;
	b=B+t8/GKn1xbyZ8F+4d00uJ2YhhAHLYjyJt+EXWDlJoY8Dz1BXt81Cn5/I4ADU6w40YcO
	 gy67n7eT1IlFNGVyJnOnBInKsL4PfSOEQFC9wICMrkY992REY/Pa9tia5N55VdHOlpvgn
	 bmHnqHFsdV74Y/gNOUuguwLV33oCDn+BQi0WnFqWhA6z6iWau4GlsEYjnt6wLZQT0K2Rc
	 PjFQVd8zpbtp8GXyYUw3eT9OHira+BPHrTa9QrqTkAJHWNj8Go5BIOvU/lLX2LO3u97RD
	 +VoDOPMdrVPSM0kBE/vx03r8G+6xEOrH5rf1vSTr6XAzTu6wseyj7EW25QFhz2hTMjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795509403;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=1w0d9sUWZdCK+5rk5sXvxrv9OLJKTusbo8yD1kTvInc=;
	b=ogGIjQN6kJhxRWul2ZbxFPh5uGPHEbfGulgOkIy2Bse58IYjKu8PMbJ/H0PIGRoE0Js3
	 brUohQGlQRSD7FbcVMPbG4YXuihu3gNyH3Qs+diMQ9mZxtpmEsrX515wDObPhf0RzqLkR
	 oxNO7ajSFEmPHbTDlgoeXl3wLJAEqJpAwz0QkOw0CncNF0PbVd7uXIdkxUP10ZLrVCa+k
	 Y8w+BbKtqlY5Yc7hOQxve5O9pAFKABeDFrv2OLKDwaTeq/w4CcwM7OyD7F3jcz3Eveduf
	 dj7FVIhpsZZehXHSgS8q2ASFcRXXi/j6H6VLi/TKTcbi0Xp0VWzkpz/WSoDJfOcpiYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VRpGars9;
	arc=none smtp.remote-ip=192.198.163.8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7C9606A32A;
	Tue, 24 Nov 2026 08:36:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E7C9606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VRpGars9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795509402; x=1827045402;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PlfoI6XoxhvXEyYiutsIZROptYu5/Xaq/GJDeIv8Qn0=;
  b=VRpGars9VkFjFoFLKs2/6nTqvZv8++Ajc+kzFQ+L7oyHlRX+7RtAXkEg
   h9E1P05SkaVMAbAQm60X8nAcWuU7kSOQnabu+wVXFYECjpG5bfkAX/9zI
   BxZS/0DdBY7LEe5bsNjcOvQy58joWjxbXj4XauA8P+CNZgIvqHf85QZW/
   gIicfAnZYxaZNKlzbWNwvCAu5jGrU92NNpH5It/G3whvFQzaez5rUu6pK
   BkumzDALXT07yZY52V3Y3ldzcrDeoZuGpOEeIlki6MWnwr7yjMv9svmU0
   ENYkuJBUCSEA0pL2xANFkcm/Gat+WYUqDVcOFwGPszt87SjLVC1kNH3Xf
   Q==;
X-CSE-ConnectionGUID: ioYyK0scQl2Q4Z48JVrqLw==
X-CSE-MsgGUID: gD0wNjwSSe6RuSAK65hUbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4231038"
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="4231038"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 00:36:41 -0800
X-CSE-ConnectionGUID: IxCl6M1tSF+dHXU2MX/Q3A==
X-CSE-MsgGUID: gNKa3/ZxRu+v3JEjljxgCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="11726749"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.125])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 00:36:37 -0800
Date: Tue, 24 Nov 2026 10:36:35 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
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
Message-ID: <awVMk-aGMRug22ss@ashevche-desk.local>
References: <20260929-rsk7203-properties-v3-0-02f84aeb8e47@gmail.com>
 <3a51385d-9649-4bd7-87b3-0caf9e462b2e@app.fastmail.com>
 <arzKNhmoL6yiGrzH@ashevche-desk.local>
 <dea00f90c205f8359baca729d8b0f31a@gmail.com>
 <ce838102be497ee6eab490b4454095b96e16d015.camel@physik.fu-berlin.de>
 <2e4f0d32c05d841feb367741bf8802fc@gmail.com>
 <awU4aqWbKEs4Qhyg@ashevche-desk.local>
 <6eb2202457d5703192a513b4e898dfe6653c1b0f.camel@physik.fu-berlin.de>
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
In-Reply-To: <6eb2202457d5703192a513b4e898dfe6653c1b0f.camel@physik.fu-berlin.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 24, 2026 at 09:27:22AM +0100, John Paul Adrian Glaubitz wrote:
> On Tue, 2026-11-24 at 09:10 +0200, Andy Shevchenko wrote:
> > ...or even remove the board support completely (would be interesting
> > to see somebody investing time in this HW to fix all what listed and
> > not listed above).
> 
> Can I as the SH maintainer at least have the last word on this? I'm not
> really happy with the fact that corporate developers are chasing hobbyists
> in the kernel developments all the time.

I'm not objecting that! I just expressed the concern that with pointed earlier
lack of time (did I misinterpreted that?) and list of problems it really needs
a time investment (note, I haven't used the word 'waste').

> You people are being paid to do this, of course you can work on the kernel
> on every weekday. But that doesn't mean hobbyist developers have to pick
> that workload as well.

I'm not getting paid for reviewing, say ARM related stuff or stuff that is
unlikely to appear on say x86 platform, so I'm pretty much understand your
pain. Please, check the history of changes I have done in the kernel before
judging, okay?

-- 
With Best Regards,
Andy Shevchenko


