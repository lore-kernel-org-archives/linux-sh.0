Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BB883CBD
	for <linux-sh@vger.kernel.org>; Thu, 21 Mar 2024 13:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711029149; cv=none; b=XLvOnrxR9OCFK2jUh3JQoYJqtfsk6kPwGGlY5TjYTbn0ZRmNHmkHlaIuyRziSN68nBjZXtB2NnNmXSXACsGoB5KWDoJ8WNG2sVIOeQOmdmrUKzckGro6x5RbvxerZaY+v/ddQ6VdTJFlfCyyz19WJb9ToDvdGTf2ygoTWDka0vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711029149; c=relaxed/simple;
	bh=cey39oyWBr01g/RFQp8UGN/BXh3Ok9Zs+xvRqAphbEg=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=N6U/YSwc3fLl6JD8LsBLWx0ndjieQRNYMg7INRG1/oIi3nbScMvwcJLkv12lBDzI/22OgQHkko5xicuwOL8vIsFfiRnTyKtEZoNYTSvyjOCuye269is7PNljJcpYasTuh6bCr0UsfHWMmJZiY2pZ9qRgxzXhBg7B75FYFTCHxz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=CgfS5+Hd; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="CgfS5+Hd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=7Wkm6/LRDDZcKlZ+t7kKqhjqwoCKShxobZenLc1kfv8=; t=1711029146; x=1711633946; 
	b=CgfS5+HdT5j6WtbZkrums2aQmpd4LkIEDSoPouihCEOWrzCO5Iy81iOgWf2AthBU1ZQ8aSSvbRC
	jRW/5FGBKMvx6x5x3uEEUxpJpV9bL4Y/TRT3iUaQ28nR8y0dgxy/SCbksnANy+0HBKurv++pUjdYf
	y4rUd4PrqrKIZ663Qr7vu4BeWgkS56FclP18/zJ/35CZWsaMxqGpLvTLj7jGsnw/YIpZXMEMGgGBB
	8nDc+0u0SZC9OPYLSqCZeccOJuvDcq2Q4YycgMpKYWXWwkWZryo3q+xShXg9SC8A0Ls7p93sCRKyG
	vBQLd65E8pWDWH/pIiHRzsJP58Ttb75sIUKw==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.97)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1rnIq8-00000003Kfo-0QoZ; Thu, 21 Mar 2024 14:52:16 +0100
Received: from p5b13a6ce.dip0.t-ipconnect.de ([91.19.166.206] helo=[192.168.178.20])
          by inpost2.zedat.fu-berlin.de (Exim 4.97)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1rnIq7-00000000Ru6-3dFL; Thu, 21 Mar 2024 14:52:16 +0100
Message-ID: <e05595fe22203dd8ec7a7800e25aedfc136b8aec.camel@physik.fu-berlin.de>
Subject: [GIT PULL] sh updates for v6.9
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Artur Rojek <contact@artur-rojek.eu>, "Ricardo B.Marliere"
	 <ricardo@marliere.net>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich
	Felker <dalias@libc.org>, linux-sh <linux-sh@vger.kernel.org>
