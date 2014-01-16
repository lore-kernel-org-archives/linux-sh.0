From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 16 Jan 2014 06:47:27 +0000
Subject: Re: [PATCH 0/2] ARM: dts: Add SATA to R8A7791 Koelsch device tree
Message-Id: <CANqRtoTUHWRjqu4JNKW_tVJ9R1zOBXUWua=mT+OntcTJVcRFqA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1389719131-24376-1-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1389719131-24376-1-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On Wed, Jan 15, 2014 at 2:05 AM, Valentine Barshak
<valentine.barshak@cogentembedded.com> wrote:
> This adds SATA nodes to r8a7791.dtsi and enables SATA0 in r8a7791-koelsch=
.dts.
> In order for this to work the following patches are also needed:
> * R-Car Gen2 SATA phy support:
> https://git.kernel.org/cgit/linux/kernel/git/tj/libata.git/commit/?h=3Dfo=
r-3.14&id=E67adb4e669db834c1f95cbdf99bb4e9ec8455b3
> * a couple of MSTP clock fixes:
> http://marc.info/?l=3Dlinux-sh&m=138823255807611&w=3D2
>
> Valentine Barshak (2):
>   ARM: dts: r8a7791: Add SATA nodes to r8a7791.dtsi
>   ARM: dts: koelsch: Enable SATA0 in r8a7791-koelsch.dts
>
>  arch/arm/boot/dts/r8a7791-koelsch.dts |  4 ++++
>  arch/arm/boot/dts/r8a7791.dtsi        | 18 ++++++++++++++++++
>  2 files changed, 22 insertions(+)

Hey Valentine,

Thanks for your patches. I have now tested this series on my Koelsch
board and it works well.

Acked-by: Magnus Damm <damm@opensource.se>

Cheers,

/ magnus
