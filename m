Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.133.4.66
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792922581;
	b=R7PCJi61CoRmHAul9TMJmly8ikVLSqiQ+U5SPBF5xWfo/tojsJbJeZQnfiDMTyGUCsGf
	 Vgj3Y/xAGC6neFLdzVAHv0ah/OslrNVBpBgpRsl8MIuuXMHnIB6JVLlhmuEbuF18Ms72h
	 zvge8pZFbdhcK71VXa1wuLXecpNChK9k9uS4fP5lbgH+swL98Lql52NgjquAmV8RkEGbP
	 zCVHXPH2rUwXwv1Lz+3Nnn9OGv3T8qUKWe1XfCT3vwPtN5BixRC1QVVS2thuI+hM2s8aE
	 wwplhFZld5VAuW7dANiL/qas0mN8ZIoRBaSWVXfjLc4QA0p0hInWYxcfPk43p0Pd1aQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792922581;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Subject:
	 From:To:Cc:Date:Content-Type:Content-Transfer-Encoding:User-Agent:
	 MIME-Version:X-Original-Sender:X-Originating-IP:X-ZEDAT-Hint;
	bh=ONuclalldvGRYeCYIBCRB+p6Rhmt1LBVitO+GbjV3sE=;
	b=bLr/xCEej3RKm5KVu+WGTfJpCKKFkc7ob1/OxACCT+CvWkmawdrbmt3wCRuFDpHPi/AY
	 RWEgns0qjj4aM2vbA8qaM9gEoxu5eZEBaxNq6CIBNLZsjIZuVGgJajYmCdaXBDzGTwqCV
	 B0/Z6p0CB23VLiFC9NZACgmcvNC9zKQSl5POtLI2FmOm0IF4I61FpcSaLpzuRKsY+WDjW
	 LMagvyOyInTHoJNmmQqU8spzzvliXoj8OL/jcq38XhGV/O3AyEOB61axB198u79TIhLmX
	 V6cGYSuX4NHLMzBCePvHKlGq/jZcSgET83JUQ3GZOFqGq2p/Hsz+697cSOO5hWmCyXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=physik.fu-berlin.de;
	spf=pass smtp.mailfrom=zedat.fu-berlin.de;
	dkim=pass header.d=fu-berlin.de header.i=@fu-berlin.de header.a=rsa-sha256 header.s=fub01 header.b=UATREoE7;
	arc=none smtp.remote-ip=130.133.4.66
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD644606A31A;
	Sun, 25 Oct 2026 10:02:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD644606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fu-berlin.de header.i=@fu-berlin.de header.a=rsa-sha256 header.s=fub01 header.b=UATREoE7
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:Date:Cc:To:From:Subject:Message-ID:From:Reply-To:Subject:Date:
	Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=ONuclalldvGRYeCYIBCRB+p6Rhmt1LBVitO+GbjV3sE=; t=1792922579; x=1793527379; 
	b=UATREoE7EpUtLHlyUByMgiwPB6yFfpY6a9ACNWxiwZkn/fx4mkETlcGcLgvrzIwJKIxicON6Uvh
	aSF/ZNBJvY5eLi7TGk08DPZo+I5yHPtYoYznpeDoEGrr6nAXaL1NmvdbTu7GnN24bEtjduGzsUILo
	u5puHlZMRvByszhf47riH4VDQpeVJmlwHD9Y123tx9QLkuxMnKpcvBDPMQvAe9RY4QN5wGlyH0uVQ
	ad/5c7XAFXmO6UkNaTCF5KeSP6CQ0vsETXUOtqticBr+xX35OwurZ8e2iOnoRteyz9OKZavkImrnJ
	ZJbhLe4NglDGzO9P8M1ts8TYTNBZWtpjnAfQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.100)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1xKv3v-00000002f7a-0VtW; Sun, 25 Oct 2026 11:02:47 +0100
Received: from p5b13a90a.dip0.t-ipconnect.de ([91.19.169.10] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.100)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1xKv3u-00000003YTu-3hzz; Sun, 25 Oct 2026 11:02:47 +0100
Message-ID: <3d0dc3463d42cf55ee69648fde508043b104369c.camel@physik.fu-berlin.de>
Subject: [GIT PULL] sh updates for v7.4
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Florian Fuchs	
 <fuchsfl@gmail.com>, Karl Mehltretter <kmehltretter@gmail.com>, Pengpeng
 Hou	 <pengpeng@iscas.ac.cn>, Runyu Xiao <runyu.xiao@seu.edu.cn>, Waldemar
 Brodkorb	 <wbx@openadk.org>, Rich Felker <dalias@libc.org>, Yoshinori Sato	
 <yoshinori.sato@nifty.com>, linux-sh <linux-sh@vger.kernel.org>,
 linux-kernel	 <linux-kernel@vger.kernel.org>
Date: Sun, 25 Oct 2026 11:02:46 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 
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

Hi Linus,

