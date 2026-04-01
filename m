Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778A54070F9;
	Wed,  1 Apr 2026 12:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775047510; cv=none; b=mOo8OH3JA23g3Nmgk8/EpGwZZ9NTe2ZFKMXD4LahRNsAM6vJOf/8ZbT4bBUltAt1rtolo9EWeVWFwrZ/DJ6YXo1pVHMUnKqlETgpEC6XOV6TEaT8Rjc640tCOYCeYiA/EAViQLNxfBc7bOSIA584aUV+vWRiST5s7FWBO32lfmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775047510; c=relaxed/simple;
	bh=Dlm8u1M9Y25VFWBj4wxzmFiwOI2m8boBhF6KqF1/Csc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=toqg5X/JsAXmo7Vblzjq135QZbSCTB5MBaCIrQm1Snc9zUrGg9IWi5gjwrkggjVKUsLgelMoOX87jPfO08fpuWpnqkYfrpgJE2IcpTJTs9Own19t8wlgpDdiIsryNM0AQ7nio9bFmKCTWYDHwVmIwO8YY2ESwRqloON5iVqZFXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lkCX4spe; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lkCX4spe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775047507; x=1806583507;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=Dlm8u1M9Y25VFWBj4wxzmFiwOI2m8boBhF6KqF1/Csc=;
  b=lkCX4speR13G5adySTkkupLRRXEwEgww3/RKuuWyOGJB9PU5735DBCMF
   5/lOI+aySOSPsbEeIfOpeuHNn9LZHPKWX7NEuy42+Ga/IOPRGULmIBbU6
   Cls7S2h8Ie+39L8l+h/Nj0SqAU9aCn2WmleqjI6F3TwZ9H7Zg50YQ4ruR
   PwrW3g2v4HqAf/8x+pWA/D0moKX4fPrdOtlUD2wwN/RBicsDsxfKH9Mc5
   1Ffv9UN4YFlfEWOYveNgX4B3C+I93WmD6otkYrYUuG2cOzU+LvwG1uGrG
   1zc1mj/BhkSgDlwaZpNcucUK1NvH+ZlQAV8pmiqh+EDSJgpoEmQAR5dct
   A==;
X-CSE-ConnectionGUID: TkdoAL3UQ3uBJm+kz0s8Jg==
X-CSE-MsgGUID: GjcHwik9Q1CMlP3lJGpdNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="75963175"
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="75963175"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 05:45:06 -0700
X-CSE-ConnectionGUID: yNEaq/s1SI2BIt62UL8L2w==
X-CSE-MsgGUID: RBJEc1KBQYmduxzbAf9YsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="220013842"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.152])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 05:45:03 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, John Paul Adrian Glaubitz
 <glaubitz@physik.fu-berlin.de>, ysato@users.sourceforge.jp,
 dalias@libc.org, arnd@arndb.de
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] arch/sh: Drop CONFIG_FIRMWARE_EDID from defconfig files
In-Reply-To: <808dcd39-ed04-4288-9b21-55b47354de17@suse.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260401083242.214492-1-tzimmermann@suse.de>
 <b7c978f9728c1a1197e90a98bcec5e8e4dc7e7ec.camel@physik.fu-berlin.de>
 <808dcd39-ed04-4288-9b21-55b47354de17@suse.de>
Date: Wed, 01 Apr 2026 15:45:00 +0300
Message-ID: <8a7e78415ac5d83ae220125b32fd68a4e629eca4@intel.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, 01 Apr 2026, Thomas Zimmermann <tzimmermann@suse.de> wrote:
> Am 01.04.26 um 10:46 schrieb John Paul Adrian Glaubitz:
>> My SH7785LCR board does have a DVI output as well as a Silicon Motion SM-501 video
>> chip though, so I think it should be able to perform EDID in general. Or is the
>> protocol actually tied to the x86 architecture? What about monitors on a PowerPC
>> workstation, for example? Does EDID not work there at all?
>
> Yes, your system can fetch the EDID via the Linux driver. But 
> FIRMWARE_EDID is a special feature where the EDID gets delivered by the 
> boot loader. This has always only been possible on x86 or with EFI.

And then there's the completely separate CONFIG_DRM_LOAD_EDID_FIRMWARE
config to allow loading the EDID through the kernel firmware loader. Not
confusing or misleading at all. ;D

BR,
Jani.


-- 
Jani Nikula, Intel
