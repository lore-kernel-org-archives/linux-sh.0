Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E28222EE5
	for <linux-sh@vger.kernel.org>; Sat,  5 Apr 2025 17:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743873941; cv=none; b=mOF1bNQrIsudMCuUobzT2CxtTthIuvhcagLrZ6RTEYF6KbTB9psTHZb0um38RIXhluINKeAVZf0cdpMO+5jPO21EDEaItOrVElym+qdXvLUkjDoTVw8h5vTX/cLBDIuO15l4o/RRg74mozvtuyQ+8BPzu51Z2s/RQisXSNlhdFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743873941; c=relaxed/simple;
	bh=gPFr6Avc3u25Pj/g8XWJ6W+GqjxTUfhQYFfGOqsMvHs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ND3yZOBhxP+RYPXKttPK5zUdFU+dCo16Nyr0uQGJmuww6k5FSly5Vxp0Z7eLfPlJtlLewqlJ11JpEolCZU97ehq3Nmm8SQkb+R0KhHkroGNNbkQhtGPcg3GiZMvkWcFgKfrgtdU6aabH+KC/qxL1kFVUeWif2pR4kevdJXdLO4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=Q/grygcN; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="Q/grygcN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=gLyNRZ7MrBxkgnGMXa52QBdoPdK42e0Hp4EPwQo3jKk=; t=1743873939; x=1744478739; 
	b=Q/grygcNMBTk7seUy9cw9K5Ze7koxO0fWBWsRcvfvhNJrb++8psLy7ubHUiyou9kx7lzJDwjhFi
	tnXCGGbnzO9FLHEzIQIT+alaTJfGgYEre/5WyB7ktiHj7P/s1r8n0mc/phBNiqFwFvU4GS3fHUhVX
	qFJBQatsbPloMCMSvltL2LPIMHbNIL7WH7+sU7+eS1p8Fm7fZmYwPlWi1kq0OEeO5z6FcjH5/dEuC
	JwD8zixaQ1WXqttMFsC+8pzgBllCCUL8XVjlPSn/SR4NLlixuxaA1H3iOjWaTVY2qF4QQZ8PCLYYj
	Wtnqd0hrQVXgcZzSIu/ERzctD9gu/FpKErGQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1u17Gy-00000003yP0-0eXa; Sat, 05 Apr 2025 19:25:36 +0200
Received: from dynamic-002-242-014-214.2.242.pool.telefonica.de ([2.242.14.214] helo=[192.168.178.50])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1u17Gx-00000000cAC-40U2; Sat, 05 Apr 2025 19:25:36 +0200
Message-ID: <4aaf26c17ab36839c406854ce2b1183db0d8db28.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] arch: sh: defconfig: Drop obsolete
 CONFIG_NET_CLS_TCINDEX
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Johan Korsnes <johan.korsnes@gmail.com>, linux-sh@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker
 <dalias@libc.org>
Date: Sat, 05 Apr 2025 19:25:35 +0200
In-Reply-To: <20250323191330.114640-1-johan.korsnes@gmail.com>
References: <20250323191330.114640-1-johan.korsnes@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0 
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Johan,

On Sun, 2025-03-23 at 20:13 +0100, Johan Korsnes wrote:
> This option was removed from the Kconfig in commit
> 8c710f75256b ("net/sched: Retire tcindex classifier") but it was not
> removed from the defconfigs.
>=20
> Fixes: 8c710f75256b ("net/sched: Retire tcindex classifier")
> Signed-off-by: Johan Korsnes <johan.korsnes@gmail.com>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> ---
>  arch/sh/configs/se7712_defconfig       | 1 -
>  arch/sh/configs/se7721_defconfig       | 1 -
>  arch/sh/configs/sh7710voipgw_defconfig | 1 -
>  arch/sh/configs/titan_defconfig        | 1 -
>  4 files changed, 4 deletions(-)
>=20
> diff --git a/arch/sh/configs/se7712_defconfig b/arch/sh/configs/se7712_de=
fconfig
> index 20f07aee5bde..49a4961889de 100644
> --- a/arch/sh/configs/se7712_defconfig
> +++ b/arch/sh/configs/se7712_defconfig
> @@ -57,7 +57,6 @@ CONFIG_NET_SCH_TBF=3Dy
>  CONFIG_NET_SCH_GRED=3Dy
>  CONFIG_NET_SCH_DSMARK=3Dy
>  CONFIG_NET_SCH_NETEM=3Dy
> -CONFIG_NET_CLS_TCINDEX=3Dy
>  CONFIG_NET_CLS_ROUTE4=3Dy
>  CONFIG_NET_CLS_FW=3Dy
>  CONFIG_MTD=3Dy
> diff --git a/arch/sh/configs/se7721_defconfig b/arch/sh/configs/se7721_de=
fconfig
> index 00862d3c030d..de293792db84 100644
> --- a/arch/sh/configs/se7721_defconfig
> +++ b/arch/sh/configs/se7721_defconfig
> @@ -56,7 +56,6 @@ CONFIG_NET_SCH_TBF=3Dy
>  CONFIG_NET_SCH_GRED=3Dy
>  CONFIG_NET_SCH_DSMARK=3Dy
>  CONFIG_NET_SCH_NETEM=3Dy
> -CONFIG_NET_CLS_TCINDEX=3Dy
>  CONFIG_NET_CLS_ROUTE4=3Dy
>  CONFIG_NET_CLS_FW=3Dy
>  CONFIG_MTD=3Dy
> diff --git a/arch/sh/configs/sh7710voipgw_defconfig b/arch/sh/configs/sh7=
710voipgw_defconfig
> index 99a5d0760532..5b151bb2bc43 100644
> --- a/arch/sh/configs/sh7710voipgw_defconfig
> +++ b/arch/sh/configs/sh7710voipgw_defconfig
> @@ -27,7 +27,6 @@ CONFIG_NETFILTER=3Dy
>  CONFIG_NET_SCHED=3Dy
>  CONFIG_NET_SCH_CBQ=3Dy
>  CONFIG_NET_CLS_BASIC=3Dy
> -CONFIG_NET_CLS_TCINDEX=3Dy
>  CONFIG_NET_CLS_ROUTE4=3Dy
>  CONFIG_NET_CLS_U32=3Dy
>  CONFIG_MTD=3Dy
> diff --git a/arch/sh/configs/titan_defconfig b/arch/sh/configs/titan_defc=
onfig
> index 99bc0e889287..e2928311a126 100644
> --- a/arch/sh/configs/titan_defconfig
> +++ b/arch/sh/configs/titan_defconfig
> @@ -119,7 +119,6 @@ CONFIG_NET_SCH_DSMARK=3Dm
>  CONFIG_NET_SCH_NETEM=3Dm
>  CONFIG_NET_SCH_INGRESS=3Dm
>  CONFIG_NET_CLS_BASIC=3Dm
> -CONFIG_NET_CLS_TCINDEX=3Dm
>  CONFIG_NET_CLS_ROUTE4=3Dm
>  CONFIG_NET_CLS_FW=3Dm
>  CONFIG_NET_CLS_U32=3Dm

Thanks for catching this! Will pick this up shortly.

Reviewed-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
