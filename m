Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80669241690;
	Mon, 13 Apr 2026 11:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776078933; cv=none; b=k7dDYKjgNRofNfzIIyyysQ1mWEUg0VsijVNBHvVSwWxE6g/tiHxH6veKkHdoWXTuoegV7uLP46rpSePKkWEM+z0pr+J0gbBhwSCAefjLzZaxkXnFyXiBbVC5bs+Z1GrxdGXljXcgFZY2FZQF6C08w9dS6ak8u0KDQ7QiMDRMsUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776078933; c=relaxed/simple;
	bh=aUdB7WjJ882hG2u9RqrsOQAs3Nk+sPvZ21NCMBdaIUo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=USuDNP5RJwZKNkIeyQjJhWrqZauEtVC4QhubQrXXjhsfPXlnZoRC0J+rNQeW6VmvPkgD2UHElpPvJdG20PhyB1FU5UzFRhGaZEhdyf9DAFHvPCnQgIA0Te6c4wd6N++kS2LycYML6D88a0EWNR8tMKvRNe04YRf3HGOX19ljLIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=BetPAMrh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YOXcQKcE; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="BetPAMrh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YOXcQKcE"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id ABC14140017B;
	Mon, 13 Apr 2026 07:15:30 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Mon, 13 Apr 2026 07:15:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1776078930;
	 x=1776165330; bh=eTmL49YPBteRUcWblilZINYX2pjzGZzY0ltnNRpdVYU=; b=
	BetPAMrh3TokbMEGjLXdAbvoda+xYNVb7jptloq6qf3qRxz85vzdHcORtEe8TXuP
	dOV1MuYz9F4OX1S+K2yf80a9wZuLzFf7+e5jUjjNBoB33TIZmS/VyTipvbHlPQSz
	5tVPVNwxOR7A52NoSBqrhSxqWSV05bpZC0NGdqEpInk63dWvXViCn06/JOQP36p7
	4x7IHw7PQwleI52ytJcWug2sXxrp8h9qalAWX3JQ5GxNlGanUzjEBFfuseuJEVn7
	OjW/9WWlfUdYC2iRFumbKaYZkfjjnrS34dNf9/R9AoAKJ6kcIx+7j/aERfxMqz2F
	kx8bcLPnV0Dks0mv0amp3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776078930; x=
	1776165330; bh=eTmL49YPBteRUcWblilZINYX2pjzGZzY0ltnNRpdVYU=; b=Y
	OXcQKcEX5tEk/wZEX8dbk21JFtetmgNCSyO5WlxHSRND3TtCzAkJ4ZsSonf2/HcA
	KfGMWqi1kJWsWR+4Z5yQL52U3+kpbgOrfjiD/Vtk2kFccDPY+j5BCEHXxSnc9FAR
	JZ2nqhKSREwSFyHvBcjfk7nfqzulatPjJp/lAACgl2ryiGrYoo544XKnYipG4uAE
	mpXz9ZDevpUZnhOzveJSqEa3YzpkAiTZTdIpfBN1M9bdyRYTtvVpX/rkU2gGJAd7
	99zQtiPydzQMu5APaYTAoWom4vXuhDo9pbsCIGREtmQAQfsdW9KfIdBRHDpfxfd5
	GA7dV1rSy11emnqRAZSZg==
