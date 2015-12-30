From: Mike Frysinger <vapier@gentoo.org>
Date: Wed, 30 Dec 2015 03:55:54 +0000
Subject: Re: SH FDPIC ABI spec/binutils and kernel conflict on flag definitions
Message-Id: <20151230035554.GU25803@vapier.lan>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="elWSKwo949DbmCL3"
List-Id: <linux-sh.vger.kernel.org>
References: <20150910033400.GM17773@brightrain.aerifal.cx>
In-Reply-To: <20150910033400.GM17773@brightrain.aerifal.cx>
To: linux-sh@vger.kernel.org


--elWSKwo949DbmCL3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 14 Sep 2015 12:09, Rich Felker wrote:
> On Thu, Sep 10, 2015 at 04:53:35PM +0100, David Howells wrote:
> > Rich Felker <dalias@libc.org> wrote:
> > > On the other hand, the only existing way to produce a binary that both
> > > (1) needs constant displacement, and (2) actually gets constant
> > > displacement from the kernel at load time, is to manually edit the ELF
> > > headers to flip the bit. So I really doubt any such binaries exist. Do
> > > you have a reason to believe they do?
> >=20
> > Well, Fujitsu asked for it for FRV - I've no idea whether they have such
> > binaries still.
>=20
> OK, I've solved part of the mystery: on FRV and Blackfin, binutils
> matches the kernel behavior and conflicts with the (effectively wrong)
> ABI documents. As can be seen at the following locations in the
> source, EF_$ARCH_PIC is cleared by default and set when there is a
> cross-segment relocation that forces constant displacement:
>=20
> Blackfin:
> https://sourceware.org/git/?p=3Dbinutils-gdb.git;a=3Dblob;f=3Dbfd/elf32-b=
fin.c;h=3D152134ee7b9b445d96818fcab2350ffd11795897;hb=3DHEAD#l3140
> https://sourceware.org/git/?p=3Dbinutils-gdb.git;a=3Dblob;f=3Dbfd/elf32-b=
fin.c;h=3D152134ee7b9b445d96818fcab2350ffd11795897;hb=3DHEAD#l4978

it's a bit more complicated than that.  only one place does Blackfin
permit setting of EF_BFIN_PIC:
https://sourceware.org/git/?p=3Dbinutils-gdb.git;a=3Dblob;f=3Dbfd/elf32-bfi=
n.c;h=3D152134ee7b9b445d96818fcab2350ffd11795897;hb=3DHEAD#l3140

and if you look before that, it has:
  if (!silence_segment_error && bfd_link_pic (info))
    return FALSE;

and those are defined as:
  int silence_segment_error =3D !bfd_link_pic (info);
  #define bfd_link_pic(info)  (bfd_link_dll (info) || bfd_link_pie (info))
  #define bfd_link_pie(info)  ((info)->type =3D=3D type_pie)

all FDPIC ELFs must be PIE which means it's not possible to create a
Blackfin FDPIC ELF with EF_BFIN_PIC set.

off the top of my head, i don't recall seeing EF_BFIN_PIC being set
in Blackfin FDPIC ELFs.  it would show up when generating some FLAT
code w/-fpic, but that doesn't matter here.

> FRV:
> https://sourceware.org/git/?p=3Dbinutils-gdb.git;a=3Dblob;f=3Dbfd/elf32-f=
rv.c;h=3Dfa12528b3d11ab9ed7a4d5d894f8b9c1a5e783a9;hb=3DHEAD#l3919
> https://sourceware.org/git/?p=3Dbinutils-gdb.git;a=3Dblob;f=3Dbfd/elf32-f=
rv.c;h=3Dfa12528b3d11ab9ed7a4d5d894f8b9c1a5e783a9;hb=3DHEAD#l6367

the Blackfin code was copied from FRV, and the codepath i noted above
is the same for FRV.
-mike

--elWSKwo949DbmCL3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWg1XJAAoJEEFjO5/oN/WBHjEP/jiqLM2H3iD85RUHTHZehSst
Qc7hA4n6FAQ9ngIZhbZX/zPVay6PWhK9qqwv2gwC0rhUxUQ7a6HotB82u3zB7ocZ
4sYUGoCF1ZJwagW/BBVaLv4bU07ec/1Y9v0ZK43k2aAUR+JGQK8ZUduv6038Jbnn
bOrmYkwNmN0i1HpM9UN7CYpf5RU6CLcWr/XWzxoB2dODFt3q7jPn0qfpc500XC3y
siDNldTTC079vG9XRQ7yACW98cACCEN+8cv4w+lu0xNdDkmcpuZYMnUWd/rJLneF
lBhddiuhuBH/aUkfOZDTzS9Gjn4tdkqNsdj1VD2jGQbDcz1h+nHi4jJ2UZM9oFGI
8gqVTtBw2RrG17FGwy+1VVjlwwo5jT9J7UpGCq6yB55tgUDlIUd8SJiICxXazMcj
BmCRVts3mLZvN/PiEfQbHxNPyunHeBWYtLfqg5tFPqUqfsLWQP7b6JI/Bai8+4eq
GRZeKW8xWCU+RtaAdZUy5TlTCBJ1Y0k8MBtlvbxI83OG55/gQ729JnzoomHXv+9e
ioL3B+0AwW3C6oDhCTAZ8sPyMOByWWEWX5u5Rhva3h3+TjIEYLh3o1eLjU3/K16d
CZBZa3q51aaNQ+XgfxImGH4W2q7Zd5a3gh16CQTEbhvctvWjFvkL/hHH5Lp09NXi
UVz7InZs1g6U2EAszmKA
=bpz+
-----END PGP SIGNATURE-----

--elWSKwo949DbmCL3--
