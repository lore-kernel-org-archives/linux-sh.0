Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2134B13D51E;
	Fri, 12 Jul 2024 09:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720777462; cv=none; b=YZPsgXLv5gz9XfdKwslPIWhyScoInYjChYv/vibo1ONbMxFmFRvNQjT/hbATU21iXLxWxrW1F4Rmtd5pRjHAgZ7QhZXOE8WUwi78LSw5XQb5Q6iaH9RL5jlw7STvWYMYKuJLRYFcuRMlQAqIGMb4CbsGTQk9VMVIZEYRTssB2j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720777462; c=relaxed/simple;
	bh=q13i1UrJbetK34WE2V5NdO5LnYAjKeg/a8WeJvLRFjo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uvkWQQz0KFbqtJYDvFaT6tkI0lJZ67NAMWMAjUp2QAsIBtM8AiEH2zSglslC3UHKqC5Jo/07FOqTd+g+3E+KCLMuYuZ75YvwGWpbcrexGaxlFUaBpS2jmNb3mWyUrlcTz7FP5FPgFjvHlkyV1swuxlmnjj4Nix1pG/dslEUgaoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=EvOYAsIa; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="EvOYAsIa"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=sDiUZ4QoH7yxeVq4sOH+f1iqy4IHQrCh16bS9Hu+pw8=; t=1720777459; x=1721382259; 
	b=EvOYAsIanIjfp/bvdXJj749oc7pauSuKW4wiwCTuhFlgbq7A+iKtF7Vzd22Pnc3dXmhbjikD2LV
	/7vIWQfDGCeOecbb/295ctLN2aL0yE1UncV20v+4iEdgVh6AQIhAC2FIBLl0wBAh2s/1xEU8v6ycC
	HG1mPLMeawuw0KjF3AuN0fRiI7X1+W5j/PCauwEZvrCCZgw9l0H6LWiLoK2FhAZBRQFnLCQ+X9dsT
	8pcm05IfhTEkkKF0xUnibdyEQDTADXbzpDgIbMLGpwgUycAFRRNSI3M/LlWXtRM0Nf7IsVjsg5GkS
	v/2/N1YiXrUvtQkJjQ8VNIgJ3i+ODwiT5arQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1sSCp5-00000000KCN-3kgO; Fri, 12 Jul 2024 11:44:15 +0200
Received: from p5b13a475.dip0.t-ipconnect.de ([91.19.164.117] helo=[192.168.178.20])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1sSCp5-00000000RTp-2shE; Fri, 12 Jul 2024 11:44:15 +0200
Message-ID: <d2f868b2184bf05e782374d4316a4ed4c1e4fe2c.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v3] sh: Restructure setup code to reserve memory regions
 earlier
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Oreoluwa Babatunde <quic_obabatun@quicinc.com>, 
	ysato@users.sourceforge.jp, dalias@libc.org
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
 robh+dt@kernel.org,  kernel@quicinc.com
Date: Fri, 12 Jul 2024 11:44:15 +0200
In-Reply-To: <fd55bf91-cc59-403f-bbba-88b63c8535df@quicinc.com>
References: <20240520175802.2002183-1-quic_obabatun@quicinc.com>
	 <47f3716dd48ecdc35d823fbab087332fbf3a24d5.camel@physik.fu-berlin.de>
	 <fd55bf91-cc59-403f-bbba-88b63c8535df@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Oreoluwa,

On Thu, 2024-07-11 at 14:50 -0700, Oreoluwa Babatunde wrote:
> Thanks for taking a look and testing the patch!
>=20
> I have made the changes you mentioned and
> uploaded the new version of the patch here:
> https://lore.kernel.org/all/20240711214438.3920702-1-quic_obabatun@quicin=
c.com/
>=20
> Please let me know if you need me to do anything else.

Perfect, thanks a lot! I will retest this updated version as well as review
it and then add the R-B and T-B tags, then merge the patch this evening.

Thanks a lot for your patience!

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
