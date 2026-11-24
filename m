Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795510020;
	b=MZHt8S2rq7daeBPI/udrjYN8b3224e69JaRWSxo05oncXoXDqbVruJTawCr7l7ij+eUV
	 X777Y+u0++heqJa4WFjpF6mmQEZMQKA6DDJ62Lcn6jzPvAoYY/zozNDjlXBNrSYYF+Np5
	 AJVr6YXJv3u0nrQBQ6iJXlWTqmWI4KaEepWBsAaFkL3Wp7J5P1jaDvtDq5HIxlvV42uFS
	 vSwev1qkHFPSxvxTchuYZ2S7p8UUVWCyF8oKXUjlarcT7HFwY5CIYicTh8A6wPBA4u6+C
	 qsfsFhgvXuMjkDIpAAgDIb/yFaHReX5G2s+7iec2aBPoejibCe2FVGD31CpbG1hvwmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795510020;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=VicFn4lVZUmbmwNsi8pCR0se7gsROCvTE9OiCVouf8g=;
	b=Gv84ecvuJGakPf4KK3eRrlTV0QYODgEBMiyhNyvTJusszJdF7ywSfkZNQbJzaq/THOAg
	 1S6zxclOiTSe6FNds3YtCxEXQ26jSCRxPcZ+XIpYSzcz+1gCiUPCe57zVwYynIqfQUZm5
	 SsGrr8qkQpx6qAZmLmuo3WjYsO7xp7n1Y9sh6u7cPINaummdlXm+Cq25lzvrpRbefQwrP
	 N/ddJRKzhzAeaFZVpldOZXQfrdRenQ60cudFC6m7sE/xuOQKvSk//joAcbQVEoTp7+UQ/
	 ztQ0OkqzqomXJZ504MKPPqpIeJjgKqsEE3HI9Q31giHp8BLV++htiXnXV7lFnu1uX6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CmTKvdWH;
	arc=none smtp.remote-ip=192.198.163.8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD0C606A31E;
	Tue, 24 Nov 2026 08:46:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8AD0C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CmTKvdWH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795510019; x=1827046019;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GMCmewBzBcfOkv8aULQ/+EyHsAV8VLb9fhCrS1cy0g8=;
  b=CmTKvdWHuTP2mH4IRB8YZlwwSZ45FPZ1DLUJ5OkOsMbCPjtfE/iN7J8/
   Ibhbghr4C0see8u2RgXdwh1vvUTiEXvfvc6v2HgiXe7YRhQTiMWsjg4K0
   oknla30jm96kmj+RvzcZvC4o5Vg55Tujc0VAfil6UC3ojg0fa8gkMEwS5
   Rf5SeZRAeWFKsWR4DjBTzFwhBlYinQ3cm2PC5xPn+/IFdh9yTUp8DAuJ8
   /TQUBuDe1Yh1zB+ylOOSl+9OazFKN/Eiry8e0bM35hLwXXfec3Jt5O4MO
   hGZmPSX8Vai2IU8hcrFJToMO7qnxSth72SYGfNaQapo3gsMcF0uRjHMnK
   w==;
X-CSE-ConnectionGUID: rPe/55r6QqSkytrizfK0mQ==
X-CSE-MsgGUID: FkhuDY5CSFqNwvezUtaRkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4232009"
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="4232009"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 00:45:24 -0800
X-CSE-ConnectionGUID: mB6oKL7aQsCW5ZDEBy/kUw==
X-CSE-MsgGUID: dLJqyAEARx2GvCvMnv9sFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="11403884"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.125])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 00:45:20 -0800
Date: Tue, 24 Nov 2026 10:45:18 +0200
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
Message-ID: <awVOnsIRDtAsE2Sk@ashevche-desk.local>
References: <20260929-rsk7203-properties-v3-0-02f84aeb8e47@gmail.com>
 <3a51385d-9649-4bd7-87b3-0caf9e462b2e@app.fastmail.com>
 <arzKNhmoL6yiGrzH@ashevche-desk.local>
 <dea00f90c205f8359baca729d8b0f31a@gmail.com>
 <ce838102be497ee6eab490b4454095b96e16d015.camel@physik.fu-berlin.de>
 <2e4f0d32c05d841feb367741bf8802fc@gmail.com>
 <awU4aqWbKEs4Qhyg@ashevche-desk.local>
 <6eb2202457d5703192a513b4e898dfe6653c1b0f.camel@physik.fu-berlin.de>
 <awVMk-aGMRug22ss@ashevche-desk.local>
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
In-Reply-To: <awVMk-aGMRug22ss@ashevche-desk.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 24, 2026 at 10:36:41AM +0200, Andy Shevchenko wrote:
> On Tue, Nov 24, 2026 at 09:27:22AM +0100, John Paul Adrian Glaubitz wrote:
> > On Tue, 2026-11-24 at 09:10 +0200, Andy Shevchenko wrote:
> > > ...or even remove the board support completely (would be interesting
> > > to see somebody investing time in this HW to fix all what listed and
> > > not listed above).
> > 
> > Can I as the SH maintainer at least have the last word on this? I'm not
> > really happy with the fact that corporate developers are chasing hobbyists
> > in the kernel developments all the time.
> 
> I'm not objecting that! I just expressed the concern that with pointed earlier
> lack of time (did I misinterpreted that?) and list of problems it really needs
> a time investment (note, I haven't used the word 'waste').
> 
> > You people are being paid to do this, of course you can work on the kernel
> > on every weekday. But that doesn't mean hobbyist developers have to pick
> > that workload as well.
> 
> I'm not getting paid for reviewing, say ARM related stuff or stuff that is
> unlikely to appear on say x86 platform, so I'm pretty much understand your
> pain. Please, check the history of changes I have done in the kernel before
> judging, okay?

Btw, if you need a help in reviewing something, don't hesitate to Cc me.

-- 
With Best Regards,
Andy Shevchenko


