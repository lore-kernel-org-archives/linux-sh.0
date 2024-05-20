Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDBD1847;
	Mon, 20 May 2024 18:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716229498; cv=none; b=a8WZCvVewLQlbaMYlwK9BBrgbhLogIk7BmKm+e5zERneW63rBhIFJSCGBuZBgIKYenO4FN7oN6rMux4nXag80A0gQf7iZeKmhdfKzZPALaEa2WmQk24LTuxBLoMTuXbH2sucnleQBCd9Z5gGHR4AU5N6LJmyhBg6TmnvkIHDW+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716229498; c=relaxed/simple;
	bh=embwZJeyhc3d/eQBQ2AmwUIIJANut56abOXK/YW3yJM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FlaPdyIfxjo/VB7v46RiX3XRO9qlMJ2r0CDVZm5UWShSBr8JJb7nv7lKNMSX6ynfuzPx+Jch4QICNaEkTjoEN2gLtKXNePr6T24P2s+X11hEr3vo9LUqneErhvzMui205Q/26AtIX8kKZ/N51mtqXOxNuOVAcsXEdw34cpIDDWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=hgUFtytb; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="hgUFtytb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=zwEmpdKTmgjz2scPBDSL4o03FYFjxO3vSlNGyHJLelg=; t=1716229494; x=1716834294; 
	b=hgUFtytblmdL0XcSezFeeqG5jBBgynRhT+8wQwOJFwCZNnSz3UxB7xvBIPFB1IbrYpX8+sCSRei
	5JdEQy1f1boAG1GpdU9g9jlrv5D2e+i2oX/JuqR62OiqZN19p1qGrYbxR0tRb24ASUfrpIL6jZ4o3
	kMZKVYoQMhynqRzoeHdV0J/QVhoKCGRsoqS9spBFTKnNAhFPh8dRcY+bmN3aEcr70LB5PzdzHAbUf
	DywqjT17b6Rlc86TjZQ1LDtA7FZ2TOeLmyo2RbP6C88unibN1ZMEiTwTYQ/OM2cTKWVhyzWmrhrQf
	0c6r//wVfWJUS3URASlrI6DsoARw6ibUWFPw==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.97)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1s97go-00000001bFA-2fJU; Mon, 20 May 2024 20:24:50 +0200
Received: from p57bd9a40.dip0.t-ipconnect.de ([87.189.154.64] helo=[192.168.178.20])
          by inpost2.zedat.fu-berlin.de (Exim 4.97)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1s97go-00000002MIw-1hpz; Mon, 20 May 2024 20:24:50 +0200
Message-ID: <7130f36dcf6f2272fa61eb1477f881ccea0375f8.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v2] sh: Call paging_init() earlier in the init sequence
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Oreoluwa Babatunde <quic_obabatun@quicinc.com>, 
	ysato@users.sourceforge.jp, dalias@libc.org
Cc: akpm@linux-foundation.org, linux-sh@vger.kernel.org, 
 linux-kernel@vger.kernel.org, robh+dt@kernel.org, kernel@quicinc.com, Rob
 Herring <robh@kernel.org>, Rob Landley <rob@landley.net>
Date: Mon, 20 May 2024 20:24:49 +0200
In-Reply-To: <e6436f2f-ac51-4f18-90f2-e39a2ff1c520@quicinc.com>
References: <20240423233150.74302-1-quic_obabatun@quicinc.com>
	 <72ec7831604326e852eb228072b1d817bab829fb.camel@physik.fu-berlin.de>
	 <b00e0adc72815e465cf32fc5505445cfceeeca84.camel@physik.fu-berlin.de>
	 <ec5f3194-7e9e-4cc9-86b9-02a204649246@quicinc.com>
	 <0e813c8498bf3d9ed5d8fd5b171ac9980dc2999c.camel@physik.fu-berlin.de>
	 <e6436f2f-ac51-4f18-90f2-e39a2ff1c520@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Oreoluwa,

On Mon, 2024-05-20 at 11:03 -0700, Oreoluwa Babatunde wrote:
> I have uploaded v3 of this patch now.
> https://lore.kernel.org/all/20240520175802.2002183-1-quic_obabatun@quicin=
c.com/
>=20
> In this new version, paging_init() is left in its original position and o=
nly the portion
> of code that is responsible for setting aside the reserved memory regions=
 is moved.

Thanks a lot for the updated version.

I will give it a try later this week as we had a public holiday in Germany
today and therefore enjoyed an extended weekend.

If it doesn't break anything and Geert is happy with the change as well,
I'll pick it up for v6.11.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
