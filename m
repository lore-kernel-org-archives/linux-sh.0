Received: from shrimp.cherry.relay.mailchannels.net (shrimp.cherry.relay.mailchannels.net [23.83.223.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6FE328B69
	for <linux-sh@vger.kernel.org>; Mon, 23 Feb 2026 17:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.164
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771866182; cv=pass; b=MZEcXi6KHgka//lpKnWk9BIYURLTw1YPYejJrW9uUWOJbwb2Vb+FzLiGJ8uxIOLP2Dwx61x9YxrBZtqZ0TT+aaTFD6OdGcR9njK96Y1SX3PDGdhdoGhuPKHUZ73c0CXP8djahvOuu2nySn5Lhku0NOGnVmIZsjjSuObTWYQzpb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771866182; c=relaxed/simple;
	bh=QYPGsDjq1Xx63hWtwZPpzVOxR9dPyN0xoX9xNQgu5nc=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=UYBr16wNwWxt9QoI2OobRJYhCwxhdk5hxHP9F5LwLCmWbyg5QJ70fqTJ5ktOgq91N/WVNCJy9PZWfIb5+qiKzMoedoW/TqKRgiyJ2hy9hzyUm1cP+8hyPHoQoRICZqlHmtnJ78SqrIKMPWgL62/KxqcNvV/xrdXGp118hwE+tIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net; spf=pass smtp.mailfrom=landley.net; dkim=pass (2048-bit key) header.d=landley.net header.i=@landley.net header.b=qhT/utBh; arc=pass smtp.client-ip=23.83.223.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=landley.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=landley.net header.i=@landley.net header.b="qhT/utBh"
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 8C1D8462984;
	Mon, 23 Feb 2026 16:44:27 +0000 (UTC)
Received: from pdx1-sub0-mail-a229.dreamhost.com (trex-green-3.trex.outbound.svc.cluster.local [100.104.88.134])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 30C8B46286F;
	Mon, 23 Feb 2026 16:44:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1771865065;
	b=dggCzMN00NEoECpE1O8zJwihrMVR44yp25DQLg5GSXXkMZfYnOKhObaDI2LplssK59M+sq
	6lP96aRGUcEHclkoImMfcyNt2Hg6eYVeHyx/mmCTJ80GaTrrqDvPwVNhvzAgSxodB4xRay
	CQhoR1w+LwMkNkcGW7v68tUmfHC3j+FdL/yQU5qAbbKNlIvQisSwR4I4ftocDZvM0fAFng
	gGinlFAfk11Q+t+yeKAogSqhbWbc9z8inQwxQts9AN9j+43AUsH/78N/za24E08l9YLb08
	DCytAGPaonBc2+Ws4JpcD7xirBsUL9c1ci3mbyYELtlq7ik6rxjCAyYWCzN0EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1771865065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=wZS3kj5cFviV41JkTgX8z3Urf1M4R3r6c59aD2ixr84=;
	b=10R2F926FXZE+Nsh0WRK+GjBK3hOuu0EqIogGmEBgtKf1NEw5qtH1J1Ylt/lq/VCJmaRNU
	WKWikwR4PeWMN2+BHkbnTeHtu5Y3YFdaaRtD3DHB6qcPRaznHB0K7/1N9GhoSnto4Elf6+
	eK09Kx57VxgYs4EHOxgbWA582tSh7K0SkwzpJ1HSVg0Z/cHOI1QkuQ/n7KoS2sTLQO5/0g
	P+J8ve7o8FV0+zua2fRxSGz6k7HnucFE095uTRTLGHXTTvboAA2lHsqj5Iac66wFTK35GJ
	iLC4bCLX/ZaaQQCx0MWRhSvXFxLLTfLQCu22Mdgjn42cTS7bqAuZaQdijGDl9g==
ARC-Authentication-Results: i=1;
	rspamd-6fbd58c58b-q6pqj;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=rob@landley.net
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|rob@landley.net
X-MailChannels-Auth-Id: dreamhost
X-Snatch-Tangy: 7615fa9d207d075e_1771865067425_590813275
X-MC-Loop-Signature: 1771865067425:4008666603
X-MC-Ingress-Time: 1771865067424
Received: from pdx1-sub0-mail-a229.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.104.88.134 (trex/7.1.3);
	Mon, 23 Feb 2026 16:44:27 +0000
Received: from [IPV6:2607:fb90:9a0f:889c:175:8594:632c:fd9c] (unknown [172.56.10.34])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	(Authenticated sender: rob@landley.net)
	by pdx1-sub0-mail-a229.dreamhost.com (Postfix) with ESMTPSA id 4fKRX85PY5zTc;
	Mon, 23 Feb 2026 08:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landley.net;
	s=dreamhost; t=1771865065;
	bh=wZS3kj5cFviV41JkTgX8z3Urf1M4R3r6c59aD2ixr84=;
	h=Date:To:From:Subject:Content-Type:Content-Transfer-Encoding;
	b=qhT/utBhw8qa+WaZPmQMvd4kp/+sz4aZfNm4oR/S7GLu8OpzES4K7IAa2Xkute0T7
	 d0ACM2ssvxoru6OEwEslv+R2Rc/LMDywuUrfcMU7obDpa15T/sSe79cQMFM8gYFt7T
	 3RBSxMWLiardtKwJuDR5VDnySFMt7HlhC/8NPleXlM8SvY21N+Gt8enl38qGHY2HzT
	 RzIVyvGk6vrZycjnqysQZdkPuZ+Skjg+7ePnHAkCTcnW/TtMlm0CWnrioCsx++lRUs
	 8Zfhf0NfcZBStfZ7fMXhZvblx5EjH18DGpskxrKGW7rbbUxKtRU/Et1WlBCZA9jgfh
	 NkzfbxZej0rUA==
Message-ID: <240590ce-7d95-491f-93b0-98abd7c6e17d@landley.net>
Date: Mon, 23 Feb 2026 10:44:19 -0600
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Linux-sh list <linux-sh@vger.kernel.org>
From: Rob Landley <rob@landley.net>
Subject: Did you see my qemu r2d memory patch?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

It was in 
https://lists.gnu.org/archive/html/qemu-devel/2026-01/msg06318.html and 
probably needs to be reposted as a separate thing, but with it I booted 
an sh4 kernel with over 200 megs of memory, enough to act as a 
reasonable native build node (especially using the distcc trick). No 
kernel patch required, just a .config change setting two symbols it's 
already got to different values.

I need to port the r2d target over to device tree (well, extend the 
turtle device tree stuff to support r2d and its devices) and teach qemu 
to supply a device tree overlay with the current memory map so you don't 
have to match kernel with qemu -m layout (the only way to get the extra 
memory in one contiguous block is to move the START of the memory range, 
which means moving the initrd and command line string locations which 
are relative to start of memory, so the kernel needs to know where to 
expect start of memory and thus needs to be recompiled for the different 
memory amount rather than just autodetecting. Device tree blob location 
is loaded into a register before kernel init...)

Anyway, thought I'd ask what you thought,

Rob
