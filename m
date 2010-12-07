From: Mike Frysinger <vapier@gentoo.org>
Date: Tue, 07 Dec 2010 20:15:23 +0000
Subject: Re: [PATCH (sh-2.6) 1/2] sh: add stack smashing protection support
Message-Id: <201012071515.25418.vapier@gentoo.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart2038247.Em6ZA23TzY"
List-Id: <linux-sh.vger.kernel.org>
References: <1291717254-17455-1-git-send-email-filippo.arcidiacono@st.com>
In-Reply-To: <1291717254-17455-1-git-send-email-filippo.arcidiacono@st.com>
To: linux-arm-kernel@lists.infradead.org

--nextPart2038247.Em6ZA23TzY
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Tuesday, December 07, 2010 05:20:53 Filippo ARCIDIACONO wrote:
> Add stack smashing suppurt for SH architecture. This is based on work
> from Nicolas Pitre for ARM (c743f38013aeff58ef6252601e397b5ba281c633).
> Use the ARM boot_init_stack_canary function to initialize the guard
> canary. It has been placed under asm-generic to allow archtectures
> based on __stack_chk_guard to use a common implementation.
> Update the __stack_chk_guard global variable with the value stored in
> the task struct whenever a task switch occurs to allow for different
> canary values per task. This cannot work on SMP where the initial
> canary value is always used.
>=20
>  arch/sh/Kconfig                      |   13 +++++++++++
>  arch/sh/Makefile                     |    4 +++
>  arch/sh/include/asm/stackprotector.h |   10 ++++++++
>  arch/sh/kernel/process_32.c          |    9 +++++++
>  include/asm-generic/stackprotector.h |   39

if you're starting asm-generic stuff, why not go the distance and do it all=
 in=20
common code ?  your sh/Kconfig and sh/Makefile changes arent specific to=20
SuperH, nor is the symbol in process_32.c.
=2Dmike

--nextPart2038247.Em6ZA23TzY
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iQIcBAABAgAGBQJM/pXdAAoJEEFjO5/oN/WBmmsQAJnnhZgrM0mHHTMLRLTwWn9k
02XU8eT404aKvhIcq0e4UW8p4LhFxXvd2WHW5vRKXiLrfA4wnHSSNNctFuCfz/jA
GUqAzQo/2OXOCmmRi6g7yJsXDUl3DBctsDurlWO85bkdJ3JXdqgnT0Uvri4broai
xJDmbFTnldQZ9GX8s+f9u6hy2heTXnT5GXSfEIRG0PwgYrZwF8T+dzn76z6HKbZJ
w1Do2HIAa3YdHzieHzHbNQB/6YfjcsoFG5ITVpzRBSQmqvwDiCr84AMoP4YZG6Pv
qRcJ8L8BeyLlk3JBbYHwxVqktSC9IWcs52Bcrs7F9ixl2gsrOnYiILto9toeWvTe
ePq9JUhyLVa7r68dgJAsNuj8eY6SaN+MuWh+aa2u0B3IDJPLMVOZSFYnpjRn007d
DN2iwU0bklIEi3Vo38fhlqcyVQ8v5i+72+3rRCcwQuC6/D3kfCQOz/Ys28dq6Uqt
pr7gfzL6L40FnvcMBIiNwu/3fqSmjdxqUqr38cPLwZc+PlbFTzWRJIYitsI2qq+g
0c4PgboQlv8oLC9kqkCAotLG5UlOOYCRzLbgzhaLTDz3LtnBItpTaMfwwjNvHmNa
t2n6i1BQhIOW6nFnvMy6Y6CVzy9mgPlg6prB5n6ZHcvspB70lCs7Rb+0emqK3+0n
La66NREnEVNTsyeUtTdI
=27BN
-----END PGP SIGNATURE-----

--nextPart2038247.Em6ZA23TzY--
