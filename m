Received: from buffalo.tulip.relay.mailchannels.net (buffalo.tulip.relay.mailchannels.net [23.83.218.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29AD1D54F4
	for <linux-sh@vger.kernel.org>; Fri, 24 Jan 2025 03:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737690788; cv=pass; b=dLk6V4r+anf1lbwnGe2s+Bp2DJH5JT4DCejbZL2bE3zL9zyxmExOVKsfHUOuNgYUdUeYkeO7K47xtDnx9dGLdwN4lYNrKoE+PSAh56uVBfsS8pF81elWu4P8wb4E/gKOTV4dS+YRwGWPtuJP+5a7+Z6+o/S+0y4WBnxZ8m03Sdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737690788; c=relaxed/simple;
	bh=yOG54emG6aTatdMl9iE+6LbeOE4Qulol3VbOIw5jPJk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EN98gAuf+2pjao5ffa/QKkiK+UyzL+SOFBVlbHowPctwfMIT1LnVK7ebuszrF1KQQIjlGnH+ct38HjpIGexNS072pak5WV9wQ18VNnpM4z22k1/evDasiUKMaEHhqTnLhuunYP9w9GjkKyFKtpPomVO6vbMNVBSureUBFqHu1KE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net; spf=pass smtp.mailfrom=landley.net; dkim=pass (2048-bit key) header.d=landley.net header.i=@landley.net header.b=iy2KRkry; arc=pass smtp.client-ip=23.83.218.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=landley.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=landley.net header.i=@landley.net header.b="iy2KRkry"
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id E518A8A3E48;
	Fri, 24 Jan 2025 03:34:56 +0000 (UTC)
Received: from pdx1-sub0-mail-a233.dreamhost.com (100-116-71-244.trex-nlb.outbound.svc.cluster.local [100.116.71.244])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 6EFB18A38AF;
	Fri, 24 Jan 2025 03:34:56 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1737689696; a=rsa-sha256;
	cv=none;
	b=f4M4Etk8arDIwq6LfCzlDqKZ06DYGrkA4z+gfMU3MfrGXzwgTZv2vVcTWg2l7vNnpyli63
	g96HVIXB6Qz410sllGiMyd4WwauOvxRHN4zw1dMnhovj2oCAudiR/tpm0V1vkvG0lGc5Q3
	6dM1s19A0k5u8XKFxfZ2xjr8yN9KVzT/yeMHRi6NHmc9icuhopUHnjxun3jfimRCYVV/ko
	xltAzRV3ctHJCnrD6EOkusRbaGghG49II2My9Sde+UH8KuidMeZFEKDzI4H+GYQqbCNdu8
	9YnYy3eve3iscxVmUTrnZS5o89P6wrtyCkb4ME68s4ziLiB/GLSMkUPkyWs0tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1737689696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=4B+Tm/pQDje0Eik/LuSN78tRvZPDM5ORapu36QueRV0=;
	b=FiECZT2JmZBF27kzO5VvFZE+QVQBOj4rr2Mud2p6NsLLFKlAWCo+vAFBfc9zty9YXnXSs8
	ys+LSsPmLGnLyEzhWuP913XR65E3p0nZycTZEHId+URAa64N4fHSIKVIEwXa5vvGw4h5bB
	uTOJjlxaOIaaaYT/WoveK6ZrWe/BpYDLXCySSQ4/c6HPU5pU8exDi0jE59+xb3f/CzmR1Q
	TGk1FjTJnQlX4eI+KACbORFEvQ0LbkveHGtadPFbWIq6jKQyLJgOvwWsXUv3F2TSeQf/Eb
	J6/FLWHPVSJI9X3nJHFjC9FROyD2Ino6Zhl9rpw9BqjyQpAXVefmXuJQXKBPXw==
ARC-Authentication-Results: i=1;
	rspamd-7d9c9fccdc-mz4x2;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=rob@landley.net
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|rob@landley.net
X-MailChannels-Auth-Id: dreamhost
X-Hysterical-Society: 49c205f353012997_1737689696708_433225318
X-MC-Loop-Signature: 1737689696708:2375255234
X-MC-Ingress-Time: 1737689696707
Received: from pdx1-sub0-mail-a233.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.116.71.244 (trex/7.0.2);
	Fri, 24 Jan 2025 03:34:56 +0000
Received: from [172.16.32.88] (unknown [198.232.126.202])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: rob@landley.net)
	by pdx1-sub0-mail-a233.dreamhost.com (Postfix) with ESMTPSA id 4YfNjW4h0yzMN;
	Thu, 23 Jan 2025 19:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landley.net;
	s=dreamhost; t=1737689696;
	bh=4B+Tm/pQDje0Eik/LuSN78tRvZPDM5ORapu36QueRV0=;
	h=Date:Subject:To:Cc:From:Content-Type:Content-Transfer-Encoding;
	b=iy2KRkry96WQaNIPP+44CHjVdztD8evNdGNIjyEMnFfGH2g3kuhgg+dKyDem0vU8/
	 1mE1PKhIZoSWZhRzoDRPoN3I8WsNcPYJVDKN5Q4m/uU/4IreMitiGu749iHQkw0dJY
	 CG1mIUMXG9q7EkBqVzK/+rO9M5ffbtkqm4KPLv2OOotTNFjmwmVUlOp10lwW26tScJ
	 1kGsJoFyp7zgdUqs9PUefE4Pz5wxxbknmUE7tUjiJBs2x958SpTpW/YnXWd8kXT1tt
	 kewITjA2B5vSHRp0EZWYoQVkw0odi5mDZg/mp3U1zR7iYaix34UxnyNlxz0xBXwlo0
	 i85cJ7awRH83Q==
Message-ID: <ff352b56-98df-4af0-ac44-4fe45725273e@landley.net>
Date: Thu, 23 Jan 2025 21:34:54 -0600
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 -next 14/16] sh: vdso: move the sysctl to
 arch/sh/kernel/vsyscall/vsyscall.c
