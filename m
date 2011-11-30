From: Mike Frysinger <vapier@gentoo.org>
Date: Wed, 30 Nov 2011 20:56:31 +0000
Subject: Re: [PATCH (sh-2.6)] sh: do not export syscalls that are actually not implemented
Message-Id: <201111301556.32503.vapier@gentoo.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart2057648.aLMa4NoyZt"
List-Id: <linux-sh.vger.kernel.org>
References: <1322685809-15587-1-git-send-email-carmelo.amoroso@st.com>
In-Reply-To: <1322685809-15587-1-git-send-email-carmelo.amoroso@st.com>
To: linux-sh@vger.kernel.org

--nextPart2057648.aLMa4NoyZt
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit

On Wednesday 30 November 2011 15:43:29 Carmelo AMOROSO wrote:
> Avoid user space to erroneously assume that a syscall is implemented
> by picking __NR_xxx from kernel headers that are actually mapped
> to sys_ni_syscall.

Acked-by: Mike Frysinger <vapier@gentoo.org>
-mike

--nextPart2057648.aLMa4NoyZt
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJO1piAAAoJEEFjO5/oN/WBT+0P/R3HcaRjs8kbTMHzpeL+5fYS
xQJVmgjLkLrs59m5PMnFB+mPIFLeruuMZbTv7M4VznQdatl3UTaz5DZQiZza8iY8
qlcacvOJOS4tVtNjQRa3GeeW+wpUlOruIISlLBIESBELwZpSPDqjs6QLoYVyiHwu
Z+aF589ha5L4cROhX6crnMOxdSXlORCjf/CrC2Y06OnDeMRF+siChbbYDfALh3kc
8S9WeqqLjesgyC8xO4IqSbMvOwSF9OTWXIC6XIYqTwMDJnRxzbbz0lYVIiyP5tgk
YboKPn54pYDOIb/uuPBZDvV2fBp0wuAbb2Ad4U4WoH48sGr5w6jnnTb7uAEjwlKJ
/ge7leVuw8iB6ivQC/A9zgLD4Lk4M3pYu+/W4sFMzefHWmr72dGWh99kTBtE2fnV
uAx3o9HSwInfWJjK1O7yVrjtOCg0QWvZ/JJo1FJr5Bula0tvQNEMm0PifIU7zw6g
cY9h6RUN+tl2RRHMWpoGfQQ0La9+DMYEELOB69WLmy8VYbxMcVe8ULBr15aWXT31
8YQZWjAMPG2mRyyQlf8ZJT22YIefA+an4N9Z11+ghCabzFWVvq087/wFg5ZjvFMX
JhrAyWB759kCK1P9I+/7+sSYeBcmNM8IjiQHn8cLDYMf0mOLCP9iraeK3/bMOGjk
OsWmH3he9QlHTsaH21V9
=i8zd
-----END PGP SIGNATURE-----

--nextPart2057648.aLMa4NoyZt--
