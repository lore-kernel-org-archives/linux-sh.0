Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9891021D00E
	for <linux-sh@vger.kernel.org>; Fri, 21 Mar 2025 10:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742553743; cv=none; b=u3oowxpYNi2JuZsvNDfbNO8xhOV7n7MJDTJOVEIH1dq6ivxFtjKz6Mo1VAYEZv4ufDZzCPbxuKKhv1AawGXGmTLK2jSJhjuObxRiJO9/31twPMpY86LBYFkLpOd1P36rcdCstmlALCrVfxxStkhG6sJ4TTVulbDxXOJZNBes7Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742553743; c=relaxed/simple;
	bh=kbwc2dMi8DGC6dfEKkduthhnqPrjCNhv9qJ/tCphYTA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=WG/aFn34OasV9Pjd0gS8NBzd0v7ZFJvXRwn7kg7ztVsoWfU89m1/RKlNwdjxNjXFQIjDEJ7F3tG0IkfANDSrbqUxxV9AR5UZjmtZcRen94Dfl3JOoRANqvsg+jJrX/pHH/kpUSumXbEVHYO4lXWliQkf5WSNl/c5RHopSY+zqsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=XjnjdZcg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ggxomf2o; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="XjnjdZcg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ggxomf2o"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B4292114010D;
	Fri, 21 Mar 2025 06:42:20 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-07.internal (MEProxy); Fri, 21 Mar 2025 06:42:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1742553740;
	 x=1742640140; bh=68U2xOJN0FdMowzUkCY1aIhi5big7bilZhbRnPyI3bA=; b=
	XjnjdZcg53TQoWY6DbowpGSf6Ma4/nsFtY8lkgM2pEJsZCUXCKKwcIm7QdV7M4Bf
	2yM/xCCXpwT3VCW/Nf9a/BX5QIhRI8DG6QFz0DYU5i+JJjSMcsuSwvkAiL2im1/B
	QUptqhaFFJMriuw9uGO3DvCvSVZBNlMR98m+YkVFJqKLF4NvSZBKjcgEnRsAB/tQ
	GA+u373L0rT8LwfZDfN7IoF8Ae7CpZXBhKthdAo373/RsGSTPT+8lljNoe/2pxZW
	qmLXa/EfmC/hpqNMa2nvBUIZRSnZ5Ij5kEXUNkbgs9aVIg6/D2HQSrEvWZgqjqP+
	354rucCqNwBj7TNoacjEgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1742553740; x=
	1742640140; bh=68U2xOJN0FdMowzUkCY1aIhi5big7bilZhbRnPyI3bA=; b=g
	gxomf2o2Tzd8VqwlKhcjQellV0+NwxdKBaE8avhS5rYKhDZa0Ghdtmqk737JgchC
	hOzMB+Mqa0XBnoWrLhvB0iXiVdTvFODyXMi+zZ5OxvSZsWps8Rq108K4//zyzO3F
	eiH70PU+qr5b18HI0fxDKjhdm62raRMh4jNwz3AVz/jG02/G7Cv9xMLW7yqji8/T
	M859M1V666xCrodf5rK91YQJ80iJENomW9W1LIJu/CiZ2+CIjNqJeK63099zJU0c
	UY2kzKmZ00WbGH31yXB8ARjAJq3PjPWLO0lP8GRVoY/h4fpdMiu25xlhdEhALANe
	CUAEDcYfu4f6wfHRj291w==
