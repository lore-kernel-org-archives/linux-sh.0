Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E7E18BC05;
	Fri, 23 Aug 2024 18:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724437012; cv=none; b=er0OmhroGbeTsrg11X+LTI7x8wSMM4lRvdbMxlquT0im2Olz5EtwBFJGEys0wIFE+WN68KuWmBMiu5p3V/NwOt2m4ZUwy1bKHVHRrJIuSSbhTJmuZI1uKZNrUL2zjecB8AHHcXAbzAklmZLEmWnq+b437AZ3deGYPM0mOw3zBs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724437012; c=relaxed/simple;
	bh=Z+KpfCDbK4dGleB/fKN+SD8SYDcZR6qlO1ZLgGdwWks=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A3EV+eUE6a6MXYvt+xFQ/YlpwvUdqTxmAzIFyqUKPThQvKAMtP5Qyr48ORq6YO8uigqPP2BU6CVXUzG5deHe2bHt9DrlgIVGW7HXE4W4R/MeWQ/0K150PzWKg/pifOnS2vskfqXL+Lr/JWT8bnsie98NqnnR3f2S/ABfCcosXl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=oj6QZ9QE; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="oj6QZ9QE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=lF3IGhVEk01uLE12Kfo9B/+81jxDEguey7tV3Pj8R54=; t=1724437008; x=1725041808; 
	b=oj6QZ9QE0pI4rsrP76Xc/gbOn3hd3JAL/e38J8YWktrd8xsThYn0awEMwITbjjnqwHJgCoN7zwn
	P7vubLn+tNj7UyQqhN35uvrqS2ABzYcENEVIqVm2JATdZ+iCZNmMSTA9LVXgB0r6lgKVUcSMWekVI
	seVN0btNP6aV5FcXlitv92sKykOA+jtDGNcXU4RPXabltMCnSP6zSHfZVOSbz21dZ0+ohGm/o8q3Y
	XWLAfslrxR2TG2w/yYRVqRQWxr8jG8+jsWX3NM9rYItjMZwoRTHqhtC/BT48poqdkfnrlDNcQ45o/
	8r4cANdCde4a+dGiXT0tYvW6HbQGjJ2iIImg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1shYpw-00000002CKl-2SPB; Fri, 23 Aug 2024 20:16:36 +0200
Received: from p5b13a2bf.dip0.t-ipconnect.de ([91.19.162.191] helo=[192.168.178.20])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1shYpw-00000003fE3-1W3A; Fri, 23 Aug 2024 20:16:36 +0200
Message-ID: <09c29a3c4879d4ce5d8b97fd60d8ba5e38bed979.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] crash: Default to CRASH_DUMP=n when support for it is
 unlikely
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>, Dave Vasilevsky
	 <dave@vasilevsky.ca>
Cc: bhe@redhat.com, linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
  mpe@ellerman.id.au, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org,  Reimar =?ISO-8859-1?Q?D=F6ffinger?=
 <Reimar.Doeffinger@gmx.de>
Date: Fri, 23 Aug 2024 20:16:35 +0200
In-Reply-To: <CAMuHMdVYNhFJ+qBDP3_fi9oeHsgOL0vqPe1YqE18+M8n1onssw@mail.gmail.com>
References: <20240823125156.104775-1-dave@vasilevsky.ca>
	 <CAMuHMdVYNhFJ+qBDP3_fi9oeHsgOL0vqPe1YqE18+M8n1onssw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Geert,

On Fri, 2024-08-23 at 15:13 +0200, Geert Uytterhoeven wrote:
> IMHO CRASH_DUMP should just default to n, like most kernel options, as
> it enables non-trivial extra functionality: the kernel source tree has
> more than 100 locations that check if CONFIG_CRASH_DUMP is enabled.

I guess we should then revert that part of Baoquan's original patch.

> What is so special about CRASH_DUMP, that it should be enabled by
> default?

Let's ask Baoquan who made the original change to enable CRASH_DUMP by defa=
ult.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
