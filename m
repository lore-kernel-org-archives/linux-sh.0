From: Linus Walleij <linus.walleij@linaro.org>
Date: Sun, 11 Jan 2015 21:40:18 +0000
Subject: Re: [PATCH v4 7/7] pinctrl: qcom-spmi-gpio: Migrate to pinconf-generic
Message-Id: <CACRpkdbDEcStJhabgKEm8H=z2umEr+bd-0oK4_HvCO+rz0pTXQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1420818231-13451-1-git-send-email-soren.brinkmann@xilinx.com>
 <1420818231-13451-8-git-send-email-soren.brinkmann@xilinx.com>
In-Reply-To: <1420818231-13451-8-git-send-email-soren.brinkmann@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Fri, Jan 9, 2015 at 4:43 PM, Soren Brinkmann
<soren.brinkmann@xilinx.com> wrote:

> Instead of the driver caring about implementation details like device
> tree, just provide information about driver specific pinconf parameters
> to pinconf-generic which takes care of parsing the DT.
>
> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>

Patch applied: qualcomm folks, can you make sure that the Qualcomm
stuff is still working as expected with S=C3=B6ren's core parser?

Yours,
Linus Walleij
