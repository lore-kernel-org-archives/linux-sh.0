From: Simon Horman <horms@verge.net.au>
Date: Wed, 05 Nov 2014 00:36:51 +0000
Subject: Re: [PATCH v3 7/7] ARM: shmobile: kzm9g-reference: require ZB clock for Ethernet controller
Message-Id: <20141105003651.GB2017@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1414515736-24905-8-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1414515736-24905-8-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On Fri, Oct 31, 2014 at 10:56:39AM +0100, Ulrich Hecht wrote:
> On Thu, Oct 30, 2014 at 7:03 PM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > I don't have the schematics for kzm9g, but I guess the LAN controller
> > is hooked up to the BSC (Bus State Controller). According to the sh73a0
> > datasheet, ZB=C3=B8 is the clock for the BSC.
>=20
> Yes, I remember something like that. (Please ignore my previous
> ramblings, I was looking at the APE6EVM schematics...)

Thanks, I have queued up this series.