To: Kaixiong Yu <yukaixiong@huawei.com>, akpm@linux-foundation.org
Cc: ysato@users.sourceforge.jp, dalias@libc.org,
 glaubitz@physik.fu-berlin.de, linux-sh@vger.kernel.org, serge@hallyn.com
References: <20250111070751.2588654-1-yukaixiong@huawei.com>
 <20250111070751.2588654-15-yukaixiong@huawei.com>
Content-Language: en-US
From: Rob Landley <rob@landley.net>
In-Reply-To: <20250111070751.2588654-15-yukaixiong@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/11/25 01:07, Kaixiong Yu wrote:
> When CONFIG_SUPERH and CONFIG_VSYSCALL are defined,
> vdso_enabled belongs to arch/sh/kernel/vsyscall/vsyscall.c.
> So, move it into its own file. To avoid failure when registering
> the vdso_table, move the call to register_sysctl_init() into
> its own fs_initcall().
> 
> Signed-off-by: Kaixiong Yu <yukaixiong@huawei.com>
> Reviewed-by: Kees Cook <kees@kernel.org>
> ---
> v5:
>   - fix the error discovered by Geert Uytterhoeven.
>     Move the call to register_sysctl_init() into
>     its own fs_initcall() as Geert Uytterhoeven's patch does.
>   - take the advice of Joel Granados, separating path14 in V4
>     into patch14 and patch15 in V5. This patch just moves the
>     vdso_enabled table. The next patch removes the vm_table.
>   - modify the change log

Speaking of, what would it take to add gettimeofday() and 
clock_gettime() vdso functions on superh? I looked into it a few weeks 
ago but found the subsystem hard to parse.

Rob

P.S. On j-core we have three memory mapped registers any process can 
read, the rtc_nsec, rtc_seclo, and rtc_sechi fields in the AIC structure 
at 
https://github.com/j-core/jcore-soc/blob/master/targets/boards/turtle_1v1/board.h#L29 
(volatile unsigned *hlc = (void *)0xabcd0220, or just x = *(volatile 
unsigned *)0xabcd0228; if you're checking before/after nanoseconds for 
quick and dirty profiling), which has let us be really lazy but ideally 
there would be a proper vdso wrapper, and the with-mmu version is going 
to want a little more kernel participation...
