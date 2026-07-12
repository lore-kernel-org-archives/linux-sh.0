Received: from eastern.ash.relay.mailchannels.net (eastern.ash.relay.mailchannels.net [23.83.222.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5464F5474F
	for <linux-sh@vger.kernel.org>; Sun, 12 Jul 2026 08:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.222.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783843848; cv=none; b=YZOcwroKVciZsaxlpQAqMOHMhcPtHLSx6mJGXbLylM03j978VSunAGY9otqbzN8WCHZ3GyKNmFov85AQNBLILmlBf2YazOQ7ThnhAq6StOB+T1H/V7Dz7U5YJjtW1+T/MiGyC506wwEM1IaaCfTb/cRUjWG2i5u5Qww85eB425c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783843848; c=relaxed/simple;
	bh=mGF6MjzIzvIkO5rx8y3KcdzmLO+HSoZJyhNn6mIulSw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g8WuS1RPUOVcqYoB4w9D/VEankxIm1E+orl4H3ItkbYEzQGlS1e5OoiA999d/e/LDF+q5vmF2ddn/KthQG5ZrLP0y+Xjw/tNXgE0ZhsnuFVT9SuBSNv6MmbAOsxxJOHwZshZNa7zDNclWbqpjGR93WizVbc4owySFOqXeSfbPV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net; spf=pass smtp.mailfrom=landley.net; dkim=pass (2048-bit key) header.d=landley.net header.i=@landley.net header.b=ZBawrHuw; arc=none smtp.client-ip=23.83.222.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=landley.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=landley.net header.i=@landley.net header.b="ZBawrHuw"
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 75750460D67;
	Sun, 12 Jul 2026 08:02:07 +0000 (UTC)
Received: from pdx1-sub0-mail-a209.dreamhost.com (100-99-1-19.trex-nlb.outbound.svc.cluster.local [100.99.1.19])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 0E622460C77;
	Sun, 12 Jul 2026 08:02:07 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|rob@landley.net
X-MailChannels-Auth-Id: dreamhost
X-Battle-Cold: 0a37ae14713b31d1_1783843327296_2655508904
X-MC-Loop-Signature: 1783843327296:3102808088
X-MC-Ingress-Time: 1783843327294
Received: from pdx1-sub0-mail-a209.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.1.19 (trex/8.0.2);
	Sun, 12 Jul 2026 08:02:07 +0000
Received: from [192.168.14.157] (unknown [209.81.127.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: rob@landley.net)
	by pdx1-sub0-mail-a209.dreamhost.com (Postfix) with ESMTPSA id 4gydML4ftwz17j;
	Sun, 12 Jul 2026 01:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landley.net;
	s=dreamhost; t=1783843326;
	bh=R8jInBxkJuGxa3yugd4jN4jiTxwyIFVx7V5RDwe1wTA=;
	h=Date:Subject:To:Cc:From:Content-Type:Content-Transfer-Encoding;
	b=ZBawrHuwUT5r4+G/mp1vrs/EsZiEDaGAmqK0rMDr6EUDbBpvlrxNcL7h9M2AgSjmZ
	 hC10WkjgdrwaVGy9+EFTAKkOHMyD0gTqAhcayrM7MrDhMFwd/IQag1BRloMGThtC3b
	 7y1dXHT9pDpTCtQGwPe/08FSG7GbeVjl+LKxiUdFoZR1pnZpPocUOjBEeaSgtNIFSj
	 CiHBGIg8dZbIWbJd0kOCIyqJMACd17E66oQnVhoIp3Su7i+DTQy2KZuYIgZZg03Abl
	 z4Wy3V7NKXnR6mVZGqQRqG4GkTbxv9nV8/TjJGWHEYBt8DTxcfCOwY0U1JNvlCMCCJ
	 bgITgrknE9VmQ==
Message-ID: <2a81cd17-bf7f-4bc0-9bc4-86b170d0cc22@landley.net>
Date: Sun, 12 Jul 2026 03:02:06 -0500
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Toybox make root no longer works as expected
To: "D. Jeff Dionne" <jeff@coresemi.io>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 "D. Jeff Dionne" <djeffdionne@gmail.com>, linux-sh
 <linux-sh@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>
References: <570e4053-9e57-4e63-9808-0b770a3a3791@landley.net>
 <A4205228-E202-4157-9C57-FE37497E1586@coresemi.io>
Content-Language: en-US
From: Rob Landley <rob@landley.net>
In-Reply-To: <A4205228-E202-4157-9C57-FE37497E1586@coresemi.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/12/26 01:00, D. Jeff Dionne wrote:
> I will try and force myself to find time to help with this.
> 
> I noticed a few days ago that some very old targets I need to work on are having some bitrot with even new 9.4.0 toolchains.
> 
> Rob, can you do me a favour and extract our GCC patch stack for all the sh2 flavours we support cleanly from the build scripts?  All those targets will need forward porting.

For gcc-9.4 there's this in musl-cross-make:

https://github.com/richfelker/musl-cross-make/blob/master/patches/gcc-9.4.0/0007-j2.diff

https://github.com/richfelker/musl-cross-make/blob/master/patches/gcc-9.4.0/0020-sh-fdpic-pr114641.diff

And then binutils-2.44 has:

https://github.com/richfelker/musl-cross-make/blob/master/patches/binutils-2.44/0001-j2.diff

https://github.com/richfelker/musl-cross-make/blob/master/patches/binutils-2.44/0002-sh-fdpic-pr31619.diff

(The second of which is apparently a fix for 
https://sourceware.org/bugzilla/show_bug.cgi?id=31619 and the fix was 
bigger in 2.33.1, I dunno if the last hunk was dropped because it was no 
longer needed or because it didn't apply...)

Then our build scripts add a specs patch:

https://codeberg.org/J-Core/librelane-vhdl-build/src/branch/master/01-toolchains.sh#L25

And you have a patch to add __attribute__ naked:

https://codeberg.org/J-Core/librelane-vhdl-build/src/branch/master/01-toolchains.sh#L212

And then here's the NOMULT patch (which is not properly #ifdeffed but 
chops out stuff when we build a second instance of the compiler, for the 
j1-nomult target):

https://codeberg.org/J-Core/librelane-vhdl-build/src/branch/master/01-toolchains.sh#L332

That's 7 patches in total, 6 of which apply always and the 7th applies 
only when we want to build a j1-nomult compiler. (Cleanup discussion 
stalled because we never worked out what config tuple we wanted to 
specify it, do we need to make it multilib, etc.)

Rob