Date: Thu, 21 Mar 2024 14:52:15 +0100
Autocrypt: addr=glaubitz@physik.fu-berlin.de; prefer-encrypt=mutual;
 keydata=mQINBE3JE9wBEADMrYGNfz3oz6XLw9XcWvuIxIlPWoTyw9BxTicfGAv0d87wngs9U+d52t/REggPePf34gb7/k8FBY1IgyxnZEB5NxUb1WtW0M3GUxpPx6gBZqOm7SK1ZW3oSORw+T7Aezl3Zq4Nr4Nptqx7fnLpXfRDs5iYO/GX8WuL8fkGS/gIXtxKewd0LkTlb6jq9KKq8qn8/BN5YEKqJlM7jsENyA5PIe2npN3MjEg6p+qFrmrzJRuFjjdf5vvGfzskrXCAKGlNjMMA4TgZvugOFmBI/iSyV0IOaj0uKhes0ZNX+lQFrOB4j6I5fTBy7L/T3W/pCWo3wVkknNYa8TDYT73oIZ7Aimv+k7OzRfnxsSOAZT8Re1Yt8mvzr6FHVFjr/VdyTtO5JgQZ6LEmvo4Ro+2ByBmCHORCQ0NJhD1U3avjGfvfslG999W0WEZLTeaGkBAN1yG/1bgGAytQQkD9NsVXqBy7S3LVv9bB844ysW5Aj1nvtgIz14E2WL8rbpfjJMXi7B5ha6Lxf3rFOgxpr6ZoEn+bGG4hmrO+/ReA4SerfMqwSTnjZsZvxMJsx2B9c8DaZE8GsA4I6lsihbJmXhw8i7Cta8Dx418wtEbXhL6m/UEk60O7QD1VBgGqDMnJDFSlvKa9D+tZde/kHSNmQmLLzxtDbNgBgmR0jUlmxirijnm8bwARAQABtEBKb2huIFBhdWwgQWRyaWFuIEdsYXViaXR6IChEZWJpYW4gUHJvamVjdCkgPGdsYXViaXR6QGRlYmlhbi5vcmc+iQI3BBMBCAAhBQJRnmPwAhsDBQsJCAcDBRUKCQgLBRYCAwEAAh4BAheAAAoJEHQmOzf1tfkTF0gQAJgvGiKf5YW6+Qyss1qGwf+KHXb/6gIThY6GpSIro9vL/UxaakRCOloaXXAs3KpgBULOO8+prqU8GIqcd8tE3YvQFvvO3rN+8bhOiiD0lFmQSEHcpCW5ZRpdh
	J5wy1t9Ddb1K/7XGzen3Uzx9bjKgDyikM3js1VtJHaFr8FGt5gtZIBDgp8QM9IRCv/32mPQxqmsaTczEzSNxTBM6Tc2NwNLus3Yh5OnFdxk1jzk+Ajpnqd/E/M7/CU5QznDgIJyopcMtOArv9Er+xe3gAXHkFvnPqcP+9UpzHB5N0HPYn4k4hsOTiJ41FHUapq8d1AuzrWyqzF9aMUi2kbHJdUmt9V39BbJIgjCysZPyGtFhR42fXHDnPARjxtRRPesEhjOeHei9ioAsZfT6bX+l6kSf/9gaxEKQe3UCXd3wbw68sXcvhzBVBxhXM91+Y7deHhNihMtqPyEmSyGXTHOMODysRU453E+XXTr2HkZPx4NV1dA8Vlid2NcMQ0iItD+85xeVznc8xquY/c1vPBeqneBWaE530Eo5e3YA7OGrxHwHbet3E210ng+xU8zUjQrFXMJm3xNpOe45RwmhCAt5z1gDTk5qNgjNgnU3mDp9DX6IffS3g2UJ02JeTrBY4hMpdVlmGCVOm9xipcPHreVGEBbM4eQnYnwbaqjVBBvy2DyfyN/tFRKb2huIFBhdWwgQWRyaWFuIEdsYXViaXR6IChGcmVpZSBVbml2ZXJzaXRhZXQgQmVybGluKSA8Z2xhdWJpdHpAcGh5c2lrLmZ1LWJlcmxpbi5kZT6JAlEEEwEIADsCGwMFCwkIBwMFFQoJCAsFFgIDAQACHgECF4AWIQRi/4p1hOApVpVGAAZ0Jjs39bX5EwUCWhQoUgIZAQAKCRB0Jjs39bX5Ez/ID/98r9c4WUSgOHVPSMVcOVziMOi+zPWfF1OhOXW+atpTM4LSSp66196xOlDFHOdNNmO6kxckXAX9ptvpBc0mRxa7OrC168fKzqR7P75eTsJnVaOu+uI/vvgsbUIosYdkkekCxDAbYCUwmzNotIspnFbxiSPMNrpw7Ud/yQkS9TDYeXnrZDhBp7p5+naWCD/yMvh7yVCA4Ea8+xDVoX
	+kjv6EHJrwVupOpMa39cGs2rKYZbWTazcflKH+bXG3FHBrwh9XRjA6A1CTeC/zTVNgGF6wvw/qT2x9tS7WeeZ1jvBCJub2cb07qIfuvxXiGcYGr+W4z9GuLCiWsMmoff/Gmo1aeMZDRYKLAZLGlEr6zkYh1Abtiz0YLqIYVbZAnf8dCjmYhuwPq77IeqSjqUqI2Cb0oOOlwRKVWDlqAeo0Bh8DrvZvBAojJf4HnQZ/pSz0yaRed/0FAmkVfV+1yR6BtRXhkRF6NCmguSITC96IzE26C6n5DBb43MR7Ga/mof4MUufnKADNG4qz57CBwENHyx6ftWJeWZNdRZq10o0NXuCJZf/iulHCWS/hFOM5ygfONq1Vsj2ZDSWvVpSLj+Ufd2QnmsnrCr1ZGcl72OC24AmqFWJY+IyReHWpuABEVZVeVDQooJ0K4yqucmrFR7HyH7oZGgR0CgYHCI+9yhrXHrQpyLQ/Sm9obiBQYXVsIEFkcmlhbiBHbGF1Yml0eiAoU1VTRSBMSU5VWCBHbWJIKSA8Z2xhdWJpdHpAc3VzZS5jb20+iQJOBBMBCAA4FiEEYv+KdYTgKVaVRgAGdCY7N/W1+RMFAloSyhICGwMFCwkIBwMFFQoJCAsFFgIDAQACHgECF4AACgkQdCY7N/W1+ROnkQ//X6LVYXPi1D8/XFsoi0HDCvZhbWSzcGw6MQZKmTk42mNFKm/OrYBJ9d1St4Q3nRwH/ELzGb8liA02d4Ul+DV1Sv3P540LzZ4mmCi9wV+4Ohn6cXfaJNaTmHy1dFvg1NrVjMqGAFZkhTXRAvjRIQItyRvL//gKaciyKB/T0C3CIzbuTLBqtZMIIuP5nIgkwBvdw6H7EQ7kqOAO85S4FDSum/cLwLzdKygyvmPNOOtxvxa9QIryLf6h7HfWg68DvGDqIV9ZBoi8JjYZrZzaBmlPV8Iwm52uYnzsKM/LoyZ0G4v2u/WEtQEl7deLJjKby3kKmZGh9hQ
	YImvOkrd9z8LQSvu0e8Qm8+JbRCCqUGkAPrRDFIzH8nFCFGCU/V+4LT2j68KMbApLkDQAFEDBcQVJYGnOZf7eU/EtYQIqVmGEjdOP7Qf/yMFzhc9GBXeE5mbe0LwA5LOO74FDH5qjwB5KI6VkTWPoXJoZA5waVC2sUSYOnmwFINkCLyyDoWaL9ubSbU9KTouuNm4F6XIssMHuX4OIKA7b2Kn5qfUFbd0ls8d5mY2gKcXBfEY+eKkhmuwZhd/7kP10awC3DF3QGhgqpaS100JW8z78el7moijZONwqXCS3epUol6q1pJ+zcapcFzO3KqcHTdVOKh6CXQci3Yv5NXuWDs/l2dMH4t2NvZC5Ag0ETckULgEQAKwmloVWzF8PYh5jB9ATf07kpnirVYf/kDk+QuVMPlydwPjh6/awfkqZ3SRHAyIb+9IC66RLpaF4WSPVWGs307+pa5AmTm16vzYA0DJ7vvRPxPzxPYq6p2WTjFqbq0EYeNTIm0YotIkq/gB9iIUS+gjdnoGSA+n/dwnbu1Eud2aiMW16ILqhgdgitdeW3J7LMDFvWIlXoBQOSfXQDLAiPf+jPJYvgkmCAovYKtC3aTg3bFX2sZqOPsWBXV6Azd92/GMs4W4fyOYLVSEaXy/mI35PMQLH8+/MM4n0g3JEgdzRjwF77Oh8SnOdG73/j+rdrS6Zgfyq6aM5WWs6teopLWPe0LpchGPSVgohIA7OhCm+ME8fpVHuMkvXqPeXAVfmJS/gV5CUgDMsYEjst+QXgWnlEiK2Knx6WzZ+v54ncA4YP58cibPJj5Qbx4gi8KLY3tgIbWJ3QxIRkChLRGjEBIQ4vTLAhh3vtNEHoAr9xUb3h8MxqYWNWJUSLS4xeE3Bc9UrB599Hu7i0w3v6VDGVCndcVO91lq9DZVhtYOPSE8mgacHb/3LP0UOZWmGHor52oPNU3Dwg205u814sKOd2i0DmY+Lt4EkLwFIYGE0FLLTHZDjDp9D
	0iKclQKt86xBRGH+2zUk3HRq4MArggXuA4CN1buCzqAHiONvLdnY9StRABEBAAGJAh8EGAEIAAkFAk3JFC4CGwwACgkQdCY7N/W1+ROvNxAAtYbssC+AZcU4+xU5uxYinefyhB+f6GsS0Ddupp/MkZD/y98cIql8XXdIZ6z8lHvJlDq0oOyizLpfqUkcT4GhwMbdSNYUGd9HCdY/0pAyFdiJkn++WM8+b+9nz4mC6vfh96imcK4KH/cjP7NG37El/xlshWrb6CqKPk4KxNK5rUMPNr7+/3GwwGHHkJtW0QfDa/GoD8hl2HI6IQI+zSXK2uIZ7tcFMN8g9OafwUZ7b+zbz1ldzqOwygliEuEaRHeiOhPrTdxgnj6kTnitZw7/hSVi5Mr8C4oHzWgi66Ov9vdmClTHQSEjWDeLOiBj61xhr6A8KPUVaOpAYZWBH4OvtnmjwsKuNCFXym2DcCywdjEdrLC+Ms5g6Dkd60BQz4/kHA7x+P9IAkPqkaWAEyHoEvM1OcUPJzy/JW2vWDXo2jjM8PEQfNIPtqDzid1s8aDLJsPLWlJnfUyMP2ydlTtR54oiVBlFwqqHoPIaJrwTkND5lgFiMIwup3+giLiDOBILtiOSpYxBfSJkz3GGacOb4Xcj8AXV1tpUo1dxAKpJ1ro0YHLJvOJ8nLiZyJsCabUePNRFprbh+srI+WIUVRm0D33bI1VEH2XUXZBL+AmfdKXbHAYtZ0anKgDbcwvlkBcHpA85NpRqjUQ4OerPqtCrWLHDpEwGUBlaQ//AGix+L9c=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Linus,

