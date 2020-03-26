From: Rich Felker <dalias@libc.org>
Date: Thu, 26 Mar 2020 20:42:26 +0000
Subject: Re: [PATCH 1/2] arch/sh: vmlinux.scr
Message-Id: <20200326204226.GE11469@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <20200315175108.9694-1-romain.naour@gmail.com>
In-Reply-To: <20200315175108.9694-1-romain.naour@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On Sun, Mar 15, 2020 at 06:51:07PM +0100, Romain Naour wrote:
> Since the patch [1], building the kernel using a toolchain built with
> Binutils 2.33.1 prevent booting a sh4 system under Qemu.
> Apply the patch provided by Alan Modra [2] that fix alignment of rodata.
>=20
> [1] https://sourceware.org/git/gitweb.cgi?p=3Dbinutils-gdb.git;h=EBd2263b=
a9a9124d93bbc0ece63d7e0fae89b40e
> [2] https://www.sourceware.org/ml/binutils/2019-12/msg00112.html
>=20
> Signed-off-by: Romain Naour <romain.naour@gmail.com>
> Cc: Alan Modra <amodra@gmail.com>

Acked-by: Rich Felker <dalias@libc.org>

> ---
>  arch/sh/boot/compressed/vmlinux.scr | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/sh/boot/compressed/vmlinux.scr b/arch/sh/boot/compresse=
d/vmlinux.scr
> index 862d74808236..dd292b4b9082 100644
> --- a/arch/sh/boot/compressed/vmlinux.scr
> +++ b/arch/sh/boot/compressed/vmlinux.scr
> @@ -1,6 +1,6 @@
>  SECTIONS
>  {
> -  .rodata..compressed : {
> +  .rodata..compressed : ALIGN(8) {
>  	input_len =3D .;
>  	LONG(input_data_end - input_data) input_data =3D .;
>  	*(.data)
> --=20
> 2.24.1