X-ME-Sender: <xms:jELdZ3Qub_8dm9XOH3yQjxa06hPdPSXZkUYGDPZhLOyeo-2A6Nk_Yw>
    <xme:jELdZ4wb-VhBLRDtRTQgYrx28aExpsmKbLRcj1mPXYv6xEC-Nt5etqa7R-KnIBLPi
    Nq4Z6LCF6f0-9-qB_w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduhedtkeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertder
    tddtnecuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnug
    gsrdguvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeet
    fefggfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohep
    kedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhkphesihhnthgvlhdrtghomh
    dprhgtphhtthhopegrrhhmsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrggsvghl
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopehgvggvrhhtsehlihhnuhigqdhmieekkh
    drohhrghdprhgtphhtthhopehlihhnuhigqdgrrhhmqdhkvghrnhgvlheslhhishhtshdr
    ihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehovgdqkhgsuhhilhguqdgrlhhlse
    hlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepghhlrghusghithiisehphhih
    shhikhdrfhhuqdgsvghrlhhinhdruggvpdhrtghpthhtoheplhhinhhugidqshhhsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:jELdZ83aQHV9LtOryKkIY-LnH0PwTwyEk09Enz43tjsIsJiEDDKD8w>
    <xmx:jELdZ3DDEPGE55RY2nfpDjDUc_c3w6BK6D87xaXuBcNEG6F60073Fg>
    <xmx:jELdZwibPTszLGO-UHzIzm2F1Ncl2_meCfYni2K7DYg2cqM7epW0cQ>
    <xmx:jELdZ7rOyu6iqfshT38zNgtCmoZfQTkaiFvSUeK8RI94N64sk42t-Q>
    <xmx:jELdZ8igUHd-95sRvIhWoI_NxZI-x8VCjyjdp2II0S9JiCsqKfZLABYb>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3C61E2220072; Fri, 21 Mar 2025 06:42:20 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Tcf25c5c4b21ac15d
Date: Fri, 21 Mar 2025 11:41:59 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Geert Uytterhoeven" <geert@linux-m68k.org>
Cc: "kernel test robot" <lkp@intel.com>,
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 oe-kbuild-all@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 arm <arm@kernel.org>, linux-sh@vger.kernel.org,
 "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>
Message-Id: <86813d50-d4c2-4220-a5a8-2a264b37f7d4@app.fastmail.com>
In-Reply-To: 
 <CAMuHMdUeynpmUUmZPViEBttANFmEhpjFn0wqNc1wQB6wRbd0rQ@mail.gmail.com>
References: <202503211029.DnQpqsJs-lkp@intel.com>
 <927105f8-4aa8-4579-ac2e-bce4bce12b1e@app.fastmail.com>
 <CAMuHMdUeynpmUUmZPViEBttANFmEhpjFn0wqNc1wQB6wRbd0rQ@mail.gmail.com>
Subject: Re: [soc:soc/drivers 20/24] ERROR: modpost: "__ffsdi2"
 [drivers/platform/cznic/turris-omnia-mcu.ko] undefined!
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Mar 21, 2025, at 10:36, Geert Uytterhoeven wrote:
>> >
>> > ERROR: modpost: "__delay" [drivers/net/mdio/mdio-cavium.ko] undefined!
>
> Bug in driver (must not use __delay() directly).
>
>> > ERROR: modpost: "devm_of_clk_add_hw_provider"
>> > [drivers/media/i2c/tc358746.ko] undefined!
>> > ERROR: modpost: "devm_clk_hw_register" [drivers/media/i2c/tc358746.ko]
>> > undefined!
>> > ERROR: modpost: "of_clk_hw_simple_get" [drivers/media/i2c/tc358746.ko]
>> > undefined!
>
> Missing dependencies for driver.

Agreed, but both of these only break the build on sh because
the architecture code is different from the others. It's obviously
best to fix these in the drivers, I just wouldn't expect the
driver maintainers to care unless someone sends them a patch/

>> >>> ERROR: modpost: "__ffsdi2" [drivers/platform/cznic/turris-omnia-mcu.ko] undefined!
>>
>> This comes from __bf_shf(spec) in omnia_mcu_request_irq().
>>
>> As far as I can tell, this is not your problem but in the
>> SH architecture missing one of the libgcc functions that are
>> called by gcc.
>>
>> Since this is only for compile-testing sh allmodconfig, and
>> that is already broken because of other bugs, I'm not going
>> to care either.
>>
>> Adding the linux-sh list to Cc, it would be nice to get a clean
>> build again. All four problems should be trivial to address,
>> and some of these have been broken for many years.
>
> So one SH-specific issue to fix...

There is also the missing clone3 syscall that has been
causing a warning for many years.

      Arnd
