Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A9A3FD153;
	Mon, 18 May 2026 12:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779106266; cv=none; b=pPc2gSGpZwWuab0f/rNwVKQOHQ4ulRem3hB028f56w9WyxGCCvRIYK8nKZyUaJvAdTCOMuvmbUMZMN3gwfLzuIYlxzx5zYtktiRDVIe5FkU4GNnsZd/tBuBs8mgplAa3Yt1+29UrlqOUmky1ky9wkadjF5MvHzY/SPtWuR26vE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779106266; c=relaxed/simple;
	bh=MMW8Xcy0ozejOhRJ6CyedjM8bREYY/A/20+GskGmUKM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OQjgsV6/IqtZaVGqBEaVQwFPHrV2K+/UBCu4iTkeb01L9wxmjBJPdqWdZMLC/VAWAkQWPOowDOlFaG7DuYDocVLICueBtW6/GIDv4uDmFPmMUgR7at6XGe4XPG72SJokTaTahS/cp4qCAS03YTgksbHmfQmDdbv+4rebxblzBfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=MMe0mM3G; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="MMe0mM3G"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=SXw+Y9FPLLLVyXTKHpJPROy78RD4gYIyHyZ6bURXx1I=; t=1779106263;
	x=1779711063; b=MMe0mM3GI5xUqj7eemGUl0OB/V8jI95SwFSqHqcZJ6M8ePtfGTk5j7KuO25mD
	P47V1472QZs4sxPED/gSwBiHPZtrFuC56eiPo3Xuhqjjcs7Us/RmQIfwfqrWHVaCnnKOPCBui5Dz+
	4oXRVWxEjm2+dGHojbmnRaVuayvpDrOulVA2U1j3nHXynyLjE6SBYe+cyRiqmCKO9utdDiiqQyjuQ
	EhwPu/B44q9S2vYOGtJeq2Bm6W4dBIi0xg9muSJwpyATwqfNxZXTjv2DLhceqeF7P/pt2aw5r9wwr
	N8QsKsYBcYN2SSw5XTseCYRHlGYYriW53A5K22Phs4ECkPyDCA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1wOwj6-00000002a3Q-3bjt; Mon, 18 May 2026 14:05:40 +0200
Received: from p5b13a134.dip0.t-ipconnect.de ([91.19.161.52] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1wOwj6-00000003CzN-2BzF; Mon, 18 May 2026 14:05:40 +0200
Message-ID: <adb1db8d1fbb9d219fa041776ae863aa2fc09270.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v2 00/10] sh: remove NUMA and SPARSEMEM support
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Mike Rapoport <rppt@kernel.org>, linux-sh@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann
 <arnd@arndb.de>,  Rich Felker <dalias@libc.org>, Yoshinori Sato
 <ysato@users.sourceforge.jp>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Date: Mon, 18 May 2026 14:05:39 +0200
In-Reply-To: <agr7XvoWn_-axX1-@kernel.org>
References: <20260510135546.13554-1-rppt@kernel.org>
	 <agr7XvoWn_-axX1-@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Mike,

On Mon, 2026-05-18 at 14:43 +0300, Mike Rapoport wrote:
> Gentle ping?

It's on my TODO list for this week!

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
