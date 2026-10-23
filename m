Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792759537;
	b=jcJRcEzg4RR6yVYZONaKZQdqLQLNB5drFL7c9aHpqfyITP5eSpBI//wsxpO/x2OKL5MY
	 IFVjztj5arHDvsijhykrvZjUinAnnHr0SjsSz+rUKIKGu9eLfWV+uDpHqM3/yXug+Lykd
	 2SKTdtlWCGRhvTC5XwVv4g5S5IJCuSJlno8izGGCneSXO6HP7Ix9RJ8vmUVEj/eEeoJpV
	 Mh4VakmCaNplPNJsdyd+IBJGiyQ5kGhwbCDakp96g/sxN1Eh3+b18JR8BrODD/R1nbj1p
	 JY8pnZvKYv+sNU70XReJS1UzfAr7HN+agZnzVACZqGsfFKlXMWS6ZXnem0YLUzoqEkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792759537;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=Dw7ixUsZNlBi2ggGvaFZwX+nWP7PGBtWcR/4kzMhp/c=;
	b=y9lHJle3Eq5Y1cTl1Q089w2ykKBwozH5C1c0wYVHPCTqzT1wdimltRSxlyb8rU6P9q1R
	 op6Jfr5pDOatdnpwsyrz3ZCfthVVnerpyQrl7g5raKpfhIdf5YY3RAq3UpClNfX7nNvEm
	 4VtuXVdzIGomCJU5vSBfl+2jf96sbJrRycjrm4tpogPXA781zO0K7CwAsbEAhyaNQBLw6
	 JX+ILi/rhYhnJtdBGVTlsBAWBtxMaO3bS4ZStukQAU0lPvqEeitL2hnQ7NnjvBBwh+ylb
	 MWUS4DuZrGIBTt9eL2XTxBY1NmyizFrdOA9807Z97jEAN86VMwJkfXMP+467Evptmyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZsGDya+h;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABD5606A31E
	for <linux-sh@vger.kernel.org>; Fri, 23 Oct 2026 12:45:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DABD5606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZsGDya+h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792759536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dw7ixUsZNlBi2ggGvaFZwX+nWP7PGBtWcR/4kzMhp/c=;
	b=ZsGDya+hYia2e4bY1OdxHKVGFldHwRjTpwI37YzaR2476cLuMRa2mnhCCEUJAmgKu1AXJp
	guRCCWVb/xhrL/iwSnsD46Mx4o5cyc9ayYgms2Fd+SGagERK1AlnSrT+Q5j/AqkHCw6srv
	iD/s+Dkf6dUyMf8eSR+IhxAohgVNSD8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-vHOqT9apNGOF683y8n7mmw-1; Fri, 23 Oct 2026 08:45:33 -0400
X-MC-Unique: vHOqT9apNGOF683y8n7mmw-1
X-Mimecast-MFC-AGG-ID: vHOqT9apNGOF683y8n7mmw_1792759532
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c2e8c76334fso75171966b.1
        for <linux-sh@vger.kernel.org>; Fri, 23 Oct 2026 05:45:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792759532; x=1793364332;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dw7ixUsZNlBi2ggGvaFZwX+nWP7PGBtWcR/4kzMhp/c=;
        b=rtWBZLNvMG1DzUizDxlPJ7TrAL6lu5PmkBebNC7Tb/srhyB4G/YFeCrttTwzzljUZx
         oHKxtUC4IdtNIu8ND1RMTbk1Itgno2+1cunmAKkzSjmBuFatkCeyubLhYdgV295X0WZy
         AVIQymvbI1n5KdUiT1N17ZlAV+9tjCBVnFYxh97+HCD9eWaEt0Ym5+vVNeeTYmEidhRv
         veEnnF8lflhjLs8EfPx2q3xhzeuuQo9plVJX7q+HJgEB7KXpIXnJ5TBK4/k4OHYRL7Vu
         Z4GNRYBSjO31OoqjgwO2fAoB07Pxj9YgSHrexpnuQC/ttw6o84H34EbmwUOvATF8Ujqi
         shiA==
X-Forwarded-Encrypted: i=1; AKwUvBzBu/hVOveDNnh3Eqdccig46CyeKwNlYJ9WfiQly1BEH1l41rSGhOs5DidO/30CQe3v2PPPKKLl0Q==@vger.kernel.org
X-Gm-Message-State: AFq9FYJXnyGgLSBtxKyYSkd2x4NmB9Sw6cnvmfzQKHXexxWFkmT8vUwP
	3s1m+quopSzPlkOi1C00DnHHylvHO8XuwXzX1KhIW4gWc00FdrV66sB+8Tj3i1eF5CchI+cCkyH
	pH2a89rCIR2yBr7ugbB3ew1ekYsQxjbEtSS6BfktLyHwAyASAHZgP9Jzejp5Uq9xs1SY0QyRYzO
	8T3nK9IhwUnkN99ZTH3XyCyL6HjgbSOMKsblA=
