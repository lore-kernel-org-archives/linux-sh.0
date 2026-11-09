Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.133.4.66
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794207858;
	b=IaJRuIjUfIJHwWPIK2GjWbnIDwJneLCvfQq1op94mr8uyo2Ogr+TuzplfGlTCZ+G16fB
	 z0Lm8+VrP9OpireMvMGtCZHaSQ63bmKrUDyb7VyvDoTWEEPpoNa6F0VtOBZik+9jOt8+2
	 +BcyJzTSTYfVt7+6C9cKLbPblJZIbVLPLbF4IOtxHfbSyNOGmcqVNGDpU9jJ/9XmRsK8n
	 i8KOoXzwFIHkxaQ92gBtU8WMaqEl8hCuz72GXomQeSN1PYzdxxl5oEzTXATvEoOhk5SNJ
	 YFLfOBOnKVvIX2an2mAblT+zhweChXIJeK/O8Wwa35HJGL9nQHyyfAZAavflZ5KnTlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794207858;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version:X-Original-Sender:
	 X-Originating-IP:X-ZEDAT-Hint;
	bh=4djJwUp2KDOzPyE+2SoRQotxdrTIk9E7zGQoNV5uat4=;
	b=rA9CNqu+eaAo5ULa4kqtrW8f0fchmnJiMIrsufX8earz4wFY7HE+/YQRSxO1+hWpG76y
	 AiJ0KWicuDG2omVpDtYp+r1HVTDkhiIWQEo3Fcr1/uVsSm/PILgV/8ghXzefF538KBEWU
	 KOFNUT7bjUkTtfi8q8v9zMd/GLaTyOc9NtFfoCDXwc36gYykG/C0MHUGYiC6e6jlRmAJC
	 L+xl4tFiQkVHC+56yFteplVIJRyQ29PSONpgbPw+UdJIy3Jyi3bOwr0vgrH3Xvwnr3TPS
	 eTp4sDK7+qK6KJCJCCzOtGsBSvPAqQ4RjLN9lRE8IyMAKsWrh10kVpB/yafrcMuP5FA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=physik.fu-berlin.de;
	spf=pass smtp.mailfrom=zedat.fu-berlin.de;
	dkim=pass header.d=fu-berlin.de header.i=@fu-berlin.de header.a=rsa-sha256 header.s=fub01 header.b=IALyzZxe;
	arc=none smtp.remote-ip=130.133.4.66
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13E9606A323;
	Mon,  9 Nov 2026 07:04:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A13E9606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fu-berlin.de header.i=@fu-berlin.de header.a=rsa-sha256 header.s=fub01 header.b=IALyzZxe
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=4djJwUp2KDOzPyE+2SoRQotxdrTIk9E7zGQoNV5uat4=; t=1794207856;
	x=1794812656; b=IALyzZxeSY/vEBSaV9CnT/UiMUuHWQC/+4fA9qmyRXs7mX+YQs8uDdJbL7NKV
	2Xie5IM3vWn621NqFiIX69PNuvB/2quaaVA3Dnnd2EkbH+OkOOFjcwcVX84c5BB1rM+qkH4QxdUQz
	ltZoWTB7zFWaAFeeGkMdF9KK0hFDPA2tBqvuiflPua4uXCq9Tu1gkDRo7gRLhJjOk/ilxUby+J2CG
	r20g6Ryi22urHwMFLbf+Cya1ESpZ2xSiX6iO+CowkxEGHH74fl7ok2xc4WqSDvDj8B2+k3ouzGjGt
	drz1FCl4r3dnngoMdy3CkFElqlgmWLqTyttbWOnCKM6U8dq2ig==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.100)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1xQJQF-000000013Jr-3oWA; Mon, 09 Nov 2026 08:04:07 +0100
Received: from p5b13a90a.dip0.t-ipconnect.de ([91.19.169.10] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.100)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1xQJQF-00000003H1R-2whf; Mon, 09 Nov 2026 08:04:07 +0100
Message-ID: <469a405f0a447cf433e9449016551cb408fd11dc.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v2 0/2] sh: add initial SH7305 CPU support
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Artem Novak <artem122novak@gmail.com>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 09 Nov 2026 08:04:07 +0100
In-Reply-To: <CAPufuhaE=pg9yzqZYaDcfkxooZeQPzSNsKQw-kX7PHN99yZyQQ@mail.gmail.com>
References: <20261002041220.133911-1-artem122novak@gmail.com>
	 <CAPufuhaE=pg9yzqZYaDcfkxooZeQPzSNsKQw-kX7PHN99yZyQQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.62.1 
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Post: <mailto:linux-sh@vger.kernel.org>
List-Help: <mailto:linux-sh+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sh+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Artem,

On Mon, 2026-11-09 at 00:43 -0600, Artem Novak wrote:
> I wanted to follow up on this patch series,
> as it's been a little over five weeks since the v2 submission.

I'm sorry, but there has been too much else on my plate in the
past weeks. And before I can get to your patches, there are a
few others still lingering on Patchwork for SH that I need to
review and pick up.

See: https://patchwork.kernel.org/project/linux-sh/list/

> I'm happy to revise and resubmit if necessary.

Not necessary. I will let you know.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
