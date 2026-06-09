Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF833254A8;
	Tue,  9 Jun 2026 06:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780986714; cv=none; b=mnvQ2n9PizbG/BJMnwsE0MYpa2owUPUFonNuNWEijNF9MO90RzhBclnC8zp4ldQG5o9/ppCIM95w4wC3FRbyhxiLTaY2rCHL0jN4xJIarbp/PvoIPaCGdJRu2zkPJ61GmJhXltJosGcdZj5yF8lfI2tEn0pEUUxctzFFgAsFOeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780986714; c=relaxed/simple;
	bh=9cVW14CxuHH6XMS02s4qPCeAXwNI63im2JshZ0C4ctU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=vCFUy6CkRw6qsGxpH8sdLYHFzz2lK+pUmHkNjooLv91nHUWnv9I31kr/laBiHSFLdQsSXgpxcW6uqSwRpJIKrkzIn6SdBAhTTWB+eGxLCGvJ8jP6f2yw+sqyyWYTpXpn5/aykgDcGl5P52morLkoVfoUiE4yT/SSjptEgNylYtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CXf/U4at; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CXf/U4at"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F2E51F00893;
	Tue,  9 Jun 2026 06:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780986712;
	bh=9cVW14CxuHH6XMS02s4qPCeAXwNI63im2JshZ0C4ctU=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=CXf/U4atw4ng7e5++Mmf/+093z4CCgU0NQ4E9ZtiHnLBZQ3XlO8c5hDUAFfLge80b
	 Pp3bnDzSXbpGGmmME5uzxoi7SzIcxFyVew9k+xSPXr9DfDxA1FocNs1iyYIFPuJeJd
	 Sc+ZhSEEIJqvvabqth1R8GJi4QuPMXUpJZ0HjkMK2cH6zsfklyrZDUE8fFdFZakSSg
	 iN//Rf5Lx9O6Aq0/7y3/j+gjCe1CkR6lQ+poglk2UzPIdWx1eUW/5HfZkTl+ArpSx8
	 5brncMYUg+37AK4DfNjqnvmHqFB89rL8uyAefG75olcRvVBlUaaShTliVjSAQy9og8
	 jW02qkerpWFyg==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 35BCEF40075;
	Tue,  9 Jun 2026 02:31:51 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-01.internal (MEProxy); Tue, 09 Jun 2026 02:31:51 -0400
X-ME-Sender: <xms:V7MnapoRZE115mv3OE1zemucjsva6zjZtD5d3LsnPgo655T0S1_hOw>
    <xme:V7Mnameu8nxCzvSST9MMvGJscv5vZhpBAdbcMmboEfheSYhr55P0vRBiJ0xjWN4Wb
    SxlxanxBk8mUaIbIG7n7TYC69uxcjn-LY5Jbu_tl1eHxWiSk2V7yw>
X-ME-Proxy-Cause: dmFkZTFT0QeOWg6z5S4Eyrduc7ntI2XZ8ybouC2z/7kLY4pY3mTLgtkacitZwNL0VP8Z+4
    i4UPqGOWioNbD8PElNjGgAiflyJ41PIsAAy+dD3ap/EH+TIAFzLxd+eA15lYonXwFjoOXm
    AKsU7Rq+u5U3jQ88y9qztBhSwCBkMRpJPnBR1JdzCnxPqezwVJAo/ivpK09iFH3/nF6WJo
    YO4ZqSmOgzUBstd3L/zqENBtA9r9ayIfL0J65bWVdVShBuwriyuFMEK/DNuMYYCR4QHL0P
    69x8Jv4sWE89NJ6Y2jLFRTyobPkf+u9dagvkxQrWTh7cFlpWSLv+eOEi7AbetLf87SYZaQ
    wEdjX5HLugz4TrS6h5hEFzg3wvewAiBqfJB1VhgirTBJK7Z5+mi4t/WhE42TBtP1+u3Ft9
    BEGoJTCVdWezAbERphPOMzN7Xs6Ww/JJqfJ2iG4yB2ymnmk6z5cXgyCU/l8ZmXDejy1iux
    nxIGX8vKp8sx5VhXOhGykeqMiho9sWDJe5REpSnNTRAAVVWR6IFKTbYhEozF1pJqJh6KXa
    uRhNRa0XsAfrFUH1snAI+NgurLh9E85q0b0eeeluRqIMM1dRoLf5asDBnpVwciTtgxGueD
    sp0lAJe9rKMlnCbk1Z4+Ym9JonWancXM30q7gcQtuJoJnqqguwszhcyU5F2Q
