From: Rich Felker <dalias@libc.org>
Date: Mon, 14 Sep 2015 16:09:56 +0000
Subject: Re: SH FDPIC ABI spec/binutils and kernel conflict on flag definitions
Message-Id: <20150914160956.GA1820@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <20150910033400.GM17773@brightrain.aerifal.cx>
In-Reply-To: <20150910033400.GM17773@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On Thu, Sep 10, 2015 at 04:53:35PM +0100, David Howells wrote:
> Rich Felker <dalias@libc.org> wrote:
>=20
> > On the other hand, the only existing way to produce a binary that both
> > (1) needs constant displacement, and (2) actually gets constant
> > displacement from the kernel at load time, is to manually edit the ELF
> > headers to flip the bit. So I really doubt any such binaries exist. Do
> > you have a reason to believe they do?
>=20
> Well, Fujitsu asked for it for FRV - I've no idea whether they have such
> binaries still.

OK, I've solved part of the mystery: on FRV and Blackfin, binutils
matches the kernel behavior and conflicts with the (effectively wrong)
ABI documents. As can be seen at the following locations in the
source, EF_$ARCH_PIC is cleared by default and set when there is a
cross-segment relocation that forces constant displacement:

Blackfin:
https://sourceware.org/git/?p=3Dbinutils-gdb.git;a=3Dblob;f=BFd/elf32-bfin.=
c;h=152134ee7b9b445d96818fcab2350ffd11795897;hb=3DHEAD#l3140
https://sourceware.org/git/?p=3Dbinutils-gdb.git;a=3Dblob;f=BFd/elf32-bfin.=
c;h=152134ee7b9b445d96818fcab2350ffd11795897;hb=3DHEAD#l4978

FRV:
https://sourceware.org/git/?p=3Dbinutils-gdb.git;a=3Dblob;f=BFd/elf32-frv.c=
;h=FA12528b3d11ab9ed7a4d5d894f8b9c1a5e783a9;hb=3DHEAD#l3919
https://sourceware.org/git/?p=3Dbinutils-gdb.git;a=3Dblob;f=BFd/elf32-frv.c=
;h=FA12528b3d11ab9ed7a4d5d894f8b9c1a5e783a9;hb=3DHEAD#l6367

And SH does the opposite:
https://sourceware.org/git/?p=3Dbinutils-gdb.git;a=3Dblob;f=BFd/elf32-sh.c;=
h{8d7636de5fe4ce169eacbeb876ab7d741df798;hb=3DHEAD#l5499
https://sourceware.org/git/?p=3Dbinutils-gdb.git;a=3Dblob;f=BFd/elf32-sh.c;=
h{8d7636de5fe4ce169eacbeb876ab7d741df798;hb=3DHEAD#l6656

So I think for consistency with other FDPIC targets, and to avoid
changing kernel ABI, binutils should just be fixed to match the
Blackfin and FRV interpretation of EF_$ARCH_PIC on SH as well.

Ideally fixed versions of the ABI documents should also be produced.

Rich
