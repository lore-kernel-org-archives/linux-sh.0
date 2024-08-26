Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CF18C11;
	Mon, 26 Aug 2024 05:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724650753; cv=none; b=QqjF+1NEFUD6mCUIVYl5sNddSyhLPvB0rxta1zSWIkcUL3yWodXjtjSuqLxbcWOZXKAQ3AI4choRdmdBzYmgEpB0/ofHpKhkJobwwakLoqBgNeq5Ij8MfZ3UVDug7m/RbukEhY7J8oUMbNIm9azYiH2W+TCk8meq1FxuqnyhZFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724650753; c=relaxed/simple;
	bh=lYVNKITBsfAKckN7qsoiYfRhfMDN1xeuGFUOSh1/PVA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R501W2Gaq6x3kFNGbokmi45JiEyCfyOVNzU6Lm9pBtESe/o8QzBiK0eyx3IbpfBm4t6aYj5rIRCqEvIVzXxefW9VOruAA9Io2hvf2KJvxdJI8cDvk9gfFEmAykwZwSrxlBk9d0O8owjk9YUWquSufTmKnH+EAjgmeOXDZDVrebw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=fjaeorAC; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="fjaeorAC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=LfT86w0DD1Bxg2yTlCdTPH77SKbVGJZWodC7UbCGiEE=; t=1724650749; x=1725255549; 
	b=fjaeorACY/fjP57jdfiar6CKv3uNaAUqeIdb9eyHvPdYPCMH5+hHFl743jq5/oV/IcX3gZioH9t
	MyYZ9aLQG//dc91S1S92/gudLbnw0vCqH1tRw59pcPLUbPi2HNfui9Z3E6p1yPh7tHdNTAO+V8h6V
	jRDtYPPJILqA3DkrlhKUTElY6XWZRKX7uGvbsItPDfQOh/fQltcr0qnd6tx24hhy7hYNOVueMSbza
	jGi0xGSnTLOBcf1qLUVP28FykVnkHwfaGbERAoopmPRtgwT3GCnq7OswffaT0XtXjGv4F27BgV9HB
	jplCqTo1CFzbUq+ibGPVQMzAptJG2dOmuUuQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1siSRK-00000003X59-0z93; Mon, 26 Aug 2024 07:38:54 +0200
Received: from p5b13a2bf.dip0.t-ipconnect.de ([91.19.162.191] helo=[192.168.178.20])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1siSRJ-00000002r7f-46hv; Mon, 26 Aug 2024 07:38:54 +0200
Message-ID: <c1fd73a3941c54e58420d7555524cd6baeebfb96.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] crash: Default to CRASH_DUMP=n when support for it is
 unlikely
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Michael Ellerman <mpe@ellerman.id.au>, Geert Uytterhoeven
	 <geert@linux-m68k.org>, Dave Vasilevsky <dave@vasilevsky.ca>
Cc: bhe@redhat.com, linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
  kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Reimar
 =?ISO-8859-1?Q?D=F6ffinger?= <Reimar.Doeffinger@gmx.de>
Date: Mon, 26 Aug 2024 07:38:53 +0200
In-Reply-To: <87frqsghws.fsf@mail.lhotse>
References: <20240823125156.104775-1-dave@vasilevsky.ca>
	 <CAMuHMdVYNhFJ+qBDP3_fi9oeHsgOL0vqPe1YqE18+M8n1onssw@mail.gmail.com>
	 <87frqsghws.fsf@mail.lhotse>
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

Hi Michael,

On Mon, 2024-08-26 at 12:02 +1000, Michael Ellerman wrote:
> > What is so special about CRASH_DUMP, that it should be enabled by
> > default?
> =20
> The reality is that essentially all distros enable it. Because they
> don't want to manage separate kernel / crash-kernel packages.
>=20
> So IMHO having it enabled by default in upstream does make sense,
> because it more closely matches what distros/users actually run.

Well, at least Debian did not enable it by default as otherwise we wouldn't
have noticed this change downstream.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
