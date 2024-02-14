Received: from mout138.5x2.de (mout138.5x2.de [136.243.126.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431E313EFFB
	for <linux-sh@vger.kernel.org>; Wed, 14 Feb 2024 21:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.243.126.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707946189; cv=none; b=KQ4zleGpfsl1IUC2j3JTIWlV/PdY1xGtVpQL85ctIRGkZubS2MrzcNhise7RxUA3F5WMpL3KsavSsqGKRD3XHmnvYX83DThGtAVY9McaF2pJZ+zLh/dUPT+/fnBUffWe4Ts2rZXi/ZcWsqQBN4ICmx1UhgkPfUoBStVHgD7ac5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707946189; c=relaxed/simple;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SbfS45F74xs0280Z79fakNKc1g0WTvEywHtsTCllp0PL5S3t8Lh4r2jd7XE4BFNdYL3Ox9J8p8HsLOIVXsEQnBXACflLgk4r1v2AggnSOX5ODzIAUe353/rwteHw7U8kwdoqoTMqPDhIUkri5j+wyjxbNhVpwqhjRoCe5yHNLAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=empfang.email; spf=pass smtp.mailfrom=empfang.email; dkim=pass (1024-bit key) header.d=empfang.email header.i=@empfang.email header.b=eH/9FRme; arc=none smtp.client-ip=136.243.126.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=empfang.email
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=empfang.email
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=empfang.email header.i=@empfang.email header.b="eH/9FRme"
X-Report-Abuse-To: <abuse@5x2.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=empfang.email;
	s=mail; t=1707943880;
	bh=frcCV1k9oG9oKj3dpUqdJg1PxRT2RSN/XKdLCPjaYaY=;
	h=Date:From:To:Subject:From:To:Subject:Date:X-5x2Result-filter;
	b=eH/9FRmeZKNbgvCOdvMINTiMvvCoDwPbcyK/bwXNxewDgKO//1J7CN1x04ohzJcye
	 tdPfm6MWv1d0CCUmKUhDazvjsTf/j8ni8xcNka9F9JUOjZE65dX9DLmzS2tPOJOQDF
	 7QE6WSFYb1A8/7QF95UmFGk7sSc0X3beBMx6kbwU=
X-Virus-Scanned: mailscanning by phylax2 system (5x2.de)
Date: Wed, 14 Feb 2024 23:51:14 +0300
From: Igor Andreev <andreev@empfang.email>
To: linux-sh@vger.kernel.org
Subject: unsubscribe
Message-ID: <Zc0nwtUjc8vxHmsP@localhost>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-JabberID: andreev@jabbers.one
User-Agent: Mutt/2.2.12 (2023-09-09)


