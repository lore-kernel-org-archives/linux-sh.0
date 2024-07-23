Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E390B14C5A4
	for <linux-sh@vger.kernel.org>; Tue, 23 Jul 2024 10:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721730333; cv=none; b=LKFFd1rWGwr7OTzfHWiEHMRqiIMBCEE5qwxywvJEYapWF3YGEtstAKBszqwOEbShKD9Y3SfJAtmgHMeBLT0GIabDQmSIQkYfiwvhP3TOdZFkoGjaMGBDwAhXUcn92n9+TbZcSWhe4n2IEX+3lav9wuENrs1s4DCaRqxfU/UrQ2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721730333; c=relaxed/simple;
	bh=jBo1ZsGr4ttkdE1yZEloCeMYmWmyjPXpl22boxcjwRo=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=Onvj6o/37TN4HveyzgDiAAlOCbaYdZl1hZaTYfXwj+KZ3J//NrNAypBlXBhADga4IOZcX21d2L7trFPPGhD1pDBHvFFHXU1ejQXl5OTV1FB8qX5EJZ7SzAD519Pmo/XzDQdjt7aSM61rwU/GWh/Dfpl6LfVRGpEyHPPuLpQOnsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=Q7q6KtkH; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="Q7q6KtkH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=bSK6wUaKoghAHlpj+LQNzXl7RTfEsk/PQ6d2j+g+AUQ=; t=1721730330; x=1722335130; 
	b=Q7q6KtkHgHT0i8e4oimAqgPL7kPySiSGGC6Bgk4mcWeJ5XfiEdRngAefTpEuXTo36NLqDj8XDj5
	YWkYlkM1pAVypoxRRtPdnb1EP+0WvzwmeUpk9IwXQdu+8+YG5CvL+Cd+QWZ1mU0RmShqEaQz6vEZx
	z8wenzKsS4w/hzeVBNaIMHiTV3zmuj4d6gDG9b0U7i+9hu7z1M/9pleQO2zzZKImylmlwAeQ6Zes6
	vtqA5S8vc0Lx4ehcOveXASbcoEf2PUkDP7/MS4FqDbMSH5UJfJZg4sYbOtIkeiD3A3+D10H2fFmA0
	OL/DUsfC3M9rFXZWbfeOOLKNkQBoXI79CuBA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1sWChy-000000041uV-1mgz; Tue, 23 Jul 2024 12:25:26 +0200
Received: from dynamic-089-012-111-099.89.12.pool.telefonica.de ([89.12.111.99] helo=[192.168.178.20])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1sWChy-00000003xsm-0vzc; Tue, 23 Jul 2024 12:25:26 +0200
Message-ID: <1fb1189190ddd4c46b19e3e00cfa901388ee8835.camel@physik.fu-berlin.de>
Subject: [GIT PULL] sh updates for v6.11 (CORRECTION)
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>, Oscar Salvador
 <osalvador@suse.de>,  Rich Felker <dalias@libc.org>, Yoshinori Sato
 <ysato@users.sourceforge.jp>, linux-sh <linux-sh@vger.kernel.org>
Date: Tue, 23 Jul 2024 12:25:25 +0200
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

Hi Linus,

my pull request with sh updates is rather small this time and contains just=
 three
changes. The first change by Oscar Salvador drops support for memory hotplu=
g and
hotremove for sh as the kernel stopped supporting it on 32-bit platforms si=
nce
7ec58a2b941e ("mm/memory_hotplug: restrict CONFIG_MEMORY_HOTPLUG to 64 bit"=
), this
includes a follow-up change to update all affected board config files. The =
third
change comes from Jeff Johnson which adds the missing MODULE_DESCRIPTION() =
macro
to the push-switch driver.

The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0=
:

  Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/glaubitz/sh-linux.git tags/=
sh-for-v6.11-tag1

for you to fetch changes up to 8fe76a1c2264a02155895cda9f97a6a5a9b97d91:

  sh: push-switch: Add missing MODULE_DESCRIPTION() macro (2024-07-16 17:52=
:36 +0200)

Thanks for pulling!

Adrian

----------------------------------------------------------------
sh updates for v6.11

- sh: push-switch: Add missing MODULE_DESCRIPTION() macro
- sh: config: Drop CONFIG_MEMORY_{HOTPLUG,HOTREMOVE}
- sh: Drop support for memory hotplug and memory hotremove

----------------------------------------------------------------
Jeff Johnson (1):
      sh: push-switch: Add missing MODULE_DESCRIPTION() macro

Oscar Salvador (2):
      sh: Drop support for memory hotplug and memory hotremove
      sh: config: Drop CONFIG_MEMORY_{HOTPLUG,HOTREMOVE}

 arch/sh/Kconfig                     |  2 --
 arch/sh/configs/apsh4ad0a_defconfig |  2 --
 arch/sh/configs/sdk7786_defconfig   |  2 --
 arch/sh/configs/shx3_defconfig      |  2 --
 arch/sh/drivers/push-switch.c       |  1 +
 arch/sh/mm/Kconfig                  |  4 ----
 arch/sh/mm/init.c                   | 28 ----------------------------
 7 files changed, 1 insertion(+), 40 deletions(-)

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
