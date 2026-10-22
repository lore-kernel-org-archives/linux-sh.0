Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.133.4.66
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792655188;
	b=TwJ5hZDUXUbpGeUGOC8NBEQQjNgO0GWsz8gn8mjnmLJ4rnyG3t1pzt+QU+oD45U0rLiE
	 SVjwWCpcUku4TE9CB9rYl42PE45e9IJSzCRKXy+sbHE4YOjU8xKRdnhSZzk2ChzwrGBQ3
	 6XL4D/B/QG9JCxpyEMAPuMCY/jH8b6AZj4/XkiKTByhm7hJGN4Ra/nj1gGKKdImEXKDVa
	 OPyVEUBrma26/BUjfs0i0edGKHNvpkDGPswWISyIgzt4UjWxXug9aNRR8BzdAqrsoAbY5
	 WVD+7X4/VA4JbzL+xk5BqCVb3pmbZoJdKLVvDMvCpd4bWKgDAL9JP5DgGAXIrkdu5uQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792655188;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version:X-Original-Sender:
	 X-Originating-IP:X-ZEDAT-Hint;
	bh=gvZ8R3iNYCC2o78cer5OoILJ7qYtxYvoXIYa4LpkwDI=;
	b=NW7DmQSFskRdhf/AdRTcJDid7AFhJvAv0KUaFhGfBxHjk6iIzaYVKxEh+NPGM12LC4Ys
	 sP+yo9XkwI99E68hFWGPSXrZmrqDpi/vNVH/HQbFs5Sq3zQroQYvk3FjV8YZtsgjDWUQr
	 epKQp9sstQ5MIY4WywEkLytyHwVdaSwcFyTqHRBjSiJOAdqQCDeF3HmHbpaHPbDZJE3HS
	 s1YjlXAQuosnVa/y6P2XizRDu47rQLkclKEKBWL6dnY8pKXOfy1YsLGS57tOPqdbosvIR
	 AND4sGTuO/kJ/4/PuYrqkZm9vh8Qwrh6myksP5/hqzncZHnliBxsZkealwBDQgg28CA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=physik.fu-berlin.de;
	spf=pass smtp.mailfrom=zedat.fu-berlin.de;
	dkim=pass header.d=fu-berlin.de header.i=@fu-berlin.de header.a=rsa-sha256 header.s=fub01 header.b=OJFX61ve;
	arc=none smtp.remote-ip=130.133.4.66
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B518A606A319;
	Thu, 22 Oct 2026 07:46:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B518A606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fu-berlin.de header.i=@fu-berlin.de header.a=rsa-sha256 header.s=fub01 header.b=OJFX61ve
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=gvZ8R3iNYCC2o78cer5OoILJ7qYtxYvoXIYa4LpkwDI=; t=1792655186;
	x=1793259986; b=OJFX61vepWU/KFcLhFseB052OCMon37GFFjjiDmHUXHlTNXWtk1lHImFkN+xd
	ueMSYS5uXaCTUU873Ujn8toKrxVI4Y6+6FbtUBGTlCDMUEde8/u95k7hnbpxJxcL8R3Fkxdh5jbTG
	tjwtDxZwr5SOM6YiIrWeOeYPqCuajxqFhT8wtgWeOoeDclbRn/m2PuSLkBRGQz8K5wvn7S8gI6Gw7
	//xdYLMI5/9iYQJkPOoP/X4zubH20JrXXPf6BHhTtwmebsxTtcB/CfIvzNagJQezvDD3eylalVrfz
	zzlgXZpSdlqx6FZm16JzLKs+YWqJZ5f9pDObvy1WEIr4mG1HTg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.100)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1xJnVI-00000003uZR-18NE; Thu, 22 Oct 2026 09:46:24 +0200
Received: from p5b13a90a.dip0.t-ipconnect.de ([91.19.169.10] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.100)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1xJnVI-00000004Agl-0Dq6; Thu, 22 Oct 2026 09:46:24 +0200
Message-ID: <4f37ee0df5c5b0b29c69b3770c06a885f0562c74.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] dt-bindings: soc: document Casio fx-9750GIII
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Krzysztof Kozlowski <krzk@kernel.org>, Artem Novak
 <artem122novak@gmail.com>, 	robh@kernel.org
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, 
	linux-sh@vger.kernel.org
Date: Thu, 22 Oct 2026 09:46:23 +0200
In-Reply-To: <b8c7db3a-ad4d-4378-9e50-4c8591b93de8@kernel.org>
References: <20261022063902.471383-1-artem122novak@gmail.com>
	 <d6562416-05aa-452d-8fe5-a68cb8f50f01@kernel.org>
	 <87fe0b0339e6f8763b9b385dbe8b8b5e587deebb.camel@physik.fu-berlin.de>
	 <b8c7db3a-ad4d-4378-9e50-4c8591b93de8@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Post: <mailto:linux-sh@vger.kernel.org>
List-Help: <mailto:linux-sh+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sh+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

On Thu, 2026-10-22 at 09:33 +0200, Krzysztof Kozlowski wrote:
> > There is a Casio calculator community out there that are users
> > for this.
>=20
> Upstream user, so any known upstream open source project using Linux
> kernel DT bindings. We do not need bindings for non-upstream users.

Yes, I realized that hadn't had any coffee yet and I misunderstood
that comment.

I think that Artem is sending the users for these bindings in a different
patch set. I have not been able to review the changes for arch/sh yet.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
