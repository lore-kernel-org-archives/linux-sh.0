Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1A53CF686;
	Tue,  9 Jun 2026 07:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780989713; cv=none; b=BdJm0yHmxKWTNrTi2S6dFquu3P7r5Aw9K2qhUZZObpb+2PGVnYGggQUlvhigeoxxW87QVFf3DFxynAHcppmjkGm0dJT7MM4CjGS2ZYj4Xuq8qRQfH6kATiZ29402G59F7GnL8oqetVW6Y4V8kWdho7wp0bB80jvOFjF+PXOenp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780989713; c=relaxed/simple;
	bh=CLHSF7HHfGTuzchCmjZ7k8LDDTj+K7azDUBGddCThic=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CgU18/zSQbDBYKf4F6rpxA0+bu6lo6SHs6rkmuCzpbiW2iUykNFVC6aYzhEi463ftnfVcIAI2yaN1e1K85aUGmZWVEhRMW0gE7EJy9hMJWOZSMjuP3kJdZLRpCd/m4VrbBOgcU6BKfkRnekc9KB0PuEuwbS8X1c9JBlALlZnLHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=eJzrXBFI; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="eJzrXBFI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=ttaPCtrBc3STGwKMfR62Rge89sISRTtqGZK4dmGPG3c=; t=1780989708;
	x=1781594508; b=eJzrXBFITNcW7ZmgJTiRcMkzrBbo0iX+fk8FyxQHPXHP8rL1pGcaZCV/Jye8I
	jlMkdfI36+EEKlzUR6oy3WNBvYDcK1asN/GrkEMKZHnC+XsVo2/dgGWdPAjdDKNFG7/zH+t+U/7MK
	am5UJgM6i+LmT+etS9Vu93Do9X4Ko7uQIt6Uvj1+SOCHN6GVKGHeBj1S90Esooha+I+hMq9plntl7
	Q+hYjsku6k52d8VE3ilgBMwRC6rKkVdu7vqfyB1OGTyL1kLVdMLNEnUgh8iYZTXFi8Zg8Ow3CRRsF
	O9cbYN9XabKHwyCk8A3l5+jGQ7gm20houd38dUldyiRonTw4zw==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1wWqmI-00000000PFR-3zui; Tue, 09 Jun 2026 09:21:38 +0200
Received: from p57bd94c1.dip0.t-ipconnect.de ([87.189.148.193] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1wWqmI-00000000jAC-318T; Tue, 09 Jun 2026 09:21:38 +0200
Message-ID: <865aaa7aa64ab69ca9020d64d86baa8d9b700bcb.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v2 00/10] sh: remove NUMA and SPARSEMEM support
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Mike Rapoport <rppt@kernel.org>
Cc: linux-sh@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
 Arnd Bergmann	 <arnd@arndb.de>, Rich Felker <dalias@libc.org>, Yoshinori
 Sato	 <ysato@users.sourceforge.jp>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Date: Tue, 09 Jun 2026 09:21:37 +0200
In-Reply-To: <aiBI_QEmeVSBb2HY@kernel.org>
References: <20260510135546.13554-1-rppt@kernel.org>
	 <agr7XvoWn_-axX1-@kernel.org>
	 <adb1db8d1fbb9d219fa041776ae863aa2fc09270.camel@physik.fu-berlin.de>
	 <aiBI_QEmeVSBb2HY@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Mike,

On Wed, 2026-06-03 at 18:32 +0300, Mike Rapoport wrote:
> On Mon, May 18, 2026 at 02:05:39PM +0200, John Paul Adrian Glaubitz wrote=
:
> > Hi Mike,
> >=20
> > On Mon, 2026-05-18 at 14:43 +0300, Mike Rapoport wrote:
> > > Gentle ping?
> >=20
> > It's on my TODO list for this week!
>=20
> It's sad to see this being dragged since mid April (if we count v1 and
> there were really minor changes in v2).

I apologize. I am doing the maintenance as a hobby in my free time, it's
not my primary job and it can sometimes take me a bit longer to take up
changes.

> If you don't have time to take care of that, just say so and we'll take
> this via one of the mm trees in the next cycle.

It should be better this week. I've been recently busy with CVE fixes durin=
g
my dayjob and the workload was extremely high.

I am not going to let this slip, don't worry. It's just been a bit too much
stress the past weeks due to the AI CVE reporting.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
