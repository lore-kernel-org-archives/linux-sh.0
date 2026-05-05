Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C433D390CAE;
	Tue,  5 May 2026 13:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777988318; cv=none; b=nDtfV/IqpR9UrzdMKwvfztsR+ECUoCRJ/SSGihIm5r1LGvcz7xF50Ma/Gz0zz8zV7slVZFMHRh9RPVhe9fwoaAkJ7ZIPZE9jSud+WW6wC9zOtaqH6U0o0ytlKkNcR1BX37LnFUO9Mu2kcU2EFYRT8fifRbmaq+AzgEWCfLqLczE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777988318; c=relaxed/simple;
	bh=q95Rk1ATQF+dR1YT9gsJqLi5tSqLSPj6ELlvXk/DMZU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SfoCdgKemB9A9SR8qCenuNp96t9D5aKW71gA/lAuFMN9XOaBWJvh3HzG3i/5eVvGfUXBYD0eX647sWX0KBKIy/ziZLBVCRzmqfrWO7nvotL52BW8P8sbuhGa1hhH3cH1x+5+tvYew1wvuSoTuZj0AbgrXOFl2iba6btfo2P7rGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=AYyxzY0/; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="AYyxzY0/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=25obrNKYXCTEPqEYH2FVP12g+zJe3Jj7maffA6QfntE=; t=1777988314;
	x=1778593114; b=AYyxzY0/xDEw7gjoJvOexS/Hcj6M/O2jhXsUNZSSw6tbcjIo+yYhqHLlZ7zmA
	uR5ZiFVXG5caZVa+nX8DCYlzgsn38IVCBv2lAH4ZIdn1yI0RWcJXBSxMaco8FOtqE/gcy5UFT/XxE
	RoHY6NFtSY81GLsSLnMVZcj4cxzDz4F7MS2A21at4pmwBCivjBvX4hMTByq+SQPxVbEPSjwjqRwFT
	4PTX4GhMiVbKOP/6OXY7e70q+leSW3Yh1Bp9mgpN5mO9fgXeLQM8r75XYIMJ+3Y0W8MhnmiPgsR2o
	EZSIpkvcyD6UsZuVqd+CAig6hKIOCApow2xh5XZwhG2OWyjSMA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1wKFyk-00000002K7G-1q7I; Tue, 05 May 2026 15:38:26 +0200
Received: from p5b13ad18.dip0.t-ipconnect.de ([91.19.173.24] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1wKFyk-00000001kmP-0wUt; Tue, 05 May 2026 15:38:26 +0200
Message-ID: <898533b39f1ce3d961428601c3097103f40f9aa2.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] MAINTAINERS: remove Yoshinori Sato as SuperH maintainer
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Thorsten Blum <thorsten.blum@linux.dev>, Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 05 May 2026 15:38:25 +0200
In-Reply-To: <20260505132755.161800-4-thorsten.blum@linux.dev>
References: <20260505132755.161800-4-thorsten.blum@linux.dev>
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

Hi Thorsten,

On Tue, 2026-05-05 at 15:27 +0200, Thorsten Blum wrote:
> Yoshinori Sato has not been active for a while and the listed email
> address bounces. Remove Yoshinori Sato as SuperH maintainer.
>=20
> Use https:// for the patchwork URL while at it.
>=20
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  MAINTAINERS | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

I think you should move him to CREDITS instead of just removing him.

Also, I'm not sure whether it's good idea to mix two different logical chan=
ges.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
