From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Tue, 22 Dec 2015 14:22:00 +0000
Subject: [PATCH v2 0/2] adv7604: .get_selection support
Message-Id: <1450794122-31293-1-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-media@vger.kernel.org, linux-sh@vger.kernel.org
Cc: magnus.damm@gmail.com, laurent.pinchart@ideasonboard.com, hans.verkuil@cisco.com, ian.molton@codethink.co.uk, lars@metafoo.de, william.towle@codethink.co.uk, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Hi!

The rcar_vin driver relies on this method.  The second patch makes sure that
they return up-to-date data if the input signal has changed since
initialization.

This revision implements .get_selection instead of .g_crop/.cropcap and
includes the suggested style changes.

It has been tested with the rcar_vin driver together with Hans Verkuil's
"v4l2: remove g/s_crop and cropcap from video ops" patch:

https://git.linuxtv.org/hverkuil/media_tree.git/commit/?h=3Drmcrop&id=9Ff32=
166c29d1323db090d638da27ea652d1d4d8

CU
Uli


Ulrich Hecht (2):
  media: adv7604: implement get_selection
  media: adv7604: update timings on change of input signal

 drivers/media/i2c/adv7604.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

--=20
2.6.3

