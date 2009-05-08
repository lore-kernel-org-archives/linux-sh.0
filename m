From: Mike Frysinger <vapier@gentoo.org>
Date: Fri, 08 May 2009 18:28:51 +0000
Subject: Re: [PATCH] Add ptrace support for NOMMU debugging
Message-Id: <200905081428.52464.vapier@gentoo.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart16159767.8RntEDRLQ1"
List-Id: <linux-sh.vger.kernel.org>
References: <1241794254.16311.32.camel@quercus-bis>
In-Reply-To: <1241794254.16311.32.camel@quercus-bis>
To: linux-sh@vger.kernel.org

--nextPart16159767.8RntEDRLQ1
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Friday 08 May 2009 10:50:54 Peter Griffin wrote:
> >From 2652ec6503dbe78e5bf371b77544e168166aa57d Mon Sep 17 00:00:00 2001
>
> From: Peter Griffin <pgriffin@mpc-data.co.uk>
> Date: Fri, 8 May 2009 15:01:21 +0100
> Subject: [PATCH] Add ptrace support for NOMMU debugging

are you not using git-send-email ?  posting the actual file produced by git-
format-patch looks weird (not sure if git-am works with this).

> +		else if ( addr == PT_TEXT_ADDR)
> +			tmp = child->mm->start_code;
> +		else if ( addr == PT_DATA_ADDR)
> +			tmp = child->mm->start_data;
> +		else if ( addr == PT_TEXT_END_ADDR )
> +			tmp = child->mm->end_code;
> +		else if ( addr == PT_TEXT_LEN )
> +			tmp = child->mm->end_code - child->mm->start_code;

style wrong: no space inside of those parenthesis
-mike

--nextPart16159767.8RntEDRLQ1
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iQIcBAABAgAGBQJKBHnkAAoJEEFjO5/oN/WB71IP/0tGL0xmYy+6TamysE4jrB6P
35itKyfj88kDLd7Whq/yG+3dFMo6nusogAX460lyImDa/xeNywto1+dFxCh/hURW
hzmQq6AxFfruP7hnPvOuGAU29VPudZ4Eux+h7pGb5y0gl9Gd00fmWdd2Vvu6mbuB
pyZ3dlKNPL6jYlBARznyK7nSBC2YnEOdQxmcKbDjjQrPH2l9iHeo/Q28BRpnTAh+
rh68PsRuByV3juSbpGxP3L7BqCFRXnjLPLIAC3E5s4GI5g41MGcOwfXcEQesX+tR
CyasdANmSIJ/rHsyjHnnBIyIhwErW9ct1m8F3PvD38mGDG5esp46mPDOToM7VdtZ
dpXD77ayq1Jv8DKFoTYX6YHv0HjfHrzMUVuEcmEdO0K0vcue1l/riwCFC7/A6Nkt
AJuvZWfUHe9yhmkAVJ1Gp4yQRqHHq3tzxCV5mZLeQ76L3S1RoPDHWU1Vyqx8lt8Y
fbKs3svVQumKmEGNOjT2AzQPuSL8/7hrwLU5S6XbjNNixdNmBIcSoDh+pceMyvBK
UT4zkctS1NMaYGJJJradWwO2kISYneOYaEi5TiPrycu5GhZD6Swqv6r+JZJQtWHj
guiB73qaHWbo7iNcAtRHusfeHWsjEm1qt+jPcj8Vr6ZGJdhfcEgFQR0VvC4pKa4A
ZDTumasOy2wBNTVdfzgJ
=pQEx
-----END PGP SIGNATURE-----

--nextPart16159767.8RntEDRLQ1--
