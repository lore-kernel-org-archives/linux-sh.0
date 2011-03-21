From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Mon, 21 Mar 2011 13:22:56 +0000
Subject: Re: [PATCH 3/3] ARM: switch mackerel to dynamically manage the
Message-Id: <Pine.LNX.4.64.1103211421040.24139@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1102221049240.1380@axis700.grange>
 <Pine.LNX.4.64.1102221057040.1380@axis700.grange>
 <AANLkTikA0QDCLNSrM3FGobEzBBh9hcP_ZpyC+4YPSbx7@mail.gmail.com>
In-Reply-To: <AANLkTikA0QDCLNSrM3FGobEzBBh9hcP_ZpyC+4YPSbx7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Linux Media Mailing List <linux-media@vger.kernel.org>, linux-sh@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Hi Magnus

On Wed, 16 Mar 2011, Magnus Damm wrote:

> On Tue, Feb 22, 2011 at 6:57 PM, Guennadi Liakhovetski
> <g.liakhovetski@gmx.de> wrote:
> > Use soc_camera_platform helper functions to dynamically manage the
> > camera device.
> >
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > ---
> > =A0arch/arm/mach-shmobile/board-mackerel.c | =A0 28 +++++++------------=
---------
> > =A01 files changed, 7 insertions(+), 21 deletions(-)
>=20
> Hi Guennadi,
>=20
> Thanks for your work on this. The soc_camera_platform interface has
> become much much nicer with these patches.
>=20
> I just tested patch 1/3 and patch 3/3 on my Mackerel board.

Thanks for testing!

> Unfortunately I get this printout on the console:
>=20
> sh_mobile_ceu sh_mobile_ceu.0: SuperH Mobile CEU driver attached to camer=
a 0
> soc_camera_platform soc_camera_platform.0: Platform has not set
> soc_camera_device pointer!
> soc_camera_platform: probe of soc_camera_platform.0 failed with error -22
> sh_mobile_ceu sh_mobile_ceu.0: SuperH Mobile CEU driver detached from cam=
era 0
>=20
> Without these two patches everything work just fine. Any ideas on how
> to fix it? I'd be happy to test V2. =3D)

Hm, yes, looks like I'm initialising the pointer too late. Could you,=20
please, test the patch below on top, if it helps, I'll send v2.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/

diff --git a/include/media/soc_camera_platform.h b/include/media/soc_camera=
_platform.h
index fbf4b79..6d7a4fd 100644
--- a/include/media/soc_camera_platform.h
+++ b/include/media/soc_camera_platform.h
@@ -50,6 +50,8 @@ static inline int soc_camera_platform_add(const struct so=
c_camera_link *icl,
 	if (!*pdev)
 		return -ENOMEM;
=20
+	info->dev =3D dev;
+
 	(*pdev)->dev.platform_data =3D info;
 	(*pdev)->dev.release =3D release;
=20
@@ -57,11 +59,10 @@ static inline int soc_camera_platform_add(const struct =
soc_camera_link *icl,
 	if (ret < 0) {
 		platform_device_put(*pdev);
 		*pdev =3D NULL;
-	} else {
-		info->dev =3D dev;
+		info->dev =3D NULL;
 	}
=20
-	return 0;
+	return ret;
 }
=20
 static inline void soc_camera_platform_del(const struct soc_camera_link *i=
cl,
