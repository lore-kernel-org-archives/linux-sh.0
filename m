Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94428CA5A;
	Sat,  7 Jun 2025 13:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749301821; cv=none; b=FaAOLSH6IxyiMviTRBcBjDoQiaj0FoAHORFfEzWpaDR7zQ10yB1WcDeMojOAuJizme8dnawYfaIS6b1MAa0vbJgh25JZDJ2IkjdPzflanXndXxOZTH/b40dY6cN/CVt8EPoAZcM3HpmiHVhtEbuttWq/0upzXbpOvTgooAnCPfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749301821; c=relaxed/simple;
	bh=ZGXW3yTEtfflID6rpetqiNuf8Uo0UZsBZ4vRucq8s/s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K1ofAAfJTU/sNno1+gSLoV2oj8DGVpKNBuDorJdiOIgiaOrGoy9+GFylYBqsCMzt8higAarUypl2pOfbV73WRSsTSyU+hPlcQHg2EbV2kREkMrlLyQu+jZbKWZfSGSwpyTYua2dz+n0tvm0k/tOU1TrfQVIwIh8LjM8wxpxgfGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=k4CCYGBN; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="k4CCYGBN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=tpZAQGYDOmCp2YaW91iZMhaPFMiPEM4BDksv9/9/IYE=; t=1749301818; x=1749906618; 
	b=k4CCYGBNTOXd5as4qHu7mWxpUPthzdhrLcUHqQgUGAFJK9w92pyOzgjiyWBYLigSkRsVRpZsx5b
	R7sOnHoAdKjCOGtVhA40OdzPC7WG7pOtlzn6MRC+JZptin2mW1mmQyHzbrWhbX6or2Bv0/lE8t7RZ
	IMXi94gvKv/alAp2wFdK25SEbAj7WszlbjtkZRbEAfKe/VTmPM3jPBl2LEWaf+vY9q3HLJ6RH0CNx
	qXZnPfFq9bAbZgRt2ORaUIIRo+6+gd2CD/gLNvPF7xMF0G1nrKWsYpAWwsqIKu4o3Mm+W3I40CaOq
	hngV2C3HbHnOvRaiEnwOpxPH0O9Kglo4JeZQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1uNtJP-00000001oAw-1CBm; Sat, 07 Jun 2025 15:10:15 +0200
Received: from p5b13afe4.dip0.t-ipconnect.de ([91.19.175.228] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1uNtJP-00000003Ovv-0Gyd; Sat, 07 Jun 2025 15:10:15 +0200
Message-ID: <916e98179181eebbfbfc2548a40a800e8c703525.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sh: kprobes: remove unused variables in
 kprobe_exceptions_notify()
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Mike Rapoport <rppt@kernel.org>
Cc: Mike Rapoport <rppt@gmail.com>, Rich Felker <dalias@libc.org>, Yoshinori
 Sato <ysato@users.sourceforge.jp>, linux-kernel@vger.kernel.org,
 linux-sh@vger.kernel.org,  kernel test robot	 <lkp@intel.com>
Date: Sat, 07 Jun 2025 15:10:14 +0200
In-Reply-To: <20250517093048.1149919-1-rppt@kernel.org>
References: <20250517093048.1149919-1-rppt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Mike,

On Sat, 2025-05-17 at 12:30 +0300, Mike Rapoport wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>=20
> kbuild reports the following warning:
>=20
>    arch/sh/kernel/kprobes.c: In function 'kprobe_exceptions_notify':
> > > arch/sh/kernel/kprobes.c:412:24: warning: variable 'p' set but not us=
ed [-Wunused-but-set-variable]
>      412 |         struct kprobe *p =3D NULL;
>          |                        ^
>=20
> The variable 'p' is indeed unused since the commit fa5a24b16f94
> ("sh/kprobes: Don't call the ->break_handler() in SH kprobes code")
>=20
> Remove that variable along with 'kprobe_opcode_t *addr' which also
> becomes unused after 'p' is removed.
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202505151341.EuRFR22l-lkp@i=
ntel.com/
> Fixes: fa5a24b16f94 ("sh/kprobes: Don't call the ->break_handler() in SH =
kprobes code")
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>=20
> I don't know why the warning poped up only now, the code there didn't
> change for some time :/
>=20
>  arch/sh/kernel/kprobes.c | 4 ----
>  1 file changed, 4 deletions(-)
>=20
> diff --git a/arch/sh/kernel/kprobes.c b/arch/sh/kernel/kprobes.c
> index 49c4ffd782d6..a250fb1b9420 100644
> --- a/arch/sh/kernel/kprobes.c
> +++ b/arch/sh/kernel/kprobes.c
> @@ -404,13 +404,10 @@ int __kprobes kprobe_fault_handler(struct pt_regs *=
regs, int trapnr)
>  int __kprobes kprobe_exceptions_notify(struct notifier_block *self,
>  				       unsigned long val, void *data)
>  {
> -	struct kprobe *p =3D NULL;
>  	struct die_args *args =3D (struct die_args *)data;
>  	int ret =3D NOTIFY_DONE;
> -	kprobe_opcode_t *addr =3D NULL;
>  	struct kprobe_ctlblk *kcb =3D get_kprobe_ctlblk();
> =20
> -	addr =3D (kprobe_opcode_t *) (args->regs->pc);
>  	if (val =3D=3D DIE_TRAP &&
>  	    args->trapnr =3D=3D (BREAKPOINT_INSTRUCTION & 0xff)) {
>  		if (!kprobe_running()) {
> @@ -421,7 +418,6 @@ int __kprobes kprobe_exceptions_notify(struct notifie=
r_block *self,
>  				ret =3D NOTIFY_DONE;
>  			}
>  		} else {
> -			p =3D get_kprobe(addr);
>  			if ((kcb->kprobe_status =3D=3D KPROBE_HIT_SS) ||
>  			    (kcb->kprobe_status =3D=3D KPROBE_REENTER)) {
>  				if (post_kprobe_handler(args->regs))

Thanks for catching this! Looks good to me!

Reviewed-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
