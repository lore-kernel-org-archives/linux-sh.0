From: Rob Landley <rob@landley.net>
Date: Thu, 26 Mar 2020 04:56:14 +0000
Subject: Re: [PATCH 2/2] include/asm-generic: vmlinux.lds.h
Message-Id: <6dca8a3e-65a3-78b8-a56f-976cecface58@landley.net>
List-Id: <linux-sh.vger.kernel.org>
References: <20200315175108.9694-2-romain.naour@gmail.com>
In-Reply-To: <20200315175108.9694-2-romain.naour@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On 3/15/20 12:51 PM, Romain Naour wrote:
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
> ---
>  include/asm-generic/vmlinux.lds.h | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmli=
nux.lds.h
> index e00f41aa8ec4..d46d34b58c96 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -374,6 +374,7 @@
>   */
>  #ifndef RO_AFTER_INIT_DATA
>  #define RO_AFTER_INIT_DATA						\
> +	. =3D ALIGN(8);							\
>  	__start_ro_after_init =3D .;					\
>  	*(.data..ro_after_init)						\
>  	JUMP_TABLE_DATA							\
>=20

This patch and the previous one:

Tested-by: Rob Landley <rob@landley.net>

Worked for me with a current musl-cross-make toolchain.

It would be nice if we could get this into 5.6.

Rob
