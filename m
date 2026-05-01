Received: from buffalo.tulip.relay.mailchannels.net (buffalo.tulip.relay.mailchannels.net [23.83.218.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D6C34A3A5
	for <linux-sh@vger.kernel.org>; Fri,  1 May 2026 21:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777670865; cv=pass; b=pDcLtjKINTh74x6oQYOE1olUzHpHFgr+HtOZEpx/p6S4niszixPT7wd9pB7MQt4Bfhpga8zGzd/objVLEVaCbvws85U/YIp4MBD3dMMI+/j/HtIQRa3cFIsqBC4SbRlLM7jsYeixGUHmMMx8Tvx+cHAE8oRgwY7mfTbgRiTrnPo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777670865; c=relaxed/simple;
	bh=ecrqxISLUM4yZWY4MZFQ3UQ5Vpcz5ZJaSJkbvy7lLus=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hqIyoL08//Qhwhe3TARZut5DWvwdK79Ul/Ca+WKjnQPK6qSGeZSprVXMlLnzt5AwVaMbayu/97GgX7Rg8BaGlW+YdvUf5yxAMSHz/1UvNISlPyKhTQSy4Po/6SoFbXecy7CKPdd3axMp7mxElGgZerimUGgAiMyY219EztMRXfo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net; spf=pass smtp.mailfrom=landley.net; dkim=pass (2048-bit key) header.d=landley.net header.i=@landley.net header.b=g/x8JTJ0; arc=pass smtp.client-ip=23.83.218.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=landley.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=landley.net header.i=@landley.net header.b="g/x8JTJ0"
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id D9F594618FD;
	Fri, 01 May 2026 21:27:37 +0000 (UTC)
Received: from pdx1-sub0-mail-a209.dreamhost.com (trex-green-8.trex.outbound.svc.cluster.local [100.97.143.63])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 77B644603B1;
	Fri, 01 May 2026 21:27:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1777670857;
	b=PSMrVMnEAwLyJTxsjTUCIaw8pfphQi1TZLd0u5+CA9+GRlnErieyDzBehRUYrOfg+GCRfj
	/jAXxro5aOU3LbVRuaQ797YuXqZjEYQ+6J4aPITRZ9EaZfxVKHhYu5rNJRP7NgfA6FWW6N
	pMADKdA5TJbJISMfg/Lc3Z4kLTmfDx/kgfW3J1L9MdADIyBzkUeBZHKWbOVTJ/98vo2cpu
	vcKEEfGxmIJuqSWaxgJs3Lx/75XCWjYAccz+nR3tALsIQjAwF0qKmEUPPkjwhR6l974uHN
	SuP501lXOesAoBD+E0n5pM4di0LfP55v5xHGVQ7AQfgusajb3vkTcavYatXK+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1777670857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=8cP0jYQI4tvcl7K44IEZNBraHacViXCU8m8VREe8Nnw=;
	b=4Ki5qDd1fJZUR+OE+Mplme0lP6wz4eMA4f6fX99Q+Hp8ipS1dOjk6W/2RnKbYttwByYHsf
	Ffm2avyhqsupYnZFyawE2vab9Yxndi3mfpw1SRmngeRvUdsJU0b20yyQQL9k82RyO1K76b
	lD8KpK4HLF6tUOvtcan3w4378llynsku2c9pZk/fUGkq47Lof6BGlwJ8zVNBDhAXXma7kV
	oA7NIRG/OM7Ip3LShVRS5UjZdSSVPe+e9+HGcxWZGjE5vePgakFXcduboQyW44ezrAkXcN
	ERY5Jp/sy08CmjQmFFXetrFOOGiwgEXVgJ7YDa2ZZH1mnoyQlKFA2m7KB7pW4g==
ARC-Authentication-Results: i=1;
	rspamd-859c89884f-l8b77;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=rob@landley.net
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|rob@landley.net
X-MailChannels-Auth-Id: dreamhost
X-Cooing-Irritate: 14c7e6b04272b07e_1777670857723_487145059
X-MC-Loop-Signature: 1777670857723:903143840
X-MC-Ingress-Time: 1777670857722
Received: from pdx1-sub0-mail-a209.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.97.143.63 (trex/7.1.5);
	Fri, 01 May 2026 21:27:37 +0000
Received: from [192.168.14.157] (unknown [209.81.127.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: rob@landley.net)
	by pdx1-sub0-mail-a209.dreamhost.com (Postfix) with ESMTPSA id 4g6kf10R6cz2n;
	Fri,  1 May 2026 14:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landley.net;
	s=dreamhost; t=1777670857;
	bh=8cP0jYQI4tvcl7K44IEZNBraHacViXCU8m8VREe8Nnw=;
	h=Date:Subject:To:Cc:From:Content-Type:Content-Transfer-Encoding;
	b=g/x8JTJ05fy8BKLJfmPz0cw/8CRRmWpmgB1tHSw355+SgKZtKIwHlFhjdfLbP6WVH
	 ULwEtbOI9Uci1VkS5DyPdwP/LZQXpHci3Guji9jAz7CFwc0qeHbm2ldiKhxv/CKtcL
	 +NlYh7xFSrIvpfVOrvjb2lhzjhcNxOZgDBCk110oGsn1jlNo3/EImh7E2zA9PTAeEX
	 TA4ODCgVjxbTts5TSly8J4a48xSGo3TOL4Alkbs9GPsJDCTaP9T3QhRCoLepBKl/2L
	 8JgzL45l2CQpc5JOSvf8NNgKXqGZdj0mCttPq3FftcKkuinGVRp4ELqIkXByDqpRqQ
	 fczvejwHcjcfg==
Message-ID: <003c0770-c6f7-4fcf-b11e-74f42bfc14b8@landley.net>
Date: Fri, 1 May 2026 16:27:36 -0500
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Toybox make root no longer works as expected
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 "D. Jeff Dionne" <djeffdionne@gmail.com>
Cc: linux-sh <linux-sh@vger.kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 "D. Jeff Dionne" <jeff@coresemi.io>
References: <359d107fd9fe92a55e77be84c26d9ac86112fe13.camel@physik.fu-berlin.de>
 <71c6a925c748fb3c9c2af30362387f0e562c0f6f.camel@physik.fu-berlin.de>
 <55D40750-934F-4F70-A19C-11DC5F97A389@gmail.com>
 <15ca13ffdfa494b4d774f75d3daaee2ac7a8c93f.camel@physik.fu-berlin.de>
 <acc36891-6148-429c-aa99-3cf7c6681d6f@landley.net>
 <84b1391eb542b5cd6bcbecdfbc63124187265402.camel@physik.fu-berlin.de>
Content-Language: en-US
From: Rob Landley <rob@landley.net>
In-Reply-To: <84b1391eb542b5cd6bcbecdfbc63124187265402.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/1/26 13:32, John Paul Adrian Glaubitz wrote:
> On Fri, 2026-05-01 at 13:20 -0500, Rob Landley wrote:
>> On 4/30/26 02:17, John Paul Adrian Glaubitz wrote:
>>> I can give it a try. Would be good if Rob could publish a recent version of the toolchain.
>>
>> It's just
>> https://codeberg.org/landley/toybox/src/branch/master/scripts/mcm-buildall.sh
>> invoking https://github.com/richfelker/musl-cross-make as described in
>> https://landley.net/toybox/faq.html#cross2
> 
> What about the patches for J2 support? And can it work with a GCC git tree like [1]?

They're in musl-cross-make.

https://github.com/richfelker/musl-cross-make/tree/master/patches/binutils-2.44

https://github.com/richfelker/musl-cross-make/tree/master/patches/gcc-9.4.0

Two in each, I think. (Base support and then a later fdpic bugfix.)

Alas, due to the way Rich maintains musl-cross-make (which is INSANE) if 
you want to know WHY any of the patches was added (relevant gcc bugzilla 
entry and so on) you have to find the first release it was added to and 
log THAT patch to find the commit message, because he never puts helpful 
comments at the start of the actual files and the commit where the issue 
was first dealt with is sometimes quite the hunt.

Another reason I wanted to migrate off mcm...

Lemme know if you need me to dig for the source of the fdpic bugfix 
thingies, I knew once but don't have it lying around. (Jeff might?)

Oh, right also invented his own patch applying infrastructure (cowpatch) 
which is like fuzz support but worse: silently eats failures of patches 
to apply. I don't understand why it exists...

Rob