this is my pull request with sh updates for v7.4. It contains fixes and imp=
rovements
for various boards as well as the generic sh kernel from six different auth=
ors.

Dmitry Torokhov has contributed three patches to help the boards mach-x3pro=
to and
ecovec24 get rid off the use of the old platform data API in the kernel. Fo=
r the
former board, software nodes are being used for gpio-keys now while for the=
 latter
board, static device properties are used to describe the touchscreen.

Florian Fuchs has contributed two fixes for the generic sh kernel, one is a=
 build fix
when CONFIG_BUILTIN_DTB is enabled and the other fixes an issue with __get_=
user_u64()
and __put_user_u64() using wrong memory operands which could cause the kern=
el build
to fail with "invalid 'asm'" or an internal compiler error in GCC's change_=
address_1.

A single patch by Pengpeng Hou updates various default configuration files =
of several
boards to replace the removed CONFIG_USB_GADGET_M66592 with the new CONFIG_=
USB_M66592
Kconfig option.

Two patches by Karl Mehltretter fix two issues with the SH-7785LCR evaluati=
on board
which is actually one of the boards I personally use for testing kernel pat=
ches.

The first patch fixes a kernel memory leak which occurred as a result of th=
e prio and
sense lists being sorted too early in register_intc_controller() while the =
second patch
fixes the the registration of the PCA9564 controller so that the RTC works =
properly
again.

A patch by Runyu Xiao fixes missing cookies when calling free_irq() in the =
maple bus
driver which ensures that IRQ handlers can be properly unregistered and the=
 kernel does
not emit a WARN message.

Finally, a patch by Waldemar Brodkorb selects BINFMT_FLAT_NO_DATA_START_OFF=
SET for !MMU
configurations such that there is no gap at the end of text and init runs w=
hich causes
the GOT register to point below the real GOT, so every GOT load reads the n=
eighbouring
slot and gets a wrong pointer.

The following changes since commit cee9395acd8043be0644b25c34bfa86623f2b935=
:

  Linux 7.3-rc1 (2026-08-30 13:34:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/glaubitz/sh-linux.git tags/=
sh-for-v7.4-tag1

for you to fetch changes up to f45711b39e03ff5e80b60dcc1fd34b3fc7d3d36c:

  sh: Select BINFMT_FLAT_NO_DATA_START_OFFSET for !MMU (2026-10-21 19:53:14=
 +0200)

----------------------------------------------------------------
sh updates for v7.4

- sh: Select BINFMT_FLAT_NO_DATA_START_OFFSET for !MMU
- sh: maple: Use the matching IRQ cookie when invoking free_irq()
- sh: sh7785lcr: Register the PCA9564 controller as I2C bus 0
- sh: intc: Sort the prio and sense lists after filling them
- sh: defconfig: Enable the current M66592 UDC symbol
- sh: uaccess: Require offsettable operands for 64-bit user access
- sh: Fix built-in DTB build with generic rule
- sh: ecovec24: Use static device properties to describe the touchscreen
- sh: mach-x3proto: Convert gpio-keys to software nodes
- sh: mach-x3proto: Add software node for GPIO controller

Thanks for pulling!

Adrian

----------------------------------------------------------------
Dmitry Torokhov (3):
      sh: mach-x3proto: Add software node for GPIO controller
      sh: mach-x3proto: Convert gpio-keys to software nodes
      sh: ecovec24: Use static device properties to describe the touchscree=
n

Florian Fuchs (2):
      sh: Fix built-in DTB build with generic rule
      sh: uaccess: Require offsettable operands for 64-bit user access

Karl Mehltretter (2):
      sh: intc: Sort the prio and sense lists after filling them
      sh: sh7785lcr: Register the PCA9564 controller as I2C bus 0

Pengpeng Hou (1):
      sh: defconfig: Enable the current M66592 UDC symbol

Runyu Xiao (1):
      sh: maple: Use the matching IRQ cookie when invoking free_irq()

Waldemar Brodkorb (1):
      sh: Select BINFMT_FLAT_NO_DATA_START_OFFSET for !MMU

 arch/sh/Kconfig                              |   1 +
 arch/sh/boards/board-sh7785lcr.c             |   2 +-
 arch/sh/boards/mach-ecovec24/setup.c         |  38 ++----
 arch/sh/boards/mach-x3proto/gpio.c           |  15 ++-
 arch/sh/boards/mach-x3proto/setup.c          | 165 +++++++++++++----------=
----
 arch/sh/boot/dts/Makefile                    |   2 +-
 arch/sh/configs/migor_defconfig              |   2 +-
 arch/sh/configs/sdk7786_defconfig            |   2 +-
 arch/sh/configs/shx3_defconfig               |   2 +-
 arch/sh/include/asm/uaccess_32.h             |   8 +-
 arch/sh/include/mach-x3proto/mach/hardware.h |   2 +
 drivers/sh/intc/core.c                       |  11 +-
 drivers/sh/maple/maple.c                     |   4 +-
 13 files changed, 122 insertions(+), 132 deletions(-)

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
