Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C9B37CD5C
	for <linux-sh@vger.kernel.org>; Tue,  9 Jun 2026 06:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780986525; cv=none; b=fnrbURM8EWaRJ7dJtZihpRi2t4S0dnOYXq9YEfyuSTPynO/IvLF0iYUi6D8+cIdYa+vogM4nnnoLM8J9x5HOP7XH3Aj4pModKyrYKcwzGRxWazhaWETGe+yT4sDLokd6HCny8EVx8ssrhtxloWQPcty0WXsCGcm3zaE/4YIwaXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780986525; c=relaxed/simple;
	bh=SFVfWkQYKQkmDlv3yjzLDsrGJLOZNviwXUib49VZTm8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:In-Reply-To:
	 Content-Type:References; b=SsG/JIcVlQdn9IdDS5clIG1e6AgT5WfQ6IB1b9g6giVgS+PIaeyCQgCg0Yc4sdvds9dS3KcYngZ+MZ3sUqKh6aJ5pQ/ZrL949DOJlq19B6yeMzOMlqe+3PasqofhqxLzy26LLhql1RbElgniNJYu89KKK9eocy4bAxw92/uXaTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=L71YJc2P; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="L71YJc2P"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260609062840euoutp0177775a80c813c6b14a8ac607bd8a0dbc~3Vc30drN11808518085euoutp01g
	for <linux-sh@vger.kernel.org>; Tue,  9 Jun 2026 06:28:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260609062840euoutp0177775a80c813c6b14a8ac607bd8a0dbc~3Vc30drN11808518085euoutp01g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1780986520;
	bh=sQDhEvXvj0vskWG5Nod+8TONy/NcJUoddZ5fD+XBrmU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=L71YJc2PSiiRY1n+YPatJVjODV3Te89KEOTZimaueovjODrs9pyp0pdbH67JiyEmb
	 wCUwBCsxT9/ecX7Nz8TuuKZuUCBE8zVB1UGNkFc3cWAa9XWukALnBxMuvL1JCRzJEL
	 shJ6fMw0Ilby9yFLoZKS/Rtr8A02ChpckDYrgCqw=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260609062840eucas1p1d49831bfdb3447e38a3cadc803a9afc0~3Vc3M9lZT1760217602eucas1p1O;
	Tue,  9 Jun 2026 06:28:40 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260609062837eusmtip165b8ffd20070283bf8a1cc3770a61ba5~3Vc0aQZiY2875428754eusmtip1_;
	Tue,  9 Jun 2026 06:28:36 +0000 (GMT)
Message-ID: <6a9c0f55-fe98-4063-864b-8f7e1f4fefd7@samsung.com>
Date: Tue, 9 Jun 2026 08:28:35 +0200
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v7 15/15] arm64: mm: Unmap kernel data/bss entirely from
 the linear map
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: Ard Biesheuvel <ardb+git@google.com>,
	linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com,
	mark.rutland@arm.com, Ard Biesheuvel <ardb@kernel.org>, Ryan Roberts
	<ryan.roberts@arm.com>, Anshuman Khandual <anshuman.khandual@arm.com>, Kevin
	Brodsky <kevin.brodsky@arm.com>, Liz Prucka <lizprucka@google.com>, Seth
	Jenkins <sethjenkins@google.com>, Kees Cook <kees@kernel.org>, Mike Rapoport
	<rppt@kernel.org>, David Hildenbrand <david@kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, Jann Horn <jannh@google.com>,
	linux-mm@kvack.org, linux-hardening@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org
Content-Language: en-US
In-Reply-To: <a1b27e97-182c-485d-a448-56c19c5de2c2@samsung.com>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260609062840eucas1p1d49831bfdb3447e38a3cadc803a9afc0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260609062840eucas1p1d49831bfdb3447e38a3cadc803a9afc0
X-EPHeader: CA
X-CMS-RootMailID: 20260609062840eucas1p1d49831bfdb3447e38a3cadc803a9afc0
References: <20260529150150.1670604-17-ardb+git@google.com>
	<20260529150150.1670604-32-ardb+git@google.com>
	<a1b27e97-182c-485d-a448-56c19c5de2c2@samsung.com>
	<CGME20260609062840eucas1p1d49831bfdb3447e38a3cadc803a9afc0@eucas1p1.samsung.com>

On 09.06.2026 08:22, Marek Szyprowski wrote:
> On 29.05.2026 17:02, Ard Biesheuvel wrote:
>> From: Ard Biesheuvel <ardb@kernel.org>
>>
>> The linear aliases of the kernel text and rodata are also mapped
>> read-only in the linear map. Given that the contents of these regions
>> are mostly identical to the version in the loadable image, mapping them
>> read-only and leaving their contents visible is a reasonable hardening
>> measure.
>>
>> Data and bss, however, are now also mapped read-only but the contents of
>> these regions are more likely to contain data that we'd rather not leak.
>> So let's unmap these entirely in the linear map when the kernel is
>> running normally.
>>
>> When going into hibernation or waking up from it, these regions need to
>> be mapped, so map the region initially, and toggle the valid bit so
>> map/unmap the region as needed.
>>
>> Doing so is required because pages covering the kernel image are marked
>> as PageReserved, and therefore disregarded for snapshotting by the
>> hibernate logic unless they are mapped.
>>
>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> This commit landed in yesterday's linux-next as commit 63e0b6a5b693
> ("arm64: mm: Unmap kernel data/bss entirely from the linear map").
> In my tests I found that it breaks booting of RaspberryPi3 and
> RaspberryPi4 boards with the following kernel panic:
One more comment - reverting 63e0b6a5b693 and 53205d56212c (dependent
change) on top of next-20260608 fixes this issue.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

