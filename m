Received: from sienna.cherry.relay.mailchannels.net (sienna.cherry.relay.mailchannels.net [23.83.223.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD81203716;
	Fri, 11 Apr 2025 11:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.165
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744371610; cv=pass; b=uKxUxH81SiGbRC+xNzSO0ANtFWYOashgIP+VTgteXxtW3DWys+pHzw7lvtVxbH2mRwlzts1cXlx5DEAbBkCPR+zmI91fc2TvfHp46VJCvf6wLXHZmKqey2pGkkPDoIEfCgysQl6h+kgd/SfVVULgkbbF2zvqsVz5RcKquj7sfBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744371610; c=relaxed/simple;
	bh=eZ7not74ayGyErQY97GIAbWimn+2ZHtNHi2jpeugyx4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U8gkDHGcjXpiMCDV9bp5m53mwy//VHgwwU5bH/Qa0rUuGT2YR9IN1P9OpKXLjIDXFzEzWlunfRiUdtPHCCs55A9kF0Ke6tJjQr+mT45/NS4lRKkm/C+GXU6U2D8/UhvLPlFLNOxr63u2Lg1X2m59eXADad7xHQqsr3u8IYqKJ1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net; spf=pass smtp.mailfrom=landley.net; dkim=pass (2048-bit key) header.d=landley.net header.i=@landley.net header.b=nkBQ91k7; arc=pass smtp.client-ip=23.83.223.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=landley.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=landley.net header.i=@landley.net header.b="nkBQ91k7"
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 1115E8A3BDD;
	Fri, 11 Apr 2025 11:25:46 +0000 (UTC)
Received: from pdx1-sub0-mail-a230.dreamhost.com (trex-5.trex.outbound.svc.cluster.local [100.107.20.214])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 883768A3F3E;
	Fri, 11 Apr 2025 11:25:45 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1744370745; a=rsa-sha256;
	cv=none;
	b=TPsLdr6dZ2BhAH4E345JeFCYsm0G2TnumsTCY1Ilub/9FV8+DBVHwxeumGBfDUCv8RphG4
	Kxgi+DrCceZQ+DmWUYZV1SJ+qAISjK3W+HQS0MZw/PKvFjNZCxMzCMxtYF+SnHv2xRBs9l
	+svlj1w/mv6IhbgviOmTid8Ae0ti/m8wpre4JGTV5KY8Yi9wiMY0cv3nOr4jHpCWOirztc
	jgkK2DprIlyHQd7CeNF1LtLKHNrNPesUAn/RBzbiMJaEvsGFL+Em1qo+ndRK07NEscyiR7
	6hdUAJ1eSu7k0mkf9dv/NNVZoEXpGQvpxNGOyRdyg4w0En8+IjdgJb0RlBDsBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1744370745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=75ipyekksOM5Ri+JXFAQmqUxDl2VTW0Cqiu2vU7L33g=;
	b=2HFGKAdBD3yTFIuPbD5v7zJxcotuv766D9IjMOWOYL1dJQBTo0epj7S9jNK1PGpX6u+L8/
	PFebKug1w+zvqYP/YRlZBsSYS7xymqdeRG+EzzKjbQk6BSHUOfxnXlwp8GND/eyJUl5Fhm
	cU+WnvmwgMCkwTbFnBMCQkWtUJiHZdj804jtoQPpq4m0TOmCGFPH72UrOSSvylcI2atA7R
	V5ZghU5fS6SqiZz2Z+gkx0a3Q3/gu/XTKLcgEvwmSRyfo+AIxeloMjem2okhXdpKZpsNsn
	N5X+88/fHqxuSjW+Mlpyidh93Dw+lf8fYGkA+UDS+32px6uJRWbndo6F8v42tw==
ARC-Authentication-Results: i=1;
	rspamd-7d787bdb4f-jxj67;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=rob@landley.net
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|rob@landley.net
X-MailChannels-Auth-Id: dreamhost
X-Chemical-Cooing: 1fa47b837051dce2_1744370745843_230911863
X-MC-Loop-Signature: 1744370745843:2240973692
X-MC-Ingress-Time: 1744370745842
Received: from pdx1-sub0-mail-a230.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.107.20.214 (trex/7.0.3);
	Fri, 11 Apr 2025 11:25:45 +0000
Received: from [172.22.7.54] (unknown [198.232.126.195])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: rob@landley.net)
	by pdx1-sub0-mail-a230.dreamhost.com (Postfix) with ESMTPSA id 4ZYvWD2Q8szFh;
	Fri, 11 Apr 2025 04:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landley.net;
	s=dreamhost; t=1744370745;
	bh=75ipyekksOM5Ri+JXFAQmqUxDl2VTW0Cqiu2vU7L33g=;
	h=Date:Subject:To:Cc:From:Content-Type:Content-Transfer-Encoding;
	b=nkBQ91k7vY1XDAEskO+FcFbCEFC0W4ZJ1yOUSLwkzdnEAT5i4nZSFbjOyCrUX/NpP
	 nQjY0k9JRbymra0/BJd1KXHsgyq56CO8PviX214E7TnvLf+xaWeAeTMcj9+nerguyr
	 ic951PGOQFcSQdpTW28eeSuOw0vzo9LBbsv2D6AkDAvNNZqYeJOiRR9M41xa2zHAbG
	 BJCqPpmP8kDEl5ezYaWxcMdYg5ZR3fEJgrWufr+GlYA5/8NoqRK+LOfFsVYUkqGM8w
	 dpBROtmFSqTd9Tpxdw7TDZTh8l3+vyc7+Oq8NimBZ1xJ84vzPkgPkmPZv4jIl2ZF1i
	 YFq1zfZyXBQqQ==
Message-ID: <5656d614-c851-4600-a79c-92edebc9c55e@landley.net>
Date: Fri, 11 Apr 2025 06:25:43 -0500
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] J2 Turtle Board fixes
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Artur Rojek <contact@artur-rojek.eu>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>, Uros Bizjak <ubizjak@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
 "D . Jeff Dionne" <jeff@coresemi.io>, linux-sh@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250216175545.35079-1-contact@artur-rojek.eu>
 <f574808500e2c5fb733c1e5d9b4d17c2884d1b9f.camel@physik.fu-berlin.de>
 <1551804b-fc78-4a3f-add8-af693f340a01@landley.net>
 <48881e2d8efa9d7df8156f5f81cd662c2286e597.camel@physik.fu-berlin.de>
 <9cf43bbe-898f-4b29-bd85-04f5320bce77@landley.net>
 <afec7233266c6c1fd1e70ac615ff129d9dc3f710.camel@physik.fu-berlin.de>
