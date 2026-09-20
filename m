Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CC4A59;
	Sun, 20 Sep 2026 03:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789873938; cv=none; b=etIJDPP1fxA5Qi+XOizKGBuoBoDobMYZUojpXRQoJiZ/slG0uwMitat3sqM9p+NQ76mQKHPZsWcoi9Nlvk1amgld+M+1gcNfbvGI2vaAYBC37G7Rze5LEVprQnE1YTN3lnbdR1uv1I962J8yk4WamlgDHlYENrfjmfvCG0O00Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789873938; c=relaxed/simple;
	bh=JRPoMFof/9AkxchNzAibyIFX6q6wt3HFiSS+wTvJM1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MAGG4AOC3AUVGz0nGLqVbkahIDICutpdxOl1GZ2qjdacWWDG08quHuOptJ1fd38YfDvxhwC/vFoPO5VzeP1b8atVdCnSLeaVhOC1mS16ma6JJiUseU1WSS2OHZnjjjr7bbAwHgospC/6GsnqWJcgDgNWsJL0Y+KfXAhNeWULZ/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=KEPrUF6N; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="KEPrUF6N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=JR
	PoMFof/9AkxchNzAibyIFX6q6wt3HFiSS+wTvJM1Y=; b=KEPrUF6N4kGdiu0ztC
	fp4fEGjaiSMU1Xv8rE6NQfHLBXDe2b3xzhJsTml5sRXS6U+w5EIukLv9l41FWSC8
	3IygQW7DsXQ3axEWoTJgkiKPqIFmztF8OAVyIUukGmlzhNIPc1QF48ylLNNst/A4
	tJvyN+NrJxwlZXjY5aSM7zjlw=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wC33QbSTq9qdYcsBw--.56454S2;
	Sun, 20 Sep 2026 11:11:14 +0800 (CST)
From: Pengpeng Hou <hppiscas@163.com>
To: geert@linux-m68k.org
Cc: ysato@users.sourceforge.jp,
	dalias@libc.org,
	glaubitz@physik.fu-berlin.de,
	linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hppiscas@163.com
Subject: Re: [PATCH] sh: Use generic OHCI platform provider symbol
Date: Sun, 20 Sep 2026 11:11:12 +0800
Message-ID: <20260920031112.98903-1-hppiscas@163.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <CAMuHMdVkL629ps2mmD3XRXM-BYWXZ-6GQGM7tKf6vEvhK--LBg@mail.gmail.com>
References: <CAMuHMdVkL629ps2mmD3XRXM-BYWXZ-6GQGM7tKf6vEvhK--LBg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC33QbSTq9qdYcsBw--.56454S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvj4ikhL7UUUUU
X-CM-SenderInfo: 5kssx2xfdvqiywtou0bp/xtbCxhNOF2qvTtP7MQAA3e

Hi Geert,

I checked the removal of USB_OHCI_SH. Please include the tag you supplied:

Fixes: 4f6dfc2136fb ("usb: remove the dead USB_OHCI_SH option")

The current SH subtype selections and sh7757lcr_defconfig still name the
removed symbol. The patch switches those users to USB_OHCI_HCD_PLATFORM;
there is no additional code change for this metadata update.

Thanks,
Pengpeng

