From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 17 Mar 2010 06:47:35 +0000
Subject: Re: Hi All, hot to debug my eth0' hw?
Message-Id: <aec7e5c31003162347q44f4df1asf5256ed1036dcb10@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201003161225.42600.fabio.giovagnini@aurion-tech.com>
In-Reply-To: <201003161225.42600.fabio.giovagnini@aurion-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi Fabio,

On Wed, Mar 17, 2010 at 2:47 PM, Fabio Giovagnini
<fabio.giovagnini@aurion-tech.com> wrote:
> Hi Magnus,
> yesterday I used the following command
> =A0git clone =A0git://git.kernel.org/pub/scm/linux/kernel/git/lethal/sh-2=
.6.git
>
> Am I ok?

I think so.

> My configuration is :
>
> SH2a 7203 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 smc9118
> Addresses:
> A1...A7 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 A1...A7
> Data:
> D0...D31 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0D=
0...D31
[snip]
> That means no swap it seems to work but really fails.

Please check the patches I pointed out earlier again. Read the commit
messages, big endian data transfer is broken on rsk7203 without the
patches. Register access is ok without swap but FIFO (actual data) is
broken.

If your ethernet hardware design is identical to rsk7203 then you will
need the patches.
Remember to set SMSC911X_SWAP_FIFO, i think that will solve your issue.

> My hw configration is good for actual version of the kernel driver or I n=
eed to
> be carefull to other stuff?

The latest kernel should be just fine on rsk7203. At least it builds. =3D)

/ magnus
