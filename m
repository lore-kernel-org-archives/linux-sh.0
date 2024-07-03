Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84861DFD1;
	Wed,  3 Jul 2024 15:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720019783; cv=none; b=QCrQnAtL7taaLT51SuIEakJLz3dgBg/p6XSk9YwdOIirtG2FlL4Lz8jc4hQj/t/YQAt1zNnsys5K0zIuunA6qGH4W5GwFGTozeufwRDTKD9Jn3SU/05i9AtkvhfFbkPF0E89C2E5T/BUYCgJGMrmGpDaQBj/DrgPBplI/+xTppw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720019783; c=relaxed/simple;
	bh=7FMn/uRg0zYfw3DQH1Sz/pojM+8pV3loh/mbtGw+Fm4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QVqWVMyoiDEcA9dukxUg9euNOnbedMXdXIyUxt50r/VAuGQM8Un6UiFSDWGNNQnTXLlcxSlJnlLwh8CfEJYwrooY6rHZU7LueR7Gsol1479wxL/YUVlq28d1FFVaKLx750QsMearbtFPEF/yDL/LnOc416J7j6TewIr9xmtU4vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=F/TChOj+; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="F/TChOj+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=6Pvtr4CL3nBCwnXoyeyqTuDH9oRlsRjo2dtNGYFj5Ks=; t=1720019779; x=1720624579; 
	b=F/TChOj+kldVL4qjJxBxCohEnwgii6ad0clG+V8T0KJKorBpRTV5RRik+zLk/d4F9/r06SwwejT
	xUdBzw57lCxjrIGtqTor+cXOzVgKMxKPeP5QNqeqxZH9Lhccit9gGlPEB8HW/KZdp5y8zlhfBKrh7
	XAceUqDm9rvmSXmIaj7d0cOFAfuJeu6y7D3g3aVkHxAJo5iFs+j4J42N1JF3bgzEfw/stgyEki6l8
	DphxZNmBP6Ws4Dmv0kJ/UejncXX8nk42U1kfIxi2atuCUtXPiFb2JG5rIBMtCKQsq62PoyhM+JWWx
	noXj8xwkCXpLb4HuJsrfS8T3WPQ8Ic7ytXMg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.97)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1sP1eU-00000002G2P-0ZsP; Wed, 03 Jul 2024 17:12:10 +0200
Received: from tmo-084-6.customers.d1-online.com ([80.187.84.6] helo=[172.20.10.3])
          by inpost2.zedat.fu-berlin.de (Exim 4.97)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1sP1eT-00000003lh1-3VTh; Wed, 03 Jul 2024 17:12:10 +0200
Message-ID: <5473f57a21639724e6277c3e271fc46ea5f62ed3.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sh: push-switch: add missing MODULE_DESCRIPTION() macro
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Jeff Johnson <quic_jjohnson@quicinc.com>, Yoshinori Sato
	 <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Date: Wed, 03 Jul 2024 17:12:07 +0200
In-Reply-To: <20240702-md-sh-arch-sh-drivers-v1-1-2c5d439a5479@quicinc.com>
References: <20240702-md-sh-arch-sh-drivers-v1-1-2c5d439a5479@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Jeff,

On Tue, 2024-07-02 at 12:29 -0700, Jeff Johnson wrote:
> With ARCH=3Dsh, make allmodconfig && make W=3D1 C=3D1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in arch/sh/drivers/push-sw=
itch.o
>=20
> Add the missing invocation of the MODULE_DESCRIPTION() macro.
>=20
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
> MODULE_DESCRIPTION copied from file prologue:
> /*
>  * Generic push-switch framework
>  *
>  * Copyright (C) 2006  Paul Mundt
>  */
> ---
>  arch/sh/drivers/push-switch.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/sh/drivers/push-switch.c b/arch/sh/drivers/push-switch.=
c
> index 362e4860bf52..1dea43381b5a 100644
> --- a/arch/sh/drivers/push-switch.c
> +++ b/arch/sh/drivers/push-switch.c
> @@ -131,4 +131,5 @@ module_exit(switch_exit);
> =20
>  MODULE_VERSION(DRV_VERSION);
>  MODULE_AUTHOR("Paul Mundt");
> +MODULE_DESCRIPTION("Generic push-switch framework");
>  MODULE_LICENSE("GPL v2");
>=20
> ---
> base-commit: 1dfe225e9af5bd3399a1dbc6a4df6a6041ff9c23
> change-id: 20240702-md-sh-arch-sh-drivers-40af731eb66c

Reviewed-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Thanks for fixing this. Will pick this up later this week.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
