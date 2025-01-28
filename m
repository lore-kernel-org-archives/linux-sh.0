Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD44C19CC02;
	Tue, 28 Jan 2025 10:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738059721; cv=none; b=GAhBm++inVb6le5mrQQRh7/VVlQl7NiGUyGDdQhP0aSK+0/zTSSf9jXWU7rh4UbjKxl889CLKB02DubIhQvhm4mw5a7RBk7oKfSPms9F+OPZBqd+K5ms1SXZNCfq2B4j0bqvqg0mVzZJOAlEN32N1n3lzfZ6dz+WWzwoClsJnjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738059721; c=relaxed/simple;
	bh=+/oxoE91NKOHcQLz3rgJnj6womVGOb1f1E1kO7EtnbM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=STi4yub8d5ey+NUFlGgB/TC6GLeyFsM21fb4owEAdaDwcku3sSu+x2L6wFv2kFSKDxZRkmzbirIilxUGs+ud07/RA6fCEMfNTdKWUzRjWBIRIjS8SL1X7GAitaG7XnAo1LmTFt5+OOhOfJ4Gw8PNq8m8njN+BMIYEzPgdJgURY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=rXQgFSX2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sNTb/Qbg; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="rXQgFSX2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sNTb/Qbg"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6141825401B3;
	Tue, 28 Jan 2025 05:21:57 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Tue, 28 Jan 2025 05:21:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1738059717;
	 x=1738146117; bh=+/oxoE91NKOHcQLz3rgJnj6womVGOb1f1E1kO7EtnbM=; b=
	rXQgFSX2hcerZ8JUvj0fBl5Rxnv0BgDnoS6KKdP9erS7+nFE/wMbt1swLoWKw2IO
	0cnwRae7Yicdf+X+1qfPAQa3IH+wgoxfxBGeskgIXO9SwVft863FzlN2Ukp/9Ikr
	rOjA6Yt7OyUPOXWm8OQuD0LQG+TqigmhfIvD/PNaqZkdOtHQNRr5mPZZa04BrhHz
	svxEEMtz0H3pPMO7m8ozQffjGxNL7wLy0pw31cRZjD7Te6fFE012aPFeMblhD+Vc
	Lb7dLfGpJkQBoBh+YXwcSQjQdN4SI0axMCOu9q28gpwy6er1sk9jZzTLv0YntiBd
	QJLJj1U7t/hM/dwCGoo0ww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738059717; x=
	1738146117; bh=+/oxoE91NKOHcQLz3rgJnj6womVGOb1f1E1kO7EtnbM=; b=s
	NTb/Qbgl26sIz/Dvd40zFBR6wwRZ5VLN14fojeHeMUHRQkRi7KQII4xL1gn9nWJm
	wmXMYjmtaUH6kHq8yCUmyFkYGzGQQs/X5qMecet+h5WHZta3iZflhvlMCIRB+Wp7
	uIcHat1EDZB9cdRRdckMpeNf+K5Xjid9v6lBqCmdNV2w5jT/tqYsMUqfXKJY7xCr
	yqpL0fU2lwyzscDN80oH+YTFtAVlBcUlnQWY6lsC7Zb3dRPG5hJ/eu6Niff8G/hN
	VqoZD/Ulzmx79T9uaqVeRLMYmFdSL1ncVgyOQPEtZ0fHoUjjjDg3REQnsQxSWs3s
	YmVuMlXLGQ19ZK4F1fVYQ==
X-ME-Sender: <xms:xK-YZxj4h-1a2Cc8VOxQHl_BfzrCE0MFlN725zIroBAW33t51oIebQ>
    <xme:xK-YZ2BO4BmHc7Uqg7aVZOlZfgpshziqH2UeXKKfdiKT1NZo5c3EUZgXID6mumMbe
    kv8t8_rd3-1rFao2Xo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgudehkeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertder
    tddtnecuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnug
    gsrdguvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeet
    fefggfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohep
    iedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrlhhirghssehlihgstgdroh
    hrghdprhgtphhtthhopehjuhhlihgrnhesohhuthgvrhdqlhhimhhithhsrdhorhhgpdhr
    tghpthhtohepghhlrghusghithiisehphhihshhikhdrfhhuqdgsvghrlhhinhdruggvpd
    hrtghpthhtohephihsrghtohesuhhsvghrshdrshhouhhrtggvfhhorhhgvgdrjhhppdhr
    tghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheplhhinhhugidqshhhsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:xK-YZxH3ywI8GtpGOClc8hOHNLujK51I2xZb43hScAyUHMO9DSYcmg>
    <xmx:xK-YZ2TkYDd2ehluwcv0A-NWYKXziIDRyypWY2COtv63KfgJqKveMg>
    <xmx:xK-YZ-za5iHKapombeksyEz6DBccRd2scJha0WfEZtf5DcXoqSgNKQ>
    <xmx:xK-YZ87acdLkQo881v18Sc1YHpUcEtd7mwCLl1oA2cxCiFLa1haHmQ>
    <xmx:xa-YZ1polCJZdS2cR0ggc52QAe5q4kgG7MFWEJ8VQrR4lj8DIvHXdSpx>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 92B742220072; Tue, 28 Jan 2025 05:21:56 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 28 Jan 2025 11:21:36 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Julian Vetter" <julian@outer-limits.org>,
 "Yoshinori Sato" <ysato@users.sourceforge.jp>,
 "Rich Felker" <dalias@libc.org>,
 "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <3b821e8a-ea45-4bb1-874f-ff18f37dd455@app.fastmail.com>
In-Reply-To: <20250128101306.1475491-1-julian@outer-limits.org>
References: <20250128101306.1475491-1-julian@outer-limits.org>
Subject: Re: [PATCH v2] sh: Remove IO memcpy and memset from sh code
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Jan 28, 2025, at 11:13, Julian Vetter wrote:
> Remove IO memcpy and memset from sh specific code and fall back to the
> new implementations from lib/iomem_copy.c. They use word accesses if the
> buffers are aligned and only fall back to byte accesses for potentially
> unaligned parts of a buffer.
>
> Signed-off-by: Julian Vetter <julian@outer-limits.org>
> ---
> Changes for V2:
> - Removed also SH4 specific memcpy_fromio code

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