Content-Language: en-US
From: Rob Landley <rob@landley.net>
In-Reply-To: <afec7233266c6c1fd1e70ac615ff129d9dc3f710.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/8/25 10:23, John Paul Adrian Glaubitz wrote:
> Hi Rob,
> 
> On Fri, 2025-02-28 at 16:19 -0600, Rob Landley wrote:
>>>> Which was fixed a year ago, which is why I told you to use the new
>>>> toolchain with a current musl-libc:
>>>>
>>>> http://lists.landley.net/pipermail/toybox-landley.net/2024-February/030040.html
>>>>
>>>> Unless you're hitting the OTHER issue I fixed last year...
>>>>
>>>> https://github.com/landley/toybox/commit/0b2d5c2bb3f1
>>>
>>> I just downloaded the latest toolchain from:
>>>
>>> https://landley.net/bin/toolchains/latest/sh2eb-linux-muslfdpic-cross.tar.xz
>>>
>>> and the issue still persists.
>>>
>>> Am I missing anything?
>>
>> The march 2024 rebuild was in response to that Feb 2024 bugfix, so it
>> _should_ have the fix? (I'm waiting for another musl release to rebuild
>> them again...)
>>
>> I just downloaded the toolchain currently at that URL and built mkroot
>> and it worked for me:
>>
>> Run /init as init process
>> sntp: time.google.com:123: Try again
>> Type exit when done.
>> $ cat /proc/version
>> Linux version 6.14.0-rc3 (landley@driftwood) (sh2eb-linux-muslfdpic-cc
>> (GCC) 11.2.0, GNU ld (GNU Binutils) 2.33.1) #1 SMP Fri Feb 28 15:47:36
>> CST 2025
>>
>> And the failure _without_ the fix was deterministic rather than
>> intermittent, so...
>>
>> Keep in mind the init script has a 3 second timeout trying to call sntp
>> to set the clock, which will fail if the ethernet isn't connected (or no
>> driver, or no internet...)
> 
> I just gave it another try and it still hangs for me at:
> 
> 	Run /init as init process
> 
> with the latest toolchain, toybox and kernel (v6.15-rc-1).

FYI I reproduced this but haven't tracked it down yet.

Rob
