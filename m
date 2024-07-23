Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE15814B08A;
	Tue, 23 Jul 2024 07:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721721439; cv=none; b=NvFIcbRuGV6uQ5fOufB2LLU9efiDzfqcgTvKhXqCzCiGmVW+vXJMBjUr/lyLy8b+OLj5F9+mHvlqvTkwdNy8P3hy0BOuz4bh7mmFJGPy8DGKmKQxPpZeotxqjCr75t0JtqpsxksbiLNSqDvibigs3VoY4cVNDpHZHqWPoe6vdoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721721439; c=relaxed/simple;
	bh=wnJ9pNLUHxA7kxh4RBSUeBXEOgCbqfzL9FdC3ImKuG8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OyvdOOYZKma+dlFCTut9Y2slRdWqaMDzpGSvE7Iq1pb0MERpxmVfeI062TtFwfyz8EubIfQt+kS2tp9kX+o8rWXvZqZx6+jZsT7oOU/zt/gxD8rW/So74ZvXE/gEKXg+sRxiM2Rs+4p7oylUpQgKXdNpCl3ldenCihuzEYXzma0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=nfRy98L0; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="nfRy98L0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ti3iYOoAZ4cKNtccnPGKPwzJ+setr/cMX0cIJgV4LLM=; t=1721721436; x=1722326236; 
	b=nfRy98L0q0dag7U0JVgy2VHhi+UlJSTfLoykOPjA9N2bpV3HO870P9AD11uNpn4r3USM100Cm1f
	mcUrCU3mAi5FeaK9+Zu6+wg6q77RBhfG1YO3qcGTPok9aDeVHbYUDdilLmK89RSd4bSZ4825JsHyB
	iXu3Uz/j0GZVPGXneMY25OYHWh+tEptywk710cHNtb9hLjhw5g51DUE6Ns19cDKLByW8zHpNmZKxZ
	h8W4SHVKZdhrD2FeRrQn82YpUow8Lwfh6U77WVLPPVVCYxLNf09E2BPPZBKCok0BrIGdzddIikoTb
	r6NgRfuW08CElTDpEsw6qMcQ09h4HicHL2fw==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1sWAOQ-00000002mxu-2cyM; Tue, 23 Jul 2024 09:57:06 +0200
Received: from dynamic-089-012-111-099.89.12.pool.telefonica.de ([89.12.111.99] helo=[192.168.178.20])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1sWAOQ-00000003bhf-1m6A; Tue, 23 Jul 2024 09:57:06 +0200
Message-ID: <d12de025cfb71bcf2a86aa54251aac20f16d32b7.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v4] sh: Restructure setup code to reserve memory regions
 earlier
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Oreoluwa Babatunde <quic_obabatun@quicinc.com>, 
	ysato@users.sourceforge.jp, dalias@libc.org
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
 robh+dt@kernel.org,  kernel@quicinc.com
Date: Tue, 23 Jul 2024 09:57:05 +0200
In-Reply-To: <636943c1-6e32-4dd1-abdd-5a110e9aa07c@quicinc.com>
References: <20240711214438.3920702-1-quic_obabatun@quicinc.com>
	 <a68b7cd0e3b143f023414feca279deb768d43575.camel@physik.fu-berlin.de>
	 <121b8077-bc6d-42a3-8ec2-c792e84bd947@quicinc.com>
	 <831887db73d9eafc50940315ed44139107bd5f2a.camel@physik.fu-berlin.de>
	 <636943c1-6e32-4dd1-abdd-5a110e9aa07c@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Oreluwa,

On Wed, 2024-07-17 at 19:22 -0700, Oreoluwa Babatunde wrote:
> Thanks for your feedback and for working with me on this.
> I have uploaded a new version here:
> https://lore.kernel.org/all/20240718021822.1545976-1-quic_obabatun@quicin=
c.com/
>=20
> Please let me know if this properly addresses your comments.

Thanks. I'll have another look this week, including testing.

But I have decided to send the pull request to Linus for v6.11 now,
so I don't have to hurry with the review.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
