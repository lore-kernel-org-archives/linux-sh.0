Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76B113E049
	for <linux-sh@vger.kernel.org>; Thu, 11 Apr 2024 07:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712821672; cv=none; b=dE3i7v/pje8TRXwp/a0gNY43FfjgATFfnBi6lR3Xh0WKDThyOzr2JeX+NkHIGXrWhPbKmbjXuYSvT/izgMoTbsRGAXjJFwuEo/KV+r2gUXte1qcz+q8GmX6/kx7qjVjvFFry10nbzcxuAkcJKnXWz0OrYAbj9Dr3mEjFTV6P0qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712821672; c=relaxed/simple;
	bh=Oi3gW2kNsksXTu8w4FFX40E7JP3pIsLvK/tjTusOZmA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZCIxxdSjCpVsp4zCfVEHjKy/JEfY3buN0ohdAkqsC3/zFPecL0qGKQ9gEq4ZDvSZdKlqtuvu3np3fkG5sIDjy99/A6v+BwCjelHFOlrTLjJwpEHnftKw50FxFy0Q2HrrjN9cdaaiv1d7Toxdd+o1aazD4mvmZXONng0OJv5wu9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=mtoKNMEA; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="mtoKNMEA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=JY1fGPyLUZZPjG5raszxMdlRAoohzbKrvbdOnZyRuYw=; t=1712821668; x=1713426468; 
	b=mtoKNMEAoRi4V/0mhlc7AtbYc1F11p76XY5YISlv49kb/vkEZ9PvlmwsXtIGDOxFfE4EDnNNokU
	uIUUrr4fBgBZDepZ2mhlKyzL5zFK9ta4e433zZd2xlN821zmSR/Ela/wNLFEk+yeKvbMmXUhx1nJF
	6eKSxG3DLOWRglWd+imH7hPMr6GEF1EE/ZZqzOA5lJroz9TqHbj8OCuo1thtxQKOxImF2UFGMJG2A
	Ik4UxGtO/fHFlBwIkoJ36B04NzJGb0+8MiMvzpCA3cWrtduIkWaMKjh8h3/xOQ5mKB3OkpvmZn73c
	FNC4s7S8Ga3tGjg53Q0cCRX3DKyBuIO5eIdw==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.97)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1rup9q-000000034vc-3tDV; Thu, 11 Apr 2024 09:47:42 +0200
Received: from p5b13a9fd.dip0.t-ipconnect.de ([91.19.169.253] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.97)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1rup9q-00000002a8z-2zRl; Thu, 11 Apr 2024 09:47:42 +0200
Message-ID: <293d667c491ab0c2e02a7c6b64ec384aedaa6fb7.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sh: push-switch: Convert to platform remove callback
 returning void
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Duoming Zhou
	 <duoming@zju.edu.cn>, linux-sh@vger.kernel.org, kernel@pengutronix.de
Date: Thu, 11 Apr 2024 09:47:42 +0200
In-Reply-To: <fwfwlvyuznwzwejg3iqvnvgolxaqfo3aod5gbydgbwpj5l4xmr@y7fuszpv7kry>
References: <20240306211947.97103-2-u.kleine-koenig@pengutronix.de>
	 <fwfwlvyuznwzwejg3iqvnvgolxaqfo3aod5gbydgbwpj5l4xmr@y7fuszpv7kry>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0 
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

On Thu, 2024-04-11 at 09:18 +0200, Uwe Kleine-K=C3=B6nig wrote:
> Apart from Geert's positive review reply I didn't get any feedback on
> this patch and it didn't appear in next yet.

The plan was to get everything approved before merging it for next
as a partial conversion to device tree for SH would probably cause
problems.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
