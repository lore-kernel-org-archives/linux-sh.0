From: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Date: Mon, 10 Nov 2008 21:39:09 +0000
Subject: Qemu SH4 status #2
Message-Id: <20081110233926.3d8c7fd1.kristoffer.ericson@gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Signature=_Mon__10_Nov_2008_23_39_26_+0100_Jix3liZvjmmBQonl"
List-Id: <linux-sh.vger.kernel.org>
To: linux-sh@vger.kernel.org

--Signature=_Mon__10_Nov_2008_23_39_26_+0100_Jix3liZvjmmBQonl
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Greetings,

I followed the segmentation fault and finally
found it being caused by :

sh_intc_source()
{
 printf("this text will show\n");
 if (id)
	return desc->sources + id;
 printf("we will never reach here...\n");
 return NULL;
}

My best guess is that id for whatever reason is tooo
high, but thats just my #1 attempt at qemu debugging.

Happy hacking!

/Kristoffer


--=20
Kristoffer Ericson <kristoffer.ericson@gmail.com>

--Signature=_Mon__10_Nov_2008_23_39_26_+0100_Jix3liZvjmmBQonl
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkkYuB4ACgkQPQls10ERAGdojwCfY7e2fG5QHrH0HtFAQ/4YuNSS
UcQAoNinuACqP/RQ2O5lX00mfQ1C/Wyb
=gkW9
-----END PGP SIGNATURE-----

--Signature=_Mon__10_Nov_2008_23_39_26_+0100_Jix3liZvjmmBQonl--
