From: Wolfram Sang <wsa@the-dreams.de>
Date: Fri, 23 Oct 2015 08:06:02 +0000
Subject: Re: [PATCH 5/9] i2c: rcar: init new messages in irq
Message-Id: <20151023080601.GC1642@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="iVCmgExH7+hIHJ1A"
List-Id: <linux-sh.vger.kernel.org>
References: <1441311613-2681-1-git-send-email-wsa@the-dreams.de>
 <131418014.1WnDGNUZcn@avalon>
 <20151022110505.GB1572@katana>
 <1917001.aD8sIkvx7f@avalon>
In-Reply-To: <1917001.aD8sIkvx7f@avalon>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Geert Uytterhoeven <geert@linux-m68k.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Yoshihiro Kaneko <ykaneko0929@gmail.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>


--iVCmgExH7+hIHJ1A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> Do you have a Koelsch board now ? Could you try=20

Nope, I only have Lager. I'd be surprised if it really was a Koelsch
only issue, though...

> b9653e9c000dc2ebd9c8712442c659ccd1586e22 from Geert's drivers tree ? On m=
y=20

Does that build for you?

drivers/gpu/drm/drm_fb_helper.c: In function 'restore_fbdev_mode':
drivers/gpu/drm/drm_fb_helper.c:448:5: error: 'error' undeclared (first use=
 in this function)

??

I fixed it locally and will see if I see ADV7511 problems. I cannot
fully test HDMI probably, because it seems that this HDMI->DVI chain I
have does not work. Tested that with a kernel which used to work in
Dublin. Need to get another HDMI device.

> board the adv7511 fails to probe completely due to the regmap_read() fail=
ure.

Okay, so before any 'modetest' activity. Which kernelconfig?
shmobile_defconfig?

Thanks,

   Wolfram


--iVCmgExH7+hIHJ1A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWKeppAAoJEBQN5MwUoCm2UqwP+gPFo1x8R8dVwyQeZ/iCP6q5
0S7xpBKtjHWL7Xzhsw5sRhjZKIHF4UBjdOVCUHFlXCrRsSfEdv2/Vjx1AgVm0SQg
EBl+4PhnrSk0QI257AZx9Kx73u/tNgmu4ctf5mBwaRDQhENVa2do6Q0NgJu7oOPN
zamHAS2Ct/oWHTQPfJfs0vzKSE/IO8sCS7wjC0Beym40Rzw3Yedt+LaQryxfLeWn
IH5+lkiJpcHJU66TsVDkNrqpvcvGPbFV+RDNFhcZdFnSFvmSoZ2vN6behZ02Ga/l
yds6Uja4ZwMs0Ss67L6WhQlLJ6XLF3DQxIg6/hTmY8bv6Zdh4Cv6L94wiFgoCJQK
qw9OJCXwcVtQWW10pbcVMCKmGU83VCtptMeYFiPtRk5L0Gaegdd7A3IWz8t9oMoz
cuCFONC70UMtvM3tN3BZe17mUfydI+5WfqlgsqrThlWJ/inIR7OV+6z++INZSl2B
IC/B34klBeG/mmrUD0ZJdlSQ6RXfKVaGerKmLm17rxoQDTzlIYNO3dGvs8lXALbW
tVuRkWQ1530bFBzhQ9ZnUux9gAbEAB/2fmsozoq1NU8NZC+Oagv4PNRBfZSefXcJ
/XenkDv9Ol+ntBSUb+NYXtUkGo3zcYtO+Al+qVIZHSdnsyUpuF2bivhfhyeN/Ho4
HxTpuHydbu9DD3s5W9vC
=9kB6
-----END PGP SIGNATURE-----

--iVCmgExH7+hIHJ1A--