X-Gm-Gg: AYBFou1Tb8DpHSdW4y0X0IHjRwqis96hB3soHcn9ni88KCLVl18sLDNrU3h3nPBVJWJ
	d5rfn6rFKLIDx8u+PpNc77K4BxFnHRPCSA9UbhnHeiRjoD4/wYi9QfDLYQ+wcF+uTcX7tRfaD59
	9m2uI8PEe9nL7V2DFy9kM0+sDuje37b6b18KjTvqF7TVtmz/X+qBKCpA0Zz22H5LxaWcpuvI0Jw
	XfG44Si1F1Ic9Vkbwihevf3Mq8JzCYMf1rZsctXHR5itgVH0gkU/cTcsvUF3uwQQx1JIbbkVEiL
	xiA=
X-Received: by 2002:a17:907:fd8a:b0:c2e:46d0:b802 with SMTP id a640c23a62f3a-c46a92ae6c0mr328360466b.40.1792759531948;
        Fri, 23 Oct 2026 05:45:31 -0700 (PDT)
X-Received: by 2002:a17:907:fd8a:b0:c2e:46d0:b802 with SMTP id
 a640c23a62f3a-c46a92ae6c0mr328354266b.40.1792759531460; Fri, 23 Oct 2026
 05:45:31 -0700 (PDT)
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Post: <mailto:linux-sh@vger.kernel.org>
List-Help: <mailto:linux-sh+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sh+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1790088067.git.rrobaina@redhat.com> <CAHC9VhQ=FFYVNmQdiMsqg+5KDDrSC3SZS+H2=r_GkhfwQox8tg@mail.gmail.com>
 <CAABTaaBL=TScs8Qqu3b8F6KZPGMyvwy6cBC3teDaBL6MGMucNg@mail.gmail.com> <CAHC9VhROsmzbm+AP63Sm7mqCokgEy6Zu0AVMY0gxp8qY75Pqiw@mail.gmail.com>
In-Reply-To: <CAHC9VhROsmzbm+AP63Sm7mqCokgEy6Zu0AVMY0gxp8qY75Pqiw@mail.gmail.com>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Fri, 23 Oct 2026 09:45:20 -0300
X-Gm-Features: AclHuK-AKUESe6iHVc-VzwOYib6sgRKlK0BCnAtM6wg5S60Ozyo0oOLLHvDr8CI
Message-ID: <CAABTaaBOrPknzdxc5S6L9hGu7hbFu2e1RZG=Sxjb_B1Cs4Sixw@mail.gmail.com>
Subject: Re: [PATCH v3 00/14] audit: log all six syscall arguments in the
 SYSCALL record
To: Paul Moore <paul@paul-moore.com>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, bpf@vger.kernel.org, eparis@redhat.com, 
	sgrubb@redhat.com, oleg@redhat.com, richard.henderson@linaro.org, 
	mattst88@gmail.com, linmag7@gmail.com, linux@armlinux.org.uk, 
	catalin.marinas@arm.com, will@kernel.org, guoren@kernel.org, monstr@monstr.eu, 
	tsbogend@alpha.franken.de, jonas@southpole.se, 
	stefan.kristiansson@saunalahti.fi, shorne@gmail.com, 
	James.Bottomley@hansenpartnership.com, deller@gmx.de, 
	ysato@users.sourceforge.jp, dalias@libc.org, glaubitz@physik.fu-berlin.de, 
	davem@davemloft.net, andreas@gaisler.com, richard@nod.at, 
	anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net, chris@zankel.net, 
	jcmvbkbc@gmail.com, tglx@kernel.org, peterz@infradead.org, luto@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: sy1clamU3srq5qEYqMLiKoiJzVqdqpizsVeW5brXba4_1792759532
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2026 at 1:39=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Tue, Oct 13, 2026 at 8:36=E2=80=AFAM Ricardo Robaina <rrobaina@redhat.=
com> wrote:
> > On Thu, Oct 1, 2026 at 6:06=E2=80=AFPM Paul Moore <paul@paul-moore.com>=
 wrote:
> > > On Tue, Sep 22, 2026 at 3:21=E2=80=AFPM Ricardo Robaina <rrobaina@red=
hat.com> wrote:
>
> ...
>
> > > * As pointed out by Sashiko, when you were converting all of the
> > > arches, it looks like you missed alpha.  I took a quick look and it
> > > appears that it should be a pretty straightforward conversion like
> > > most of the others.
> >
> > I've actually dropped the alpha patch as per Magnus's request [1].
> >
> > [1] https://lore.kernel.org/audit/CA+=3DFv5T4826T2sd0Gbh-nfZsqcWK_phdBK=
y4BLWOvDTt92t5Eg@mail.gmail.com/
>
> The problem is that as things stand, this patchset breaks the build on
> Alpha.  Perhaps this gets resolved during the current merge window,
> but as you know we can't break the kernel build ...
>
> https://lore.kernel.org/oe-kbuild-all/202610041836.6TatRQSm-lkp@intel.com

Of course, you're absolutely right that we can't break the build. I
was afraid that this dependency might cause trouble.

I noticed Magnus posted a pull request a few days ago containing the
"alpha: enable GENERIC_ENTRY" series [1]. It seems this will get
resolved during the current merge window.

For future reference, what's the best way to handle dependencies on
other subsystem changes like this?

[1] https://lore.kernel.org/linux-alpha/ataJlL6L7TrS3gWs@z440.darklands.se/

>
> --
> paul-moore.com
>

-Ricardo

