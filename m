Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DEA396573;
	Wed, 27 May 2026 09:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779872896; cv=none; b=dCuGsFgjOSvUK67shcQONJleqd8hv0icrcAKIKhUTwAsoNOiMJdcbLLC+w+EZl/TfHUQgcBG9tVmOo4q76GvcVO6JhWSz2oFm/6KaJciUsfMce7iVkpOtFKhy8us2I1Y50nKvFSWoTaV4qkui1gPXB4z4HSbOeQqOHEcWP7g6Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779872896; c=relaxed/simple;
	bh=yGB4Pnsh6y/n7VuGcmXB+c+INnnsRFuGZCwCmF3fXjw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ofEQu0zqT4GxhEPMF2yGwwm3IscEX/hWmdESVTC+Wfj0Hv6YhvSxEGRFQBGsjar9qhO1/8r13sFdrQxcLiZWHK60wMCoyYIUkwnUcackdJD3z42L26uKiaKXX88zHjpOKCaCPJ/67GbYiLyGk3DWXFXQJrreC60fIPIrZDDV5nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=I6SVVkiO; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="I6SVVkiO"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id B9B084E42D19;
	Wed, 27 May 2026 09:08:13 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8C0B1601A1;
	Wed, 27 May 2026 09:08:13 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 37E9410888BA2;
	Wed, 27 May 2026 11:08:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1779872893; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=kK4DTYkH4mVqwbeUHZEIbZsf6OS+5cQBMBpoc2DcWR8=;
	b=I6SVVkiOFww4QVTTTD7F7O1TYjm+ySSBsQfX6Y8/mfPsdhbzIkTo3Gsn2+jPEsG73kI9Xf
	zws+RC/t3v8l2NQgg/kDgN2g8Las5DBzhE1WmzZIj8TkkVKoTFuf7K7ttWTG8c4n5aKNHc
	W7PwTT0/MR7498W1CGFyHhYduvN66YAF+PctgU0zUDl5RlczG6MucMRePGOSwdQ/wlDUS/
	VIx+d9mXKXH6n4dxKLH0LB5HFTajOvUh6OyPzq88WBmJsBAUTINdVjzlThwEsq/z3hJq4V
	1MnYpnvnw12nbHO+Y67l43wR+OhWjHa0VDDX3obB4kvgpnJ5OVh1wHdbZxnXOw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>, linux-mtd@lists.infradead.org, 
 Florian Fuchs <fuchsfl@gmail.com>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 Adrian McMenamin <adrian@newgolddream.dyndns.info>, 
 Artur Rojek <contact@artur-rojek.eu>
In-Reply-To: <20260518114521.81564-1-fuchsfl@gmail.com>
References: <20260518114521.81564-1-fuchsfl@gmail.com>
Subject: Re: [PATCH v3 0/3] mtd: maps: vmu-flash: Fix build and runtime
 errors
Message-Id: <177987289003.3980206.15138963212721838518.b4-ty@bootlin.com>
Date: Wed, 27 May 2026 11:08:10 +0200
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

On Mon, 18 May 2026 13:45:18 +0200, Florian Fuchs wrote:
> This small series fixes build and runtime errors in the vmu-flash driver
> (enabled by CONFIG_MTD_VMU) and the related maple.h. These changes were
> verified on real Dreamcast hardware with a physical VMU. The VMU can now
> be successfully probed, read and written with MTD tools like mtdinfo and
> mtd_debug. Previously, the driver failed to build or crashed during
> probing.
> 
> [...]

Applied to mtd/next, thanks!

[1/3] maple: fix build error due to missing include of linux/device.h
      (no commit info)
[2/3] mtd: maps: vmu-flash: fix fault in unaligned fixup
      commit: 79d1661502c6e4b6f626185cef72cf2fa78116e1
[3/3] mtd: maps: vmu-flash: fix NULL pointer dereference in initialization
      commit: 357e3b8e3a8769ba36eb8ec5e053e4825f1a9329

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl

