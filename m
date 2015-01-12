From: "Ivan T. Ivanov" <iivanov@mm-sol.com>
Date: Mon, 12 Jan 2015 09:09:11 +0000
Subject: Re: [PATCH v4 7/7] pinctrl: qcom-spmi-gpio: Migrate to pinconf-generic
Message-Id: <1421053751.28652.9.camel@mm-sol.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1420818231-13451-1-git-send-email-soren.brinkmann@xilinx.com>
 <1420818231-13451-8-git-send-email-soren.brinkmann@xilinx.com>
 <CACRpkdbDEcStJhabgKEm8H=z2umEr+bd-0oK4_HvCO+rz0pTXQ@mail.gmail.com>
In-Reply-To: <CACRpkdbDEcStJhabgKEm8H=z2umEr+bd-0oK4_HvCO+rz0pTXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org


On Sun, 2015-01-11 at 22:40 +0100, Linus Walleij wrote:
> On Fri, Jan 9, 2015 at 4:43 PM, Soren Brinkmann
> brinkmann@xilinx.com> wrote:
>=20
> > Instead of the driver caring about implementation details like device
> > tree, just provide information about driver specific pinconf parameters
> > to pinconf-generic which takes care of parsing the DT.
> >=20
> > Signed-off-by: Soren Brinkmann brinkmann@xilinx.com>
>=20
> Patch applied: qualcomm folks, can you make sure that the Qualcomm
> stuff is still working as expected with S=C3=B6ren's core parser?
>=20

Yep, it still works. Tested on pm8941 and pma8084. Thanks.

Tested-by: Ivan T. Ivanov <iivanov@mm-sol.com>
