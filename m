Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264BE45003
	for <linux-sh@vger.kernel.org>; Mon, 25 Nov 2024 07:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732518863; cv=none; b=oyFnMTuVOFtNBRrEdDHHjO32alSo2xE3jocpGMFHPo7r9dVmuYq+hW5zMC4YnD/Yz+4iLypLVgPtAaYuzQ/mDcv4Pw05Ok6JDY1qHBSyzJVBIbCu1qDNRWPLhJAD95Svxe/FFZm8NU0JTTDaIetXobRN4KngfuqJ2CxtfeAM8K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732518863; c=relaxed/simple;
	bh=ASrqRf9mu05t+iI4Vsa0vSOLm1AmEFoO1/lKtg7k2cQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bq3uHqaA5xFzgXhs1B0YLyZWa1i6CUzEgDESXe6kjmEl3H3ie6L6p+v4jNXVcbpRX4aGpo1QVLenFIXWz9sPYWj0k4ip8kS4sKZnrCUJfQDQbYxU4P+3//1wKdRMB8EmA5e9n4/Taq+xgNI87dO3b7FEtqEJa6xHZpCsKJ+7ahI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=Natcm7qi; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="Natcm7qi"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=QUz84zWZnWktzf5Zr8MR1f8RYzXllQ3j/mOld51+N9E=; t=1732518858; x=1733123658; 
	b=Natcm7qiWhOKw6rcGIWyEXQZqQhsqKpQXcBUe/sJmj5Q9pghevzjkjxOE6nxvHNL3FDW6ua6YWi
	xXwI6L/VNv0fsQEFCVHDdg8PhQJ3/VaXN6BLuOn+zlxhzmcC6TNIe0ep2yzeK6FLPsi1cmOn3zxQ+
	zIVVB9at+FfqU/sTGc8EFvSiiq7Xzy307IduZ8Y+OjwqXqL2Gi7XDs//Ab58Wd/zrXAvXOv0/vVx7
	x5jbEriUjR/VNW7DemRlAhoVSai/jDmZhzI7PpW8HhQT39iznKScxprPzaxV/PmiPe1O5kp7FPS9T
	IAxpjcnK9XOdpcrmpj4KPORRJUInwLyUH0MA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1tFTID-00000001vg0-1Gse; Mon, 25 Nov 2024 08:13:57 +0100
Received: from p57bd904e.dip0.t-ipconnect.de ([87.189.144.78] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1tFTID-00000003gY0-0Gra; Mon, 25 Nov 2024 08:13:57 +0100
Message-ID: <b5acd30ef15d409689c06e76ef6e7fb9232a622b.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sh: intc: Fix possible UAF in register_intc_controller
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Chen Ridong <chenridong@huaweicloud.com>, Geert Uytterhoeven
	 <geert@linux-m68k.org>
Cc: ysato@users.sourceforge.jp, dalias@libc.org, gregkh@linuxfoundation.org,
 	ricardo@marliere.net, damm@opensource.se, lethal@linux-sh.org, 
	linux-sh@vger.kernel.org, chenridong@huawei.com, wangweiyang2@huawei.com
Date: Mon, 25 Nov 2024 08:13:56 +0100
In-Reply-To: <a3decec2-53f7-48bd-a2c8-2400cc7a1dad@huaweicloud.com>
References: <20241030060813.1307698-1-chenridong@huaweicloud.com>
	 <CAMuHMdXznLuo7QegG9giQo80HcRmV4MgKh67sWy2WJXd4Pry+Q@mail.gmail.com>
	 <a3decec2-53f7-48bd-a2c8-2400cc7a1dad@huaweicloud.com>
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

Hello Ridong,

On Mon, 2024-11-25 at 09:21 +0800, Chen Ridong wrote:
> On 2024/11/13 16:26, Geert Uytterhoeven wrote:
> > On Wed, Oct 30, 2024 at 7:17=E2=80=AFAM Chen Ridong <chenridong@huaweic=
loud.com> wrote:
> > > From: Chen Ridong <chenridong@huawei.com>
> > >=20
> > > When it goes to error, the 'd' is freed, but 'd->list' was not delete=
d
> > > from 'intc_list', which may lead to a UAF.
> > >=20
> > > Fixes: 01e9651a21bc ("sh: add INTC out of memory error handling")
> > > Signed-off-by: Chen Ridong <chenridong@huawei.com>
> >=20
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >=20
> > Gr{oetje,eeting}s,
> >=20
> >                         Geert
> >=20
>=20
> Hi, can this patch be applied?

The patch is on my list, don't worry.

However, the same issue was actually already fixed by Dan Carpenter:

> https://patchwork.kernel.org/project/linux-sh/patch/45ff88d1-b687-43f4-a0=
22-4e07930cd2d0@stanley.mountain/

I need to figure out which of the two is the better approach.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
