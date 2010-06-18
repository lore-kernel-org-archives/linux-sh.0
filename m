From: Fabio Giovagnini <fabio.giovagnini@aurion-tech.com>
Date: Fri, 18 Jun 2010 07:20:13 +0000
Subject: Re: [uClinux-dev] Userspace command line gcc options troubles
Message-Id: <201006180920.13448.fabio.giovagnini@aurion-tech.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20100617210346.GA422@minime.bse>
In-Reply-To: <20100617210346.GA422@minime.bse>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

This is the result (i suppose):
*asm:
%(subtarget_asm_endian_spec) %{mrelax:-relax=20
%(subtarget_asm_relax_spec)}%(subtarget_asm_isa_spec) %(subtarget_asm_spec)=
=20
%{m2a:--isa=3Dsh2a} %{m2a-single:--isa=3Dsh2a} %{m2a-single-only:--isa=3Dsh=
2a}=20
%{m2a-nofpu:--isa=3Dsh2a-nofpu} %{m5-compact*:--isa=3DSHcompact} %{m5-32med=
ia*:--
isa=3DSHmedia --abi2} %{m5-64media*:--isa=3DSHmedia --abid} %{m4al:-dsp}=20
%{mcut2-workaround:-cut2-workaround}


Nowhere I can see :
--fdpic--isa=3Dsh2a

I think it should be=20
--fdpic --isa=3Dsh2a
at most (with a blank space in between)



In data gioved=EC 17 giugno 2010 23:03:47, Daniel Gl=F6ckner ha scritto:
: > On Thu, Jun 17, 2010 at 12:32:56PM +0200, Fabio Giovagnini wrote:
> > uclinux/bin/as: unrecognized option '--fdpic--isa=3Dsh2a'
> >
> > How could I solve?
>=20
> cd /home/fgiovagnini/sh7203/sh7203-uclinux-4.4-206/build/target/
> ./bin/sh-uclinux-gcc -dumpspecs > lib/gcc/sh-uclinux/4.4.1/specs
> sed -i 's/subtarget_asm_spec)/& /' lib/gcc/sh-uclinux/4.4.1/specs
>=20
> Best regards
>=20
>   Daniel
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Fabio Giovagnini

Aurion s.r.l.
P.I e C.F.
00885711200
skype: aurion.giovagnini
Tel. +39.051.594.78.24
Cell. +39.335.83.50.919
www.aurion-tech.com
