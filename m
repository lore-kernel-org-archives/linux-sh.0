Received: from seashell.cherry.relay.mailchannels.net (seashell.cherry.relay.mailchannels.net [23.83.223.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBD2269AF0;
	Tue, 18 Feb 2025 14:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.162
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739887214; cv=pass; b=WYUHEtVbscUboykn4gNhqy4AKT07+QZOymz3PAwmkzENli4tj+23vIUei3ntAhXPVwWEFaNIq02t1tiIWzYwJXl+huClIrNXg2a6fXnaX0r86MpmMlMgZ4BOQezESG5t9vLGVKapuhHb/pT0fGyqZ7BMv2GBoOb86kVCC/gpXCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739887214; c=relaxed/simple;
	bh=DGgdmGoXFuNbS7z/vFF8stOUuDr8Sn4WUzD/hMg1nu4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ur8UROBZihrdaxtpe0UvYShhg4cwqc8p6Z1eDWQUSJIFlm1ZXAT2J+YD3Q7smtcayje35TkoTX5RRelaXeEtqQQu0BX6K+mS+z8i1y3ZdcCKdbo2TFdYohOVJCJQCQ6OjHFWWxbZHSG6CcF3tut0l+az6O12DHDjWBXvaqm6qak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net; spf=pass smtp.mailfrom=landley.net; dkim=pass (2048-bit key) header.d=landley.net header.i=@landley.net header.b=B4psEMDl; arc=pass smtp.client-ip=23.83.223.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=landley.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=landley.net header.i=@landley.net header.b="B4psEMDl"
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id ADFC71A5486;
	Tue, 18 Feb 2025 12:43:10 +0000 (UTC)
Received: from pdx1-sub0-mail-a208.dreamhost.com (100-127-158-254.trex-nlb.outbound.svc.cluster.local [100.127.158.254])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 0E1A61A4E91;
	Tue, 18 Feb 2025 12:43:10 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1739882590; a=rsa-sha256;
	cv=none;
	b=VrwwjxbFesy8mpfO2IjNYUhcLWBLaYAgmBHh+mrMKnhAM8CJ7q0AfNwtFaJZhLG8VJaNS5
	0UWnJASq6ykqjlPUp8troZLiwAVQxv/juZ+j0UorrMeeqaHhA1gisW0M5YBp6NHy8C8hdL
	Ai9IAOmvU5Pb6u7N1j5v/gRaisbRWh/abj7c+RZhx+Ibi6uj5qdMxt7ghv0XYU6pge5qga
	3msspTlwd+WBz364Y3d4vPI9A1mJkuaxwJLmtUULQlvCp84czqy1ZbwmFHOkLJr3J3Hgql
	tlzlLgRX6kB+qGuLAChdMDNxSdGaf8/VAoLBwE4OvLHgZXJqcfI4DKSiIdSJOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1739882590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=B95tabb5XZzsLZAdmM0q9rShY5CxFJ7DzbxtbrrhHbY=;
	b=ZlvR4WgSsHn+uWciGXRxmLTLs9afzEirW57vVLw+fbrBJgl6fituvs27LNJyTNDFgw4bWi
	mX2jnFlFWu0vFpKtYE9zuZj2SwAlDPb8hjcqUxS+qJampzAOzpev79dF+pQhKOleg5CAvZ
	R41V/MF/pxzs+FMx94NTZigkkrXm1XT5RBwZLCocLpkk5N+vWxTGs3zgj/EYxykUcV9Edq
	VnvUNvxwVc8iJRHqHbbQAhaIVPkB81wzd25agT2DShpo5bQRqbhmogQbWDeOMBy+ooREp3
	zQl6SrPLeVEjrarzDrCMNpllEq1XR6puu1ciPrejLgNSVokR1xwzrCRmRoD1lg==
ARC-Authentication-Results: i=1;
	rspamd-78ddd997cc-ttgrr;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=rob@landley.net
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|rob@landley.net
X-MailChannels-Auth-Id: dreamhost
X-Stop-Madly: 6edb93bf651849a8_1739882590423_2474421560
X-MC-Loop-Signature: 1739882590423:52837196
X-MC-Ingress-Time: 1739882590423
Received: from pdx1-sub0-mail-a208.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.127.158.254 (trex/7.0.2);
	Tue, 18 Feb 2025 12:43:10 +0000
Received: from [172.16.32.88] (unknown [198.232.126.202])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	(Authenticated sender: rob@landley.net)
	by pdx1-sub0-mail-a208.dreamhost.com (Postfix) with ESMTPSA id 4YxzhX6n0qzNR;
	Tue, 18 Feb 2025 04:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landley.net;
	s=dreamhost; t=1739882589;
	bh=B95tabb5XZzsLZAdmM0q9rShY5CxFJ7DzbxtbrrhHbY=;
	h=Date:Subject:To:Cc:From:Content-Type:Content-Transfer-Encoding;
	b=B4psEMDltaoKyD63Dts4zk1CiSgxddy46xHI/QV5mgigdVCqa2Bu/FzfsnujpuaPb
	 eeZbRnPq+UC/S1HRcZABcatN5jxRzWlmKGyF36KtpgCg56zffacA73cKHb2nB1SeUS
	 vzFrvGBuMWF0+LtGa5O3dqci2KXCJ1mz9s+zz4Q8FrjVTuUvpTsKA1avO0L/QZBEVg
	 f73zzlrc3rb6uQPQ/So8zmcuGSRtL5N/mjcXyw4mGBTYdXtDTTVC95V4o6YYMYKdD0
	 8sXSdHaLqUotjLgMAL/wrYlInzhPKifQchb0/DKoibUsrgqxy7iZIuA9mSYZmuYomY
	 kNmukHkY9h9+w==
Message-ID: <c9caa50a-597b-48c7-9ac8-b3a4193c3fec@landley.net>
Date: Tue, 18 Feb 2025 06:43:07 -0600
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] irqchip: clocksource: fix jcore-pit irq request
To: Artur Rojek <contact@artur-rojek.eu>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>, Uros Bizjak <ubizjak@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
 "D . Jeff Dionne" <jeff@coresemi.io>, linux-sh@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250216175545.35079-1-contact@artur-rojek.eu>
 <20250216175545.35079-3-contact@artur-rojek.eu>
Content-Language: en-US
From: Rob Landley <rob@landley.net>
In-Reply-To: <20250216175545.35079-3-contact@artur-rojek.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/16/25 11:55, Artur Rojek wrote:
> The jcore-aic irqchip does not have separate interrupt numbers reserved
> for cpu-local vs global interrupts. Instead, the task of selecting this
> property is being delegated to the device drivers requesting the given
> irq.
> 
> This quirk has not been taken into account while migrating jcore-pit to
> request_percpu_irq(), resulting in a failure to register PIT interrupts.
> 
> Fix this behavior by making the following changes:
> 1) Explicitly register irq_set_percpu_devid() in jcore-pit.
> 2) Provide enable_percpu_irq()/disable_percpu_irq() calls in jcore-pit.
> 3) Make jcore-aic pass the correct per-cpu cookie to the irq handler by
>     using handle_percpu_devid_irq() instead of handle_percpu_irq().
> 
> Fixes: 69a9dcbd2d65 ("clocksource/drivers/jcore: Use request_percpu_irq()")
> 
> Signed-off-by: Artur Rojek <contact@artur-rojek.eu>

Tested-by: Rob Landley <rob@landley.net>

Rob
