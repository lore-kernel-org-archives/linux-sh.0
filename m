Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3278B23F39A;
	Fri, 28 Feb 2025 22:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740782096; cv=none; b=OLTXJlXDn+uvbx5PheI156WB0itXJ3dLwyc6tKiPVSwbKGxKBvR9YX/rkkPkO/nudYtXjKB69VgQQH8pWqZ7iHSYF0WEE7X9GzlDmIf8kg5CAIBhc174nhns8NxCflt6fATecKV2TO2qckB3LrdSfSByig7ApHgfzNxYm4bmsbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740782096; c=relaxed/simple;
	bh=rIMtkx3BumZFM1f+9gr/3L1rwx+8OL99ijM7SYaHIHA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QsrvaJeRUYmJPMoV8RKiLmshhuboiUA906eE4yjJhVKBUmLuemfgHMUyzKJfKFer5u2dqGh3vHqLUtgeZX4YLl38fCQsu6VcaJ3U5yh4bhvtGG2EjAeqZJ0K26WAYZpkh0aztxcCOSYjl6tOTwF7WxXgd/AWvth3kaGSWD9RtHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=clg88Fvi; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="clg88Fvi"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=WkMCPfebqRX1ArJd0tbG7Xc61T/aB+raQSI5boJryfM=; t=1740782093; x=1741386893; 
	b=clg88FvigaDlx6wJQvruwHKpSpN+VDrWkALwnWMeTjx2T3ETDh5HSwU+bNtxlHp4rIIVJ4bqyww
	gKICx7x3ECymZFApFRwn5+l09Y3p0d4/b2jfYJ7tgwKtDj4kYdyQ0AFjseGvI3vb6xxB6Gcr6athe
	bEuClnUQmF04pFHfOiMjLWnHjkzkBYb5hoMrcWcvNB65vajKUkG8BfeEbKnH0u42o5QD12Vj4eCGD
	6oIFnJ3cI1xQJmpfSjuCv5Fz0CkTdr2Jmj+ARO8z51Sn3iacY6hFUiAq1ki1vhS3buiwedfJU4aQb
	jIxRglGohAmTn+x1G+Gm2odpcnDYym8Aj9gw==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1to8wQ-00000001LRv-0LRi; Fri, 28 Feb 2025 23:34:46 +0100
Received: from p5dc5515a.dip0.t-ipconnect.de ([93.197.81.90] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1to8wP-00000000NgP-3X5c; Fri, 28 Feb 2025 23:34:46 +0100
Message-ID: <a917c1183f85bad8af1312994d330f141c57db04.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 0/2] J2 Turtle Board fixes
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Rob Landley <rob@landley.net>, Artur Rojek <contact@artur-rojek.eu>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 Daniel Lezcano	 <daniel.lezcano@linaro.org>, Thomas Gleixner
 <tglx@linutronix.de>, Uros Bizjak	 <ubizjak@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, "D . Jeff Dionne"
	 <jeff@coresemi.io>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 28 Feb 2025 23:34:44 +0100
In-Reply-To: <9cf43bbe-898f-4b29-bd85-04f5320bce77@landley.net>
References: <20250216175545.35079-1-contact@artur-rojek.eu>
	 <f574808500e2c5fb733c1e5d9b4d17c2884d1b9f.camel@physik.fu-berlin.de>
	 <1551804b-fc78-4a3f-add8-af693f340a01@landley.net>
	 <48881e2d8efa9d7df8156f5f81cd662c2286e597.camel@physik.fu-berlin.de>
	 <9cf43bbe-898f-4b29-bd85-04f5320bce77@landley.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi,

On Fri, 2025-02-28 at 16:19 -0600, Rob Landley wrote:
> The march 2024 rebuild was in response to that Feb 2024 bugfix, so it=20
> _should_ have the fix? (I'm waiting for another musl release to rebuild=
=20
> them again...)
>=20
> I just downloaded the toolchain currently at that URL and built mkroot=
=20
> and it worked for me:
>=20
> Run /init as init process
> sntp: time.google.com:123: Try again
> Type exit when done.
> $ cat /proc/version
> Linux version 6.14.0-rc3 (landley@driftwood) (sh2eb-linux-muslfdpic-cc=
=20
> (GCC) 11.2.0, GNU ld (GNU Binutils) 2.33.1) #1 SMP Fri Feb 28 15:47:36=
=20
> CST 2025

Is that on Toybox git HEAD?

> And the failure _without_ the fix was deterministic rather than=20
> intermittent, so...
>=20
> Keep in mind the init script has a 3 second timeout trying to call sntp=
=20
> to set the clock, which will fail if the ethernet isn't connected (or no=
=20
> driver, or no internet...)

I'll try again this weekend. Also, I will review and pick up the fix.

> P.S. Speaking of intermittent, I hit that hang after "clocksource:=20
> Switched to clocksource jcore_pit_cs" on one attempt just now. I should=
=20
> sit down with the engineers next time I'm in japan and try to root cause=
=20
> it. The scheduler fires reliably, so it's _probably_ not a hardware=20
> issue? We've had Linux uptime of over a year, not just idle but running=
=20
> an energy monitoring app, so it's pretty stable in our systems...

I thought it was a software issue?

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
