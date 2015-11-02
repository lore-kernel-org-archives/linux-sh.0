From: Wolfram Sang <wsa@the-dreams.de>
Date: Mon, 02 Nov 2015 21:33:05 +0000
Subject: Re: [PATCH 0/3] Fix rcar-pcie for arm64
Message-Id: <20151102213305.GA1158@tetsubishi>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="6TrnltStXW4iwmi0"
List-Id: <linux-sh.vger.kernel.org>
References: <1446482175-26507-1-git-send-email-phil.edworthy@renesas.com>
In-Reply-To: <1446482175-26507-1-git-send-email-phil.edworthy@renesas.com>
To: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Simon Horman <horms@verge.net.au>, linux-pci@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> The first patches fixes the build problem, and the second patch reverts the
> patch that removed the driver from arm64 builds. The final patch add a compat
> string for the r8a7795 (arm64) device.

Thanks. I will test them next week when I have access to my board again.

> Apart from patches to add the PCIe clock and DT nodes, I had to revert these
> patches to get it to work on arm64:
>  f075915ac0b1 ("PCI/MSI: Drop domain field from msi_controller")
>  d8a1cb757550 ("PCI/MSI: Let pci_msi_get_domain use struct device::msi_domain")

Does that solve the MSI problems you mentioned?

Regards,

   Wolfram


--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIbBAEBAgAGBQJWN9aRAAoJEBQN5MwUoCm2Pm4P+L482xGmQKOByU6eZ3F1AZ84
jUDdOzZK6NaKTlFOicZer47e1tmOHNFjy0JrSLOb6I9gIFZYWWmo5weUZgEiH3oy
QVcX1mXB4BLmu1I2is9tuKpZbFc3yypc3nvVQ7N67OdEaOu0zLkP0ePOOdqX7mSt
a7H80lfaGE+TmSUVFB3e/aWgMMtWoAzqhf0ZkUovRLnWcy8jRff9qqX52jI/t4ux
UANwpQGzX3qRwQVN3eBmcWuWn/Lq0S0CYF2aLPihDD7VSJdKhjZFLD0jaDd66jbV
nbQYpy0cpbvhxLQTOkXQb84lBJ2Vq+cZKuSELObm5idJoj0vFrid4F8UQTaTHQDP
Gg4j6yh2He+eU1kPQ08fDxOzFT1owvx3VszDrA/T9V6QiajHMYZjCGqV+wq6sT9w
DhXRrjR89yDu8YB6uooHFvCM/AfasOfjHdakFdQaV3q69lZwFbcnBaagT+QDDdjk
IRSubv7S8pOsT4nCQKi4Rv0i1dyhykItHl15mK1PrTQMnghAZ0oAVz+SLh0vX+OZ
bnNkj9kEoU3rVS7RxnI5jUbR3S1TfQ+UW+wuFN4dRF7OsaNBATSh5rCsdu7PkP3I
EDjJ4vV+3PPcJxebcnRIN+mQN8iHk/DTX331pbfcx0DOnu+UROfoMYRJqyZuBfkX
wQcAZjXeENzAODjbetI=
=zEfu
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--
