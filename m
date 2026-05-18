Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2007D355F2D;
	Mon, 18 May 2026 12:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779105979; cv=none; b=HmEzSpE/bpRziigOwhLDoTT2jrXxsPpyxOSG7x2PmXqIKUa5i9Ok7GGOV/XZ8rlxTS/Yv63un5Bx+s1dNysxvLk+wELr5UlPd4RgUwzrxFRsxUv8fdFu0Oi7UERJesQ/peXaC64NZ74Pj8oGqYmIEXRXVKT3u7RuohnZLtCs1KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779105979; c=relaxed/simple;
	bh=qGBbj7L2BkeT8w74J5jzL7q2DOUlya6jHM7hiGnOStw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HCviKqXBGdWvY4DtHjJnly6tCVuGjcrXP+BzJVI1P8KIMVjkAkWCl36ENsjk64ZxliwUFN30VHu31G/G+a769U9Be/1rKtHlqQtewZRgHCCvRXc/uwV3sdMYLVZJDugm3A91yeN3mgSgMas9nWaEaXgzwUC+9MYouIt1P5vR9ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=iczjFiyE; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="iczjFiyE"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 09A8C4E42CDB;
	Mon, 18 May 2026 12:06:14 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A48C95FFA3;
	Mon, 18 May 2026 12:06:13 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1F6E211AF84A3;
	Mon, 18 May 2026 14:06:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1779105973; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ti0kMieo1Q8WJfj742mYfiKH1EDQpG4zFPCckhsBW8U=;
	b=iczjFiyENVzumC7GYJz0GANMpn8oqwIM5i47kKTaNE2KAADb0M4OV9NHxgKGRcUesiZeaR
	tY2qV2QWorlamiM1iDRU06Te+s4RMPtLWnXk5vO1cFywyy/GTwxwc2bs6xt4yTdHfQsnkE
	JTgL23eQHhnPJCfuMh/hLRVdVoydfRjGnsUJb2mL37pcUBPczSBux5Ou8zlugRumWZ5IRg
	M0XqOkT1W0pd3IIZklkZ3xZZOzjtFIdVgBl9/MjXutuHPx/Bby7KI4e/tsHW7sSBpuV4H3
	7jManfFXTvjWZt6XmvFmVtSF3edN58jl0clzOog4j0OyTXjfxVfuE0pwkfJKJQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Florian Fuchs <fuchsfl@gmail.com>
Cc: Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  linux-mtd@lists.infradead.org,
  linux-sh@vger.kernel.org,  linux-kernel@vger.kernel.org,  Rich Felker
 <dalias@libc.org>,  John Paul Adrian Glaubitz
 <glaubitz@physik.fu-berlin.de>,  Adrian McMenamin
 <adrian@newgolddream.dyndns.info>,  Artur Rojek <contact@artur-rojek.eu>
Subject: Re: [PATCH v3 0/3] mtd: maps: vmu-flash: Fix build and runtime errors
In-Reply-To: <20260518114521.81564-1-fuchsfl@gmail.com> (Florian Fuchs's
	message of "Mon, 18 May 2026 13:45:18 +0200")
References: <20260518114521.81564-1-fuchsfl@gmail.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Mon, 18 May 2026 14:06:08 +0200
Message-ID: <87fr3oudlb.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hi Florian,

On 18/05/2026 at 13:45:18 +02, Florian Fuchs <fuchsfl@gmail.com> wrote:

> Hi all,
>
> This small series fixes build and runtime errors in the vmu-flash driver
> (enabled by CONFIG_MTD_VMU) and the related maple.h. These changes were
> verified on real Dreamcast hardware with a physical VMU. The VMU can now
> be successfully probed, read and written with MTD tools like mtdinfo and
> mtd_debug. Previously, the driver failed to build or crashed during
> probing.
>
>         bash-5.3# mtdinfo /dev/mtd0
>         mtd0
>         Name:                           vmu2.1.0
>         Type:                           mlc-nand
>         Eraseblock size:                512 bytes
>         Amount of eraseblocks:          256 (131072 bytes, 128.0 KiB)
>         Minimum input/output unit size: 512 bytes
>         Sub-page size:                  512 bytes
>         Character device major/minor:   90:0
>         Bad blocks are allowed:         true
>         Device is writable:             true
>
> Thanks,
> Florian
> ---

I believe there is no issue in applying patches 2 and 3 on top of the
mtd tree and let whoever is responsible take patch 1. If I get an ack I
can also carry patch 1 through the mtd tree. Without more feedback I
plan on applying patches 2 and 3 in the coming weeks.

Thanks,
Miqu=C3=A8l
