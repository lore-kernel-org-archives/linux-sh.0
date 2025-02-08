Received: from server-598995.kolorio.com (server-598995.kolorio.com [162.241.152.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD7018FC67
	for <linux-sh@vger.kernel.org>; Sat,  8 Feb 2025 04:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.241.152.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738989740; cv=none; b=T3Tl9Z0NwSimQ8ZXz1R8AdbHTcseG+NSGFeQlmpDlauEXbUkrX5I+ebWFWvp84l8uUf4SzUCMsTF+waCMxD3BYbqHXNBImX7ognwaPnsy5fLYrDJSZk3QH59pQ48qBlMiQBxj3g9J5UEonGRkzhPBxIOZp+7ncSiGbwlNJPpvNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738989740; c=relaxed/simple;
	bh=gl4+7vNxgV9+JzZtw7EthQ6aGDgi0WVn3wQV/lnKiyo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uTWiQrUT7g/bquyUuEUO5JJF+mYFdou3NfCosVPiPvz4hgjypKbyBa8cMPYrb0fA8IGozDBkSPGbpNDPnLbgZdcEMj7nWbZF+i9eNx8+68KMf58NHmV5NFqIQiZ0yRRUKK3tZ9X3hRx/1CnmtRDSDqc33QWtEQFlRjxk7xasdrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=truemaisha.co.tz; spf=pass smtp.mailfrom=truemaisha.co.tz; dkim=pass (2048-bit key) header.d=truemaisha.co.tz header.i=@truemaisha.co.tz header.b=a2m7vYVi; arc=none smtp.client-ip=162.241.152.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=truemaisha.co.tz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=truemaisha.co.tz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=truemaisha.co.tz header.i=@truemaisha.co.tz header.b="a2m7vYVi"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=truemaisha.co.tz; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Sender:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=gl4+7vNxgV9+JzZtw7EthQ6aGDgi0WVn3wQV/lnKiyo=; b=a2m7vYVi5P6hnt4ZNhU0jvHCCO
	kQuY/W9oCvtIsfzhpm5mh+5Vp9S6yXKh1y9RQoMBLTf5u003kmBht2WqP6HKsCa6rvIItlCfBBDcq
	Q3yEJBvuhD4dx/mwkm3pdI6ivJyAqhCduzEY7z7vKSjuOwmmPdF1++KByh7VKyCW7mHOj/nRYq31Q
	V42EoitAtc4S/hyYXaCzpxL7Cj+5r06sanhFuWAj5tAA8myUnc191Ha5CwJgvs6TOcvoeo+RjUPrl
	mkVVu1FelCZKBFL/LW7fLl+8HqapjYhbku4GnV6dUOsXq00rC0cAkj2UPvGfbh5tzm2DaRhWE+vKm
	eYCPaAkg==;
Received: from [74.208.124.33] (port=51293 helo=truemaisha.co.tz)
	by server-598995.kolorio.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <chrispinerick@truemaisha.co.tz>)
	id 1tgcfX-0004BR-0c
	for linux-sh@vger.kernel.org;
	Fri, 07 Feb 2025 22:42:16 -0600
Reply-To: dsong@aa4financialservice.com
From: David Song <chrispinerick@truemaisha.co.tz>
To: linux-sh@vger.kernel.org
Subject: Re: The business loan- 
Date: 08 Feb 2025 04:42:17 +0000
Message-ID: <20250208015433.75D219D4E2FB76B2@truemaisha.co.tz>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server-598995.kolorio.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - truemaisha.co.tz
X-Get-Message-Sender-Via: server-598995.kolorio.com: authenticated_id: chrispinerick@truemaisha.co.tz
X-Authenticated-Sender: server-598995.kolorio.com: chrispinerick@truemaisha.co.tz
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Hello,

My name is David Song, at AA4 FS, we are a consultancy and
brokerage Firm specializing in Growth Financial Loan and joint
partnership venture. We specialize in investments in all Private
and public sectors in a broad range of areas within our Financial
Investment Services.

 We are experts in financial and operational management, due
diligence and capital planning in all markets and industries. Our
Investors wish to invest in any viable Project presented by your
Management after reviews on your Business Project Presentation
Plan.

 We look forward to your Swift response. We also offer commission
to consultants and brokers for any partnership referrals.

 Regards,
David Song
Senior Broker

AA4 Financial Services
13 Wonersh Way, Cheam,
Sutton, Surrey, SM2 7LX
Email: dsong@aa4financialservice.com

