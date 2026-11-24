Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.133.4.66
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795508858;
	b=OGeCqZa0azsfBxHeasTL2M56Oce308iM2W8QJHm6ZhClAns0JkjbmDQkPf6GF2/07QuV
	 tfZcNh3j7Xh2A8w4ZZPF7vJ8Xtp+rFHRiJn9EgTpZoQVtb48rPwaz45JYy4y3Lm4PPN5w
	 SUWg2zuL0g8mfqP0yjPtbwtd8pvpoUwgzvPPPx3//cs+1eXrVy1y4NZz4OsQRczhHgeCh
	 rK/hbcghJfzHm4STJnMPqOgjJUNX5Qhn3tp015zQhOUi2BLVlhAuXOOcocfZWsHfSk8Nf
	 DjzUqjLm++LtNS2Li5ui23Oi1fpVuhIqyh2xuYA+D5IVt+Q3eBt5U+0S+uFUcsCroqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795508858;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version:X-Original-Sender:
	 X-Originating-IP:X-ZEDAT-Hint;
	bh=fOwYXB5vdalFPHcBdZlvLIB1kc1NWkQ5l89Xnccj3bM=;
	b=ouJ5cJ3zPIqNO4/a/67xLEZYK3PIwuh58EpnB582sROUxYWcQ/TQb7Ul89NexZ9m4OZR
	 WqnpUE+HHkVpRVm7PtQj+M0Fpm3wJFCIxEnyVRF10sbfDlhsVXScmoWXYrhGUf1xFGQuz
	 eDwB01K3G9kXMmlWJx5RD4YuDlo4dpb1p0ZX5QD+Z6PYvJCBFwN4vZNes3ee+i/3DEnV2
	 0/cn0g9Jr58hPRkO6yc+gptlhpCObr1wB+muqfbcJTxmrorWIYCQxt53Mr0tkmdkhwbj7
	 7Ynpy9uOjWZuMDJbrbO4jo9NhVOeZ+rt6ix5pplPU7RaI/3+tFOwP6S0ePmMF+S/zCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=physik.fu-berlin.de;
	spf=pass smtp.mailfrom=zedat.fu-berlin.de;
	dkim=pass header.d=fu-berlin.de header.i=@fu-berlin.de header.a=rsa-sha256 header.s=fub01 header.b=GZRlBdlc;
	arc=none smtp.remote-ip=130.133.4.66
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8824606A322;
	Tue, 24 Nov 2026 08:27:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8824606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fu-berlin.de header.i=@fu-berlin.de header.a=rsa-sha256 header.s=fub01 header.b=GZRlBdlc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=fOwYXB5vdalFPHcBdZlvLIB1kc1NWkQ5l89Xnccj3bM=; t=1795508856;
	x=1796113656; b=GZRlBdlcX4n0Jy/5ON6iC6aq0/HHtSx6o31Dne0g7MHIG8tvMxGkUqmYt8dh9
	/3L2FXPJfjUScXbqtR/fQkRsm79i/8ynBrKwtRiDrAIbolKYr/3V3hKUtillOxRLoQkxiD6CE+CdJ
	YI+yfHtEvL4Gdd2GmpznMImNqoBfblvMmIc3fqIkbmSnFcrpOlYi6yCN6X6CsWHwoDStmKbVkzMlb
	1AuJHqWYZ0RX7MidYxaOy2Pyoq26DN2WEDxYwF1x+ooY1ZWSexSY/VeSZzRajyBmTH9FaBBHZH/CU
	E92qIKwl0f+zGmwcnk2necycUL3Opyvi4ABAbVoP7tD+pbnbRw==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.100)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1xVls4-00000003CfB-07QK; Tue, 24 Nov 2026 09:27:24 +0100
Received: from p57bd95b5.dip0.t-ipconnect.de ([87.189.149.181] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.100)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1xVls3-00000000YVA-36qH; Tue, 24 Nov 2026 09:27:23 +0100
Message-ID: <6eb2202457d5703192a513b4e898dfe6653c1b0f.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v3 0/5] sh: mach-rsk: rsk7203: switch to using static
 device property, drop legacy gpio API
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Dmitry Torokhov
	 <dmitry.torokhov@gmail.com>
Cc: Arnd Bergmann <arnd@kernel.org>, Rich Felker <dalias@libc.org>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Geert Uytterhoeven
 <geert+renesas@glider.be>, Linus Walleij	 <linusw@kernel.org>, Bartosz
 Golaszewski <brgl@kernel.org>, Bartosz Golaszewski	
 <bartosz.golaszewski@oss.qualcomm.com>, linux-sh@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Tue, 24 Nov 2026 09:27:22 +0100
In-Reply-To: <awU4aqWbKEs4Qhyg@ashevche-desk.local>
References: <20260929-rsk7203-properties-v3-0-02f84aeb8e47@gmail.com>
	 <3a51385d-9649-4bd7-87b3-0caf9e462b2e@app.fastmail.com>
	 <arzKNhmoL6yiGrzH@ashevche-desk.local>
	 <dea00f90c205f8359baca729d8b0f31a@gmail.com>
	 <ce838102be497ee6eab490b4454095b96e16d015.camel@physik.fu-berlin.de>
	 <2e4f0d32c05d841feb367741bf8802fc@gmail.com>
	 <awU4aqWbKEs4Qhyg@ashevche-desk.local>
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

On Tue, 2026-11-24 at 09:10 +0200, Andy Shevchenko wrote:
> ...or even remove the board support completely (would be interesting
> to see somebody investing time in this HW to fix all what listed and
> not listed above).

Can I as the SH maintainer at least have the last word on this? I'm not
really happy with the fact that corporate developers are chasing hobbyists
in the kernel developments all the time.

You people are being paid to do this, of course you can work on the kernel
on every weekday. But that doesn't mean hobbyist developers have to pick
that workload as well.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
