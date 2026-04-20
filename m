Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B5539B974;
	Mon, 20 Apr 2026 11:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776682908; cv=none; b=RxWfRLQi8OJ08GSQvYHcvdjZ966TiQJOar1DsBPi9B1qOGsaCVCD7WNH5EaBPNdm7d1gteAaocafYzLnkNKxrQdWkUJ9NZaTGTZ6g2zKyUuQsia4SApeShzlCokeAtcEolAYzrTHi1Py7RDbSqE61U7z++akHWHUklRo3DxphOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776682908; c=relaxed/simple;
	bh=vfQOszqQkZfTBazif3oO/GwHw+VUNhjFRqt6XKYL+z0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bsJWBzWKo5djFmR2E1RYeKAiCQ7l0CYWGzPEIMtK6ZmgJkPDb4YnoakRTDWLv20N5BpoYPSfvKDK5cETLtFjaN5Jf4hhhH8PcK/QXnjwyodQGwilwNP0uOccXj6A7erkX99L7uixcYCF98RAUd/qxIy4Gm9BQq8VZSKBn040nFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=eGpCVXul; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="eGpCVXul"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=rHlmg5iiBtxDhLK6PNzJzJ/wYmTcaHy8pMUz2QDPrMU=; t=1776682904;
	x=1777287704; b=eGpCVXullmQIcNKQMbIjKwTLrZP9Zbyc/v7T1bHLdHfacYX1RZi9YkVrmu9Ov
	iuh+HU3lBxx9J9wTC0W6EQO4vhIPUlQKxo3jcCfGdtJGMcLmWN85nJvOr5D/GYu/Of8idUSBniuk9
	kjehZqwIHwXti2oV+ujuoRTzOzSxws8s+KhpXxtHRfKk9fV7HcmzNzGvBeu7dFbF3YUgDle9uEjaj
	fzyY2sWhm7Yo8OkMhmf4vO6R5K09ORLwxm8qPTWgA74KBQkUzoywnb14Lc9YbnVrZkYX7DABy4Vay
	U0RIeZRVv99uqrVPLBcOsYzgTOPXFYb0mNMhidklTKAlFWpwgQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1wEmNk-00000003oca-3W0e; Mon, 20 Apr 2026 13:01:36 +0200
Received: from dynamic-089-012-084-148.89.12.pool.telefonica.de ([89.12.84.148] helo=[192.168.178.50])
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1wEmNk-0000000230c-2eaP; Mon, 20 Apr 2026 13:01:36 +0200
Message-ID: <8aeef1ad6eb193d02c2b42fa5b952e4c82598261.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v2 1/2] cdrom: gdrom: replace port I/O with MMIO
 accessors
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Adrian McMenamin <adrianmcmenamin@gmail.com>, Florian Fuchs
	 <fuchsfl@gmail.com>
Cc: linux-sh@vger.kernel.org, Artur Rojek <contact@artur-rojek.eu>, 
	linux-kernel@vger.kernel.org
Date: Mon, 20 Apr 2026 13:01:36 +0200
In-Reply-To: <CACwZE5RD2Jm6ssUJMwQBzVcOuT-Dc1jxg5tA+reqPM2aPXrqTw@mail.gmail.com>
References: <20260419162823.2829286-1-fuchsfl@gmail.com>
	 <20260419162823.2829286-2-fuchsfl@gmail.com>
	 <CACwZE5RD2Jm6ssUJMwQBzVcOuT-Dc1jxg5tA+reqPM2aPXrqTw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Adrian,

On Mon, 2026-04-20 at 11:20 +0100, Adrian McMenamin wrote:
> On Sun, 19 Apr 2026 at 17:29, Florian Fuchs <fuchsfl@gmail.com> wrote:
> >=20
> Not tested this on real hardware but I can confirm it addresses the
> identified bug and is logically correct.

Want to add your Reviewed-by maybe?

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
