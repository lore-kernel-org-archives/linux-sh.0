Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.133.4.66
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792654038;
	b=J9iZW9EqmatBjz4pyCykhNgaHrEkXOXrI5x0t1HlqNihmb8KW2/k9YBcCp6fEOPsl64E
	 x4sbRbFJgLcQ+HAWSf62qafeH2e7oZruU30dBf54YDln68+QISCnMdtyo13cHQp4t+FzR
	 Y8UaePZ5kpviSBNZFpoz9Q+O59ofdTywTrn5O1IVRRYXW7nxjNKNk4my07rp5ZBDyY1cG
	 ZO9RCpmXH0NMia7wJaaOr/cUY/ebuYjSDZktflVl9z5rOK1b1ps8gZj1vu46IEyFzpRqm
	 SgctBSLz+GoHr6QvzeIpvpai2l/DpTTMQJu9YVGa2qqCgJritjN+Skg+N5WMhXWJiQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792654038;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version:X-Original-Sender:
	 X-Originating-IP:X-ZEDAT-Hint;
	bh=O/h10BzqvZOpu72U+oB1edYnS1r8iKvOz5b2/aHp5LE=;
	b=kaywRFoRZu7TztPjAyKkcCgtUSCnmTU9IMUGLxiXJMDAmcX7N0h95xqhdeZLmmlreGmk
	 hdeI89Zv9Ee2U8X9Cl5s9516r8t+JrfSTVaHTGVylkkDH3tYwzrc72nCITrJTiJEC09w+
	 OyzEA6zGilNcdAjF1WMmnOezxsRqSAqpdTHCDWRoziJih6QdxI10xKW8n1yCOatAl7sT5
	 ikyQSlOFJHPbHtpRc51Fh6eKpp6ZP/WF7aTH2iBxoBcDKaph1OpScpMsLU58bj2gaGLvG
	 ixQESSh8/xfIOD1N+ICx0AUiEq8daVaY0lBNvrB0LV+v71ei/pBSMAUkL7NYlXR40pA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=physik.fu-berlin.de;
	spf=pass smtp.mailfrom=zedat.fu-berlin.de;
	dkim=pass header.d=fu-berlin.de header.i=@fu-berlin.de header.a=rsa-sha256 header.s=fub01 header.b=VxJRSEbU;
	arc=none smtp.remote-ip=130.133.4.66
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BDD606A319;
	Thu, 22 Oct 2026 07:27:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2BDD606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fu-berlin.de header.i=@fu-berlin.de header.a=rsa-sha256 header.s=fub01 header.b=VxJRSEbU
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=O/h10BzqvZOpu72U+oB1edYnS1r8iKvOz5b2/aHp5LE=; t=1792654036;
	x=1793258836; b=VxJRSEbUCWY/HNBAnTJ1yQDoFi5LPRkESzx+vguF7KWQhPexauCnBZyfFtjyK
	CRnb69mUNzQxMpm9oPEuSSda3gi9dJPal5WfTI9AVvVxvsS/zWgcxWtUypImlgO5rr/QT5Wxbber+
	MEsZqulO/NyTN4WBIXlVZCuEFzpfZyb5n1kP4Y2v6DYBQ/ZOv9wQH+2Itkzgm0SOJkSSgYOtjmH2O
	8PKIHHxoMPcopm/fdyBCMZm/lGViWCWqQ13kY5/YFHrarUGakGIwHZZ13/nnVJBlCakICIWitMKPn
	MeM55ix1naFwrsANiNEUezKzZKx85Y87pnMP9ZhZMENBPCh/Uw==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.100)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1xJnCj-00000003nmW-203q; Thu, 22 Oct 2026 09:27:13 +0200
Received: from p5b13a90a.dip0.t-ipconnect.de ([91.19.169.10] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.100)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1xJnCj-00000004666-13Er; Thu, 22 Oct 2026 09:27:13 +0200
Message-ID: <87fe0b0339e6f8763b9b385dbe8b8b5e587deebb.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] dt-bindings: soc: document Casio fx-9750GIII
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Krzysztof Kozlowski <krzk@kernel.org>, Artem Novak
 <artem122novak@gmail.com>, 	robh@kernel.org
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, 
	linux-sh@vger.kernel.org
Date: Thu, 22 Oct 2026 09:27:12 +0200
In-Reply-To: <d6562416-05aa-452d-8fe5-a68cb8f50f01@kernel.org>
References: <20261022063902.471383-1-artem122novak@gmail.com>
	 <d6562416-05aa-452d-8fe5-a68cb8f50f01@kernel.org>
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

On Thu, 2026-10-22 at 09:16 +0200, Krzysztof Kozlowski wrote:
> > +properties:
> > +  compatible:
> > +    items:
> > +      - const: casio,fx-9750giii
> > +      - const: renesas,sh7305
>=20
> Where is any user of this?

There is a Casio calculator community out there that are users
for this.

Thanks,
Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
