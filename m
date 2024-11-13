Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E2A189BB2
	for <linux-sh@vger.kernel.org>; Wed, 13 Nov 2024 08:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731486950; cv=none; b=URF/aYFRKrpinq5g+wvPvLxD+OlSHOrUH0svmqog9o2p3ydZ1/VkVsPmrwycswo3g/h3crAQL8D4AyZy/la8pXL8HqGP1nRJu/8yUV5xZXimvOKDHJTED4drmvlYr/wKShy9ADp15eXV1FvAw0e1pWTpIxmXgGIQoogwCWQZqlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731486950; c=relaxed/simple;
	bh=qssUItXR4KeAG7Pj6TG4nxZsavri/8Hgsr+ricLqG/U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CmBc1v7iW35g674E8XRIAG0zrw8GNnmozei5CdeEumgc8I/RLPKg6wvxu3kBt4ULiCG8mEfuSsXf/URrKEs0HquIKSYTaPxAQRlWYoXQRkzxWvLAPLshYhssfKmOKI4RpXYjs/QgCWjyy0bdxymEklBvJn2/sq5rmPINWUZaKvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=cIU2JTir; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="cIU2JTir"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=aq1aKmSJAsEPraUzGdk0YYk8e3bSxzlFeAMaSTEUZ/I=; t=1731486946; x=1732091746; 
	b=cIU2JTirjivISWSJ0ddjUij4WEz0qVGM0EsYDpPCHgAIzDGeXG8F2OFq3z/h5s34ua8DdtL/Bdd
	C8b3d1vQ71xytNlgZr/TwOL01NeHx3bAs05rOwHa+3vQSRpP51CfbosGGKLbRLyZfjOL7UWXpR6BH
	4NgyGh/g8tC8nDYkOGufUT7dszyDSpGv4zc3IeOS+qaP73l3RH+diZAe5YHgstGJlBtU4s8ynoDZq
	0fBM4YN+TATuJoDGd01aczAEndU5AIb3ApYI2p8v99MLg4X7RjM9h1rIfPVSZ016eOAiY0vE9tP5g
	CibOtH65MOqNFIhxCn9LS+MZDdmv3fBbD5zg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1tB8qW-00000001ApC-2S1Z; Wed, 13 Nov 2024 09:35:28 +0100
Received: from p57bd904e.dip0.t-ipconnect.de ([87.189.144.78] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1tB8qW-00000003QsV-1Tln; Wed, 13 Nov 2024 09:35:28 +0100
Message-ID: <cc97795980848b7002bf157d9e925cd6e516e9cb.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sh: intc: Fix possible UAF in register_intc_controller
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Chen Ridong <chenridong@huaweicloud.com>, ysato@users.sourceforge.jp, 
	dalias@libc.org, gregkh@linuxfoundation.org, ricardo@marliere.net, 
	damm@opensource.se, lethal@linux-sh.org
Cc: linux-sh@vger.kernel.org, wangweiyang2@huawei.com
Date: Wed, 13 Nov 2024 09:35:27 +0100
In-Reply-To: <7ff2dc30-1b63-4314-b154-355880bba3a7@huaweicloud.com>
References: <20241030060813.1307698-1-chenridong@huaweicloud.com>
	 <e1792bb5-6212-4452-9c1d-c372204c3348@huaweicloud.com>
	 <cf281c9e0d04483d7cafd89aeb25b55878e81385.camel@physik.fu-berlin.de>
	 <7ff2dc30-1b63-4314-b154-355880bba3a7@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Ridong,

On Wed, 2024-11-13 at 14:21 +0800, Chen Ridong wrote:
>=20
> Hi, Adrian, have you reviewed this patch?
> Looking forward your reply.

It's still on my radar. Luckily, Geert has reviewed your patch in the meant=
ime.

I currently have a busy week again, but I will have more time in the weeken=
d.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
