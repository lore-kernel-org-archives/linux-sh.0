From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Sun, 24 Jan 2016 22:58:51 +0000
Subject: Re: [RFC 0/5] [media] rcar-vin: skeleton driver not depending on soc_camera
Message-Id: <1555265.Nfj4OXtCrr@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1452778216-31978-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
In-Reply-To: <1452778216-31978-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi Niklas,

Thank you for the patches.

On Thursday 14 January 2016 14:30:11 Niklas S=F6derlund wrote:
> Hi,
>=20
> This is a RFC for the initial work of a rcar-vin driver that do not depend
> on the soc_camera framework. What is presented here is a WIP, lots of stu=
ff
> is missing:
>=20
>  - Setting format handling together with the v4l2_subdev.
>  - DMA engine integration.
>  - Power management
>  - ...
>=20
> I saw some recent patches on linux-se where the soc_camera rcar_vin driver
> is extended so I though it best to make others aware of what I'm working
> on. But since this in such a incomplete state I do not wish to generate
> noise on linux-media so I just post it here.
>=20
> Niklas S=F6derlund (5):
>   [media] rcar-vin: add skeleton
>   [media] rcar-vin: hookup a vb2queue
>   [media] rcar-vin: add array of supported formats
>   [media] rcar-vin: add video_device
>   [media] rcar-vin: hookup subdeivce using v4l2-async

Could you please resend the five patches squashed together ? It's difficult=
 to=20
review a new driver split across several patches.

>  drivers/media/platform/rcar-vin.c | 697 ++++++++++++++++++++++++++++++++=
+++
>  1 file changed, 697 insertions(+)
>  create mode 100644 drivers/media/platform/rcar-vin.c
>=20
> --
> 2.7.0

--=20
Regards,

Laurent Pinchart

