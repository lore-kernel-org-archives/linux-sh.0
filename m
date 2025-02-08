Received: from server-598995.kolorio.com (server-598995.kolorio.com [162.241.152.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2EC244EA8
	for <linux-sh@vger.kernel.org>; Sat,  8 Feb 2025 22:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.241.152.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739052317; cv=none; b=j0vqU6/LY5jz6atF0uQsxcYJ9FmMyqEMy33wD2GLj1XzRS+/CTOyZKmJfb8iZLi46vpCbU0p0k6GcoVPXEQDlJFsMPAseMlJzmmX90amkNUHiFPxOhqT93LpH03w+f38tCEnJ/dUAE31CRqS7zSX6/wKNuc/mGPczMXfg+JJ9Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739052317; c=relaxed/simple;
	bh=gl4+7vNxgV9+JzZtw7EthQ6aGDgi0WVn3wQV/lnKiyo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qjId3MIZiPDAIqFCQUoQsxnEd9SY7hi3R4970vQG4XuDUA04r8832vvLXuLRl9mkAuyCalI0krN6o1Xl/fRdSWR0NQ/7EDXVWHF5E1fo1F3CLfVDXA48X/92Acb/5vAnj7SADvv9w4RkTbivDJAqYN+xi3x05g38X2LCNLkFf+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=truemaisha.co.tz; spf=pass smtp.mailfrom=truemaisha.co.tz; dkim=pass (2048-bit key) header.d=truemaisha.co.tz header.i=@truemaisha.co.tz header.b=oYg5XQFP; arc=none smtp.client-ip=162.241.152.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=truemaisha.co.tz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=truemaisha.co.tz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=truemaisha.co.tz header.i=@truemaisha.co.tz header.b="oYg5XQFP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=truemaisha.co.tz; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Sender:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=gl4+7vNxgV9+JzZtw7EthQ6aGDgi0WVn3wQV/lnKiyo=; b=oYg5XQFP8+Ci03CBdauZRNp5+P
	Ljcc/yls4woR0YjqnIKBHFMD49r2pemA3SV/XBCvWXUCIZwn7jIsw/8crsZ0bVtqQWuym+b02nnJU
	v+j3p23eGF8PGZ4Y0uqCD+nrFgl/Su3v3bSzdSQ0HuGpa1Itm+ibrW8V9+qRqE3QgiCTpSLDzfPNY
	TE6ss7pKmuvd8m0MoMK9/RHLso/EYoXcqeiVEmZIK9Pik5PcLl+tWwQXdXWYf2RhM1LJ87MGmq8Ka
	Og6nnxUqVLHihPdnV/ulrLGQ7XFT3bK0iq+6LzoRq0MMi8Lpqj/N7jt0Pb+ag5r6YTNP+j2Hb5kG8
	aTaAr/HA==;
Received: from [74.208.124.33] (port=59519 helo=truemaisha.co.tz)
	by server-598995.kolorio.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <chrispinerick@truemaisha.co.tz>)
	id 1tgswo-0001Qh-1m
	for linux-sh@vger.kernel.org;
	Sat, 08 Feb 2025 16:05:11 -0600
Reply-To: dsong@aa4financialservice.com
From: David Song <chrispinerick@truemaisha.co.tz>
To: linux-sh@vger.kernel.org
Subject: Re: The business loan- 
Date: 08 Feb 2025 22:05:12 +0000
Message-ID: <20250208210542.91992E9AE9E50295@truemaisha.co.tz>
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

