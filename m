Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052573B635B;
	Tue, 11 Aug 2026 07:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786431921; cv=none; b=Jt2YB7lV+wi0sqsbOLdIktya0FX+U7TWQM+NFYJv8Gccfp45i6V7PWDnLXD/IVWki9rUfZpn+14Wqoq+hkmUwKTmPCK3eGVhpNiZQ8se9Fw23evk3rCVKT9itrJIdUtJe2gn3wqJeSctlsdkb5/UGIDFHLRsSFJKswBnbHl+Y/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786431921; c=relaxed/simple;
	bh=DIMOPBVekP6L2BK936FqUInSum7lh/bsRY6w9e7IhqA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SAuYGcsQBxCDSUJjD3XgFpIm5dD6QGtw2kC64P7DCh+x6Qe0IQkJPg+RIVP2VYNpg/2FEMJojETUCP9jONMPmkxP4cTpr0pRzX4tsNaIiDx8ID9AU6yedcmiZQFfevFicVyrcrGc1N6n94CUY4dPVj26WFjkNNFm42CW1rF3XqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=IdKM7dVZ; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="IdKM7dVZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=Ex4q7ykPfIR19PS0JSgYzk10qmPo/yRZsmrtNkk/C0c=; t=1786431917;
	x=1787036717; b=IdKM7dVZqTLUYwj13QbLRapW0T21izq26saOWGxzH1MVtQBNYm+gt3zsI+msh
	KrP9yw952+4RT6pgRiRtHS5M1TpcEBtg7+1BiI/gXRzKXKwdWonr1jGB16Ey7MOgZKiPICz6Xxcgw
	170XGCKfkYOc1KGXujkgMGUSpI8KgAxWi5vpkCUqywFE6euSmCbEjX37HIMOIgwhqcvBK4bvtwpal
	rE8FH/3wKdw6oe7jZxBYDWAKFj3PV9zPlvhIq4PnDYgm8l4rq5m/9nFHu9RofUcW+qKtg/xq7cO3q
	EQEPu2qbQngHHMo1XGpKNc/B8VXofGGeEDjbC5/RIC8ilEjHZA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1wtgSK-00000002QmD-3YGh; Tue, 11 Aug 2026 08:59:24 +0200
Received: from p5dc558fe.dip0.t-ipconnect.de ([93.197.88.254] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1wtgSK-00000000ni5-2Tov; Tue, 11 Aug 2026 08:59:24 +0200
Message-ID: <b9b5a0c24433c4a191a504f652127ef1fb9b1731.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sh: mach-rsk: rsk7203: avoid using inline compound
 literals
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Linus Walleij <linusw@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Yoshinori Sato	
 <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Bartosz
 Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
 linux-sh@vger.kernel.org, 	linux-kernel@vger.kernel.org, kernel test robot
 <lkp@intel.com>
Date: Tue, 11 Aug 2026 08:59:23 +0200
In-Reply-To: <CAD++jLmNry6DwjDm490_n1Z2AmBb7viaOTEv_Ntnsc77dBHmJQ@mail.gmail.com>
References: <20260802-sh-rsk7203-swnode-props-v1-1-7a790cbac9e6@gmail.com>
	 <32a0d810bfc56029453aa72cefa49cb40466f64e.camel@physik.fu-berlin.de>
	 <anAvJM0u_TIgL4ck@google.com>
	 <70cb2e4d8a6fd11cbeb534dbf269f67148a00a8d.camel@physik.fu-berlin.de>
	 <CAD++jLkxXYfZadV26956yMAaCtZYr7mRGPA8_kixufbXFW1B=Q@mail.gmail.com>
	 <CAD++jLmNry6DwjDm490_n1Z2AmBb7viaOTEv_Ntnsc77dBHmJQ@mail.gmail.com>
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

Hi Linus,

On Tue, 2026-08-11 at 08:52 +0200, Linus Walleij wrote:
> On Fri, Aug 7, 2026 at 12:05=E2=80=AFAM Linus Walleij <linusw@kernel.org>=
 wrote:
>=20
> > 1. (easiest): tell me to just revert this out of my tree.
> >  Deal with this whole ordeal later.
>=20
> The merge window is coming up and I can't send a broken tree
> to Linus so I went with this option now.
>=20
> John: the patches are all yours, I have dropped them from my
> tree.

OK, I will pick them up this week. My workload has settled a bit, so that
I have some time for kernel stuff again.

Did you revert Dmitry's patches in the kernel as well?

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