X-ME-Proxy: <xmx:V7Mnarble0pwjkE_7YhgAahliXMbQH-zJV-FMhh0Vo225d_uaGzbaQ>
    <xmx:V7MnavbvD-WJixjTpRNbVUmFMt3WUdWknFu_5_hMnuncD3ThvB-dnQ>
    <xmx:V7Mnau32lH_vp-FfGhx90w1SaqphVHzCJxm3a0ywDm83jsotvCPYEw>
    <xmx:V7MnanZUgCXHNAw5zTNMLkS1bpPFe_ckgiLJju_yL5znmAF7kWdFCA>
    <xmx:V7MnajlRhooJNXLU6ZdPb7qf28Zq9usC6xacsV83k3tEqjwUaKa6cEjU>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 0E00F182007E; Tue,  9 Jun 2026 02:31:51 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 09 Jun 2026 08:31:30 +0200
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Marek Szyprowski" <m.szyprowski@samsung.com>,
 "Ard Biesheuvel" <ardb+git@google.com>, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, "Will Deacon" <will@kernel.org>,
 "Catalin Marinas" <catalin.marinas@arm.com>,
 "Mark Rutland" <mark.rutland@arm.com>, "Ryan Roberts" <ryan.roberts@arm.com>,
 "Anshuman Khandual" <anshuman.khandual@arm.com>,
 "Kevin Brodsky" <kevin.brodsky@arm.com>, "Liz Prucka" <lizprucka@google.com>,
 "Seth Jenkins" <sethjenkins@google.com>, "Kees Cook" <kees@kernel.org>,
 "Mike Rapoport" <rppt@kernel.org>, "David Hildenbrand" <david@kernel.org>,
 "Andrew Morton" <akpm@linux-foundation.org>, "Jann Horn" <jannh@google.com>,
 linux-mm@kvack.org, linux-hardening@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org
Message-Id: <12e57bd2-5eb3-4de0-bec7-b46b58935977@app.fastmail.com>
In-Reply-To: <6a9c0f55-fe98-4063-864b-8f7e1f4fefd7@samsung.com>
References: <20260529150150.1670604-17-ardb+git@google.com>
 <20260529150150.1670604-32-ardb+git@google.com>
 <a1b27e97-182c-485d-a448-56c19c5de2c2@samsung.com>
 <CGME20260609062840eucas1p1d49831bfdb3447e38a3cadc803a9afc0@eucas1p1.samsung.com>
 <6a9c0f55-fe98-4063-864b-8f7e1f4fefd7@samsung.com>
Subject: Re: [PATCH v7 15/15] arm64: mm: Unmap kernel data/bss entirely from the linear
 map
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Tue, 9 Jun 2026, at 08:28, Marek Szyprowski wrote:
> On 09.06.2026 08:22, Marek Szyprowski wrote:
>> On 29.05.2026 17:02, Ard Biesheuvel wrote:
>>> From: Ard Biesheuvel <ardb@kernel.org>
>>>
>>> The linear aliases of the kernel text and rodata are also mapped
>>> read-only in the linear map. Given that the contents of these regions
>>> are mostly identical to the version in the loadable image, mapping t=
hem
>>> read-only and leaving their contents visible is a reasonable hardeni=
ng
>>> measure.
>>>
>>> Data and bss, however, are now also mapped read-only but the content=
s of
>>> these regions are more likely to contain data that we'd rather not l=
eak.
>>> So let's unmap these entirely in the linear map when the kernel is
>>> running normally.
>>>
>>> When going into hibernation or waking up from it, these regions need=
 to
>>> be mapped, so map the region initially, and toggle the valid bit so
>>> map/unmap the region as needed.
>>>
>>> Doing so is required because pages covering the kernel image are mar=
ked
>>> as PageReserved, and therefore disregarded for snapshotting by the
>>> hibernate logic unless they are mapped.
>>>
>>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>> This commit landed in yesterday's linux-next as commit 63e0b6a5b693
>> ("arm64: mm: Unmap kernel data/bss entirely from the linear map").
>> In my tests I found that it breaks booting of RaspberryPi3 and
>> RaspberryPi4 boards with the following kernel panic:
> One more comment - reverting=C2=A063e0b6a5b693 and 53205d56212c (depen=
dent
> change) on top of next-20260608 fixes this issue.
>

Thanks for the report, and for the confirmation that those reverts fix
the issue - this was reported here as well:

https://lore.kernel.org/all/aicVyebkEMs6w6UV@sirena.co.uk/

