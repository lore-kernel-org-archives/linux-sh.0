From: =?UTF-8?q?Niklas=20S=C3=B6derlund?=  <niklas.soderlund+renesas@ragnatech.se>
Date: Thu, 14 Jan 2016 13:30:11 +0000
Subject: [RFC 0/5] [media] rcar-vin: skeleton driver not depending on soc_camera
Message-Id: <1452778216-31978-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi,

This is a RFC for the initial work of a rcar-vin driver that do not depend =
on
the soc_camera framework. What is presented here is a WIP, lots of stuff is
missing:

 - Setting format handling together with the v4l2_subdev.
 - DMA engine integration.
 - Power management
 - ...

I saw some recent patches on linux-se where the soc_camera rcar_vin driver =
is
extended so I though it best to make others aware of what I'm working on. B=
ut
since this in such a incomplete state I do not wish to generate noise on
linux-media so I just post it here.

Niklas S=C3=B6derlund (5):
  [media] rcar-vin: add skeleton
  [media] rcar-vin: hookup a vb2queue
  [media] rcar-vin: add array of supported formats
  [media] rcar-vin: add video_device
  [media] rcar-vin: hookup subdeivce using v4l2-async

 drivers/media/platform/rcar-vin.c | 697 ++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 697 insertions(+)
 create mode 100644 drivers/media/platform/rcar-vin.c

--
2.7.0

