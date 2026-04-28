Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3B8379EE0;
	Tue, 28 Apr 2026 16:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777393496; cv=none; b=ZWll6NG31Je2AGb6uv/0fINWurKf8ieC6nQCc+0bfy7symqBzy8VKG9BkGMjNqLZYvAExVFR2MzdqO+khjp3bT0w2ZzG+nJNTAZs7QjgFB0fih3ICVc16YxGpe5ep95F2LlVMHzDznYvs4Bwgz8/shmP9s4dH8Ij23IBtbv/4n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777393496; c=relaxed/simple;
	bh=/hlZ3CL15YhKohO8sPXh/S4gsytLOUouefAunH1BjjM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Yzf0CCqqknsgIVdZikBFWyE6MPQ8T9N6TlQE6wsI/m9KpYDOX+VrY26VILorMr1IvuCIfeDYjFlV0Zne7O4p5PeYyKfiQbtCzqtf9TGub3u+yfnN8+zqdClL1J9a3tZz8VoCKBxZjeqQsCcE8kR+nR/SSFRVySWRflSGidjr/5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=d2a+5lXu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Wa0Z9JpK; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="d2a+5lXu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Wa0Z9JpK"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0781F1400074;
	Tue, 28 Apr 2026 12:24:55 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Tue, 28 Apr 2026 12:24:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1777393495;
	 x=1777479895; bh=irc105uO1cybgeA/saKncpmZjelpNEHcYcoMOYqpIx4=; b=
	d2a+5lXuAkobqaqiI4is1xb/ldvom8VJPfxThMf0AaPCYSqzvpl5JXoRmLKAeVRB
	890ajlazYBrmJrr1xtRbK9rd/oiB9rL/OGyF7W5Gw9uC5wO4oClyfMgNDHmJXEr2
	21HKY9cKwQwPToOtKmMeVdR60xp+axJdaW3LpPWmxZ/Q0uDx3WZT9/xQC1mde/Lu
	HJCdBiN1eak2smY9hX6cetzTnawqiipiwRhU8zLFvmo47XXLl1fzfVrqPFEvsJTs
	b5rarK1bAZyve7mcKTtL89RAiC/6/3oNyqGBjvhwELb6qXOhejPZRSYKg7ExT7S+
	eiZlJbfza42Y7wKxvAOmOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1777393495; x=
	1777479895; bh=irc105uO1cybgeA/saKncpmZjelpNEHcYcoMOYqpIx4=; b=W
	a0Z9JpKz6CImujwjUKNH25WC7kZwD7MLFaDSdA9B2OLJKnb0JNeKmSJ6Fvr/C6mU
	nptbKlXFGeVqoau26D15WYVNyP3xvK/6Hr484UG7vXn1f2cUXWLoy4gLqToalKdI
	r20KcQCrvw6LU3nz9HN+AtG0b8uUWbrTTYrTdcHHWv6/qeQwJl0JCJOokYxt3lmJ
	8juTdadrOuEaovVUqJRqKNpznMEQ+YqG2rHBaLsPAzlfo1rgBgD1B3afZxMXsrUS
	dXRchHLbN8zU8Gl/183Z28DmzEp3Ou8QP5zDwBTunXkVXI00/gCZmg2zmKdHwB5D
	oUKWhQHXO0r4uI6Ocw7lw==
X-ME-Sender: <xms:Vt_wae3FalrXxwOoJD9oNKmif3oQw7DWwJZBoeFdVczPLRUkPnl_3Q>
    <xme:Vt_wab4HVEWDxUMRfGk8Gh6vvvWRPvexBdlNGBAKhsGzZmD0rOz7RuNkc-NYdbaU3
    JHBRtGh-nN-dXweOBnI8quPnW0VCBkSNrG1tw_b0QliSowIJ7lwAlxk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekvddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffgvedugeduveelvdekhfdvieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehrohhsthgvughtsehgohhoughmihhsrdhorhhgpdhrtghpthhtoheprg
    hrnhgusehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghlihgrsheslhhisggtrdho
    rhhgpdhrtghpthhtohepghhlrghusghithiisehphhihshhikhdrfhhuqdgsvghrlhhinh
    druggvpdhrtghpthhtohephihsrghtohesuhhsvghrshdrshhouhhrtggvfhhorhhgvgdr
    jhhppdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtoheplhhinhhugidqshhhsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Vt_waaK1sJy8HvTm2y2p_iCyRfKOZbVHJokhnzDdCJvt8gbxrViQpA>
    <xmx:Vt_wacL_rdxBq6jcPVJfxBdexuchRt9G4MwyWlpJJFTlAl3-8z5JHQ>
    <xmx:Vt_waRXA9HSA0344c_HRwKo54R9VhS0qRWh4b0DxwcE2zVBCf4snLA>
    <xmx:Vt_wadmk3NqJ5O_o8YU4JJ6k-2ZWC_10IK2GUFRZavIzSQoLQXDd_w>
    <xmx:V9_waQUDZpHbVm7rtPjBAYbRfJZm4ytQCkjYkLOC3pmd9gn4_i1F6Rw5>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B1433700065; Tue, 28 Apr 2026 12:24:54 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AuXWUXY87igk
Date: Tue, 28 Apr 2026 18:24:34 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
 "Arnd Bergmann" <arnd@kernel.org>,
 "Yoshinori Sato" <ysato@users.sourceforge.jp>,
 "Rich Felker" <dalias@libc.org>
Cc: "Steven Rostedt" <rostedt@goodmis.org>, linux-sh@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-Id: <b45a2235-4249-406f-aef1-e54a05f0e401@app.fastmail.com>
In-Reply-To: 
 <fdd60c87a0303a130b0ba28f3fe04b5ad27cf027.camel@physik.fu-berlin.de>
References: <20260428155528.3218943-1-arnd@kernel.org>
 <716fb62be57fd01c68cfed9220da7ebddfa321ae.camel@physik.fu-berlin.de>
 <3529a6c7-401c-4ec3-a63c-5235416e52c5@app.fastmail.com>
 <fdd60c87a0303a130b0ba28f3fe04b5ad27cf027.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sh: select legacy gpiolib interface
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Apr 28, 2026, at 18:21, John Paul Adrian Glaubitz wrote:
>
> Makes sense. I'll pick it up for v7.2 then unless you think it's urgent
> enough to warrant another pull for v7.1.

7.2 is fine, thanks!

     Arnd
