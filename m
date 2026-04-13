Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9702A362149;
	Mon, 13 Apr 2026 10:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776077876; cv=none; b=dYq6/jWLggJmCzHWh3MuYu8DVf17Ju8HZbJAdMt3Ktno8GB/BW53tBRbj9sBLqRBgr9Mvpjo3wvBwfec28v4j0yQWSmVkRBqX6ARLFipCHFxPYgXFSYmE/inZoET3J5IrR6qthfYnOOBnvRleuAlHS7o6U2xCz7q9b0i9G+DyE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776077876; c=relaxed/simple;
	bh=I22KCoQJs29JGx1Ursr9A/Bk8D4wMlhLoggGTpiO3tU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l0YrBg0MC2D6Jwi8wU8xRdOo6u65ZdN3od9J/TWILYA+qf5IuqLtd/uMz0NBpmFuJXSRCzdxIEpJjbbox6dDzP2x4gJ913qwhUYmsVTIbtb6cUuGYFvdhIqiksjSTz0TgHSSnfPRMQcmxyVouzrf0wsJbgSy3Z3O0ZkUPQcNi8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=TvRZ66+m; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="TvRZ66+m"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=6yOlosg+cVYV8+u47sLzjplPhc3Rbe3BWWgSNY8/iuQ=; t=1776077873;
	x=1776682673; b=TvRZ66+m2+aeouiRBT5RJrlKfthf3aYfFywB/zc7gVdEg11b4PZpAa0HXoQOg
	9H20lkXi8T8HgGwTRIdoZ99xbmTgg6x9wtD2eC0j2cQXTxUfDeqUnUVHHKKrN88kZu0nUKPOJzSPX
	qPAGGK5GyNCFI8VL7OXg0vbAM5+wVdK8erlX7o/6tcgMbyGiBShoS2y1LKJggKFFjKGz+VU4Jz37o
	ydSWUxXSpFaAPG05ToUfDQ++n41u3nGRvDIMLTnnpcBJ8UUrvj03dkpu8C3U1TQEuE1PlcERy3nvb
	yZZxSBq+QxNWM1iulb4FAXC6FY5NEj2QYSv+itjm0k8YBotURA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1wCEzG-00000002T6c-1k78; Mon, 13 Apr 2026 12:57:50 +0200
Received: from dynamic-093-128-043-080.93.128.pool.telefonica.de ([93.128.43.80] helo=[192.168.178.50])
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1wCEzG-000000023DI-0ooC; Mon, 13 Apr 2026 12:57:50 +0200
Message-ID: <44fcae62f14a4020483b8a2f867c94045155fdb9.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 00/10] sh: remove NUMA and SPARSEMEM support
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Mike Rapoport <rppt@kernel.org>, linux-sh@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann
 <arnd@arndb.de>,  Rich Felker <dalias@libc.org>, Yoshinori Sato
 <ysato@users.sourceforge.jp>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Date: Mon, 13 Apr 2026 12:57:49 +0200
In-Reply-To: <20260413104649.852228-1-rppt@kernel.org>
References: <20260413104649.852228-1-rppt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.0 
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Mike,

On Mon, 2026-04-13 at 13:46 +0300, Mike Rapoport wrote:
> NUMA support for SuperH was introduced a long time ago by commit
> b241cb0c885e ("sh: Support for multiple nodes.")
>=20
> 	"... for boards with many different memory blocks that are
> 	 otherwise unused (SH7722/SH7785 URAM and so forth)"
>=20
> In reality, this added 128K of memory on sh7722 and sh7785 and 256K on
> shx3 at the expense of all the NUMA related code in the kernel.
>=20
> For build of v7.0-rc7 with defconfig and the same configuration with
> CONFIG_NUMA disabled, bloat-o-meter reports difference of ~76k. Disabling
> CONFIG_SPARSMEM on top increases the difference to ~94k. And that's only
> overhead in code and static data that does not take into the account data
> structures allocated at run time.
>=20
> And all this overhead has been there for nothing for almost 8 years
> because since commit ac21fc2dcb40 ("sh: switch to NO_BOOTMEM")
> those additional "nodes" could not be used by the core MM because the
> maximal pfn for ZONE_NORMAL was cut out at the end of the normal memory.
>=20
> Mike Rapoport (Microsoft) (10):
>   sh: remove CONFIG_NUMA and realted configuration options
>   sh: mm: remove numa.c
>   sh: mm: drop allocate_pgdat()
>   sh: remove setup_bootmem_node() and plat_mem_setup()
>   sh: drop dead code guarded by #ifdef CONFIG_NUMA
>   sh: drop include/asm/mmzone.h
>   init/Kconfig: drop ARCH_WANT_NUMA_VARIABLE_LOCALITY
>   sh: init: remove call the memblock_set_node()
>   sh: remove SPARSEMEM related entries from Kconfig
>   sh: drop include/asm/sparsemem.h

Thanks a lot for the series. It will take me some time to review and I expe=
ct
it to be taken for v7.2. FWIW, I actually own several boards using the SH-7=
785LCR
CPU and I issues booting kernels newer than 6.5 on these so I'm wondering w=
hether
this broken feature might be to blame?

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
