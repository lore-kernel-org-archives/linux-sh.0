Received: from cockroach.ash.relay.mailchannels.net (cockroach.ash.relay.mailchannels.net [23.83.222.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5820818E743;
	Tue, 18 Feb 2025 12:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.222.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739882961; cv=pass; b=j+M/aZeBxxbrEDMN7YOsJocJd3mv/Cty8vOaz1V9g6XBcLrFrOxw0hS6S04d+O0PkCSqkS3URgIJ+nPqiBHhs9P3NbF7+lQGqNU/fQBnkdofozC937dlwpz5U0UXTh2fhPI4UK6dJhWIQoBuJ2AprbvQetrR0FHnGM7mnsEvb3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739882961; c=relaxed/simple;
	bh=oyws2QiZFuIt6DrRqRZ1qQHGzM+sDSzFBEXrjGhiuAI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UvtpLXMrZo4px93R9MdIInyT4TzaUsLfmDR7cgfNlWl0WPKF0r993FsWMLm/BLXwmw6stTPa1Ts+A9978ag45MPOPubuZB6IJeqIDn57t6/IZwH+YLK51NU3bai8uw4jHF964dUzhiiXeFEWl2esOIIeKH7SmXRbjtTR6dN6uMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net; spf=pass smtp.mailfrom=landley.net; dkim=pass (2048-bit key) header.d=landley.net header.i=@landley.net header.b=K6AzvimS; arc=pass smtp.client-ip=23.83.222.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=landley.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=landley.net header.i=@landley.net header.b="K6AzvimS"
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 5E36F9016F6;
	Tue, 18 Feb 2025 12:41:40 +0000 (UTC)
Received: from pdx1-sub0-mail-a208.dreamhost.com (trex-8.trex.outbound.svc.cluster.local [100.101.191.136])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id C301A903245;
	Tue, 18 Feb 2025 12:41:39 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1739882500; a=rsa-sha256;
	cv=none;
	b=9EAQpInMEG6JT796LTMao/zvnCOtU226t9GVmJ1LcDuEn5xeDKQk2iaSUDh6vWjOBnb8To
	GigI3GTRnWY+kbZ+FHKc0ECPpXovteIfnafdaOuDm6QTTKtHRmH4Yrjb5VHQQJnWAIPJAw
	9S/ey5gyl2j6ip86/7WCe8w2eTD/hwfIXHMs/uDzd5W7cmpElry1/bH86og+gkGvckVAQ9
	7xp2iqHuVJyrLNjkXB483wVffKAel+5WofG2pbAnVP7a2a0gUsrAHsacsQf0X0C2w8EzhN
	Ohpwk2tTJBpj27UHbJIptSCS24Q8yiGU+gxVPZW8/EAcKqSlccpog3E1E2IHfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1739882500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=BF/VLSC721a0M3yVlQ6Nld3atgt9dPOXgqi8DHEfHuU=;
	b=XmwBnSgAjjBzUB0KDkpvgbBXWnTIibicKMCbdTIOsgZBbn1bhfi/iwBos3wpCzzkpr8weP
	VNHSNeC0wq6OrfwMu4ntgpz1dvNsLPTIQnSE5XXA6c7ybLRF2/wJV+mqNO5nmz5jB0iXQX
	00ncGKHUZcG8vrG17lu46raODhScT5mkHmDg5jeQSPWdMmEmaTOOVP8Gox/gWvcvYEbX+O
	HVzrwStnRGsdmvNJTTozqFTdzs8fdwV8+OPzTOt2WdgFGf3wkej0ZagnBrnIB1qFCHjGcI
	gIHwxzxUR8J3JcjRYLd5QJHPZ+UQhhTtQ/CCHvwRyiKYQdhaFw2q1R1k3FBJgA==
ARC-Authentication-Results: i=1;
	rspamd-6d7cc6b78d-bzqsf;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=rob@landley.net
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|rob@landley.net
X-MailChannels-Auth-Id: dreamhost
X-Harbor-Imminent: 4d4fb9c841e32c0c_1739882500220_1183222984
X-MC-Loop-Signature: 1739882500220:2903814765
X-MC-Ingress-Time: 1739882500220
Received: from pdx1-sub0-mail-a208.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.101.191.136 (trex/7.0.2);
	Tue, 18 Feb 2025 12:41:40 +0000
Received: from [172.16.32.88] (unknown [198.232.126.202])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: rob@landley.net)
	by pdx1-sub0-mail-a208.dreamhost.com (Postfix) with ESMTPSA id 4Yxzfp4vVXzLJ;
	Tue, 18 Feb 2025 04:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landley.net;
	s=dreamhost; t=1739882499;
	bh=BF/VLSC721a0M3yVlQ6Nld3atgt9dPOXgqi8DHEfHuU=;
	h=Date:Subject:To:Cc:From:Content-Type:Content-Transfer-Encoding;
	b=K6AzvimS8+QAmV2ySs+wM8dN97OaV5qTjV8Ye1QNAPV0yFQFP5DjOt4u2SFGjTuCr
	 Pj7sS7GFBVWvRdHwyxGT4ywW9/53nG0gzOwidmv1m77KWB/jqOurznF+TfDk+KvOuf
	 pxqz/cJI/8ko54KM12V6Cphx0ZkSXWAIQIY9RLq5dZaqOkj9feCK+g65WslyCcErcl
	 mbPB/Y0k2Ho+PhIQkea50ia6a/V6CX0vv5Oe+KwPGzBgevsGUQAgmKL7ct2AMipiVr
	 TrIg89QLK6ZMIIb+fPBSfZe7UFxKVq37p02DtMuVovRhjMIhlE/OwNOudIEpBQj5vj
	 9QR19EGC93FaA==
Message-ID: <52c7d318-434c-4d1d-abd6-86b11e854ab7@landley.net>
Date: Tue, 18 Feb 2025 06:41:37 -0600
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] sh: align .bss section padding to 8-byte boundary
To: Artur Rojek <contact@artur-rojek.eu>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>, Uros Bizjak <ubizjak@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
 "D . Jeff Dionne" <jeff@coresemi.io>, linux-sh@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250216175545.35079-1-contact@artur-rojek.eu>
 <20250216175545.35079-2-contact@artur-rojek.eu>
Content-Language: en-US
From: Rob Landley <rob@landley.net>
In-Reply-To: <20250216175545.35079-2-contact@artur-rojek.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/16/25 11:55, Artur Rojek wrote:
> J2 based devices expect to find a devicetree blob at the end of the bss
> section. As of a77725a9a3c5, libfdt enforces 8-byte alignment for the
> dtb, causing J2 devices to fail early in sh_fdt_init.
> 
> As J2 loader firmware calculates the dtb location based on the kernel
> image .bss section size, rather than the __bss_stop symbol offset, the
> required alignment can't be enforced with BSS_SECTION(0, PAGE_SIZE, 8).
> Instead, inline modified version of the above macro, which grows .bss
> by the required size.
> 
> While this change affects all existing SH boards, it should be benign on
> platforms which don't need this alignment.
> 
> Signed-off-by: Artur Rojek <contact@artur-rojek.eu>

Tested-by: Rob Landley <rob@landley.net>

Rob
