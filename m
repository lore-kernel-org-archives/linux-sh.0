Received: from insect.birch.relay.mailchannels.net (insect.birch.relay.mailchannels.net [23.83.209.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D0C298CB7;
	Mon,  8 Dec 2025 22:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.209.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765232471; cv=pass; b=DlZ33jTGV1/XK/ilj16PFPkibfyFn1IifDEUskxj0klHuBMzOPkuJfXX9m6sz1qy1RsqjjLIKbXVaCQpveMLkEusrP2kf3POXV51cH5Kvelk5IaLYRSUFbZTTtA817tW4T3IiGSWVAXFcadDXrjZUKiDS6L1Pmeml4uXGZYZEh8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765232471; c=relaxed/simple;
	bh=KFi5Hx4685FsJdPvT54y8Jr07Z0DhyPEjBS5zty/cUo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U3az6jw/e0kjZlgMS9Lnv5oh6XuXSGGtTs5hn9WB3sBUYJcP170iLZq8QFwoQwyuxBXItaZNSJxdzFOPwLvXpBn+qQjffZFDC/kVYbZnVGWhwJgwi8DrQhPu06tISj196qqJa63D/M/UR8Mxbs05Ak2ftVUN3r8Zoc2lvb0m46I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net; spf=pass smtp.mailfrom=landley.net; dkim=pass (2048-bit key) header.d=landley.net header.i=@landley.net header.b=eJb/RiLl; arc=pass smtp.client-ip=23.83.209.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=landley.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=landley.net header.i=@landley.net header.b="eJb/RiLl"
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id F0E3B121E1D;
	Mon, 08 Dec 2025 22:21:01 +0000 (UTC)
Received: from pdx1-sub0-mail-a247.dreamhost.com (100-103-73-45.trex-nlb.outbound.svc.cluster.local [100.103.73.45])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 6ADD1121A28;
	Mon, 08 Dec 2025 22:21:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1765232461;
	b=qZiy6ry/ZBfinqyEfJvr7nVpcrbPpSKaMlWE9UjDAg/pNCBukuD2NAnMncvzqIGsIAVpzM
	HzwS189SP3AI08MspeucPD8PGF6+8vqsupoIG1T1UzWoKaKKLeyM0pFB/I/OGiGuLK7RO/
	taG2bde3EVeUQg/SSASUb+/AucTAGklXoGKz2tOTFCJVfD4mjizVvlxWzBpJ6SLd/gGmpu
	04S8D7/mOtwTPu5ynesELlJc3JkwMJQrhGyuhtgaiacRXmicLPNQRjCqf79rW22vErzgUo
	a/ZX9cvMZFfTXg+TKoEuDqoY7bg7kCG8G0BeDh+t9uP7QvLt+O3G1BsO8xFDaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1765232461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=L1RQ3iFll8k4vyXkf57ManBwY/nb1VghWZ8P3Q8kdCM=;
	b=cbS+u8RxM3GJjfOBZB9V+GlXlYQRkE+Q659aQYj6E3lNCmJjsVKAaz23xirJfrFvV8OTBj
	JwpGeTTwxqXwlvoV+OgR8xyNtH2AEMXSNC2rxVtqAPIUOdr3Lpa8Yax8ubCFnQZnRPz2rF
	hcdQa+Q3SbRdRI+4gwE0+HROavgVG618i2lv8l3f67x855LFsi5s3fKAPIT56leQzWrfkl
	6DtYDqYQmt4yFSctLfaoIDAL50udm/ye2ZtAwasaZAAidEtElA/GY0lWjrnMLPpGNcGrDu
	ExKh8p7n3YDMPsXtItG3DitQO1A4tu6xLD7Imnt9coo2B/cuk5XSFKCxIcAzrA==
ARC-Authentication-Results: i=1;
	rspamd-57b9fc4dc5-grwdn;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=rob@landley.net
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|rob@landley.net
X-MailChannels-Auth-Id: dreamhost
X-Coil-Whispering: 0033e86560d9169c_1765232461776_2558580605
X-MC-Loop-Signature: 1765232461776:1297394009
X-MC-Ingress-Time: 1765232461775
Received: from pdx1-sub0-mail-a247.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.103.73.45 (trex/7.1.3);
	Mon, 08 Dec 2025 22:21:01 +0000
Received: from [192.168.88.2] (unknown [209.81.127.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: rob@landley.net)
	by pdx1-sub0-mail-a247.dreamhost.com (Postfix) with ESMTPSA id 4dQGf41lb2z106B;
	Mon,  8 Dec 2025 14:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landley.net;
	s=dreamhost; t=1765232461;
	bh=L1RQ3iFll8k4vyXkf57ManBwY/nb1VghWZ8P3Q8kdCM=;
	h=Date:Subject:To:Cc:From:Content-Type:Content-Transfer-Encoding;
	b=eJb/RiLlvRi4iGeCSlIcsiY3teg4ovb/kpSB0cIkachS1hxBEWt2NOG9hsGWOG1Nq
	 J0ixH5dJhTETWB0rzWaQq4Mus6J9EUG+plLoUuZVp2mk/Gk5UAxj/qktIiG4st54kL
	 o7BSP7dknliEVwlz+lYeN9MoXVCjjA9Jt+47QDhMhew3WNtfvk5+deCc5vQF/+0BZZ
	 OY/Cb5ZCnAzShd9lL7nzM8DETmqU4u2g32be+3hcrWvKlH39gDhCUaMIhDyd5NxToe
	 u7BO9evWD8w37HVK5/igxtD1aH44bI6EEjm53Uh9QB2HtKx5ugRAd/8pi/GGdmSbZT
	 6/t8XN//fiDQQ==
Message-ID: <f10e135e-14c5-4bc0-8100-1712be3796dd@landley.net>
Date: Mon, 8 Dec 2025 16:20:57 -0600
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Kconfig dangling references (BZ 216748)
To: Randy Dunlap <rdunlap@infradead.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, andrew.jones@linux.dev,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 Paul Kocialkowski <paulk@sys-base.io>, chrome-platform@lists.linux.dev,
 Paul Cercueil <paul@crapouillou.net>,
 linux-stm32@st-md-mailman.stormreply.com,
 Srinivas Kandagatla <srini@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Matti Vaittinen <mazziesaccount@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>,
 Vaibhav Hiremath <hvaibhav.linux@gmail.com>, linux-sh@vger.kernel.org,
 Max Filippov <jcmvbkbc@gmail.com>
References: <22b92ddf-6321-41b5-8073-f9c7064d3432@infradead.org>
Content-Language: en-US
From: Rob Landley <rob@landley.net>
In-Reply-To: <22b92ddf-6321-41b5-8073-f9c7064d3432@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/7/25 20:04, Randy Dunlap wrote:
> USB_OHCI_SH ---
> arch/sh/Kconfig:334:	select USB_OHCI_SH if USB_OHCI_HCD
> arch/sh/Kconfig:344:	select USB_OHCI_SH if USB_OHCI_HCD
> arch/sh/Kconfig:429:	select USB_OHCI_SH if USB_OHCI_HCD
> arch/sh/Kconfig:455:	select USB_OHCI_SH if USB_OHCI_HCD
> arch/sh/configs/sh7757lcr_defconfig:61:CONFIG_USB_OHCI_SH=y
Commit 231a72e03af6 removed the only user of CONFIG_USB_OHCI_SH (an 
#ifdef in drivers/usb/host/ohci-hcd.c), commit f6723b569a67 missed it 
cleaning up, then commit 4f6dfc2136fb special case removed the symbol 
but not references to it.

It can go.

Rob
