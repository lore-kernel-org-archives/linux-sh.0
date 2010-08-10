From: Namhyung Kim <namhyung@gmail.com>
Date: Tue, 10 Aug 2010 03:09:43 +0000
Subject: Re: [PATCH] sh: remove RELOC_HIDE on exception handlers and
Message-Id: <1281409783.1670.14.camel@leonhard>
List-Id: <linux-sh.vger.kernel.org>
References: <1281300825-3327-1-git-send-email-namhyung@gmail.com>
	 <4C601ECD.2070503@st.com>
In-Reply-To: <4C601ECD.2070503@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Stuart Menefy <stuart.menefy@st.com>
Cc: Paul Mundt <lethal@linux-sh.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

2010-08-09 (=EC=9B=94), 16:29 +0100, Stuart Menefy:
> Unfortunately these are necessary, although it is nothing to do with link=
er
> relocation. These functions take a struct pt_regs as a parameter (not a
> pointer), and modify some of the fields of that structure. We needed a way
> to ensure that gcc didn't optimise away those assignments - to gcc
> they appear to be assignments to a local variable, so quite legitimately
> get optimised away. So we used RELOC_HIDE() as a way of doing that.
>=20

Oh, I didn't know that. Thank you for the comments.


> A clearer way to do this would be to pass in a struct pt_regs pointer,
> but that would require going via a stub function which loads up the
> pointer.
>=20
> Stuart
>=20

So is it worth if I'm gonna work on it?


--=20
Regards,
Namhyung Kim