X-ME-Sender: <xms:UtDcaYZ9Lj7eUioEjYGAs_F4D-XDMonTm9KEwN29pS75MLp2k0fztw>
    <xme:UtDcaeOpqAWqWH5l9iimHatP93rKoI6x2GWYVl3svuNrZebzA5kBemlq7fKZKa029
    P5PhPdtxFAJ4QqpFg04wSEk6pJIC-veFe5QSJSMQh4Qw_-4ZiZJLf0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefkedtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffgvedugeduveelvdekhfdvieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehrphhptheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugi
    dqmhhmsehkvhgrtghkrdhorhhgpdhrtghpthhtohepuggrlhhirghssehlihgstgdrohhr
    ghdprhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpd
    hrtghpthhtohepghhlrghusghithiisehphhihshhikhdrfhhuqdgsvghrlhhinhdruggv
    pdhrtghpthhtohephihsrghtohesuhhsvghrshdrshhouhhrtggvfhhorhhgvgdrjhhppd
    hrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheplhhinhhugidqshhhsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:UtDcaTVhNnohniEpWSmvnWRVT09fC4MbQYw3OKQQKbx5Gkbst2Xo4A>
    <xmx:UtDcaQi35YRxdd-eBug821sMGAnmxA88IjiZgna8jp7APSUWbAL0iw>
    <xmx:UtDcaTpOICXGGe_7nFcnIuqavX2tXVzmrsTHz_qaGl9462ioCB6FHA>
    <xmx:UtDcaeEgI1CA0ozWy8pYv6A3rwt8FqUQLFIqW94AzMx98eegKhAoOw>
    <xmx:UtDcaV160YJtqTh9toAPDrp88_47LlPOCEB-oJpt0rD1QzX6hJHfAxMf>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 9C449700069; Mon, 13 Apr 2026 07:15:29 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ax9AE_gslVNw
Date: Mon, 13 Apr 2026 13:14:49 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Mike Rapoport" <rppt@kernel.org>, linux-sh@vger.kernel.org
Cc: "Andrew Morton" <akpm@linux-foundation.org>,
 "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
 "Rich Felker" <dalias@libc.org>,
 "Yoshinori Sato" <ysato@users.sourceforge.jp>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Message-Id: <42a4c6c1-762f-449f-9d14-3eb0fa02b94f@app.fastmail.com>
In-Reply-To: <20260413104649.852228-1-rppt@kernel.org>
References: <20260413104649.852228-1-rppt@kernel.org>
Subject: Re: [PATCH 00/10] sh: remove NUMA and SPARSEMEM support
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Apr 13, 2026, at 12:46, Mike Rapoport wrote:
>
> NUMA support for SuperH was introduced a long time ago by commit
> b241cb0c885e ("sh: Support for multiple nodes.")
>
> 	"... for boards with many different memory blocks that are
> 	 otherwise unused (SH7722/SH7785 URAM and so forth)"
>
> In reality, this added 128K of memory on sh7722 and sh7785 and 256K on
> shx3 at the expense of all the NUMA related code in the kernel.
>
> For build of v7.0-rc7 with defconfig and the same configuration with
> CONFIG_NUMA disabled, bloat-o-meter reports difference of ~76k. Disabling
> CONFIG_SPARSMEM on top increases the difference to ~94k. And that's only
> overhead in code and static data that does not take into the account data
> structures allocated at run time.
>
> And all this overhead has been there for nothing for almost 8 years
> because since commit ac21fc2dcb40 ("sh: switch to NO_BOOTMEM")
> those additional "nodes" could not be used by the core MM because the
> maximal pfn for ZONE_NORMAL was cut out at the end of the normal memory.

I had looked at it when you asked me about it last year, and I can
confirm that agree with all your findings and the resulting patches.

Whole series

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

Two very minor points:

* It looks like you left the 'config SYS_SUPPORTS_NUMA' symbol
  in Kconfig, which no longer does anything, so this should probably
  be removed in patch 9 along with the lines that select it.

* It appears that after your series, RISC-V is the only remaining
  architecture that supports NUMA in 32-bit mode, which I think
  we should not allow as a configuration, given that this would
  run into untested code and no hardware exists for it.
  Apparently commit 4f0e8eef772e ("riscv: Add numa support for
  riscv64 platform") intended this to only be for 64-bit targets
  but did not add a Kconfig dependency for CONFIG_64BIT (or
  CONFIG_SMP, which was added later).

        Arnd
