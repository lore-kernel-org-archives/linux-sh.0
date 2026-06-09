Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCF24048A3;
	Tue,  9 Jun 2026 12:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781007681; cv=none; b=V6+3TIU7Rg7BnUXHm3bU/IOb/kusKss/SZQ81xjdB3t/29CyJe2LL/ArfR3BJ8McBPlb0V0xULb1l4FD6rk4Q0dN73PT9eSkYRFKwJauPVFa5rfmDeO99N6J1sk5GfdEoEwJmtETEKomCwP+X9Rz8i7UqHXUc7ZQeIsEtoMrZow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781007681; c=relaxed/simple;
	bh=BWUt1+RB/jCkrdpsMBXD2NcEwLIyRgW5iHsIFh5hGtk=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qsMGYSU9EcDgA8qVPPpcmZTge9ILBNaQH1Bozojv6Fs/xX7XqLkCqWcCIxTJNSk5A5f6hliuX1SclnfB7Q/9iX8FLpb2LogB4rV1OGuVkCUPxFnU7pN5aGGyo01QCRQNaSj6d4wrg1w1p6+9WAgjAI6d+/T0vgvUIRT+mhSvbxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=VYk4/1zZ; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="VYk4/1zZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=OGU1CgChEeCgPS7G5LflryCr8OO4qfeKLQ2OoufI8hw=; t=1781007678;
	x=1781612478; b=VYk4/1zZcL0TESJA5iyFSkgJTzxmyOgxGdOuCqUMjVxjKjhpqCIek/PBtQZzI
	ZD6BACtFjJM1P/nY1GxN6+k9N74W0YRThEvizWIZbixjyC4bUwY37/GT5ljjdaXWK1ntYBS1KfV3u
	oAXRriuzvXPty+DTyaB2YgOswJHMqKuG9M+h26Uueeenz3DC3LFUoMsbq8d78j10KsvoL5giDmAuE
	kq6sIzhpW1pdBmgaJoWDKzNr2Hzw7IKtIcKP2Z4gn3gSFxXNqWTaCKETvQ1J5D06vokmAjrx0NsED
	yvbF8DXmJ9s2llfbm3eY1Ej/mBOp+fFbpPPDZmQAFCpk5Ex+xA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1wWvSD-00000002cav-3h2R; Tue, 09 Jun 2026 14:21:13 +0200
Received: from p57bd94c1.dip0.t-ipconnect.de ([87.189.148.193] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1wWvSD-00000001us6-2Nae; Tue, 09 Jun 2026 14:21:13 +0200
Message-ID: <fa7d7af8a780c27f85e29c518ba45e39ab18abad.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 0/3] ASoC: simple-card: remove platform data style
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Mark Brown <broonie@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, Jaroslav Kysela
 <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>,  Linus Walleij
 <linusw@kernel.org>, Rich Felker <dalias@libc.org>, Takashi Iwai
 <tiwai@suse.com>, Yoshinori Sato	 <ysato@users.sourceforge.jp>,
 linux-sh@vger.kernel.org, 	linux-sound@vger.kernel.org, Kuninori Morimoto
 <kuninori.morimoto.gx@renesas.com>
Date: Tue, 09 Jun 2026 14:21:12 +0200
In-Reply-To: <178094130630.20828.12708103059145547835.b4-ty@b4>
References: <87zf1le4fu.wl-kuninori.morimoto.gx@renesas.com>
	 <178094130630.20828.12708103059145547835.b4-ty@b4>
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

Hello Mark,

On Mon, 2026-06-08 at 18:55 +0100, Mark Brown wrote:
> On Wed, 27 May 2026 06:45:26 +0000, Kuninori Morimoto wrote:
> > ASoC: simple-card: remove platform data style
> >=20
> > Hi
> >=20
> > SuperH ecovec24/7724se are the last user of Simple Audio Card as
> > "platform data style". It is mainly supporting "DT style" in these days=
.
> >=20
> > [...]
>=20
> Applied to
>=20
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-=
7.2
>=20
> Thanks!
>=20
> [1/3] sh: ecovec24: remove FSI/DA7210/Simple-Audio-Card support
>       https://git.kernel.org/broonie/sound/c/9cc93ebc85e7
> [2/3] sh: 7724se: remove FSI/AK4642/Simple-Audio-Card support
>       https://git.kernel.org/broonie/sound/c/deadb855b694
> [3/3] ASoC: simple-card: remove platform data style
>       https://git.kernel.org/broonie/sound/c/325fea33e141
>=20
> All being well this means that it will be integrated into the linux-next
> tree (usually sometime in the next 24 hours) and sent to Linus during
> the next merge window (or sooner if it is a bug fix), however if
> problems are discovered then the patch may be dropped or reverted.
>=20
> You may get further e-mails resulting from automated or manual testing
> and review of the tree, please engage with people reporting problems and
> send followup patches addressing any issues that are reported if needed.
>=20
> If any updates are required or you are submitting further changes they
> should be sent as incremental updates against current git, existing
> patches will not be replaced.
>=20
> Please add any relevant lists and maintainers to the CCs when replying
> to this mail.

I actually wanted to keep the driver and convert it to using device-trees,
not remove it. We have an out-of-tree patch for switching SuperH to device-
tree support.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