this pull request is unfortunately small again as I have not managed to rev=
iew all
the pending patches posted by contributors yet. I didn't want to rush these=
 into
this cycle, so they will be part of the next one.

The first two patches by Ricardo B. Marliere make two instances of struct b=
us_type
in the interrupt controller driver and the DMA sysfs interface const since =
the
driver core in the kernel is now able to handle that.

A third patch by Artur Rojek enforces internal linkage for the function set=
up_hd64461()
in order to fix the build of hp6xx_defconfig with -Werror=3Dmissing-prototy=
pes.

The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d=
:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/glaubitz/sh-linux.git tags/=
sh-for-v6.9-tag1

for you to fetch changes up to 1e21acb7fbfb15fcb4afe21fb5a50a1bc00743ec:

  sh: hd64461: Make setup_hd64461() static (2024-03-21 12:17:35 +0100)

Thanks for pulling!

Adrian

----------------------------------------------------------------
sh updates for v6.9

- sh: hd64461: Make setup_hd64461() static
- sh: intc: Make intc_subsys const
- sh: dma-sysfs: Make dma_subsys const

----------------------------------------------------------------
Artur Rojek (1):
      sh: hd64461: Make setup_hd64461() static

Ricardo B. Marliere (2):
      sh: dma-sysfs: Make dma_subsys const
      sh: intc: Make intc_subsys const

 arch/sh/cchips/hd6446x/hd64461.c | 2 +-
 arch/sh/drivers/dma/dma-sysfs.c  | 2 +-
 drivers/sh/intc/core.c           | 2 +-
 drivers/sh/intc/internals.h      | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
